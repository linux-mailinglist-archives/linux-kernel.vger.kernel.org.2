Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C29430794
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbhJQJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhJQJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:50:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA41C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 02:48:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y3so35405119wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VemNr59oeExyJMlI/fohSHUiHaPcBF5eF3WpdYswakk=;
        b=M9IJbA0mOpSB48bAdJievp/E3liC+59Nwq/hRNPPXENDITFPuot+VH1kNog7eOII3o
         vfGwgQa1SrHHPVzLn7SgQ2ElwiWKQF/O/Iw5/VNQ6qKs3pEnW+JNyKwMIRJPOdzHfbVb
         rdnAUpOTZGqYTIxg5Wu1k7BrDnHJKOA88NO+S6meyD0PFL3/3KllBKcSbHsGFaatlJLY
         IFvdR+HP4cdwzq4UGZwivPyF5XNPH9ZvLdQl0k75I4QLdhIMjrzuvvMpaPUXHJEd7j60
         4BpC7Lm5dh1dxi4YczI3aKXbUD7geame1JaBChDhlOmItNk5KHun8nLnyzcVbHvUrC42
         zC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VemNr59oeExyJMlI/fohSHUiHaPcBF5eF3WpdYswakk=;
        b=Zg9w4KXkEXUW+XSuAWo8UY1Dq+6hs6iURweLYwUUa9XET4YhmsDqLrjVFUhmYWshri
         SBN/WdbxzQEL6ycgoQIEuTam+AxsDCvMT3Q8rWuJtn1blOvWRjxjbn/Ut63iFDQWNLzZ
         uOlw8sowMeI69oxmtmrtvjkIBhgA3n4K0D0aFij9YEmlxt7mBIhvpLO70mW/3wm0w/pe
         D8sklYAGLrZyrA5wwRjIBtOKQapPbtEqfwDyDQBV6YqUr9A7AnHMsYawG3rtOc8+QR+H
         Fy9V5+xhv2zPkWbPng2oyoX9AgaAXRKK7kTwWo9G6WsldjH3XRe2AqM83gmK1nS5Unsb
         Zqag==
X-Gm-Message-State: AOAM5339nmWGV/b5Cr1SpZwI7sw3he1AINArq7iy3YYRJp8Vh+BxgT9m
        /uLo9Kn9Dx/lk0SGXH0gXCRyvw==
X-Google-Smtp-Source: ABdhPJzhjgHbGfjEBnAo+HUxyGnXmicF9xB0Hdq/zXOQ0Wiy1Jb9RQcq1ZPeZjOOZVJ1NBNiqnA/qA==
X-Received: by 2002:adf:a40f:: with SMTP id d15mr26831147wra.41.1634464085094;
        Sun, 17 Oct 2021 02:48:05 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l2sm16216667wmi.1.2021.10.17.02.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 02:48:04 -0700 (PDT)
Date:   Sun, 17 Oct 2021 10:48:02 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: r8188eu: use completions and clean
 rtw_cmd_thread()
Message-ID: <YWvxUg0/5TrVZu8M@equinox>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com>
 <YWrvbPkqer43C+Fk@equinox>
 <3115690.HXPuu0oz9h@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3115690.HXPuu0oz9h@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 07:54:51PM +0200, Fabio M. De Francesco wrote:
> I guess that Dan will disagree with us :) Did you read his last message?
> 
> I hope that he has time to review these patches. He expressed some doubts 
> about splitting the changes in two separate patches. As far as I know, since 
> Dan is a very experienced engineer (I am not even graduated and everything I 
> know of Computer Science is self-taught), I could have been wrong in doing 
> this work the way I did.
> 

I did read it yes, he makes good points, and my motivation is simply
that the patches look fine as they are to me personally :-)

> > given that one semaphore was there for kthread start/stop and the other
> > for queuing. Looks good to me anyway based on what I know of completion
> > variables :-) I assume you've not made the waits killable or
> > interruptible in patch 1 due to the fact they are specifically related
> > to kthread start/stop?
> 
> Good question! :)
> 
> Let me explain how I chose to make one wait killable and the other 
> uninterruptible.
> 
> As far as I know, waiters may spin or sleep while waiting to acquire a lock  
> (see spinlocks or mutexes for instance) or to be awakened (completions and 
> condition variables for instance).
> 
> These were the cases of sleeping waiters. Sleeping can be done in 
> uninterruptible, interruptible / killable, and timed-out states.
> 
> Where I'm 100% sure that the code doesn't require / want to be interrupted 
> for whatever reason I prefer to use uninterruptible variants (and so I did in 
> 1/3).
> 
> When I'm not sure of the requirement above, I prefer to avoid that the 
> process or the entire system hangs while waiting to acquire a mutex or to be 
> awakened by a complete() (and so on).
> 
> Conversely, using interruptible versions without proper checking of return 
> codes and without proper managing of errors may lead to serious bugs.
> 
> Kernel threads (kthreads) are like user processes / threads and are scheduled 
> the same way the former are. One noteworthy difference is that their mm 
> pointer is NULL (they have not an userspace address spaces). However they are 
> still threads that have a PID in userspace and they can be killed by root.
> 
> This is the output of the "ps -ef" command after "modprobe r8188eu":
> 
> localhost:~ # ps -ef | grep RTW
> root      1726     2  0 19:06 ?        00:00:00 [RTW_CMD_THREAD]
> 
> Since the developers who wrote the original code thought that that thread 
> must be interrupted I thought that restricting interruptions to kills was the 
> wiser choice in 2/3. Conversely, I cannot see reasons to interrupt the core 
> part of a driver, so I chose to use an uninterruptible version of 
> wait_for_completion*() in the other parts of the code.
> 
> I warned you that I'm not an engineer, so please double check my argument :)
> 

Sounds good to me, just wanted to know your reasoning.

> > Anyhow:
> > 
> > For whole series:
> > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Thanks for you ack. I really appreciated it.
> 

You're welcome :-)

Regards,
Phil
