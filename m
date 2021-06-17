Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9143F3AB12D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhFQKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:20:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:45837 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFQKUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:20:18 -0400
IronPort-SDR: JuoiUbDJxYrjVqj2c6/aS71KnJrNKJT1ArnsHxSpjweeNswvS2BxahQtUu3bpkZdxkAo1gVzhI
 CBjMGQ+Rkp4A==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206160893"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="206160893"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 03:18:10 -0700
IronPort-SDR: HpqYa4kpXC0ZuelTPE4bdlUaMvgp+k5NgcFyeQmvzkydBKSNtK7nnOxSkDChNcJr25Lil23b+B
 49lLl0k0L7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="555162421"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Jun 2021 03:18:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 17 Jun 2021 13:18:07 +0300
Date:   Thu, 17 Jun 2021 13:18:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Add the missed altmode_id_remove() in
 typec_register_altmode()
Message-ID: <YMshX75xfDczNmS1@kuha.fi.intel.com>
References: <20210617073226.47599-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617073226.47599-1-jingxiangfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 03:32:26PM +0800, Jing Xiangfeng wrote:
> typec_register_altmode() misses to call altmode_id_remove() in an error
> path. Add the missed function call to fix it.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b9429c9f65f6..aeef453aa658 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -517,8 +517,10 @@ typec_register_altmode(struct device *parent,
>  	int ret;
>  
>  	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
> -	if (!alt)
> +	if (!alt) {
> +		altmode_id_remove(parent, id);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	alt->adev.svid = desc->svid;
>  	alt->adev.mode = desc->mode;
> -- 
> 2.26.0.106.g9fadedd

-- 
heikki
