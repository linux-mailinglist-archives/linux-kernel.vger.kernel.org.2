Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611E9351011
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDAHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhDAHYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:24:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7BB56101E;
        Thu,  1 Apr 2021 07:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617261857;
        bh=QTnz+6jGcvYfBHbJRGBNxgg3sk4PrA6WsodxoS43ESU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLEIbHNJkGB0NFObdCK7gpCmPVD4KaJpzmuIm/d5lUy5SAcJLDoxf9MbGHC5FmzzD
         lKlelSAxNMmFMs5Qz3e9nIYEvPbPm3Vxo3Swhxa/FgsCxV2UOr7FnO9EYAoSyneHjO
         6+eUDHE3L07aU6xaWL3uLosHkrY+RyswCd616bSSw1B3nW9/Szeql7N+xR7FJ9z7pm
         xFophTyXhdWtSOfGKp41VSxOe8mSMsk/WTGK7gQz/wRFlQAilRdjHtZL1gbEWzOSFi
         c6jah7hrwaEuKY0Y3Q/MCv0s2NmyJMXyzMsi4Y0NWY72YIvRAEmrTI6NBhVPWozxJe
         0DlfuhEokyc/w==
Date:   Thu, 1 Apr 2021 12:54:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
Message-ID: <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-21, 09:13, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We sometimes discard -ENODATA when reporting errors and lose all
> traces of issues in the console log, add a macro to add use dev_dbg()
> in such cases.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 40354469860a..8370216f95d4 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -227,4 +227,12 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>  void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
>  int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
>  
> +#define sdw_dev_dbg_or_err(dev, is_err, fmt, ...)			\
> +	do {								\
> +		if (is_err)						\
> +			dev_err(dev, fmt, __VA_ARGS__);			\
> +		else							\
> +			dev_dbg(dev, fmt, __VA_ARGS__);			\
> +	} while (0)

I see a variant in sof code and now here, why not add in a
dev_dbg_or_err() and use everywhere?

Thanks
-- 
~Vinod
