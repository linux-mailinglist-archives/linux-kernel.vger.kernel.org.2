Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E934E354
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhC3IlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhC3Ikk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:40:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44B886198F;
        Tue, 30 Mar 2021 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617093640;
        bh=5vjWHQpNnWwzD+C6Uz33hAqzurkp949O30Cxa1ACg+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4xqREtMQ8bpOCp6JwQ/3PzO7VMBuDSe7ZnSjC6GYVtJ6HrzoEKwDVAgVYngc550c
         yCkq/FDploTzNru+QMIPcLrXIN5xQexxLy/aQW+bas9TDRAkth582KEpNHu4TQ7jxd
         m/Ja/WBc8YHofa5W1SCk8BYlUgp6ltyaR5f2+d19vgifk7Hztcxi89s+WDEI9/2ajJ
         nUrRHJqp2WwRIKKgI+VjaMk+8124TloR2JctPrPHh4ZW/KcZUCN34147qu0Ya6uYWJ
         fLevnAqIpW0TNYczFYW2MOaJE+desJ0bnflqoCtsJNnpN7UDmgKHXKgk6oODRSNYZL
         td6WS0Mj+hJzA==
Date:   Tue, 30 Mar 2021 14:10:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/9] soundwire: qcom: update register read/write
 routine
Message-ID: <YGLkA3p634eg9FDl@vkoul-mobl.Dlink>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
 <20210326063944.31683-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326063944.31683-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-21, 06:39, Srinivas Kandagatla wrote:

> +	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
> +
> +	/* version 1.3 or less */
> +	if (swrm->version <= 0x01030000)
> +		usleep_range(150, 155);
> +
> +	if (cmd_id == SWR_BROADCAST_CMD_ID) {
> +		/*
> +		 * sleep for 10ms for MSM soundwire variant to allow broadcast
> +		 * command to complete.
> +		 */
> +		ret = wait_for_completion_timeout(&swrm->broadcast,
> +						  msecs_to_jiffies(TIMEOUT_MS));
> +		if (!ret)
> +			ret = SDW_CMD_IGNORED;
> +		else
> +			ret = SDW_CMD_OK;
>  
> -	if (!ret) {
> -		ret = SDW_CMD_IGNORED;
> -		goto err;
>  	} else {
>  		ret = SDW_CMD_OK;
>  	}

Maybe add a comment here that we dont get status so write is assumed to
be OK

-- 
~Vinod
