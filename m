Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41A3C9CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbhGOKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbhGOKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:34:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B13C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:31:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso842552wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3/UMFIYsAEmuojKVnN83fkHudTM2KjmLO3fL2UtgQ6A=;
        b=N5Lyb39oENufWE6yapTpCuVDAhA3OtRhE2gyJO/P6vwASt50ZCX/EvD432it5Mczrf
         F/OZXxKcieDIWitNPfB5FugMJnt81uJwMbHEitadMBTzOcRYJOLf/d8wdFA76iy6WzIV
         sOKLwyAyXuWFrKHG3Nr22XtGjTm8gYsmUvwqqVeh6h1Bu6QIws6O291MKjrs2X/ISdoC
         B+9CChoPwlyRnJwiYyZ6cnBokbRphVDKQxUP8m45vHw/8FdqcfgnP+1G6fR0sns9xDxu
         vj87AJ/B/nPy8yjmfhHKKfzu7XKUparm39Wmup85/o2q2n4lGe0An4Cs/CDDgL0EYnq+
         3AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/UMFIYsAEmuojKVnN83fkHudTM2KjmLO3fL2UtgQ6A=;
        b=nbmOxWqBCOjBIoM5yuyn4aF5VdQUaqXrQ+GAMdEEzc4anz1jleH6m9klwlIE39ugBC
         eGXh1pkWV02V0HDPkmKt96+E5FVWJgO2VRusQpzOMqHYNx7ifzLoVTDXGE4MEXhxsCnE
         lCLodbbvbuYb4+6mHHgK1bt45YWELQzj3CuMSYPxG+EWESR2L4NhQdSay31Mh1QUjTb0
         FR1b9FEzcScGHhOvPoVnd3TFm2+6naZljYEcmjXjtWwZ49Dna7fNc2MHpCt4XTsn+g3I
         /PrYVfrmqzmQAuap909qtrlf1IxW71oq4ab5/NPCx2t4IQjpBGI+F/hBmEyg1hYVbfNH
         Q7pg==
X-Gm-Message-State: AOAM533Fr5EdOcoDRteeet3jdbaiK7OsQ/pdmXATkfCpwkCnR/aYHMHx
        B8Hhjz+e4E83sLJrQ2Y+89bEMQRkMhNdzA==
X-Google-Smtp-Source: ABdhPJycJXClZY+iOj0PtsWA83BQXsa43bgsifSJi81IB3vG8RMJeZKJ7IGF0rwEOuzlYe6mVFgSeQ==
X-Received: by 2002:a7b:c2a2:: with SMTP id c2mr3821401wmk.89.1626345107087;
        Thu, 15 Jul 2021 03:31:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m15sm4687547wmc.20.2021.07.15.03.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:31:46 -0700 (PDT)
Subject: Re: [PATCH v2 03/16] soc: qcom: apr: Add GPR support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.de,
        plai@codeaurora.org, linux-kernel@vger.kernel.org
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
 <20210714153039.28373-4-srinivas.kandagatla@linaro.org>
 <349b94b8-0ce3-20f1-d7e3-b6d0609ecdc4@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <da7c8e4d-fe79-de54-025e-2bb25dc16698@linaro.org>
Date:   Thu, 15 Jul 2021 11:31:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <349b94b8-0ce3-20f1-d7e3-b6d0609ecdc4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks Pierre for the review,

On 14/07/2021 17:20, Pierre-Louis Bossart wrote:
> 
>> +void gpr_free_port(gpr_port_t *port)
>> +{
>> +	struct packet_router *gpr = port->pr;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&gpr->svcs_lock, flags);
>> +	idr_remove(&gpr->svcs_idr, port->id);
>> +	spin_unlock_irqrestore(&gpr->svcs_lock, flags);
> 
> maybe add a comment somewhere on why you need the irqsave/irqrestore version of spin_lock/unlock?

All the responses to the messages arrive in interrupt context which 
could try to find the matching svc idr, so we needed this irq version of 
spinlock here. I did move this handling to a work queue in the past, so 
we should be able to relax this lock to non-irq version.

