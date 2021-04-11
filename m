Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD735B735
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 00:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhDKWWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 18:22:11 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:53684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235005AbhDKWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 18:22:09 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3B5EF1801A773;
        Sun, 11 Apr 2021 22:21:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 2902BD1513;
        Sun, 11 Apr 2021 22:21:51 +0000 (UTC)
Message-ID: <0362ad3912473d24e5927c0b54ed8fd3648c68a9.camel@perches.com>
Subject: Re: [PATCH v2] iommu/amd: Fix extended features logging
From:   Joe Perches <joe@perches.com>
To:     Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Date:   Sun, 11 Apr 2021 15:21:49 -0700
In-Reply-To: <20210411211330.2252-1-amonakov@ispras.ru>
References: <20210411211330.2252-1-amonakov@ispras.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2902BD1513
X-Spam-Status: No, score=0.10
X-Stat-Signature: 9q8g74u5wmyjuhdqzmu6sgk8n19m8uoo
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19fWofgnuzzhGoeM7lXW+imT0hmBDHhTow=
X-HE-Tag: 1618179711-799595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-12 at 00:13 +0300, Alexander Monakov wrote:
> print_iommu_info prints the EFR register and then the decoded list of
> features on a separate line:
> 
> pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
>  PPR X2APIC NX GT IA GA PC GA_vAPIC
> 
> The second line is emitted via 'pr_cont', which causes it to have a
> different ('warn') loglevel compared to the previous line ('info').
> 
> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> from the pci_info format string, but this doesn't work, as pci_info
> calls implicitly append a newline anyway.
> 
> Printing the decoded features on the same line would make it quite long.
> Instead, change pci_info() to pr_info() to omit PCI bus location info,
> which is shown in the preceding message anyway. This results in:
> 
> pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC GA_vAPIC
> AMD-Vi: Interrupt remapping enabled
> 
> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> 
> v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
> solution
> 
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 596d0c413473..62913f82a21f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
>  		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
>  
> 
>  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> -				 iommu->features);
> +			pr_info("Extended features (%#llx):", iommu->features);
> +
>  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>  				if (iommu_feature(iommu, (1ULL << i)))
>  					pr_cont(" %s", feat_str[i]);

How about avoiding all of this by using a temporary buffer
and a single pci_info.

Miscellanea:
o Move the feat_str and i declarations into the if block for locality

---
 drivers/iommu/amd/init.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed..0d219044726e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1943,30 +1943,37 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 static void print_iommu_info(void)
 {
-	static const char * const feat_str[] = {
-		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
-		"IA", "GA", "HE", "PC"
-	};
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
 		struct pci_dev *pdev = iommu->dev;
-		int i;
 
 		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pci_info(pdev, "Extended features (%#llx):",
-				 iommu->features);
+			static const char * const feat_str[] = {
+				"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
+				"IA", "GA", "HE", "PC"
+			};
+			int i;
+			char features[128] = "";
+			int len = 0;
+
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
-				if (iommu_feature(iommu, (1ULL << i)))
-					pr_cont(" %s", feat_str[i]);
+				if (!iommu_feature(iommu, BIT_ULL(i)))
+					continue;
+				len += scnprintf(features + len,
+						 sizeof(features) - len,
+						 " %s", feat_str[i]);
 			}
 
 			if (iommu->features & FEATURE_GAM_VAPIC)
-				pr_cont(" GA_vAPIC");
+				len += scnprintf(features + len,
+						 sizeof(features) - len,
+						 " %s", "GA_vPIC");
 
-			pr_cont("\n");
+			pci_info(pdev, "Extended features (%#llx):%s\n",
+				 iommu->features, features);
 		}
 	}
 	if (irq_remapping_enabled) {


