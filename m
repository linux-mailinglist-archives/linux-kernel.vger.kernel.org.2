Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC24E3A8840
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFOSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:09:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:52197 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhFOSJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:09:32 -0400
IronPort-SDR: 8n2KEIkAJjqESnr/C5AbX648ylJ/2f2lQXDmitxLrxQrp4DA1Hh+1zXEy0vVv0Q8zV8qyezsg/
 wr1VoEyaoZwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="205862421"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="205862421"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:07:27 -0700
IronPort-SDR: l17N2PZlkqbXrxLTnLXGRVq5xI5edKcK94Sphr+nDQ63Sy2VK4fvUPxECDS1wkCLfO2VgFUTmL
 lG35A/9JR/nw==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554528532"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:07:26 -0700
Subject: Re: [PATCH v4 01/24] x86/resctrl: Split struct rdt_resource
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com
References: <20210614200941.12383-1-james.morse@arm.com>
 <20210614200941.12383-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <b4efe746-b36e-1ac1-99d1-f0363e2a62d3@intel.com>
Date:   Tue, 15 Jun 2021 11:07:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-2-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/14/2021 1:09 PM, James Morse wrote:
> resctrl is the defacto Linux ABI for SoC resource partitioning features.
> 
> To support it on another architecture, it needs to be abstracted from
> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
> struct rdt_resource contains a mix of architecture private details
> and properties of the filesystem interface user-space users.

"user-space users" -> "user-space uses" ?

...

> +struct rdt_parse_data;
> +
> +/**
> + * struct rdt_resource - attributes of a resctrl resource
> + * @rid:		The index of the resource
> + * @alloc_enabled:	Is allocation enabled on this machine
> + * @mon_enabled:	Is monitoring enabled for this feature
> + * @alloc_capable:	Is allocation available on this machine
> + * @mon_capable:	Is monitor feature available on this machine
> + * @num_rmid:		Number of RMIDs available.
> + * @cache_level:	Which cache level defines scope of this resource
> + * @cache:		If the component has cache controls, their properties.
> + * @membw:		If the component has bandwidth controls, their properties.
> + * @domains:		All domains for this resource
> + * @name:		Name to use in "schemata" file.
> + * @data_width:		Character width of data when displaying.
> + * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> + * @format_str:		Per resource format string to show domain value
> + * @parse_ctrlval:	Per resource function pointer to parse control values
> + *

Unexpected space here.

> + * @evt_list:		List of monitoring events
> + * @fflags:		flags to choose base and info files
> + */
> +struct rdt_resource {
> +	int			rid;
> +	bool			alloc_enabled;
> +	bool			mon_enabled;
> +	bool			alloc_capable;
> +	bool			mon_capable;
> +	int			num_rmid;
> +	int			cache_level;
> +	struct resctrl_cache	cache;
> +	struct resctrl_membw	membw;
> +	struct list_head	domains;
> +	char			*name;
> +	int			data_width;
> +	u32			default_ctrl;
> +	const char		*format_str;
> +	int			(*parse_ctrlval)(struct rdt_parse_data *data,
> +						 struct rdt_resource *r,
> +						 struct rdt_domain *d);
> +	struct list_head	evt_list;
> +	unsigned long		fflags;
> +
> +};
> +
>   #endif /* _RESCTRL_H */
> 

Reinette