> 
> It's not very clear by looking at this patch only that those locks are handled in interrupt context.
> 
>> +
>> +	kfree(port);
>> +}
>> +EXPORT_SYMBOL_GPL(gpr_free_port);
>> +
>> +gpr_port_t *gpr_alloc_port(struct apr_device *gdev, struct device *dev,
>> +				gpr_port_cb cb,	void *priv)
>> +{
>> +	struct packet_router *pr = dev_get_drvdata(gdev->dev.parent);
>> +	gpr_port_t *port;
>> +	struct pkt_router_svc *svc;
>> +	int id;
>> +
>> +	port = kzalloc(sizeof(*port), GFP_KERNEL);
>> +	if (!port)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	svc = port;
>> +	svc->callback = cb;
>> +	svc->pr = pr;
>> +	svc->priv = priv;
>> +	svc->dev = dev;
>> +	spin_lock_init(&svc->lock);
>> +
>> +	spin_lock(&pr->svcs_lock);
>> +	id = idr_alloc_cyclic(&pr->svcs_idr, svc, GPR_DYNAMIC_PORT_START,
>> +			      GPR_DYNAMIC_PORT_END, GFP_ATOMIC);
>> +	if (id < 0) {
>> +		dev_err(dev, "Unable to allocate dynamic GPR src port\n");
>> +		kfree(port);
>> +		spin_unlock(&pr->svcs_lock);
> 
> nit-pick: more this before the dev_err?

I agree, will do that in next spin.
> 
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	svc->id = id;
>> +	spin_unlock(&pr->svcs_lock);
>> +
>> +	dev_info(dev, "Adding GPR src port (%x)\n", svc->id);
>> +
>> +	return port;
>> +}
> 
>> +static int gpr_do_rx_callback(struct packet_router *gpr, struct apr_rx_buf *abuf)
>> +{
>> +	uint16_t hdr_size, ver;
>> +	struct pkt_router_svc *svc = NULL;
> 
> unnecessary init? it's overritten...
> 
Yep.


--srini

>> +	struct gpr_resp_pkt resp;
>> +	struct gpr_hdr *hdr;
>> +	unsigned long flags;
>> +	void *buf = abuf->buf;
>> +	int len = abuf->len;
>> +
>> +	hdr = buf;
>> +	ver = hdr->version;
>> +	if (ver > GPR_PKT_VER + 1)
>> +		return -EINVAL;
>> +
>> +	hdr_size = hdr->hdr_size;
>> +	if (hdr_size < GPR_PKT_HEADER_WORD_SIZE) {
>> +		dev_err(gpr->dev, "GPR: Wrong hdr size:%d\n", hdr_size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (hdr->pkt_size < GPR_PKT_HEADER_BYTE_SIZE || hdr->pkt_size != len) {
>> +		dev_err(gpr->dev, "GPR: Wrong packet size\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	resp.hdr = *hdr;
>> +	resp.payload_size = hdr->pkt_size - (hdr_size * 4);
>> +
>> +	/*
>> +	 * NOTE: hdr_size is not same as GPR_HDR_SIZE as remote can include
>> +	 * optional headers in to gpr_hdr which should be ignored
>> +	 */
>> +	if (resp.payload_size > 0)
>> +		resp.payload = buf + (hdr_size *  4);
>> +
>> +
>> +	spin_lock_irqsave(&gpr->svcs_lock, flags);
>> +	svc = idr_find(&gpr->svcs_idr, hdr->dest_port);
> 
> ... here
> 
>> +	spin_unlock_irqrestore(&gpr->svcs_lock, flags);
>> +
>> +	if (!svc) {
>> +		dev_err(gpr->dev, "GPR: Port(%x) is not registered\n",
>> +			hdr->dest_port);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (svc->callback)
>> +		svc->callback(&resp, svc->priv, 0);
>> +
>> +	return 0;
>> +}
>> +
> 
