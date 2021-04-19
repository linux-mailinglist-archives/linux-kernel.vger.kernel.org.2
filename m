Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E873647EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhDSQHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:07:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:29355 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238377AbhDSQHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:07:18 -0400
IronPort-SDR: EeRepVeNmIx4ajAMZfdyWqJRLypUE+vOxaFFCzYj2IIRW+428cAQTNZbqlagAtMBPBSaqWOXF1
 sutczh4PLDHg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="256665638"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="256665638"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 09:04:12 -0700
IronPort-SDR: t5DAkXmlvwniORyDpzVffceigCGlOZ133P9EB9TGAXhCmbq9kozvQc4vsSZzXrCgvH9xXACkPm
 WTj4fin83e9Q==
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="420062661"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 09:04:11 -0700
Date:   Mon, 19 Apr 2021 09:04:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] libnvdimm.h: Remove duplicate struct declaration
Message-ID: <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
References: <20210419112725.42145-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419112725.42145-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:
> struct device is declared at 133rd line.
> The declaration here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/libnvdimm.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 01f251b6e36c..89b69e645ac7 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
>  
>  struct nvdimm_bus;
>  struct module;
> -struct device;
>  struct nd_blk_region;

What is the coding style preference for pre-declarations like this?  Should
they be placed at the top of the file?

The patch is reasonable but if the intent is to declare right before use for
clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
device.  So perhaps this duplicate is on purpose?

Ira

>  struct nd_blk_region_desc {
>  	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
> -- 
> 2.25.1
> 
