Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B229434E13A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhC3G20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhC3G16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:27:58 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA4C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:27:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f12so11195924qtq.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTKFXboCMW/RHSVj5ctaX+kshotuw4OedTxRCH8e0yM=;
        b=WcIrrCS5AFhvkMvKJqOirHo0TnQjMZjYyxn4ZCyRcWwJ2gpDKqqQTgJbZEucXYwL3t
         UteP4sIvF8xCouQqjnHFbijDVTAeE8J/g/Rkw8sKBlkTYN9Vi6iehqTnLlePyT1A58py
         twSbnFkdI+LEsMct+zY0tqYlqNDEKUD85KY2P80HUiYw3mOv9z85ag1IXmsyv+lKwu8B
         t/psBxNJJxTuKddlWs/vM2TKrwooGqjlGYBUnHDoeJ9BAgS51jBz7YDgnxV8y1uXXlD6
         mIOCVmzy+z5wq+X2Sz952jWpbu0HuwrZYd+MmW5ZA8/Se1ZAmaJfNC8Uz645MrIiu0TT
         DMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTKFXboCMW/RHSVj5ctaX+kshotuw4OedTxRCH8e0yM=;
        b=IB3Du+hcuBdfNlLk2ps1n2meX+xoctrY+X6e+Rm3+YqhXcTVxBn/nBfVBITLxij562
         lp2co9kt7nD+YWCeATstuF5S+Y0hHjWq4l3x+nZ4KkgGfyCmfvPMhkheprKFgw62pjkx
         xsI22kO3jp/+faSuGyXVBT04WNwMGxHD1sNyeZmV9z1UABxcdCqay/4v5Ej9lcg8GlEZ
         ij7CvsGZSxlVn9MU3RdaLEjeZ+3Ou22Hm0/pGoupoxXm2Xy6X8PK2muxDIhAUUee2tle
         XlhqsEtrb/o2QBFTPn7YrSTtPAO6cux3k1F3UMqxyU0iv6MYqhdz0AFPSPhrtiVVHUu6
         FhkA==
X-Gm-Message-State: AOAM5312jXzT8Nhc7GId+ax18yu3F0cSioGR5bf8AKN2fdXBFpNPTWrc
        1mc8kTwqbtUEHvMF0Tm1yYbjBOEyuSfNNQ==
X-Google-Smtp-Source: ABdhPJxqE3WGpjyZ+4KdHZxRDCb/cbh3QyipzZAZiDF1BLFi/v8evuxcuqfqtgGBSbknphds37wyKA==
X-Received: by 2002:a05:622a:110:: with SMTP id u16mr26930016qtw.254.1617085673619;
        Mon, 29 Mar 2021 23:27:53 -0700 (PDT)
Received: from calvin.localdomain ([2804:14d:5c5a:802e:bdc9:ded9:cc08:a4e9])
        by smtp.gmail.com with ESMTPSA id 7sm15221950qkm.64.2021.03.29.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:27:53 -0700 (PDT)
Date:   Tue, 30 Mar 2021 03:27:49 -0300
From:   Jonas Malaco <jonas@protocubo.io>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nzxt-kraken2) mark and order concurrent accesses
Message-ID: <20210330062749.tcscp2kzxqugbtiv@calvin.localdomain>
References: <20210329082211.86716-1-jonas@protocubo.io>
 <20210329215339.GH220164@roeck-us.net>
 <20210330002131.s2qz3dr6bwr6jz25@calvin.localdomain>
 <56ebbf0f-cdcb-d5af-e1ad-c7604597566e@roeck-us.net>
 <20210330031652.zhhxft4trli6zqtw@calvin.localdomain>
 <37e5b3d3-8868-c70e-4c01-2d3d777df4de@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37e5b3d3-8868-c70e-4c01-2d3d777df4de@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 10:43:55PM -0700, Guenter Roeck wrote:
