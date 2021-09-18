Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06485410601
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbhIRLPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbhIRLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:15:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03113C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:13:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q3so40117277edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vr2U1g0cHwYjPOSj/zot+rofFLB5h1tCK6NQz/LyYE=;
        b=ktJ6F95cTA1GygDzE7c5ZtbpuPy6Uini85+rNZuEpmM732dC56TDIuHQ42No5D3rNq
         xyLHzOa1lykeFa47OuvPsmpoSPWjjrYyQZbfqiLeOCgCPzuMSiDCfxq48e2VGCfzXcjX
         C5F5E15K5+3DLlNcprvf9L3JkXkD7r58aYYJw4/KiEEnQvH8ud/kGhJEBFIoyLig7yKM
         aDgPjViPmAiFNx/3S4MzcI5MIn1zDVhzZNxykhGOnizx9CksOpRbfxU1oFIVhPtGh6Gc
         aamk33p1cAkCqpI0dE5m+mrmKKUM/EHQyy4iNwfmh2qaWVwQgzoeyP2LNS2/ESmYVmp6
         /ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vr2U1g0cHwYjPOSj/zot+rofFLB5h1tCK6NQz/LyYE=;
        b=onpcy9rDzFSex+RQJKQk8BF0bLge4v/infzVDZ131XuI1MA5w+Z+QING9YtRZPu/Dg
         vpIBFB0CsXhUo6/DNPdUSuc18itZaXXyno/wEHkOh1bw2pi347ALJnnoYThPjSqUfAhb
         itVtZyvGIVb4vH4rwehRe63er7yrQECRBRtZ5gciqEoEqQhqM2NpkRiIOwp5yxIn/KED
         7BVAkOJyyIS8CVQRtFxc3zYCIQWvYtiyo/mUrll5l1M0G3gjdrLU0jvfCsXtwd7vQSG+
         dfj2pezIPulEbfaIUi2frZ2A1pCrp9ON7J7WPp7MwN8ICtyaXxN8tm8pgx5c3WQ5sakO
         OcnA==
X-Gm-Message-State: AOAM532JQt+A+8DBkyHdM0Hm6EClFzDsun/hOn3EQX5cWlP90R2dhvXD
        UILz9cOjdDufH94x4uzEMR4=
X-Google-Smtp-Source: ABdhPJw+Wub1Nm0D6xiJKPChmzA+MVSq3jw11+5fT1PMrsC8+XDpKgxxZOHPfzaabMZg03AVVX8OcQ==
X-Received: by 2002:a17:906:3fd7:: with SMTP id k23mr17245844ejj.176.1631963632371;
        Sat, 18 Sep 2021 04:13:52 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id a24sm4055999edu.49.2021.09.18.04.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 04:13:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 15/19] staging: r8188eu: clean up usbctrl_vendorreq()
Date:   Sat, 18 Sep 2021 13:13:48 +0200
Message-ID: <1988292.s3joEKjhKX@localhost.localdomain>
In-Reply-To: <YUSpwTneDgRtUBvM@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com> <20210917071837.10926-16-fmdefrancesco@gmail.com> <YUSpwTneDgRtUBvM@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 17, 2021 4:44:17 PM CEST Greg Kroah-Hartman wrote:
> On Fri, Sep 17, 2021 at 09:18:33AM +0200, Fabio M. De Francesco wrote:
> > Clean up usbctrl_vendoreq() in usb_ops_linux.c.
> > 
> > List of changes:
> > 
> > 1) Rename variables:
> > 	pdata => data
> >         pio_priv => io_priv
> >         pintfhdl => intfhdl
> >         wvalue => address.
> > 2) Reorder variables declarations according to the "Reverse Xmas Tree"
> >    style.
> > 3) Remove unnecessary test for "!pIo_buf".
> > 4) Move comments one line below code.
> > 5) Remove unnecessary excess parentheses.
> > 6) Remove unnecessary extra spaces.
> > 7) Remove unnecessary comments.
> > 8) Fix grammar errors (checksumed => checksummed).
> 
> When you find yourself listing all of the different things you have done
> in a single commit, that is a HUGE hint that you need to break this up
> into smaller pieces.
> 
> Please do so here, this should not be just one change, as it's almost
> impossible to look at this and "know" it's all still the same logic
> happening here.  But if you had broken this down into 8 different
> changes, then it would have been obvious and I could easily have applied
> the changes.

Dear Greg,

My first thought when I read you message was to simply delete this patch 
because usbctrl_vendorreq() is going to be deleted in 18/19. But then I 
rethought of the original purpose behind this patch and (after talking with 
Pavel) we decided to do the task you asked and split this patch into 8 
smaller ones. The only reason is because, as you noticed, we "[]are moving 
code around", so, although I'm not required to clean up code in 
usbctrl_vendorreq(), I'm required to make the new usb_read() and usb_write() 
the cleaner the possible. This preventive clean up helps me a lot.

Obviously I guess that I'm required to split also the next patch of this 
series in 3 because there are also there 3 different kind of clean-ups.

So, we'll have a total of 11 clean-ups.

> 
> I've taken the first 14 patches in this series, it's great work, thank
> you all for doing this.  

Thanks to you for the "great work". We appreciated it.

> But this, and the remaining patches in here
> need to be split up more to make it obvious that the changes are correct
> and should be accepted.  Please feel free to start the numbering of the
> patch series over now, given that the first 14 are now merged into my
> tree.

We're working on this.

Thanks,

Fabio

> 
> thanks,
> 
> greg k-h
> 




