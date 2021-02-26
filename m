Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E775832671F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhBZStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBZSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:48:57 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30694C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:48:16 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id g27so9311744iox.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=dFlVFMXR6zkeSmTa+VmhKZsBr7CDjQVvbvNL54kRIqM=;
        b=lPOMa+8pvfomnNffVsiwlHQ22Eqfsox3m5BrPOt8XmAT8QMELdsaOcKmDKK4NyC0IH
         yarH4QuwPNfNLn7Aj1q1GrIYyz4DHgoe8Z4hAPa8GgjS+ca1x4/18xaUDxHQ942fDHMd
         43PaWg5k76d9y84bYv64IkqR0sIM1PxDLH9LpEwMBgt0Qg8jB7vVgO1998dOItGkAAS1
         xclYdZjvB+A8QuGH6HlT5f36+Fio8F/CmWEw63mIIYpR0mhJXiXBmR1h+mDs+WESU6OS
         Pm6d34hPOoT1mV0Jfg5H73VoRPyHWcnx0KRlMsmb3ZhVd7IKBqJA6hvNDcIf+zaOemba
         pX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=dFlVFMXR6zkeSmTa+VmhKZsBr7CDjQVvbvNL54kRIqM=;
        b=Zf6v4IfGiM19SKJ6IoB8qWz/mdluGMppbnk6AbrtY9I6PYYzFdjA9fFvGw1F+ulUzQ
         wgDIHK3/EOn7bAf6P8Kwo+yWO/L/xrN+P8YgGqMi2EKJLzXLh3/xqv/4soMPpi5XfjFZ
         y91gNAktgtJQLcT/87Ge7Q3AnJSvH7VRmmHOKNN/PuCPrsYoScap//VOh/lKvWiboE50
         grox3Ql6St1jju7flcpR7tt0gGvBV1AHZF7T+bHyyafq5/y/NsSOIuILX/OYwxzgnsbs
         Pk2kX8t9GhGM6rBNXDK064smiRadW7vX+xOsTBZb4XjjQyzhZBJhPdLKu0Er3gzaBK3C
         0m/Q==
X-Gm-Message-State: AOAM531iiNCVLtk8XHpusWG1d9e9W8wHXEzpzcJhoKwB4KHdpweEs7UC
        ADCTkf3OxPKWyheNkXzyHvWlOA==
X-Google-Smtp-Source: ABdhPJzz6Vy+v1BXGIBBrGM1fsQ0mK/bOWqRSOpsYqFZq6XCJvNZFJP25EUBTuUjZXnR7EaojvuObQ==
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr1661589ioh.73.1614365295679;
        Fri, 26 Feb 2021 10:48:15 -0800 (PST)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net. [71.237.100.236])
        by smtp.gmail.com with ESMTPSA id h23sm4744598ila.15.2021.02.26.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 10:48:15 -0800 (PST)
Date:   Fri, 26 Feb 2021 11:48:13 -0700
From:   Jordan Crouse <jordan@cosmicpenguin.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <20210226184813.t6ohkh3gxeseev2j@cosmicpenguin.net>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <YDku5PFQZetP4iG8@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDku5PFQZetP4iG8@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:24:52AM -0600, Bjorn Andersson wrote:
> On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:
> 
> > Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
> > both implement "arm,mmu-500" in some QTI SoCs and to run through
> > adreno smmu specific implementation such as enabling split pagetables
> > support, we need to match the "qcom,adreno-smmu" compatible first
> > before apss smmu or else we will be running apps smmu implementation
> > for adreno smmu and the additional features for adreno smmu is never
> > set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
> > and adreno smmu implementing "arm,mmu-500", so the adreno smmu
> > implementation is never reached because the current sequence checks
> > for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
> > specific impl and we never reach adreno smmu specific implementation.
> > 
> 
> So you're saying that you have a single SMMU instance that's compatible
> with both an entry in qcom_smmu_impl_of_match[] and "qcom,adreno-smmu"?
> 
> Per your proposed change we will pick the adreno ops _only_ for this
> component, essentially disabling the non-Adreno quirks selected by the
> qcom impl. As such keeping the non-adreno compatible in the
> qcom_smmu_impl_init[] seems to only serve to obfuscate the situation.
> 
> Don't we somehow need the combined set of quirks? (At least if we're
> running this with a standard UEFI based boot flow?)

We *do* need the combined set of quirks, so there has to be an adreno-smmu
impelmentation that matches the "generic" implementation with a few extra
function hooks added on. I'm not sure if there is a clever way to figure out how
to meld the implementation hooks at runtime but the alternative is to just make
sure that the adreno-smmu static struct calls the same quirks as its generic
partner.

Jordan

> > Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index bea3ee0dabc2..03f048aebb80 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -345,11 +345,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> >  {
> >  	const struct device_node *np = smmu->dev->of_node;
> >  
> > -	if (of_match_node(qcom_smmu_impl_of_match, np))
> > -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> > -
> > +	/*
> > +	 * Do not change this order of implementation, i.e., first adreno
> > +	 * smmu impl and then apss smmu since we can have both implementing
> > +	 * arm,mmu-500 in which case we will miss setting adreno smmu specific
> > +	 * features if the order is changed.
> > +	 */
> >  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
> >  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
> >  
> > +	if (of_match_node(qcom_smmu_impl_of_match, np))
> > +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> > +
> >  	return smmu;
> >  }
> > -- 
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> > 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
