Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7C375652
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhEFPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhEFPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:15:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CBC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:14:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620314053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjXaRPYgibbNlztaH09GSIpAz9D/ill1Tqtt3ZMqsMI=;
        b=AufxCAdboeSEomhGk1TTv7j4T6zD42LThBg4cQnSgybpVs2moRr3S/TXkI3vQ0rFG+CLgi
        rhICELE8Y8XoJjv1K5TNBLiV51Smp6N0zW1Ig/ypxos8f4SIYT1P7ssolhu4tYa9QOSgWt
        bocVeclXFzSWjGOd6iRUuaWb7v32avw03YyeMMN0t/zUDkgD8hClMbPU9gbVnpcyKVryxI
        d81lku+O9SL8vpdfOjGBa7MQvj1v0Ljq0riRjcmDWOoc81YS9wjpRdPRexIWoUvwJmMLTE
        J39Vk1y5cYGQYtL2nt6ZspBVvnr8RjkowjXRnqmYy+mj7Midi1pNBf5VTVvocA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620314053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjXaRPYgibbNlztaH09GSIpAz9D/ill1Tqtt3ZMqsMI=;
        b=kpsZtECYp8qnzgSKO0mXZf0w9r5myai//7ZNeeLcYLVDwa+ZhXYPFmorvZBeLsXC321Qi6
        ytd6y8rvrZrKZEAA==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, bobo.shaobowang@huawei.com,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush prb
In-Reply-To: <YJP5MnkJ8pJevXM6@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com> <YJPxj83F1sBjHHAE@alley> <YJP4F1UIt/eRZ96s@google.com> <YJP5MnkJ8pJevXM6@google.com>
Date:   Thu, 06 May 2021 17:14:12 +0200
Message-ID: <87h7jfzygr.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-06, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> Can we count the number of lines that we print from the `current` context
>> in console_unlock() and if after N messages there is no console_lock waiter
>> waiting for the `current` to handover console lock ownership, then create
>> one: schedule IRQ work that will become a console lock owner, spin on
>> console lock and call console_unlock() once it acquired the ownership.
>> That 'artificial' console lock owner will do the same - print N
>> messages, if nothing wants to become a console lock owner then it'll
>> queue another IRQ work.
>
> Or even simpler
>
> console_unlock()
> {
> 	...
>
> 	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
> 		printk_safe_exit_irqrestore(flags);
>
> 		console_locked = 0;
> 		up_console_sem();
>
> 		defer_console_output();
> 		return;
> 	}
>
> 	...
> }

Or instead to keep it suspend/resume related maybe...

 void resume_console(void)
 {
         if (!console_suspend_enabled)
                 return;
         down_console_sem();
         console_suspended = 0;
-        console_unlock();
+        console_locked = 0;
+        up_console_sem();
+        defer_console_output();
 }

John Ogness
