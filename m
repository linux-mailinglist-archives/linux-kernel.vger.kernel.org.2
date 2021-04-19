Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6478E364A84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbhDSTYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:24:07 -0400
Received: from mail.ispras.ru ([83.149.199.84]:51704 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241686AbhDSTX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:23:56 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 5E0EC4076B4A;
        Mon, 19 Apr 2021 19:23:23 +0000 (UTC)
Date:   Mon, 19 Apr 2021 22:23:23 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Joe Perches <joe@perches.com>
cc:     linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/amd: Fix extended features logging
In-Reply-To: <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
Message-ID: <alpine.LNX.2.20.13.2104192207130.19608@monopod.intra.ispras.ru>
References: <20210411211330.2252-1-amonakov@ispras.ru> <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="168458499-251955098-1618860203=:19608"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168458499-251955098-1618860203=:19608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 11 Apr 2021, Joe Perches wrote:

> > v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
> > solution
> > 
> >  drivers/iommu/amd/init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index 596d0c413473..62913f82a21f 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
> >  		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
> >  
> > 
> >  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> > -			pci_info(pdev, "Extended features (%#llx):",
> > -				 iommu->features);
> > +			pr_info("Extended features (%#llx):", iommu->features);
> > +
> >  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
> >  				if (iommu_feature(iommu, (1ULL << i)))
> >  					pr_cont(" %s", feat_str[i]);
> 
> How about avoiding all of this by using a temporary buffer
> and a single pci_info.

I think it is mostly up to the maintainers, but from my perspective, it's not
good to conflate such a simple bugfix with the substantial rewrite you are
proposing (which also increases code complexity).

My two-line patch is a straightforward fix to a bug that people already agreed
needs to be fixed (just the previous attempt turned out to be insufficient). If
there's a desire to eliminate pr_cont calls (which I wouldn't support in this
instance), the rewrite can go in separately from the bugfix.

A major problem with landing a simple bugfix together with a rewrite in a big
patch is that if a rewrite causes a problem, the whole patch gets reverted and
we end up without a trivial bugfix.

And, once again: can we please not emit the feature list via pci_info, the line
is long enough already even without the pci bus location info.

Joerg, are you satisfied with my v2 patch, are you waiting for anything before
picking it up?

Alexander

> 
> Miscellanea:
> o Move the feat_str and i declarations into the if block for locality
> 
> ---
>  drivers/iommu/amd/init.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 321f5906e6ed..0d219044726e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1943,30 +1943,37 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  
>  static void print_iommu_info(void)
>  {
> -	static const char * const feat_str[] = {
> -		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> -		"IA", "GA", "HE", "PC"
> -	};
>  	struct amd_iommu *iommu;
>  
>  	for_each_iommu(iommu) {
>  		struct pci_dev *pdev = iommu->dev;
> -		int i;
>  
>  		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
>  
>  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> -				 iommu->features);
> +			static const char * const feat_str[] = {
> +				"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
> +				"IA", "GA", "HE", "PC"
> +			};
> +			int i;
> +			char features[128] = "";
> +			int len = 0;
> +
>  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
> -				if (iommu_feature(iommu, (1ULL << i)))
> -					pr_cont(" %s", feat_str[i]);
> +				if (!iommu_feature(iommu, BIT_ULL(i)))
> +					continue;
> +				len += scnprintf(features + len,
> +						 sizeof(features) - len,
> +						 " %s", feat_str[i]);
>  			}
>  
>  			if (iommu->features & FEATURE_GAM_VAPIC)
> -				pr_cont(" GA_vAPIC");
> +				len += scnprintf(features + len,
> +						 sizeof(features) - len,
> +						 " %s", "GA_vPIC");
>  
> -			pr_cont("\n");
> +			pci_info(pdev, "Extended features (%#llx):%s\n",
> +				 iommu->features, features);
>  		}
>  	}
>  	if (irq_remapping_enabled) {
> 
> 
> 
--168458499-251955098-1618860203=:19608--