> On 3/29/21 8:16 PM, Jonas Malaco wrote:
> > On Mon, Mar 29, 2021 at 06:01:00PM -0700, Guenter Roeck wrote:
> >> On 3/29/21 5:21 PM, Jonas Malaco wrote:
> >>> On Mon, Mar 29, 2021 at 02:53:39PM -0700, Guenter Roeck wrote:
> >>>> On Mon, Mar 29, 2021 at 05:22:01AM -0300, Jonas Malaco wrote:
> >>>>> To avoid a spinlock, the driver explores concurrent memory accesses
> >>>>> between _raw_event and _read, having the former updating fields on a
> >>>>> data structure while the latter could be reading from them.  Because
> >>>>> these are "plain" accesses, those are data races according to the Linux
> >>>>> kernel memory model (LKMM).
> >>>>>
> >>>>> Data races are undefined behavior in both C11 and LKMM.  In practice,
> >>>>> the compiler is free to make optimizations assuming there is no data
> >>>>> race, including load tearing, load fusing and many others,[1] most of
> >>>>> which could result in corruption of the values reported to user-space.
> >>>>>
> >>>>> Prevent undesirable optimizations to those concurrent accesses by
> >>>>> marking them with READ_ONCE() and WRITE_ONCE().  This also removes the
> >>>>> data races, according to the LKMM, because both loads and stores to each
> >>>>> location are now "marked" accesses.
> >>>>>
> >>>>> As a special case, use smp_load_acquire() and smp_load_release() when
> >>>>> loading and storing ->updated, as it is used to track the validity of
> >>>>> the other values, and thus has to be stored after and loaded before
> >>>>> them.  These imply READ_ONCE()/WRITE_ONCE() but also ensure the desired
> >>>>> order of memory accesses.
> >>>>>
> >>>>> [1] https://lwn.net/Articles/793253/
> >>>>>
> >>>>
> >>>> I think you lost me a bit there. What out-of-order accesses that would be
> >>>> triggered by a compiler optimization are you concerned about here ?
> >>>> The only "problem" I can think of is that priv->updated may have been
> >>>> written before the actual values. The impact would be ... zero. An
> >>>> attribute read would return "stale" data for a few microseconds.
> >>>> Why is that a concern, and what difference does it make ?
> >>>
> >>> The impact of out-of-order accesses to priv->updated is indeed minimal.
> >>>
> >>> That said, smp_load_acquire() and smp_store_release() were meant to
> >>> prevent reordering at runtime, and only affect architectures other than
> >>> x86.  READ_ONCE() and WRITE_ONCE() would already prevent reordering from
> >>> compiler optimizations, and x86 provides the load-acquire/store-release
> >>> semantics by default.
> >>>
> >>> But the reordering issue is not a concern to me, I got carried away when
> >>> adding READ_ONCE()/WRITE_ONCE().  While smp_load_acquire() and
> >>> smp_store_release() make the code work more like I intend it to, they
> >>> are (small) costs we can spare.
> >>>
> >>> I still think that READ_ONCE()/WRITE_ONCE() are necessary, including for
> >>> priv->updated.  Do you agree?
> >>>
> >>
> >> No. What is the point ? The order of writes doesn't matter, the writes won't
> >> be randomly dropped, and it doesn't matter if the reader reports old values
> >> for a couple of microseconds either. This would be different if the values
> >> were used as synchronization primitives or similar, but that isn't the case
> >> here. As for priv->updated, if you are concerned about lost reports and
> >> the 4th report is received a few microseconds before the read, I'd suggest
> >> to loosen the interval a bit instead.
> >>
> >> Supposedly we are getting reports every 500ms. We have two situations:
> >> - More than three reports are lost, making priv->updated somewhat relevant.
> >>   In this case, it doesn't matter if outdated values are reported for
> >>   a few uS since most/many/some reports are outdated more than a second
> >>   anyway.
> >> - A report is received but old values are reported for a few uS. That
> >>   doesn't matter either because reports are always outdated anyway by
> >>   much more than a few uS anyway, and the code already tolerates up to
> >>   2 seconds of lost reports.
> >>
> >> Sorry, I completely fail to see the problem you are trying to solve here.
> > 
> > Please disregard the out-of-order accesses, I agree that preventing them
> > "are a (small) cost we can spare".
> > 
> > The main problem I still would like to address are the data races.
> > While the stores and loads cannot be dropped, and we can tolerate their
> > reordering, they could still be teared, fused, perhaps invented...
> > According to [1] these types of optimizations are not unheard.
> > 
> > Load tearing alone could easily produce values that are not stale, but
> > wrong.  Do we also tolerate wrong values, even if they are infrequent?
> > 
> > Another detail I should have mentioned sooner is that READ_ONCE() and
> > WRITE_ONCE() cause only minor (gcc) to no (clang) changes to the
> > generated code for x86_64 and i386.[2]  While this seems contrary to the
> > point I am trying to make, I want to show that, for the most part, these
> > changes just lock in a reasonable compiler behavior.
> > 
> > Specifically, on x86_64/gcc (the most relevant arch/compiler for this
> > driver) the changes are restricted to kraken2_read:
> > 
> > 1.	Loading of priv->updated and jiffies are reordered, because
> > 	(with READ_ONCE()) both are volatile and time_after(a, b) is
> > 	defined as b - a.
> > 
> 
> Are you really trying to claim that much of the time_after() code
> in the Linux kernel is wrong ?

