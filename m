Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7914D3C8976
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhGNRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:17:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:35631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhGNRRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:17:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232207995"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="232207995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="413353647"
Received: from alpinagh-mobl1.amr.corp.intel.com (HELO [10.212.71.223]) ([10.212.71.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:14:21 -0700
Subject: Re: [PATCH v2 03/16] soc: qcom: apr: Add GPR support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <349b94b8-0ce3-20f1-d7e3-b6d0609ecdc4@linux.intel.com>
Date:   Wed, 14 Jul 2021 11:20:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714153039.28373-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +void gpr_free_port(gpr_port_t *port)
> +{
> +	struct packet_router *gpr = port->pr;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpr->svcs_lock, flags);
> +	idr_remove(&gpr->svcs_idr, port->id);
> +	spin_unlock_irqrestore(&gpr->svcs_lock, flags);

maybe add a comment somewhere on why you need the irqsave/irqrestore version of spin_lock/unlock?

It's not very clear by looking at this patch only that those locks are handled in interrupt context.

> +
> +	kfree(port);
> +}
> +EXPORT_SYMBOL_GPL(gpr_free_port);
> +
> +gpr_port_t *gpr_alloc_port(struct apr_device *gdev, struct device *dev,
> +				gpr_port_cb cb,	void *priv)
> +{
> +	struct packet_router *pr = dev_get_drvdata(gdev->dev.parent);
> +	gpr_port_t *port;
> +	struct pkt_router_svc *svc;
> +	int id;
> +
> +	port = kzalloc(sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return ERR_PTR(-ENOMEM);
> +
> +	svc = port;
> +	svc->callback = cb;
> +	svc->pr = pr;
> +	svc->priv = priv;
> +	svc->dev = dev;
> +	spin_lock_init(&svc->lock);
> +
> +	spin_lock(&pr->svcs_lock);
> +	id = idr_alloc_cyclic(&pr->svcs_idr, svc, GPR_DYNAMIC_PORT_START,
> +			      GPR_DYNAMIC_PORT_END, GFP_ATOMIC);
> +	if (id < 0) {
> +		dev_err(dev, "Unable to allocate dynamic GPR src port\n");
> +		kfree(port);
> +		spin_unlock(&pr->svcs_lock);

nit-pick: more this before the dev_err?

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	svc->id = id;
> +	spin_unlock(&pr->svcs_lock);
> +
> +	dev_info(dev, "Adding GPR src port (%x)\n", svc->id);
> +
> +	return port;
> +}

> +static int gpr_do_rx_callback(struct packet_router *gpr, struct apr_rx_buf *abuf)
> +{
> +	uint16_t hdr_size, ver;
> +	struct pkt_router_svc *svc = NULL;

unnecessary init? it's overritten...

> +	struct gpr_resp_pkt resp;
> +	struct gpr_hdr *hdr;
> +	unsigned long flags;
> +	void *buf = abuf->buf;
> +	int len = abuf->len;
> +
> +	hdr = buf;
> +	ver = hdr->version;
> +	if (ver > GPR_PKT_VER + 1)
> +		return -EINVAL;
> +
> +	hdr_size = hdr->hdr_size;
> +	if (hdr_size < GPR_PKT_HEADER_WORD_SIZE) {
> +		dev_err(gpr->dev, "GPR: Wrong hdr size:%d\n", hdr_size);
> +		return -EINVAL;
> +	}
> +
> +	if (hdr->pkt_size < GPR_PKT_HEADER_BYTE_SIZE || hdr->pkt_size != len) {
> +		dev_err(gpr->dev, "GPR: Wrong packet size\n");
> +		return -EINVAL;
> +	}
> +
> +	resp.hdr = *hdr;
> +	resp.payload_size = hdr->pkt_size - (hdr_size * 4);
> +
> +	/*
> +	 * NOTE: hdr_size is not same as GPR_HDR_SIZE as remote can include
> +	 * optional headers in to gpr_hdr which should be ignored
> +	 */
> +	if (resp.payload_size > 0)
> +		resp.payload = buf + (hdr_size *  4);
> +
> +
> +	spin_lock_irqsave(&gpr->svcs_lock, flags);
> +	svc = idr_find(&gpr->svcs_idr, hdr->dest_port);

... here 

> +	spin_unlock_irqrestore(&gpr->svcs_lock, flags);
> +
> +	if (!svc) {
> +		dev_err(gpr->dev, "GPR: Port(%x) is not registered\n",
> +			hdr->dest_port);
> +		return -EINVAL;
> +	}
> +
> +	if (svc->callback)
> +		svc->callback(&resp, svc->priv, 0);
> +
> +	return 0;
> +}
> +

