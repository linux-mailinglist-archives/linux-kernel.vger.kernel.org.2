Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA730A5B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhBAKnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhBAKnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:43:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0905864DD8;
        Mon,  1 Feb 2021 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612176154;
        bh=jMGFVom3o9SisYFVYliXyOSgOs0PraIR76dQsjdWD4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cVTJQwwhar+cPS71ncFP3tPnD5B+l6r0zNy4ecVf1qbRwkvrlWytYsEC+Tl3M7/w8
         1zMJQKIKzzQE+W2sRnAx5w6ebr7s52li9qWsfnM/9AtTFkBo/2yTgSroAoaU2gYGQ/
         KTIe33lSR+X/LXJ7RgAPTFDhFUrbhTEi8PJt3bUBcSzzkOZMBGVZc0a+tzui427Dxi
         D369kDe0/92oXxy4qOP0HPDOBoHbSJplkh79Uk9RZCC5kv4DiknSElKud6SQeqCdh/
         c2q+t58lGdAnG/c1L0KFVX+CZ77drW9MgN85KVEdFSbLV9xv/+62An7HHCGWDTxXTi
         nHHBaHncbeTLg==
Date:   Mon, 1 Feb 2021 16:12:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 2/3] soundwire: intel: add
 SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk
Message-ID: <20210201104229.GY2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 16:37, Bard Liao wrote:
> There is nothing we can do to handle the bus clash interrupt before
> interrupt mask is enabled.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index a2d5cdaa9998..f7ba1a77a1df 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1286,6 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>  	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
>  		prop->hw_disabled = true;
>  
> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;

Should this not be last 'enabling' the quirk patch in series :)

-- 
~Vinod
