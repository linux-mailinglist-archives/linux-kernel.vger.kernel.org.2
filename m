Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA333A223D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 04:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFJCXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 22:23:24 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:37060
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229507AbhFJCXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 22:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=NMsSgl6f+0/76cM6TWJIRwVGyQWYDV2Tj3+p
        XgGcVjw=; b=h0DdnxmDGdxo/ZvlIym9A/BSoYA8FvRFABsDpIC8PpAroL2Fg8Q7
        eMnqA0rb9qKSRA0+qUfiTrQuALWbYnYgGcy0NpfWsvH25n66Ow/yXHrH5ZI9ZyxF
        tYYPBkrc22ILJ7++iGriysV4XdC8KFb8NJ42oEyjuZlrvPZUGRe3aIg=
Received: by ajax-webmail-app2 (Coremail) ; Thu, 10 Jun 2021 10:20:24 +0800
 (GMT+08:00)
X-Originating-IP: [10.162.161.90]
Date:   Thu, 10 Jun 2021 10:20:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Xiyu Yang" <19210240158@fudan.edu.cn>
To:     "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Will Deacon" <will@kernel.org>, "Joerg Roedel" <joro@8bytes.org>,
        "Nicolin Chen" <nicoleotsuka@gmail.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Krishna Reddy" <vdumpa@nvidia.com>,
        "Jordan Crouse" <jordan@cosmicpenguin.net>,
        "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
Subject: Re: Re: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak
 when arm_smmu_rpm_get fails
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20200917(8294e55f) Copyright (c) 2002-2021 www.mailtech.cn fudan.edu.cn
In-Reply-To: <e5b8d7f6-862e-bca4-a1e9-35e0de47440e@arm.com>
References: <1623245709-11123-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <e5b8d7f6-862e-bca4-a1e9-35e0de47440e@arm.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: 7bit
X-CM-CTRLDATA: ZmoaFmZvb3Rlcl90eHQ9Mzk1ODoxMA==
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3da0a67a.3d4d.179f3b87d02.Coremail.19210240158@fudan.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: XQUFCgCHTGvodsFgpJpUAw--.21437W
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/1tbiAQwIAVKp4t+ptgACsf
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your advice, I'll send a v2 patch soon.


> -----Original Messages-----
> From: "Robin Murphy" <robin.murphy@arm.com>
> Sent Time: 2021-06-09 22:12:11 (Wednesday)
> To: "Xiyu Yang" <xiyuyang19@fudan.edu.cn>, "Will Deacon" <will@kernel.org>, "Joerg Roedel" <joro@8bytes.org>, "Nicolin Chen" <nicoleotsuka@gmail.com>, "Bjorn Andersson" <bjorn.andersson@linaro.org>, "Krishna Reddy" <vdumpa@nvidia.com>, "Jordan Crouse" <jordan@cosmicpenguin.net>, "Sai Prakash Ranjan" <saiprakash.ranjan@codeaurora.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
> Cc: yuanxzhang@fudan.edu.cn, "Xin Tan" <tanxin.ctf@gmail.com>
> Subject: Re: [PATCH] iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
> 
> On 2021-06-09 14:35, Xiyu Yang wrote:
> > arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
> > refcount of the "smmu" even though the return value is less than 0.
> > 
> > The reference counting issue happens in some error handling paths of
> > arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
> > fails, the caller functions forget to decrease the refcount of "smmu"
> > increased by arm_smmu_rpm_get(), causing a refcount leak.
> > 
> > Fix this issue by calling arm_smmu_rpm_put() or jumping to the "rpm_put"
> > label when arm_smmu_rpm_get() fails.
> 
> If only there was some kind of helper function which could encapsulate 
> the correct expected behaviour in a single place...
> 
> In fact with the new pm_runtime_resume_and_get() API I think these two 
> patches boil down to a one-line change.
> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 6f72c4d208ca..177ee54c5534 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -840,7 +840,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> >   	if (ret < 0)
> > -		return;
> > +		goto rpm_put;
> >   
> >   	/*
> >   	 * Disable the context bank and free the page tables before freeing
> > @@ -857,6 +857,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> >   	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> >   	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> >   
> > +rpm_put:
> >   	arm_smmu_rpm_put(smmu);
> >   }
> >   
> > @@ -1153,7 +1154,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> >   	if (ret < 0)
> > -		return ret;
> > +		goto rpm_put;
> >   
> >   	/* Ensure that the domain is finalised */
> >   	ret = arm_smmu_init_domain_context(domain, smmu, dev);
> > @@ -1404,7 +1405,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> >   	if (ret < 0)
> > -		goto out_cfg_free;
> > +		goto rpm_put;
> >   
> >   	ret = arm_smmu_master_alloc_smes(dev);
> >   	arm_smmu_rpm_put(smmu);
> > @@ -1417,6 +1418,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >   
> >   	return &smmu->iommu;
> >   
> > +rpm_put:
> > +	arm_smmu_rpm_put(smmu);
> >   out_cfg_free:
> >   	kfree(cfg);
> >   out_free:
> > @@ -1438,8 +1441,10 @@ static void arm_smmu_release_device(struct device *dev)
> >   	smmu = cfg->smmu;
> >   
> >   	ret = arm_smmu_rpm_get(smmu);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		arm_smmu_rpm_put(smmu);
> >   		return;
> > +	}
> >   
> >   	arm_smmu_master_free_smes(cfg, fwspec);
> >   
> > 






