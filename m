Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4641E690
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbhJAEW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345456AbhJAEWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:22:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5E8461A40;
        Fri,  1 Oct 2021 04:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633062041;
        bh=P1aX9F2pe3olEwuezxcNa6NkzrsGb7AJ7jerrhnDnJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTHJJOzbxXLg7tBsiLtwlBQFBMMfVLEi9P3xu08vOt4JwboxSS6yyAWMxC9VB3pbj
         0IBzDTTFzqUlhTRnDYQJgnINkBN31hnzQPQ2DEJbFAfprsVfn+/94vY6R0L2NSBSyG
         zdzS/aNVE/R9tIHOj1f3ilaRSxzWTliuhgJR34CC/bpDaygjprIIQt/qTCtiVOZvpC
         gwMNdQxzFTQaXcETYdLIP8pcL7Ri/iy+v9p3CxPtIhcpLHITVAPze2eB+ly+XAsEGr
         JU8Zwn2spZLQSXPti1DXl1fHc/5e8Xjl7wtWqUG1EbEQsaP9z/qbTpPSFZb81MwNq8
         TjHxWTBZyGTlQ==
Date:   Fri, 1 Oct 2021 09:50:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: qcom: add debugfs entry for soundwire
 register dump
Message-ID: <YVaMlSbmFnrQyb0u@matsya>
References: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Srini,

On 07-09-21, 11:56, Srinivas Kandagatla wrote:
> +#ifdef CONFIG_DEBUG_FS
> +static int swrm_reg_show(struct seq_file *s_file, void *data)
> +{
> +	struct qcom_swrm_ctrl *swrm = s_file->private;
> +	int reg, reg_val;
> +
> +	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
> +		swrm->reg_read(swrm, reg, &reg_val);

Why not use regmap_read here, that would avoid reading from the bus when
we already have the values...

Second make sure later when pm_runtime support is added, this take a
reference ..

Thanks
-- 
~Vinod
