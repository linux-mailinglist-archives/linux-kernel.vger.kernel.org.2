Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73794345812
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCWG6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCWG55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:57:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70526198C;
        Tue, 23 Mar 2021 06:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616482676;
        bh=/WkMVn8JteJqWLVGkAGsNc7gqYAORiyqFDj83S0YhyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucO160+bXDEasmx03pxQ1ZbsuPUQa3KqGCJQOOU3b+GzNaWgjVZd0o42JQKfaehll
         hFuY4x83pTUX7NKPbxFiltzhTpbqalwWlA09IdB996nViBvVwtqQl1bNykRmpiax77
         1qju1YGTEycLBtCT5goY7IbYc9jd4u6SAEneEoYTRR54Jdp66cO7kn6ei0RXYOZwWK
         KWRTzmEiVXoWCvypLWfFJ1QHhPDk4usl0E/LlJaz11FjWPCU7AmOG+oTVWvfedAt8w
         Y06BPnvVMBgziX5owdAM0Cfn6JKrQa25IGrUg8t+arA4R1bijV7jMzn4rwbo5LtJ0+
         MujIMAZXhQBBg==
Date:   Tue, 23 Mar 2021 12:27:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: add slave device to linked list after
 device_register()
Message-ID: <YFmRcPUxxFxkuMkr@vkoul-mobl.Dlink>
References: <20210323022529.21915-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323022529.21915-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 10:25, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We currently add the slave device to a linked list before
> device_register(), and then remove it if device_register() fails.
> 
> It's not clear why this sequence was necessary, this patch moves the
> linked list management to after the device_register().

Maybe add a comment :-)

The reason here is that before calling device_register() we need to be
ready and completely initialized. device_register is absolutely the last
step in the flow, always.

The probe of the device can happen and before you get a chance to
add to list, many number of things can happen.. So adding after is not a
very good idea :)

HTH

> 
> Suggested-by: Keyon Jie <yang.jie@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/slave.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index 112b21967c7a..0c92db2e1ddc 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -65,9 +65,6 @@ int sdw_slave_add(struct sdw_bus *bus,
>  	for (i = 0; i < SDW_MAX_PORTS; i++)
>  		init_completion(&slave->port_ready[i]);
>  
> -	mutex_lock(&bus->bus_lock);
> -	list_add_tail(&slave->node, &bus->slaves);
> -	mutex_unlock(&bus->bus_lock);
>  
>  	ret = device_register(&slave->dev);
>  	if (ret) {
> @@ -77,13 +74,15 @@ int sdw_slave_add(struct sdw_bus *bus,
>  		 * On err, don't free but drop ref as this will be freed
>  		 * when release method is invoked.
>  		 */
> -		mutex_lock(&bus->bus_lock);
> -		list_del(&slave->node);
> -		mutex_unlock(&bus->bus_lock);
>  		put_device(&slave->dev);
>  
>  		return ret;
>  	}
> +
> +	mutex_lock(&bus->bus_lock);
> +	list_add_tail(&slave->node, &bus->slaves);
> +	mutex_unlock(&bus->bus_lock);
> +
>  	sdw_slave_debugfs_init(slave);
>  
>  	return ret;
> -- 
> 2.17.1

-- 
~Vinod
