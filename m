Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067973ACEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhFRPbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:31:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:64875 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235495AbhFRPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:30:26 -0400
IronPort-SDR: Stf7Zwm6TDlOxa+DGpaRVUT4vWEomiTYKZcCUhZjTsSFUIxRcmc1/0wXse4935C4Zd2F/RV3SH
 XWj+ucGSOJxA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193883835"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193883835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:28:16 -0700
IronPort-SDR: tXz/DeiAVks+cDsEly+zSEIB1Rr8PgbebPoxlYQ+o2gY45Akxd/kzS6WUq6dDl72DHPx7qRD+o
 eKKwL/3yJGyg==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="622422622"
Received: from myshevts-mobl.ccr.corp.intel.com (HELO [10.209.154.63]) ([10.209.154.63])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:28:15 -0700
Subject: Re: [PATCH] soundwire: stream: Fix test for DP prepare complete
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20210618144745.30629-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a401be25-8ab6-4d28-3a87-10860ca1102d@linux.intel.com>
Date:   Fri, 18 Jun 2021 10:28:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618144745.30629-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/21 9:47 AM, Richard Fitzgerald wrote:
> In sdw_prep_deprep_slave_ports(), after the wait_for_completion()
> the DP prepare status register is read. If this indicates that the
> port is now prepared, the code should continue with the port setup.
> It is irrelevant whether the wait_for_completion() timed out if the
> port is now ready.
> 
> The previous implementation would always fail if the
> wait_for_completion() timed out, even if the port was reporting
> successful prepare.
> 
> This patch also fixes a minor bug where the return from sdw_read()
> was not checked for error - any error code with LSBits clear could
> be misinterpreted as a successful port prepare.
> 
> Fixes: 79df15b7d37c ("soundwire: Add helpers for ports operations")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Looks good to me

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/stream.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 1eaedaaba094..1a18308f4ef4 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -422,7 +422,6 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>  	struct completion *port_ready;
>  	struct sdw_dpn_prop *dpn_prop;
>  	struct sdw_prepare_ch prep_ch;
> -	unsigned int time_left;
>  	bool intr = false;
>  	int ret = 0, val;
>  	u32 addr;
> @@ -479,15 +478,15 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>  
>  		/* Wait for completion on port ready */
>  		port_ready = &s_rt->slave->port_ready[prep_ch.num];
> -		time_left = wait_for_completion_timeout(port_ready,
> -				msecs_to_jiffies(dpn_prop->ch_prep_timeout));
> +		wait_for_completion_timeout(port_ready,
> +			msecs_to_jiffies(dpn_prop->ch_prep_timeout));
>  
>  		val = sdw_read(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
> -		val &= p_rt->ch_mask;
> -		if (!time_left || val) {
> +		if ((val < 0) || (val & p_rt->ch_mask)) {
> +			ret = (val < 0) ? val : -ETIMEDOUT;
>  			dev_err(&s_rt->slave->dev,
> -				"Chn prep failed for port:%d\n", prep_ch.num);
> -			return -ETIMEDOUT;
> +				"Chn prep failed for port %d: %d\n", prep_ch.num, ret);
> +			return ret;
>  		}
>  	}
>  
> 
