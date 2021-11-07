Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90F2447456
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 18:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhKGROm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 12:14:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:41072 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhKGROl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 12:14:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="230834401"
X-IronPort-AV: E=Sophos;i="5.87,216,1631602800"; 
   d="scan'208";a="230834401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 09:11:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,216,1631602800"; 
   d="scan'208";a="502693291"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 09:11:57 -0800
Date:   Sun, 7 Nov 2021 09:11:57 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvdimm/pmem: Fix an error handling path in
 'pmem_attach_disk()'
Message-ID: <20211107171157.GC3538886@iweiny-DESK2.sc.intel.com>
References: <f1933a01d9cefe24970ee93d741babb8fe9c1b32.1636219557.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1933a01d9cefe24970ee93d741babb8fe9c1b32.1636219557.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021 at 06:27:11PM +0100, Christophe JAILLET wrote:
> If 'devm_init_badblocks()' fails, a previous 'blk_alloc_disk()' call must
> be undone.

I think this is a problem...

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. Several fixes on error handling paths have been
> done recently, but this one has been left as-is. There was maybe a good
> reason that I have missed for that. So review with care!
> 
> I've not been able to identify a Fixes tag that please me :(
> ---
>  drivers/nvdimm/pmem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index fe7ece1534e1..c37a1e6750b3 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -490,8 +490,9 @@ static int pmem_attach_disk(struct device *dev,
>  	nvdimm_namespace_disk_name(ndns, disk->disk_name);
>  	set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
>  			/ 512);
> -	if (devm_init_badblocks(dev, &pmem->bb))
> -		return -ENOMEM;
> +	rc = devm_init_badblocks(dev, &pmem->bb);
> +	if (rc)
> +		goto out;

But I don't see this 'out' label in the function currently?  Was that part of
your patch missing?

Ira

>  	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
>  	disk->bb = &pmem->bb;
>  
> -- 
> 2.30.2
> 
