Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A1350993
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhCaVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:36:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:61698 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhCaVgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:36:07 -0400
IronPort-SDR: xT3SnKbgf+i/YyFzFGCWPhWpy0DNfwkMXWqk3whcW4zMeXG+5iwpaJFNRInjLDvbBiRlciHOkl
 stE3NS906ZOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171511569"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171511569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:35:54 -0700
IronPort-SDR: 5Ey8/YfGEHKpOL8ULD2dsbwYe4xWzBmF+22GqimsWKRceHRpuOalqkbbty1AVaJQE8V+UfdKlI
 LXXA8rEu6Lrg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377432389"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:35:53 -0700
Subject: Re: [PATCH v2 01/24] x86/resctrl: Split struct rdt_resource
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <20210312175849.8327-2-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4d2cabac-a3a8-68a1-381e-44df66b61345@intel.com>
Date:   Wed, 31 Mar 2021 14:35:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-2-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

A significant time has passed since the first version and with that a 
lot of my context lost.

On 3/12/2021 9:58 AM, James Morse wrote:
> resctrl is the defacto Linux ABI for SoC resource partitioning features.
> To support it on another architecture, it needs to be abstracted from
> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
> 
> Start by splitting struct rdt_resource, (the name is kept to keep the noise
> down), and add some type-trickery to keep the foreach helpers working.

Could you please replace "add some type-trickery" with a description of 
the changes(tricks?) referred to? Comments in the code would be helpful 
also ... helping to avoid frowning at what at first glance seems like an 
out-of-bounds access.

> 
> Move everything that is particular to resctrl into a new header
> file, keeping the x86 hardware accessors where they are. resctrl code
> paths touching a 'hw' struct indicates where an abstraction is needed.

This establishes the significance of this patch. Here the rdt_resource 
struct is split up and it is this split that guides the subsequent 
abstraction. Considering this I find that this description does not 
explain the resulting split sufficiently.

Specifically, after reading the above summary I expect fs information in 
rdt_resource and hw information in rdt_hw_resource but that does not 
seem to be the case. For example, num_rmid is a property obtained from 
hardware but is found in rdt_resource while other hardware properties 
initialized at the same time are found in rdt_hw_resource. It is 
interesting to look at when the hardware is discovered (for example, 
functions like cache_alloc_hsw_probe(), __get_mem_config_intel(), 
__rdt_get_mem_config_amd(), rdt_get_cache_alloc_cfg()). Note how some of 
the discovered values end up in rdt_resource and some in 
rdt_hw_resource. I was expecting these properties discovered from 
hardware to be in rdt_hw_resource.

It is also not clear to me how these structures are intended to be used 
for related hardware properties. For example, rdt_resource keeps the 
properties alloc_capable/alloc_enabled/mon_capable/mon_enabled - but in 
this series companion properties of cdp_capable/cdp_enabled are 
introduced and placed in rdt_hw_resource. That seems contradicting to me.

Since this change is so foundational it would be very helpful if the 
resulting split could be explained in more detail.

Thank you

Reinette

