Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67A326750
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBZTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:15:37 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0CC061788
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:14:56 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id k13so10030777otn.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdjUcLxk2QvpLN9cIgDlB2j3H6R/HkQpTGOCpOO1Kzc=;
        b=mkm2dkX4Y+Z734KK7R323V1DAZfdISDSI0DyUExHe3MEfmafJkwFgjh/MTITPaACIx
         6ri8ig6m2bvOCL6L5Vlj2iD5X04ZxDr7tMQYc+Vl09dTP5tcXLzXZP4enTSGazUZ8WUT
         9jo8+oA2bc4w/7CQ1305a0+MIWEVgGfzw/gBlGvjFRDkrZjYkh1LipSMxOxUqoRuzjnh
         3F2SpdqnJdHkzxXCh/DwUKJGbMPlGENG8X+95/t66ABEPVttZ8DvUR4BYhcWwuM8E2Ga
         bMT64Tv03tP5ceB2fLJJO8qqQctHge9YmIawYoxZN6PXA239Et13LGoTpuh6sg0BHgRC
         Tbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdjUcLxk2QvpLN9cIgDlB2j3H6R/HkQpTGOCpOO1Kzc=;
        b=irK9TAsdEeFx5h+/QdhgR/QPDTe/t6ScYaEezuPxmtoBQgRnVReOBGZ9yg9X+N91di
         8gWrv4l0Z/NC6RdJ8VMPXrdA0hIFHc/xE6/K//RcnELjJ2vHgzJe1fjUaOo+8BWEdxKH
         iKO/EvfOAf378tykRGSEJuqjtKu7VNAyrwLqJLC8cklsAHAliD7uYGNB9HePfFUS2du2
         +E8mkIMy1gWvsKOo3AxaxtR7xjfbb8HZgOUfpXa7AW8tw8NkGUWvdNndH9clep1EfFme
         pvmoaaoNxciY3hzMfqr0BaSTMtgZNbjXD/VFhfnoix4aRELB/H9ifgrn0Vdo6bPNBLvx
         uvjg==
X-Gm-Message-State: AOAM532mHC6fjWSLSVRb2kwPARmV3maeX7KgJU2JteM07trdVqdUd24M
        caMHm+vdrVtJaemTbQZjm2gb/Q==
X-Google-Smtp-Source: ABdhPJxzYAfho+QsHxzw0qLDDKe+oOdenr7TqRA2BY16Q3eGFcAz2SSEe8X4Q7pgZcv10c+yJEjeAg==
X-Received: by 2002:a9d:ec8:: with SMTP id 66mr3553224otj.217.1614366896253;
        Fri, 26 Feb 2021 11:14:56 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 64sm1965824otl.5.2021.02.26.11.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:14:55 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:14:54 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <YDlIrjkfv16o4Nu3@builder.lan>
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <YDku5PFQZetP4iG8@builder.lan>
 <CAF6AEGvJF19JA5hNps37urMrF5r03y90XgvO4FtT6wFPD6UZcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGvJF19JA5hNps37urMrF5r03y90XgvO4FtT6wFPD6UZcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:

> On Fri, Feb 26, 2021 at 9:24 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:
> >
> > > Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
> > > both implement "arm,mmu-500" in some QTI SoCs and to run through
> > > adreno smmu specific implementation such as enabling split pagetables
> > > support, we need to match the "qcom,adreno-smmu" compatible first
> > > before apss smmu or else we will be running apps smmu implementation
> > > for adreno smmu and the additional features for adreno smmu is never
> > > set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
> > > and adreno smmu implementing "arm,mmu-500", so the adreno smmu
> > > implementation is never reached because the current sequence checks
> > > for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
> > > specific impl and we never reach adreno smmu specific implementation.
> > >
> >
> > So you're saying that you have a single SMMU instance that's compatible
> > with both an entry in qcom_smmu_impl_of_match[] and "qcom,adreno-smmu"?
> >
> > Per your proposed change we will pick the adreno ops _only_ for this
> > component, essentially disabling the non-Adreno quirks selected by the
> > qcom impl. As such keeping the non-adreno compatible in the
> > qcom_smmu_impl_init[] seems to only serve to obfuscate the situation.
> >
> > Don't we somehow need the combined set of quirks? (At least if we're
> > running this with a standard UEFI based boot flow?)
> >
> 
> are you thinking of the apps-smmu handover of display context bank?
> That shouldn't change, the only thing that changes is that gpu-smmu
> becomes an mmu-500, whereas previously only apps-smmu was..
> 

The current logic picks one of:
1) is the compatible mentioned in qcom_smmu_impl_of_match[]
2) is the compatible an adreno
3) no quirks needed

The change flips the order of these, so the only way I can see this
change affecting things is if we expected a match on #2, but we got one
on #1.

Which implies that the instance that we want to act according to the
adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
wrong, or there's a single instance that needs both behaviors.

(And I believe Jordan's answer confirms the latter - there's a single
SMMU instance that needs all them quirks at once)

Regards,
Bjorn