No.

(nor do I otherwise think that)

I am merely describing the changes observed when introducing READ_ONCE/
WRITE_ONCE.  They aren't an argument for them; if anything, they are
a counter argument.  Ideally, there would be none of these unnecessary
(from our point of view) changes.

But the absence of more costly ones, together with the proposition that
right now the compiler is free to generate much less reasonable code
than it currently does, is the argument I am trying to make for
READ_ONCE/WRITE_ONCE.

> > 2.	When loading priv->fan_input[channel],
> > 		movzx  eax,WORD PTR [rdx+rcx*2+0x14]
> > 	is split into
> > 		add rcx,0x8
> > 		movzx  eax,WORD PTR [rdx+rcx*2+0x4]
> > 	for no reason I could find in the x86 manual.
> > 
> > 3.	Similarly, when loading priv->temp_input[channel]
> > 		movsxd rax,DWORD PTR [rdx+rcx*4+0x10]
> > 	turns into
> > 		add    rcx,0x4
> > 		movsxd rax,DWORD PTR [rdx+rcx*4]
> > 
> I hardly see how this matters. In both cases, rax enda up with the same value.
> Maybe rcx is reused later on. If not, maybe the compiler had a bad day.

Oddly, no, rcx is not reused before the return.

> But that is not an argument for using READ_ONCE/WRITE_ONCE; after all, the

No, of course not (see above).

> same will happen with all other indexed accesses.

... still, I did not understand what you meant here.  Can you clarify?

Thanks,
Jonas

> Guenter
> 
> > Both 2 and 3 admittedly get a bit worse with READ_ONCE()/WRITE_ONCE().
> > But that is on gcc, and with the data race it could very well decide to
> > produce much worse code than that at any moment.
> > 
> > On Arm64 the code does get a lot more ordered, which we have already
> > agreed is not really necessary.  But removing smp_load_acquire() and
> > smp_store_release() should still allow the CPU to reorder those,
> > mitigating some of the impact.
> > 
> > I hope this email clarifies what I am concerned about.
> > 
> > Thanks for the patience,
> > Jonas
> > 
> > P.S. Tested with gcc 10.2.0 and clang 11.1.0.
> > 
> > [1] https://lwn.net/Articles/793253/
> > [2] (outdated, still with smp_*()): https://github.com/jonasmalacofilho/patches/tree/master/linux/nzxt-kraken2-mark-and-order-concurrent-accesses/objdumps
> > 
> 
