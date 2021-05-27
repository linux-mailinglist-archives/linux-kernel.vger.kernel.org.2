Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B0A392B61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhE0KFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:05:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:4589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235768AbhE0KFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:05:53 -0400
IronPort-SDR: s/N7sflE8d6Q9TECp+BIHLh1AxrRq4YPgYDamQ8qTbTAipdFxutsXIp+ji2c0DPHzeSDuXvW6u
 swMLTveAyPOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="190069620"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="190069620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 03:04:19 -0700
IronPort-SDR: W5C8h0ho+YxsKWciWBWStpIEd2Gn3EVlQk7BfRGTlX8nCU9S/FRdyUtFro7VMeQU46OVyCe3B4
 6pV2ZrVgIuww==
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="477421498"
Received: from ebenabu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.22])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 03:04:14 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] drm/i915/hdcp: Simplify code in intel_hdcp_auth_downstream()
In-Reply-To: <20210527090421.9172-1-thunder.leizhen@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210527090421.9172-1-thunder.leizhen@huawei.com>
Date:   Thu, 27 May 2021 13:04:11 +0300
Message-ID: <87sg28a3xg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> If intel_hdcp_validate_v_prime() has been successful within the allowed
> number of tries, we can directly call drm_dbg_kms() and "goto out" without
> jumping out of the loop and repeatedly judging whether the operation is
> successful. This can help us reduce an unnecessary if judgment. And it's
> a little clearer to read.

Generally I think the "happy day scenario" should be at the topmost
indentation level and not buried in the ifs with a goto exit.

BR,
Jani.

>
> No functional change.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/gpu/drm/i915/display/intel_hdcp.c | 24 ++++++++++-------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
> index d8570e14fe60..c32a854eda66 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> @@ -663,13 +663,13 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
>  
>  	ret = shim->read_ksv_fifo(dig_port, num_downstream, ksv_fifo);
>  	if (ret)
> -		goto err;
> +		goto out;
>  
>  	if (drm_hdcp_check_ksvs_revoked(&dev_priv->drm, ksv_fifo,
>  					num_downstream) > 0) {
>  		drm_err(&dev_priv->drm, "Revoked Ksv(s) in ksv_fifo\n");
>  		ret = -EPERM;
> -		goto err;
> +		goto out;
>  	}
>  
>  	/*
> @@ -680,20 +680,16 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
>  		ret = intel_hdcp_validate_v_prime(connector, shim,
>  						  ksv_fifo, num_downstream,
>  						  bstatus);
> -		if (!ret)
> -			break;
> -	}
> -
> -	if (i == tries) {
> -		drm_dbg_kms(&dev_priv->drm,
> -			    "V Prime validation failed.(%d)\n", ret);
> -		goto err;
> +		if (!ret) {
> +			drm_dbg_kms(&dev_priv->drm,
> +				    "HDCP is enabled (%d downstream devices)\n",
> +				    num_downstream);
> +			goto out;
> +		}
>  	}
>  
> -	drm_dbg_kms(&dev_priv->drm, "HDCP is enabled (%d downstream devices)\n",
> -		    num_downstream);
> -	ret = 0;
> -err:
> +	drm_dbg_kms(&dev_priv->drm, "V Prime validation failed.(%d)\n", ret);
> +out:
>  	kfree(ksv_fifo);
>  	return ret;
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
