Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322ED42A7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbhJLO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:56:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:21810 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237167AbhJLO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:56:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227125957"
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="227125957"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 07:54:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="486417496"
Received: from csharp1-mobl.amr.corp.intel.com (HELO [10.213.183.127]) ([10.213.183.127])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 07:54:52 -0700
Subject: Re: [PATCH] soundwire: bus: stop dereferencing invalid slave pointer
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        guennadi.liakhovetski@linux.intel.com, rander.wang@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211012101521.32087-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cb1d0d1d-100f-48b7-f809-7c84148ae0ba@linux.intel.com>
Date:   Tue, 12 Oct 2021 08:32:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012101521.32087-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/21 5:15 AM, Srinivas Kandagatla wrote:
> Slave pointer is invalid after end of list iteration, using this
> would result in below Memory abort.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> ...
> Call trace:
>  __dev_printk+0x34/0x7c
>  _dev_warn+0x6c/0x90
>  sdw_bus_exit_clk_stop+0x194/0x1d0
>  swrm_runtime_resume+0x13c/0x238
>  pm_generic_runtime_resume+0x2c/0x48
>  __rpm_callback+0x44/0x150
>  rpm_callback+0x6c/0x78
>  rpm_resume+0x314/0x558
>  rpm_resume+0x378/0x558
>  rpm_resume+0x378/0x558
>  __pm_runtime_resume+0x3c/0x88
> 
> Use bus->dev instead to print this error message.
> 
> Fixes: b50bb8ba369cd ("soundwire: bus: handle -ENODATA errors in clock stop/start sequences")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Nice catch, even if the 'slave' pointer was valid it makes no sense to
use this device for a bus-level operation. Using the bus->dev is the
right thing to do.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1b115734a8f6..67369e941d0d 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1110,7 +1110,7 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus)
>  	if (!simple_clk_stop) {
>  		ret = sdw_bus_wait_for_clk_prep_deprep(bus, SDW_BROADCAST_DEV_NUM);
>  		if (ret < 0)
> -			dev_warn(&slave->dev, "clock stop deprepare wait failed:%d\n", ret);
> +			dev_warn(bus->dev, "clock stop deprepare wait failed:%d\n", ret);
>  	}
>  
>  	list_for_each_entry(slave, &bus->slaves, node) {
> 
