Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022BF34E36D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhC3Ine (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhC3InJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:43:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 291ED61919;
        Tue, 30 Mar 2021 08:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617093789;
        bh=BzVGzxF47npQxoaPhUx9SUpW2ax62qrGKvP/1FIKvQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VE57U+us+WY2P7L75NyhztMPzKv47qlr7zFsI5g4VEu/PGQgC7xXcGldZ5myuSx97
         FAFZuCT6YDQC14wM6lTEZ0NZqCkv6qqnY0SiBku0HR2MYI03pj7x2gn5UZDxkiQ9hl
         PRVayX9J4rxOfKc/3mksaBV8qzQVXmVY2nBu42qNs84OlFOYbJQWz5/mdysb95q1xQ
         reLoX0cMiTVDPaoo/N/ZU5uqILVqaAdQSYwpceTNJXvv49SqtXxpnPwMNI9dsAQMkm
         hHymudupflnovj1MSU7neN1lI/RcUocquJ/0RkEvWwuniyvf0n+UX0qnIVwcP+P9Ft
         NF8Fj6wAsEURw==
Date:   Tue, 30 Mar 2021 14:13:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/9] soundwire: qcom: add support to new interrupts
Message-ID: <YGLkmM4QCjkpg8/6@vkoul-mobl.Dlink>
References: <20210326063944.31683-1-srinivas.kandagatla@linaro.org>
 <20210326063944.31683-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326063944.31683-7-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-21, 06:39, Srinivas Kandagatla wrote:

> -	ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
> +	do {
> +		for (i = 0; i < SWRM_INTERRUPT_MAX; i++) {
> +			value = intr_sts_masked & (1 << i);

BIT(i) istead of shifiting?

> +			if (!value)
> +				continue;
> +
> +			switch (value) {
> +			case SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ:
> +				devnum = qcom_swrm_get_alert_slave_dev_num(swrm);
> +				if (devnum < 0) {
> +					dev_err_ratelimited(swrm->dev,
> +					    "no slave alert found.spurious interrupt\n");
> +				} else {
> +					sdw_handle_slave_status(&swrm->bus, swrm->status);
> +				}
>  
> -	if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED)
> -		complete(&ctrl->broadcast);
> +				break;
> +			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
> +			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
> +				dev_err_ratelimited(swrm->dev, "%s: SWR new slave attached\n",
> +					__func__);

This should be debug
-- 
~Vinod
