Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7B430405
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbhJPR5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbhJPR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:57:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3240EC061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:54:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ec8so51878219edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgxvPWQKp0jUp34dpM5a7Zgyxji+U3TzZbm6NerkAYs=;
        b=J/IHkzrKhdnJos+3T4yVTo5R91dYy9x4z/GcE06KlPKvMxdlK/xGmp5+XcVVwmWYM0
         e+hGqZcLLb0/tZT68P8gpAEhrRezn6jAWMLEKQHzn9RdA60ThhJ/na2kkTWi1LvYlWmD
         FtcnZqvE/MuwvKmcoq4BxIzDrSre0XB4VbRru/mqQFedWemoULyV7R+IO+rmRgH+KB61
         eP+UIA1V3/xv38c7oKOWF0ye7hwRnLlYvcxxAE0JXNDLua2d3GcSHaU72slOxd38whaK
         zgBC14Gh04F8Q7F013gvrRjKbttJFDqS+7PFrkh4lAHM+GsJtSSYZTJwuZK0g9Rz+v0D
         KXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgxvPWQKp0jUp34dpM5a7Zgyxji+U3TzZbm6NerkAYs=;
        b=uxF0yf6hNDaItUslnLJfZE4chBO9WGe9GdDNaBSwA6HKJeUlELK9wZJiJ6G/HhRZyb
         8KWsvGcXt3lVwAW0p1f5EM5y+Z/BunhGqtFb6rYbGTh2V0L2HO2V4/6lyjWmpdP3L5Yc
         ictxXsd8F6jXAjUFzW7V8etLT8baG69St61q8xcQL/KH6bhCyXaqVzYm/zfJ9AvJ6DSf
         Sm324T96xDAp/7cG+ij7dx/ddIXAd0UOWbZO9TX3tzpk+fSUvGftm25Q+fqme09ieaPR
         1d0W2DhhJixdgPvHHri/prK7JHLnAXjbrl8ubsLxHa0Z9+Ef9LlWuKtq+jYR74V/Jnpz
         FbMw==
X-Gm-Message-State: AOAM533togEVRA78//7QCxswvVSZHtC5wqX9Ph/A+3s0/QnSJ/NMczNx
        YpFdmKm1l19O6IsaNdDsRiI=
X-Google-Smtp-Source: ABdhPJySjGiUzuyLvXLx64c/C6arNKREc0HKkWOQfrlxuNxrilnWi7emf14zSosvbfgEBzDQRBEvkg==
X-Received: by 2002:a17:906:7d09:: with SMTP id u9mr16672991ejo.120.1634406893650;
        Sat, 16 Oct 2021 10:54:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id j22sm6457302ejt.11.2021.10.16.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 10:54:53 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: r8188eu: use completions and clean rtw_cmd_thread()
Date:   Sat, 16 Oct 2021 19:54:51 +0200
Message-ID: <3115690.HXPuu0oz9h@localhost.localdomain>
In-Reply-To: <YWrvbPkqer43C+Fk@equinox>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com> <YWrvbPkqer43C+Fk@equinox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 16, 2021 5:27:40 PM CEST Phillip Potter wrote:
> On Sat, Oct 16, 2021 at 11:10:39AM +0200, Fabio M. De Francesco wrote:
> > This series replaces two semaphores with three completion variables
> > in rtw_cmd_thread(). Completions variables are better suited for the
> > purposes that are explained in detail in the commit messages of patches
> > 1/3 and 2/3. Furthermore, patch 3/3 removes a redundant 'if' statement
> > from that same rtw_cmd_thread().
> > 
> > Tested with ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]
> > 
> > Many thanks to Dan Carpenter <dan.carpenter@oracle.com> who helped with
> > his review of the RFC Patch.
> >
> > [...]
> >

Dear Phil,

> 
> Dear Fabio,
> 
> Built and tested on my USB-N10 Nano, working well. In terms of how
> you've split the patches out, I have no problem with it personally,

I guess that Dan will disagree with us :) Did you read his last message?

I hope that he has time to review these patches. He expressed some doubts 
about splitting the changes in two separate patches. As far as I know, since 
Dan is a very experienced engineer (I am not even graduated and everything I 
know of Computer Science is self-taught), I could have been wrong in doing 
this work the way I did.

> given that one semaphore was there for kthread start/stop and the other
> for queuing. Looks good to me anyway based on what I know of completion
> variables :-) I assume you've not made the waits killable or
> interruptible in patch 1 due to the fact they are specifically related
> to kthread start/stop?

Good question! :)

Let me explain how I chose to make one wait killable and the other 
uninterruptible.

As far as I know, waiters may spin or sleep while waiting to acquire a lock  
(see spinlocks or mutexes for instance) or to be awakened (completions and 
condition variables for instance).

These were the cases of sleeping waiters. Sleeping can be done in 
uninterruptible, interruptible / killable, and timed-out states.

Where I'm 100% sure that the code doesn't require / want to be interrupted 
for whatever reason I prefer to use uninterruptible variants (and so I did in 
1/3).

When I'm not sure of the requirement above, I prefer to avoid that the 
process or the entire system hangs while waiting to acquire a mutex or to be 
awakened by a complete() (and so on).

Conversely, using interruptible versions without proper checking of return 
codes and without proper managing of errors may lead to serious bugs.

Kernel threads (kthreads) are like user processes / threads and are scheduled 
the same way the former are. One noteworthy difference is that their mm 
pointer is NULL (they have not an userspace address spaces). However they are 
still threads that have a PID in userspace and they can be killed by root.

This is the output of the "ps -ef" command after "modprobe r8188eu":

localhost:~ # ps -ef | grep RTW
root      1726     2  0 19:06 ?        00:00:00 [RTW_CMD_THREAD]

Since the developers who wrote the original code thought that that thread 
must be interrupted I thought that restricting interruptions to kills was the 
wiser choice in 2/3. Conversely, I cannot see reasons to interrupt the core 
part of a driver, so I chose to use an uninterruptible version of 
wait_for_completion*() in the other parts of the code.

I warned you that I'm not an engineer, so please double check my argument :)

> Anyhow:
> 
> For whole series:
> Acked-by: Phillip Potter <phil@philpotter.co.uk>

Thanks for you ack. I really appreciated it.

Best regards,

Fabio

> 
> Regards,
> Phil
> 




