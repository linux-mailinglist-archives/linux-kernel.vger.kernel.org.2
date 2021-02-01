Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7A830B2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBAWPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:15:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:21874 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBAWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:15:41 -0500
IronPort-SDR: KpqDNxTTqGSN7kY+dJZCL3hfkEYI8jBrzthrlGJdJDal28olaErKcJSzdImDxz46l4i0f6n3/b
 oPuW02ik3NkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168441607"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="168441607"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:13:55 -0800
IronPort-SDR: k+DSzuSbx/nUyBmHFSNswXkbIERwisUZHZgb+djSOhQQ0beal1nSEl0Aqn7J1V/qDXZoa+lntX
 auRjh2B+D2GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="370133505"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga008.fm.intel.com with SMTP; 01 Feb 2021 14:13:51 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 02 Feb 2021 00:13:50 +0200
Date:   Tue, 2 Feb 2021 00:13:50 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sam McNally <sammc@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
Message-ID: <YBh9HvbIRF4zd+AK@intel.com>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:13:53PM +1000, Sam McNally wrote:
> From: Hans Verkuil <hans.verkuil@cisco.com>
> 
> For adapters behind an MST hub use the correct AUX channel.
> 
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> [sammc@chromium.org: rebased, removing redundant changes]
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 15b6cc39a754..0d753201adbd 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
>  	drm_dp_mst_topology_put_port(port);
>  }
>  
> +static ssize_t
> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
> +
>  static struct drm_dp_mst_port *
>  drm_dp_mst_add_port(struct drm_device *dev,
>  		    struct drm_dp_mst_topology_mgr *mgr,
> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
>  	port->port_num = port_number;
>  	port->mgr = mgr;
>  	port->aux.name = "DPMST";
> +	mutex_init(&port->aux.hw_mutex);
> +	mutex_init(&port->aux.cec.lock);
>  	port->aux.dev = dev->dev;
>  	port->aux.is_remote = true;
>  
> +	port->aux.transfer = drm_dp_mst_aux_transfer;
> +

This was supposed to be handled via higher levels checking for
is_remote==true.

>  	/* initialize the MST downstream port's AUX crc work queue */
>  	drm_dp_remote_aux_init(&port->aux);
>  
> @@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>  	return 0;
>  }
>  
> +static ssize_t
> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
> +{
> +	struct drm_dp_mst_port *port =
> +		container_of(aux, struct drm_dp_mst_port, aux);
> +	int ret;
> +
> +	switch (msg->request & ~DP_AUX_I2C_MOT) {
> +	case DP_AUX_NATIVE_WRITE:
> +	case DP_AUX_I2C_WRITE:
> +	case DP_AUX_I2C_WRITE_STATUS_UPDATE:
> +		ret = drm_dp_send_dpcd_write(port->mgr, port, msg->address,
> +					     msg->size, msg->buffer);

That doesn't make sense to me. I2c writes and DPCD writes
are definitely not the same thing.

aux->transfer is a very low level thing. I don't think it's the
correct level of abstraction for sideband.

> +		break;
> +
> +	case DP_AUX_NATIVE_READ:
> +	case DP_AUX_I2C_READ:
> +		ret = drm_dp_send_dpcd_read(port->mgr, port, msg->address,
> +					    msg->size, msg->buffer);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
>  {
>  	if (dp_link_bw == 0 || dp_link_count == 0)
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
