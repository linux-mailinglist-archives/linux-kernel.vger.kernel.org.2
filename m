Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B087141AA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhI1H43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbhI1H42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:56:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D507C061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:54:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so56460591wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f4VN/SnhPqfb/dEeJYDkJM2WbH0AefwIT+QKzstH0Q8=;
        b=qzlQe3PVamgrfOedx3vzFKyEVE37BD2Pmu1oTNeTtix60+ticgm1/crdjKGDbW+DrW
         zUkHOtCy2iZ8E4Ux+zxwrtaNtBAYwPPeLR4xBanAU2dXq6neD9wH9wSuMUcP21JGSnPb
         awbXYpU3q2BOyxQ5RxVWOQH0JW60yOAGQ6LXrnjwZhsIcJpHk96T4rTJEN+pd2iwTXrw
         hecRYw1fC48BRlLCCqIg8YfdFgoMItU7LjO5r/N+xMRDoFVoeG7tsTpCwdJNPfVGvcWE
         2dHwEL7q1uqwtOPdaw7//A9tAwqjE1i22TtFj8KDlwJh8Hoi7E5ByE6a4pl8q6HX4hyV
         clwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f4VN/SnhPqfb/dEeJYDkJM2WbH0AefwIT+QKzstH0Q8=;
        b=Rrmb3WT2N19V7mnvYkhvHjldd01elTpx/XmZdXZsB4WuNmlQI7MIpE3oBFKPuxZzPn
         kumfrnmDqzblQl1Mr6GPb/btsYNtDng7JI3xiuYu8tEOllv8DQnQOJmf6+LrEB2nN4ap
         q+FrEgmFFCXVg1unWqIdOjuyIqvLKQra1bbwaa4WVIOxMZtsRmuebvbOCFX5PeV0//JQ
         FeLKk1qqOKIOP6CSOJK8wCirVnfbXhwLONt66uB+mGUzMPygF+UdRPHVzhTyUA+gn3eh
         KiZbYaSuVWdTriYFBrCWdQ0x3i38RUnWHtE+scVOw+mMPn5Alvkq5IjkWXB6aYIxMAdW
         7S+w==
X-Gm-Message-State: AOAM530DB8yGwY+AyyjIGIVnc6RWK7zq6G2vNtK7NDeaWz6SS60gdxDc
        TbTLv6l3FHSi3DriSV8jdyyf1w==
X-Google-Smtp-Source: ABdhPJxo4xGSPJSRJOoFV6bJHHHqYhKffK7s6nvA0mYcfzzl/U5f1AFb8FTvNNUh0LiuR2Jp2Hy4uA==
X-Received: by 2002:adf:d22e:: with SMTP id k14mr4994311wrh.258.1632815687682;
        Tue, 28 Sep 2021 00:54:47 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id p10sm1375564wmq.40.2021.09.28.00.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:54:47 -0700 (PDT)
Date:   Tue, 28 Sep 2021 08:54:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mgross@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/5] MFD: intel_pmt: Support non-PMT capabilities
Message-ID: <YVLKRSQx01vB4N77@google.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
 <20210922213007.2738388-3-david.e.box@linux.intel.com>
 <YVIBI6TQrD/rehli@kroah.com>
 <d540894d3d8c05722bd924c21bd9dd9c2b9def53.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d540894d3d8c05722bd924c21bd9dd9c2b9def53.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021, David E. Box wrote:

> On Mon, 2021-09-27 at 19:36 +0200, Greg KH wrote:
> > On Wed, Sep 22, 2021 at 02:30:04PM -0700, David E. Box wrote:
> > > Intel Platform Monitoring Technology (PMT) support is indicated by presence
> > > of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
> > > structures may also be used by Intel to indicate support for other
> > > capabilities unrelated to PMT.  OOBMSM is a device that can have both PMT
> > > and non-PMT capabilities. In order to support these capabilities it is
> > > necessary to modify the intel_pmt driver to handle the creation of platform
> > > devices more generically.
> > 
> > I said this on your other driver submission, but why are you turning a
> > PCIe device into a set of platform devices and craming it into the MFD
> > subsystem?
> > 
> > PCIe devices are NOT platform devices.
> 
> But they *are* used to create platform devices when the PCIe device is multi-functional, which is
> what intel_pmt is.
> 
> > 
> > Why not use the auxiliary bus for this thing if you have individual
> > drivers that need to "bind" to the different attributes that this single
> > PCIe device is exporting.
> 
> It wasn't clear in the beginning how this would evolve. MFD made sense for the PMT (platform
> monitoring technology) driver. PMT has 3 related but individually enumerable devices on the same IP,
> like lpss. But the same IP is now being used for other features too like SDSi. We could work on
> converting this to the auxiliary bus and then covert the cell drivers.

I see this as subsequent work.  It should not affect this submission.

FWIW, I still plan to review this set for inclusion into MFD.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
