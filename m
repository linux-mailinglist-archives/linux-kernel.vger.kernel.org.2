Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2B392C68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhE0LRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:17:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:31870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhE0LRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:17:42 -0400
IronPort-SDR: kwDFGaJvqb7XDacrzHtcgee6Lc8WII41M4UVFuh0Pl5YUx1pVNhNoayfik6TU72bMLOBi/nilg
 bMA/dZ+MLMHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="266597979"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="266597979"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 04:16:07 -0700
IronPort-SDR: 6CbIEesmm+lUth9+uOM2iluGxfBnGVTzU9qVQb/DsibTzqEGflwjzxR/ovtXWKSRFVRLs6l3F1
 iY5NTHEqI3cA==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547761583"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.9.95]) ([10.213.9.95])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 04:16:04 -0700
Subject: Re: [PATCH -next] ASoC: Intel: Skylake: use DEVICE_ATTR_RO macro
To:     YueHaibing <yuehaibing@huawei.com>,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210524115506.35724-1-yuehaibing@huawei.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <11235207-1b76-fbfd-316e-a4f6f885d928@intel.com>
Date:   Thu, 27 May 2021 13:16:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524115506.35724-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-24 1:55 PM, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Thanks for your input.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Regards,
Czarek

>   sound/soc/intel/skylake/skl-nhlt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
> index 87c891c46291..64226072f0ee 100644
> --- a/sound/soc/intel/skylake/skl-nhlt.c
> +++ b/sound/soc/intel/skylake/skl-nhlt.c
> @@ -149,8 +149,8 @@ int skl_nhlt_update_topology_bin(struct skl_dev *skl)
>   	return 0;
>   }
>   
> -static ssize_t skl_nhlt_platform_id_show(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> +static ssize_t platform_id_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>   {
>   	struct pci_dev *pci = to_pci_dev(dev);
>   	struct hdac_bus *bus = pci_get_drvdata(pci);
> @@ -166,7 +166,7 @@ static ssize_t skl_nhlt_platform_id_show(struct device *dev,
>   	return sprintf(buf, "%s\n", platform_id);
>   }
>   
> -static DEVICE_ATTR(platform_id, 0444, skl_nhlt_platform_id_show, NULL);
> +static DEVICE_ATTR_RO(platform_id);
>   
>   int skl_nhlt_create_sysfs(struct skl_dev *skl)
>   {
> 
