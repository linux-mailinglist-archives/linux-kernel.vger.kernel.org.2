Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577CF35FB71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhDNTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:16:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:41716 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347863AbhDNTQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:16:27 -0400
IronPort-SDR: sOEVM88M4j3KVm7PNFy07/Bf83Y0k45RswZ2VulBP5oVpwFtE49wqgFT1MpiMeMWJn2hztKlNC
 nkzU22BbMvsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="215211993"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="215211993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:16:06 -0700
IronPort-SDR: 1zt3d8op+1asmS9HeqADSdgpMhHskIgdY2aMVRSdZ5sV+FVFy7SYATA/+eM6MGlQ+GVsQ6Sg+Y
 Dnm2L2HA9/sw==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="461333436"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:16:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWkzZ-00457j-Ut; Wed, 14 Apr 2021 22:16:01 +0300
Date:   Wed, 14 Apr 2021 22:16:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHc/cQAmLLOXwLLB@smile.fi.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com>
 <YHcqxMLR44laX2PZ@smile.fi.intel.com>
 <YHc68v7keeITnA3K@kroah.com>
 <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:14:34PM +0300, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >> Using raw buffer APIs against uuid_t / guid_t.
> >
> > So you want to do that, or you do not want to do that?  Totally
> > confused,
> 
> My understanding is that:
> 1) generate_random_uuid() use is allegedly bad even though it's in their
> header,
> 2) poking directly at the byte array inside uuid_t is bad, even though,
> again, header.
> 
> It is, indeed, not ideal.
> 
> If agreeable, I'll update this patch to the below and respin the whole
> series.

Below patch looks good to me, thanks!

> From 02340f8c7c17ace028040a35553c33cce8f3bce4 Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Wed, 22 Apr 2020 16:02:20 +0300
> Subject: [PATCH] stm class: Use correct UUID APIs
> 
> It appears that the STM code didn't manage to accurately decypher the
> delicate inner workings of an alternative thought process behind the
> UUID API and directly called generate_random_uuid() that clearly needs
> to be a static function in lib/uuid.c.
> 
> At the same time, said STM code is poking directly at the byte array
> inside the uuid_t when it uses the UUID for its internal purposes.
> 
> Fix these two transgressions by using intended APIs instead.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> [ash: changed back to uuid_t and updated the commit message]
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/hwtracing/stm/p_sys-t.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
> index 360b5c03df95..8254971c02e7 100644
> --- a/drivers/hwtracing/stm/p_sys-t.c
> +++ b/drivers/hwtracing/stm/p_sys-t.c
> @@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
>  {
>  	struct sys_t_policy_node *pn = priv;
>  
> -	generate_random_uuid(pn->uuid.b);
> +	uuid_gen(&pn->uuid);
>  }
>  
>  static int sys_t_output_open(void *priv, struct stm_output *output)
> @@ -292,6 +292,7 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
>  	unsigned int m = output->master;
>  	const unsigned char nil = 0;
>  	u32 header = DATA_HEADER;
> +	u8 uuid[UUID_SIZE];
>  	ssize_t sz;
>  
>  	/* We require an existing policy node to proceed */
> @@ -322,7 +323,8 @@ static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
>  		return sz;
>  
>  	/* GUID */
> -	sz = stm_data_write(data, m, c, false, op->node.uuid.b, UUID_SIZE);
> +	export_uuid(uuid, &op->node.uuid);
> +	sz = stm_data_write(data, m, c, false, uuid, sizeof(op->node.uuid));
>  	if (sz <= 0)
>  		return sz;
>  
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


