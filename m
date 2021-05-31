Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD1396632
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhEaRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:00:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50212 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhEaP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:28:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B22341FD2E;
        Mon, 31 May 2021 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622474739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
        b=BwNRtZQdewfSD5/Y/MAaTAQ+HFuDdWwB7E9kqcjTmUQCofNG8Uw8NejuCIl4GbyvttA+RI
        ztvIPbsgaYeYbRb1gvvoTdUApVj3i33lziPwmlkrBAlDviY41KiPiahLXhNgwqiy0vnm6U
        ZqglJiO3TAIES7KBUe13+vORCL62IWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622474739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
        b=5AbunJCdRaWXd1KtJWWp9KOqfk/3AMKQ5nVVxdTY0oxm6+UL1NEWlp1ulnf5ue1ZrBfDHi
        HE1DTs1+AsyIoxDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4A925118DD;
        Mon, 31 May 2021 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622474739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
        b=BwNRtZQdewfSD5/Y/MAaTAQ+HFuDdWwB7E9kqcjTmUQCofNG8Uw8NejuCIl4GbyvttA+RI
        ztvIPbsgaYeYbRb1gvvoTdUApVj3i33lziPwmlkrBAlDviY41KiPiahLXhNgwqiy0vnm6U
        ZqglJiO3TAIES7KBUe13+vORCL62IWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622474739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
        b=5AbunJCdRaWXd1KtJWWp9KOqfk/3AMKQ5nVVxdTY0oxm6+UL1NEWlp1ulnf5ue1ZrBfDHi
        HE1DTs1+AsyIoxDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id aamiEfP/tGDvHQAALh3uQQ
        (envelope-from <hare@suse.de>); Mon, 31 May 2021 15:25:39 +0000
Subject: Re: [PATCH] nvme: verify MNAN value if ANA is enabled
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20210531103651.109426-1-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <7c7b96e7-ea31-1d3b-9b5c-3b89133926b5@suse.de>
Date:   Mon, 31 May 2021 17:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210531103651.109426-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 12:36 PM, Daniel Wagner wrote:
> The controller is required to have a non-zero MNAN value if it supports
> ANA:
> 
>    If the controller supports Asymmetric Namespace Access Reporting, then
>    this field shall be set to a non-zero value that is less than or equal
>    to the NN value.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> This is a follow up to the discussion in
> 
>   https://lore.kernel.org/linux-nvme/20210521144734.90044-1-dwagner@suse.de/
> 
>  drivers/nvme/host/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cb1a76a3d42a..4c412adc9e14 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2972,6 +2972,16 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		goto out_free;
>  
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->ana_log_buf && (!ctrl->max_namespaces ||
> +				  ctrl->max_namespaces > le32_to_cpu(id->nn))) {
> +		dev_err(ctrl->device,
> +			"Invalid MNAN value %u\n", ctrl->max_namespaces);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +#endif
> +
>  	if (ctrl->apst_enabled && !prev_apst_enabled)
>  		dev_pm_qos_expose_latency_tolerance(ctrl->device);
>  	else if (!ctrl->apst_enabled && prev_apst_enabled)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
