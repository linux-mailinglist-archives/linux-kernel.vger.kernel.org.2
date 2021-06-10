Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E583A25D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJHws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:52:48 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:43563 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:52:47 -0400
Received: by mail-lj1-f171.google.com with SMTP id r14so3511155ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9U6TcdGqm3u7Y2Gu0vtl5OMZBJyJdaAvj/22UF0aYUY=;
        b=m6h2sCmVnvQGmh62QuSQtgdkFEfB2vCjhZyS/lQSoaS1c1pBGTdiOrA5UOKHG7s+Sw
         z8vR75Zkxz1UnCNTBSlFmL9+m09W4aGfLenkDWyhatb9ZLrEWNpEqAuIqI7CAqckZWmW
         xSIlS6ZsP7xRrE5/aacBrCjBsI2Lvtc49J8Xwe0zo5wq8l9plYmELtoYbsjTrBgEx2yV
         ZwzIiQ/hfz4V9xt5nGRPtyw7bbAG/9Ft+KJNSgCox42XMvFg1SW++nTWQCo2IG06IoAV
         JEuZF0zqmWC0rcoKKCG+mGzMIBk4YLRQasqjVNoD1zgEZwZads2frxgD87USr0u5m88I
         S+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9U6TcdGqm3u7Y2Gu0vtl5OMZBJyJdaAvj/22UF0aYUY=;
        b=Q7+ELnHqPJPQIcrmNGpnv1y954XHAA+HQrhYAf3PnO7FZeKPpJGdj3MjRkDagYiIw2
         DuE9bRBp95bpCe2PIJnQhY4U2veUaljN80HBohTjvrDTUsJP4WALXWRya/SncQQ3k8Rn
         s9jMTc0rADnLf2FmTdvuqAd9roTnhZ9brhYBFZUYuvgExy6BsKjMhzvPM+vTLH1dMTtX
         ZNLQis6pqpoo+S6xBnngwRfYvGc7vL+QGk0P1n2SZ6Tga+5TAP9LrXvmzSy0mWgMUpEA
         9YIuQn0aBdxgIWpLqOEhKPmJ1ox1aUZnSeRs1Cm5+qxQau8NUhA3cLj5hKpqB2zJpx/T
         lbjQ==
X-Gm-Message-State: AOAM530TSSzpIEzfO21UVs7sEdNVICHGORGVgFtic2IlyoroAH1vowVF
        F2Giyn7DOmFWcOK7W4QkuO77Zg==
X-Google-Smtp-Source: ABdhPJw+LWHmePKtC4iF5BWtQ+R4/B9mNUcolpBZmJXquUlETwTjG1GUUJVdPdt3rnw/U2h9mcjuvg==
X-Received: by 2002:a2e:6c12:: with SMTP id h18mr1189990ljc.125.1623311390816;
        Thu, 10 Jun 2021 00:49:50 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id b2sm220213lfo.221.2021.06.10.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:49:50 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:49:48 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>, Rijo-john.Thomas@amd.com,
        Allen Pais <apais@linux.microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf
 backing
Message-ID: <20210610074948.GC2753553@jade>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia>
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
 <20210609121533.GA2267052@jade>
 <20210609134225.GC4910@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609134225.GC4910@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 08:42:25AM -0500, Tyler Hicks wrote:
[snip]
> > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linaro.org/
> > 
> > Where tee_shm_alloc() is replaced by among other functions
> > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > problem with TEE_SHM_DMA_BUF.
> 
> Thanks! At first glance, that series would take care of the last three
> patches in my kexec/kdump series.
> 
> I'm a bit worried that it is a rewrite of the shm allocator. Do you plan
> to send all of that to stable? (I mentioned earlier in this thread that
> I'm affected by these bugs in linux-5.4.y.)

No, that might be a bit much.

> Also, you and Sumit don't seem to have the same opinion on kernel
> drivers making use of tee_shm_register() for allocations that are only
> used internally. Can you comment on that?
> 
> I'm not clear on the next steps for fixing these kexec/kdump bugs in
> older releases. I appreciate any guidance here.

Neither am I be honest. You're the only one that has brought up this
problem so perhaps it's enough to focus on the stable branch you need to
have fixed.

If I've understood it correctly it's best if it's possible to
cherry-pick the fixes from mainline to the stable branch in question.
So we must make sure to get your needed patches in before any rewrites
that would make cherry-picking impossible. The rewrite I'm proposing
isn't urgent so it can be held off for a while.

Cheers,
Jens
