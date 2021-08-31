Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2437A3FC6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbhHaLvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhHaLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:51:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94488C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:50:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc21so37984702ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G3EAEGce9DDVcaeWugp6PobFOe4iFXkc5xvRhZSkkGw=;
        b=Lx/1A6DmeuQnhij6Da/uxEIPb5BzL0zii2ZMDwEmwWrwBQlFXT5fa7AvJHvNjfRKc8
         zFAiJWXEAji1k2DPGLezQZgyLaEdKNsk715u1/F1fY8mgprK4lw9hV80bV+r14ejvwJR
         W2XX7In0UNfhjDweu6YiWImhaQWrXBji2j2wd94Rpn9b9+bwamPieXl4qfabnYm/33S+
         YK2fxSy45j26/VJhWPSG6L/kHq5ALeKyWWvJWjKoi1gEO67ocd2Cyp7vg8zV0R3sViGX
         n6A2AasECZmsfz9xPvjktBhvy9MXH1nATuDu0FZJrlna0CODYBPZwyk7M9SE5Qn0qwkF
         /Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G3EAEGce9DDVcaeWugp6PobFOe4iFXkc5xvRhZSkkGw=;
        b=sdxGGKxrz791jTCOTCxgkdgqiwq3a0jj6BTkpC4XuE3HtXJBtlUThb3N9kpD+Z2igF
         6pv3Nt88OQJrtY9jz2zkdPQu5wAPo2aIeeBWxnm4IudyW6svqkT0Kn9Kp94Xv/YQN+gH
         j5k2s3ahwO0JOBGCowUjAJEcc8/FEvgBEBTtVN0bpyngDlvVTgFcuNLat9In4YCpoaie
         gLJ8xD24HQ+yBMn7luNxkkARPmjbaZK2DRyRwIn/i8uDMBC19zN97kYgbA12WEdgk+vh
         3L3UuSZltFDjXAnAHuuj6H+8sYkuTyTKOi83+00gSEYjl/9fQC8ead469EsTyuaA/R5x
         Jj1A==
X-Gm-Message-State: AOAM531Xk/Ekbo/Fq+v82gPzayt4tEMTORZIkfZmT/DcFD8oZkKnDKHH
        BUwLsoXjYUrokpGmL0qG6Xc=
X-Google-Smtp-Source: ABdhPJzYUeBhPzvh8YJvV3+MS2hWTuO/H0Yc5wWmS5Dyi+xlR7LcBqk6GL61VKzNkx/PZed228yzIA==
X-Received: by 2002:a17:906:32d9:: with SMTP id k25mr29842763ejk.290.1630410609117;
        Tue, 31 Aug 2021 04:50:09 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id e11sm9273276edq.30.2021.08.31.04.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:50:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Date:   Tue, 31 Aug 2021 13:50:05 +0200
Message-ID: <6155058.TBsaUTXu4T@localhost.localdomain>
In-Reply-To: <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com> <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org> <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 31, 2021 10:07:38 AM CEST Johan Hovold wrote:
> On Mon, Aug 30, 2021 at 08:20:25AM -0500, Alex Elder wrote:
> 
> > I have been offering review feedback on this patch for three reasons:
> > 
> > - First, because I think the intended change does no real harm to the
> >   Greybus code, and in a small way actually simplifies it.
> 
> You leave out that we've already seen three versions of the patch that
> broke things in various ways and that there was still work to be done
> with respect to the commit message and verifying the locking. That's all
> real costs that someone needs to bear.
> 
> > - Because I wanted to encourage Fabio's efforts to be part of the
> >   Linux contributor community.

I really appreciated it, thank you so much Alex.

> Helping new contributers that for example have run into a bug or need
> some assistance adding a new feature that they themselves have use for
> is one thing.
> 
> I'm not so sure we're helping either newcomers or Linux long term by
> inventing work for an already strained community however.
> 
> [ This is more of a general comment and of course in no way a critique
>   against Fabio or a claim that the XArray conversions are pointless. ]
> 
> > - Because I suspected that Matthew's long-term intention was to
> >   replace IDR/IDA use with XArray, so this would represent an early
> >   conversion.

I am pretty sure that Mathew desires that people convert as much as possible 
code from IDR to XArray. You had his confirmation in this thread along with 
the link to the old message I have provided. However you and Alex are the 
maintainers, not Matthew. I must respect your POV.

> That could be a valid motivation for the change indeed (since the
> efficiency arguments are irrelevant in this case), but I could not find
> any indications that there has been an agreement to deprecate the
> current interfaces.
> 
> Last time around I think there was even push-back to convert IDR/IDA to
> use XArray internally instead (but I may misremember).
> 
> > The Greybus code is generally good, but that doesn't mean it can't
> > evolve.  It gets very little patch traffic, so I don't consider small
> > changes like this "useless churn."  The Greybus code is held up as an
> > example of Linux kernel code that can be safely modified, and I think
> > it's actively promoted as a possible source of new developer tasks
> > (e.g. for Outreachy).
> 
> Since most people can't really test their changes to Greybus perhaps it
> isn't the best example of code that can be safely modified. But yeah,
> parts of it are still in staging and, yes, staging has been promoted as
> place were some churn is accepted.
>  
> Johan

I cannot test my changes to Greybus, but I think that trivial changes are 
just required to build. To stay on the safe side I had left those 
mutex_lock() around xa_load(). I wasn't sure about it, but since the original 
code had the Mutexes I thought it wouldn't hurt to leave them there.

As it was conceived it was a "trivial" patch that didn't" need any tests, 
IMO. Greg has said, more than once, that "trivial" patches are "more than
welcome" in drivers/staging, so I took his words applicable to staging/
greybus too. 

Until the locks were there, my patch was indeed a "trivial" patch. I know the 
XArray API enough to do this task because I've already worked on unisys/
visorhba and you may bet I had not the hardware to test that patch. 
Furthermore, it was much more complex work than what I've done in staging/
greybus. After some time, due to the lack of responses from Unisys 
maintainers he took the responsibility to apply my patch. He knew that it was 
not tested, so he wrote "let's see what it breaks :)". 

I'm very sorry to bother you. I don't really know in the deep how Greybus 
works and I don't know how to write drivers because at the moment I prefer  
to spend my (very limited) time to learn core subsystems (process management 
and the schedulers above all). But while learning, I also want to give back 
something to the kernel and its Community. I think that little works on 
staging are the best way to accomplish this goal.

I was wrong in assuming that trivial patches to Greybus are welcome as they 
are for other drivers.

Best regards,

Fabio



