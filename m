Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7151D3E39F1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhHHLWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:22:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49927 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHLWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:22:12 -0400
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 178BL5xU071398;
        Sun, 8 Aug 2021 20:21:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sun, 08 Aug 2021 20:21:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 178BL5rw071395
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 8 Aug 2021 20:21:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] profiling: fix shift-out-of-bounds in profile_setup
To:     Pavel Skripkin <paskripkin@gmail.com>, rostedt@goodmis.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
References: <20210716190409.25523-1-paskripkin@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7bc788bf-ba81-5732-957e-55edf522d1ca@i-love.sakura.ne.jp>
Date:   Sun, 8 Aug 2021 20:21:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716190409.25523-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/07/17 4:04, Pavel Skripkin wrote:
> Syzbot reported shift-out-of-bounds bug in profile_init().
> The problem was in incorrect prof_shift. Since prof_shift value comes from
> userspace we need to check this value to avoid too big shift.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  kernel/profile.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/profile.c b/kernel/profile.c
> index c2ebddb5e974..c905931e3c3b 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -42,6 +42,7 @@ struct profile_hit {
>  
>  static atomic_t *prof_buffer;
>  static unsigned long prof_len, prof_shift;
> +#define MAX_PROF_SHIFT		(sizeof(prof_shift) * 8)

I came to think that we should directly use BITS_PER_LONG, for
the integer value which is subjected to shift operation is e.g.

	(_etext - _stext)

part of

	prof_len = (_etext - _stext) >> prof_shift;

in profile_init().

Since "unsigned char" will be sufficient for holding BITS_PER_LONG - 1,
defining MAX_PROF_SHIFT based on size of prof_shift is incorrect.

Also, there is

	unsigned int sample_step = 1 << prof_shift;

in read_profile(). This may result in shift-out-of-bounds on BITS_PER_LONG == 64
architecture. Shouldn't this variable changed from "unsigned int" to "unsigned long"
and use 1UL instead of 1 ?

