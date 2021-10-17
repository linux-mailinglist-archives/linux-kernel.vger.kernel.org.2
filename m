Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC0430991
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhJQOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhJQOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:04:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B952C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:02:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so59754790edv.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y3pRgRc7swprQz7ta2Ya3wYVlloPNmLFhGxcjrLg3sA=;
        b=NM9sC+iRRI5rDsoimUbZQLAsDs6fFewQoAxJ09Mob4o5WBV7oT4cZ1Kmv96/ixA0Qe
         ue1nwMTd/f2qgfH22IZ2EkDEdHIG/b0WV6yAFSeQutBGJ4OE+T/GLKPX1uialdXDz+vO
         dsigyWRYOTKHa2litXb1sqxb3diTZWscOzouIoJqJqexpar7kd5ZF+0ppg9TstfaT/i+
         WfzsMNfE8O1lYt+XQ9IJwq/rUof44cxRhpSCIei3TQZDQcxWB2G5LibBFedCwbR0Ocpp
         iDg/aOgSrdZ07xX+EuNA2nuV/bI8plCxP9Dx6dPf3JyIz2mRAKy2oUhkZ4zxbW9J/Gpk
         2/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3pRgRc7swprQz7ta2Ya3wYVlloPNmLFhGxcjrLg3sA=;
        b=ExjKJDaGXD96ly0iY79ckoCep0BloV4VWh/1i8vAkLmJRumEIZxSUOSONYFDPMH0Rs
         6vP2EiDzIKOGCfK0dX50A2oq4CjjHLmgixCKsWo8cz9zdMRDf0l9PXeTf+ktXIcE3Bl7
         52x4iLGJO5A/+tPOWjX8KTXbM0TtqG5PsyfhHAj/M4khLkCJ6STE69cMLQvIE24J8Xw0
         3rFPrqrQfGib31Te0KRvVuRDq0XdhZjYqN78S6j4UqzHIT6bftUm3dpHsvoo9PJqkoW5
         ycaST6Zpci8CH/srJc955UFZbgl90i6Ng+BeAITblUpTugzM1ssZTwrgGPozP25z94pq
         blUg==
X-Gm-Message-State: AOAM532wOfNYYBdK+x/ouzfaxyD+wI4TMu0kmG4tcXdFO3622cxrKdK4
        GRxMc5/S+p/3Jtp6GTULYLc=
X-Google-Smtp-Source: ABdhPJwBmQEnMcA7/M8C+ZGZOOZtlwhYs6NTiUiWOVWASQwWXZfWbQjmm/tc9CEhjs6DNanatd5fQA==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr37181449edd.13.1634479350738;
        Sun, 17 Oct 2021 07:02:30 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id x16sm7785384ejj.8.2021.10.17.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:02:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Date:   Sun, 17 Oct 2021 14:51:40 +0200
Message-ID: <1957621.GeRc3qvyWe@localhost.localdomain>
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

Correct.

> 
> So in other words, the kthread could still be killed while waiting
> in the wait_for_completion_killable() call, even if we are ignoring
> SIGTERM. From that perspective I guess, it is therefore not 'incorrect' as
> such - if indeed we wanted that behaviour.

No. This misunderstandings is my fault. :(

In Martin's patch I read "SIGTERM" but for some reason I thought he was 
talking of "SIGKILL".

At the moment, without Martin's patch, the kthread can be terminated by the 
command "kill -TERM <PID>". If we try "kill -KILL <PID>", nothing happens.
This is because only "allow_signal(SIGTERM);" is present in the code.

I think that kthreads must also allow  SIGKILL with "allow_signal(SIGKILL);" 
for allowing root to make them terminate.

For what relates to my patch, it doesn't matter if I either leave 
wait_for_completion_killable() as-is or change it to wait_for_completion().
This is because at the moment SIGKILL cannot kill rtw_cmd_thread(), while 
SIGTERM can.

However, for consistency, I should better change it to the uninterruptible 
version.

@Martin: Please correct me if I'm wrong. Thanks.

Regards,

Fabio

> 
> That said, killing it would still cause the behaviour Martin mentions -
> I guess we don't want it to be either killable or interruptible based on
> that logic?
> 
> Regards,
> Phil
> 




