Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF83EB615
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbhHMN2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:28:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58808 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbhHMN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:28:35 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17DDRL1d011578;
        Fri, 13 Aug 2021 22:27:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 13 Aug 2021 22:27:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17DDRLVB011515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Aug 2021 22:27:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] profiling: fix shift-out-of-bounds in profile_setup
To:     Pavel Skripkin <paskripkin@gmail.com>, rostedt@goodmis.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
References: <20210716190409.25523-1-paskripkin@gmail.com>
 <7bc788bf-ba81-5732-957e-55edf522d1ca@i-love.sakura.ne.jp>
 <a222a2b1-63bd-9fe1-cbc4-ca0e1e214a46@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <99b9e091-9e95-5e45-5914-38a938840aa6@i-love.sakura.ne.jp>
Date:   Fri, 13 Aug 2021 22:27:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a222a2b1-63bd-9fe1-cbc4-ca0e1e214a46@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/08/13 19:56, Pavel Skripkin wrote:
> I don't get it, sorry. Do you mean, that
> 
> #define MAX_PROF_SHIFT        BITS_PER_LONG
> 
> is better solution here?

Yes, but I feel we don't need to define MAX_PROF_SHIFT because
the type of the integer value which is subjected to shift operation
will be always "unsigned long" and will unlikely change in the future.

>                          And as I understand we can change prof_shift type from "unsigned long" to "unsigned short", rigth?

Yes, "unsigned int" or "unsigned short int", or even "u8" (I don't know
whether compilers generate bad code if "u8" is used). At least, since
get_option() stores result into "int", receiving via "unsigned int" will
be enough.
