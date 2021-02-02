Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855330BA1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhBBIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:40:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:39921 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhBBIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:39:54 -0500
IronPort-SDR: JfMfCd3CYtABHYIj4qpcAY5BmKa1fuQ1Yv0/7Qb1epUMYmx4DYtt4TzcJTbRC69uVwfO2HWqHf
 qVEp7GXS04Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="167926184"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="167926184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:38:07 -0800
IronPort-SDR: 25nJEXC6Eo2ZVFdDKTpuj8jByfCWS5snTrgr8nHnDtg3g3y/959Cff7F/5fjVv99ICIGuwBIb0
 IVcumXJipUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="391353919"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga008.jf.intel.com with SMTP; 02 Feb 2021 00:38:02 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:38:01 +0200
Date:   Tue, 2 Feb 2021 10:38:01 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Zhaoge Zhang <zhangzhaoge@loongson.cn>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix drm_atomic_get_new_crtc_state call error
Message-ID: <YBkPaYiyyYjV/NMH@intel.com>
References: <1612172024-3556-1-git-send-email-zhangzhaoge@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612172024-3556-1-git-send-email-zhangzhaoge@loongson.cn>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 05:33:44PM +0800, Zhaoge Zhang wrote:
> This position is to clear the previous mask flags,
> so drm_atomic_get_crtc_state should be used.
> 
> Signed-off-by: Zhaoge Zhang <zhangzhaoge@loongson.cn>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 268bb69..07fe01b 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -313,8 +313,8 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>  		return 0;
>  
>  	if (conn_state->crtc) {
> -		crtc_state = drm_atomic_get_new_crtc_state(conn_state->state,
> -							   conn_state->crtc);
> +		crtc_state = drm_atomic_get_crtc_state(conn_state->state,
> +							conn_state->crtc);

drm_atomic_get_new_crtc_state() should be fine here since
drm_atomic_get_connector_state() will have added the old
crtc to the state already.

>  
>  		crtc_state->connector_mask &=
>  			~drm_connector_mask(conn_state->connector);
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
