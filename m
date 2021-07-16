Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9363CB886
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhGPOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:14:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53245 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhGPOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:14:40 -0400
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 16GEATWZ036199;
        Fri, 16 Jul 2021 23:10:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 16 Jul 2021 23:10:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 16GEASKV036196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Jul 2021 23:10:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
References: <000000000000610af005c714c1d1@google.com>
 <20210716152440.368d4250@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <949a12a0-a0a6-0574-4e87-4ed196ff6d78@i-love.sakura.ne.jp>
Date:   Fri, 16 Jul 2021 23:10:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716152440.368d4250@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/07/16 21:24, Pavel Skripkin wrote:
> But this function can be called not only from sysfs and I can't
> understand will my patch break something or not. And, I think, error
> message is needed somewhere here to inform callers about wrong shift
> value.
> 
> 
> Thoughts?

Subsequent profiling_store() attempts will return -EEXIST if
profile_setup() once set prof_on to non-zero value. Therefore,
if you try to return -EINVAL when profile_setup() returns 0,
you need to make sure that prof_on is set to non-zero value
only if prof_shift is valid.

But, the userspace might not be aware of the value of MAX_PROF_SHIFT
because it is an architecture dependent value, and par might become negative
value because get_option() accepts negative value. Therefore, it might be
better to

+		par = clamp(par, 0, MAX_PROF_SHIFT - 1);

than

+		if (par < 0 || par >= MAX_PROF_SHIFT)
+			return 0;

.

