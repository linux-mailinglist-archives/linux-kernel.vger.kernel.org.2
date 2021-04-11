Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0356135B38C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhDKLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:31:26 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:34308 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233696AbhDKLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:31:25 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id AC886181D2098;
        Sun, 11 Apr 2021 11:31:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 32507315D79;
        Sun, 11 Apr 2021 11:31:07 +0000 (UTC)
Message-ID: <6fbc8d6b885771ad4e69fc6789d07fd2b66f01d5.camel@perches.com>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
From:   Joe Perches <joe@perches.com>
To:     Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Date:   Sun, 11 Apr 2021 04:31:06 -0700
In-Reply-To: <20210410211152.1938-1-amonakov@ispras.ru>
References: <20210410211152.1938-1-amonakov@ispras.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32507315D79
X-Spam-Status: No, score=0.10
X-Stat-Signature: gxjes4ah47oq6d917spxhf1rbfm9bpsm
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18gDYP58m9/GUiRCS+mgNCaIQI5Gz2Pa7s=
X-HE-Tag: 1618140667-663278
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing the printk maintainers)

On Sun, 2021-04-11 at 00:11 +0300, Alexander Monakov wrote:
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
> Restore the newline, and call pr_info with empty format string to set
> the loglevel for subsequent pr_cont calls. The same solution is used in
> EFI and uvesafb drivers.
> 
> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>  drivers/iommu/amd/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 596d0c413473..a25e241eff1c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1929,8 +1929,11 @@ static void print_iommu_info(void)
>  		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
>  
> 
>  		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
> -			pci_info(pdev, "Extended features (%#llx):",
> +			pci_info(pdev, "Extended features (%#llx):\n",
>  				 iommu->features);
> +
> +			pr_info("");
> +
>  			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
>  				if (iommu_feature(iommu, (1ULL << i)))
>  					pr_cont(" %s", feat_str[i]);

This shouldn't be necessary.
If this is true then a lot of output logging code broke.



