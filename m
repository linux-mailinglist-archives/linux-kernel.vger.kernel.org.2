Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EF430990
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhJQOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhJQOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:04:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86885C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:02:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ec8so59799324edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfJb2Dp3qAN2h5mlKZA9k9vBsOWuLleVKJHFCcPHtVc=;
        b=bwraluQuMOfB9CNN19bQ30M3dqORXrpEsJuktiuPhxTnBCB4EJTU+/taPbb+3D5dda
         96DTPHv5gHpTlFoy6fykdcQCr43+XWWXBcbYtVnDYfvkXFGShUglPVeq2qAXi/7WVUp/
         laccBkjWsyBEhyDLujnrGltFVbgAp8Geml2lvf9iz4LlFSfocEfSKjoC5gX2kbexxLqr
         79uo7l0vvSUTn7QJYzS+OonDv6WK3YMZyTqHr701xmy6oFuYRsDBcUG21d07LiS9EVOB
         Q/ftFBCBeWr6+l/VSjifl4LtJBw8rVqYTkNUWpT4S1drJFPtXM1mvkueiIf1Mx5vvN02
         /Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfJb2Dp3qAN2h5mlKZA9k9vBsOWuLleVKJHFCcPHtVc=;
        b=Pbk2cJ9k3kK1ctKpix8n4YgugycYMy0fDHiDGOJ997KcyeNbmAs8eSrmRBbgI66qQh
         6oLIKGOv0fRWgMkr/ZlE04aGB+q2FhvgPuEzLMbIEBg8BpewS0XBPjJsLc2imbzbJmZG
         Fx/WuV8X9F+F0Fe4OCyUUsQyqFvYSfUVedMaAvLC3weYxKSaY06IXOryNScha/c0fAp4
         OoiJStIvoK7Z8xJ0ShIqEYcG9UoU7KWab3kTxMHKkx0s7BKHdm/gjiU4Gk7dwGH/4fYI
         qaXYKBWqcOagobwwN7G5TRtNYLcq3U8RhsgBJ/qrve95eCWSAmCv+aqXRTQNZXog80qS
         SMhg==
X-Gm-Message-State: AOAM532a0G+Naa0wws5SFCGQn3v6tgGBDWsTIuYNoQcg+ZAQNdkkitYg
        9ufnTWUr3MbJNbj1Ni4RlKU=
X-Google-Smtp-Source: ABdhPJwobCNJ9oJe0u9DHqeDAeTt6oU/qIUcrOf++gKbGT/A8HgvCfInhJI1GjAHNxuxESCBa6yq+Q==
X-Received: by 2002:a17:906:ad98:: with SMTP id la24mr23145974ejb.383.1634479347989;
        Sun, 17 Oct 2021 07:02:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id lb20sm7652524ejc.40.2021.10.17.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:02:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Date:   Sun, 17 Oct 2021 15:14:49 +0200
Message-ID: <14217682.9BgDuDnfkJ@localhost.localdomain>
In-Reply-To: <YWv67ozbJGxMa69t@equinox>
References: <20211016181343.3686-1-martin@kaiser.cx> <2409617.cBYgoVRs56@localhost.localdomain> <YWv67ozbJGxMa69t@equinox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 17, 2021 12:29:02 PM CEST Phillip Potter wrote:
> On Sat, Oct 16, 2021 at 08:53:15PM +0200, Fabio M. De Francesco wrote:
> > On Saturday, October 16, 2021 8:13:43 PM CEST Martin Kaiser wrote:
> > > At the moment, our command thread can be killed by user space.
> > > 
> > > [root@host ]# kill `pidof RTW_CMD_THREAD`
> > > 
> > > The driver will then stop working until the module is unloaded
> > > and reloaded.
> > > 
> > > Don't process SIGTERM in the command thread. Other drivers that have a
> > > command thread don't process SIGTERM either.
> > 
> > Hi Martin,
> > 
> > This is _really_ interesting :)
> > 
> > May be that you have had time to read my last email in reply to a message 
of 
> > Phillip P. Soon after writing of the arguments in favor of using 
> > wait_for_completion_killable() (in patch 2/3 of the series I sent today), 
I 
> > read your patch.
> > 
> > If you are right (and I think you are) I'll have to send a v2 that 
replaces 
> > the killable wait with an uninterruptible one.
> > 
> > Unfortunately I have not the needed experience to decide whether or not 
to 
> > ack your patch, even if I'm strongly tempted to do it.
> > 
> > Let's wait for more experienced people.
> > 
> > Thanks,
> > 
> > Fabio 
> > 
> 
> So I myself am a little confused on this one :-)
> 
> Based on my understanding, so correct me if I'm wrong, a process (kthread 
or
> otherwise) can still be killed if marked TASK_KILLABLE, even if ignoring
> SIGTERM. Indeed, from a userspace perspective, SIGKILL is unblockable
> anyway - although of course kernel code can choose how to respond to it.

@Phil, Correct.
@Martin, Please correct me if I'm missing something in what follows...

> So in other words, the kthread could still be killed while waiting
> in the wait_for_completion_killable() call, even if we are ignoring
> SIGTERM. 

No, this confusion is my fault.

I read Martin's patch, but in my mind I exchanged "SIGTERM" with "SIGKILL".

At this moment, without Martin's patch, only SIGTERM is delivered to the 
kthread. This is due to the line "allow_signal(SIGTERM);".

If we try to kill the kthread with "kill -KILL <PID>", nothing happens. 
Instead if we use "kill -TERM <PID>", the kthread terminates.

For what is related to my code, there is no functional changes between using 
the killable or the uninterruptible version (I guess). But for sake of 
consistency, since SIGKILL is not allowed, I should use either 
wait_for_completion_interruptible() (without Martin's patch) or 
wait_for_completion() (with Martin's patch).

However, I re-iterate that, since SIGKILL is not allowed in the current code, 
"kill -KILL <PID>" has no effect at all and the wait is not interruptible 
with my killable version of the wait.

> From that perspective I guess, it is therefore not 'incorrect' as
> such - if indeed we wanted that behaviour.
> 
> That said, killing it would still cause the behaviour Martin mentions -
> I guess we don't want it to be either killable or interruptible based on
> that logic?

Yes, I agree. I should replace the killable version with the uninterruptible 
one.

Thanks,

Fabio

> 
> Regards,
> Phil
> 



