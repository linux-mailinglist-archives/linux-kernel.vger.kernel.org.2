Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3335E40E387
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbhIPQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:49:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:11538 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244356AbhIPQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:42:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="222263863"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="222263863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 09:36:36 -0700
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="554156676"
Received: from xuanguan-mobl.amr.corp.intel.com (HELO [10.213.180.84]) ([10.213.180.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 09:36:35 -0700
Subject: Re: [PATCH v3 16/30] ABI: sysfs-bus-soundwire-slave: use wildcards on
 What definitions
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
 <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9a379f0a-e076-844c-fb5d-130359e36754@linux.intel.com>
Date:   Thu, 16 Sep 2021 11:36:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/21 3:59 AM, Mauro Carvalho Chehab wrote:
> An "N" upper letter is not a wildcard, nor can easily be identified
> by script, specially since the USB sysfs define things like.
> bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> to convert it into a Regex.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

I also realized that we have a similar with the 'master' case

more sysfs-bus-soundwire-master
What:		/sys/bus/soundwire/devices/sdw-master-N/revision
		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
		/sys/bus/soundwire/devices/sdw-master-N/default_col
		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
		/sys/bus/soundwire/devices/sdw-master-N/default_row
		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq

If there is an update we should modify this as well for consistency with
sdw-master-<N>?

> ---
>  .../ABI/testing/sysfs-bus-soundwire-slave     | 60 +++++++++----------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-slave b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> index d324aa0b678f..fbf55834dfee 100644
> --- a/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> +++ b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> @@ -64,37 +64,37 @@ Description:	SoundWire Slave Data Port-0 DisCo properties.
>  		Data port 0 are used by the bus to configure the Data Port 0.
>  
>  
> -What:		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_word
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_word
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/words
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/type
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_grouping
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/simple_ch_prep_sm
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/ch_prep_timeout
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/imp_def_interrupts
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_ch
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_ch
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/channels
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/ch_combinations
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_async_buffer
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/block_pack_mode
> -		/sys/bus/soundwire/devices/sdw:.../dpN_src/port_encoding
> +What:		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_word
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/min_word
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/words
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/type
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_grouping
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/simple_ch_prep_sm
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/ch_prep_timeout
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/imp_def_interrupts
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/min_ch
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_ch
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/channels
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/ch_combinations
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_async_buffer
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/block_pack_mode
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/port_encoding
>  
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_word
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/min_word
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/words
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/type
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_grouping
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/simple_ch_prep_sm
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/ch_prep_timeout
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/imp_def_interrupts
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/min_ch
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_ch
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/channels
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/ch_combinations
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_async_buffer
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/block_pack_mode
> -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/port_encoding
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_word
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/min_word
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/words
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/type
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_grouping
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/simple_ch_prep_sm
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/ch_prep_timeout
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/imp_def_interrupts
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/min_ch
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_ch
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/channels
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/ch_combinations
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_async_buffer
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/block_pack_mode
> +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/port_encoding
>  
>  Date:		May 2020
>  
> 
