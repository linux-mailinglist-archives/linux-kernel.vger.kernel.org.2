Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9734830A52B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhBAKPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhBAKPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:15:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C16C64DDD;
        Mon,  1 Feb 2021 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612174459;
        bh=wSWGa0AelgE602zA7s8sVuYnMOyWFW24cLHyxoZNYfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gk+wAbdlwBheXAQXLjaJm15extS73qIDqUBGucZqPW5kf/Cc7IsbSde/eoEWpEG6r
         ysyEJCkXiriqE5jfqSNXEgT4FEpH2Uce3eXfcjHCeRQehaTGwC3IE6ELPkiRH/HPkC
         YbV1kes4m6ptkpiMPf4C21xicjejLsBRdB0xDwZQOwOE38H5HqNpBWgvK3xeYnglST
         ogznAUVtWylVTKvwVCKuvr8AD4b8K6JuhKIo9jJNgqsRvliGYBpw0JOINv43EXhO0i
         +BIgB9k9WdZWd9fsWUJ+R5V/AWK6aX5eDZefYilW+dextu1yx7+jXy5JJdzoH5x/ta
         Lu8mkzNExbKFg==
Date:   Mon, 1 Feb 2021 15:44:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
Message-ID: <20210201101414.GS2771@vkoul-mobl>
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-21, 17:23, Srinivas Kandagatla wrote:
> 
> 
> On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 19/01/2021 19:09, Pierre-Louis Bossart wrote:
> > > > 
> > > > > currently we have
> > > > > /sys/kernel/debug/soundwire/master-*
> > > > > 
> > > > > Are you suggesting that we have something like this:
> > > > > 
> > > > > /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
> > > > 
> > > > Yes this is what I was thinking about.
> > > 
> > > Vinod/Pierre,
> > > 
> > > One Question here,
> > > 
> > > Why is link_id part of "struct sdw_bus", should it not be part of
> > > "struct sdw_master_device " ?
> > > 
> > > Given that "There is one Link per each Master"
> > 
> > it's true that link == master == bus at the concept level.
> > 
> > but we have an existing code base with different structures and we can't
> > break too many things at once.
> > 
> > In the existing flow, the 'bus' is created and setup first, the
> > sdw_bus_master_add() routine takes a 'bus' argument, and the link_id is
> > already set. This routine only creates a device and in the rest of the
> > code we keep using the 'bus' pointer, so there's no real short-term
> > scope for moving the information into the 'sdw_master_device' structure
> > - that would be a lot of surgery when nothing is really broken.
> 
> I totally agree!
> 
> If I understand it correctly in Intel case there will be only one Link ID
> per bus.

Yes IIUC there would be one link id per bus.

the ida approach gives us unique id for each master,bus I would like to
propose using that everywhere

> 
> 
> Does this change look good to you?
> 
> ---------------->cut<---------------
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index b6cad0d59b7b..f22868614f09 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -19,13 +19,14 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
>                 return;
> 
>         /* create the debugfs master-N */
> +       bus->controller_debugfs = debugfs_create_dir(dev_name(bus->dev),
> sdw_debugfs_root);
>         snprintf(name, sizeof(name), "master-%d", bus->link_id);
> -       bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
> +       bus->debugfs = debugfs_create_dir(name, bus->controller_debugfs);
>  }
> 
>  void sdw_bus_debugfs_exit(struct sdw_bus *bus)
>  {
> -       debugfs_remove_recursive(bus->debugfs);
> +       debugfs_remove_recursive(bus->controller_debugfs);
>  }
> 
>  #define RD_BUF (3 * PAGE_SIZE)
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index b198f471bea8..242bde30d8bd 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -877,6 +877,7 @@ struct sdw_bus {
>         struct sdw_master_prop prop;
>         struct list_head m_rt_list;
>  #ifdef CONFIG_DEBUG_FS
> +       struct dentry *controller_debugfs;
>         struct dentry *debugfs;
>  #endif
>         struct sdw_defer defer_msg;
> 
> ---------------->cut<---------------
> 
> With this change I get something like this on my board:
> 
> ~# find /sys/kernel/debug/soundwire/
> /sys/kernel/debug/soundwire/
> /sys/kernel/debug/soundwire/sdw-master-2
> /sys/kernel/debug/soundwire/sdw-master-2/master-0
> /sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:4
> /sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:4/registers
> /sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:3
> /sys/kernel/debug/soundwire/sdw-master-2/master-0/sdw:0:217:2110:0:3/registers
> /sys/kernel/debug/soundwire/sdw-master-1
> /sys/kernel/debug/soundwire/sdw-master-1/master-0
> /sys/kernel/debug/soundwire/sdw-master-1/master-0/sdw:0:217:10d:0:3
> /sys/kernel/debug/soundwire/sdw-master-1/master-0/sdw:0:217:10d:0:3/registers
> /sys/kernel/debug/soundwire/sdw-master-0
> /sys/kernel/debug/soundwire/sdw-master-0/master-0
> /sys/kernel/debug/soundwire/sdw-master-0/master-0/sdw:0:217:10d:0:4
> /sys/kernel/debug/soundwire/sdw-master-0/master-0/sdw:0:217:10d:0:4/registers
> 
> 
> 
> Thanks,
> srini

-- 
~Vinod
