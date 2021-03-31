Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498703509A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhCaVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:39:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:8206 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhCaVjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:39:13 -0400
IronPort-SDR: Kgy/PqLNF4NoNHVmrzhKYUVEp8ETMx4elyWNEfnzVDYu6noChz9fQigslMfOe/o5Tb65L749N1
 NB0O0mkWEJMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="179629597"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="179629597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:39:12 -0700
IronPort-SDR: XvTn2FJpFtXBQLuiJg6yOjQIjGzmROuVLmgSrrWRsSCPuMTMlAcBO55lxgNOKe4TVnujBmTsdN
 bchhyS7PKoTw==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377433317"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:39:11 -0700
Subject: Re: [PATCH v2 07/24] x86/resctrl: Store the effective num_closid in
 the schema
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
 <20210312175849.8327-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0d16823c-58b4-1c01-b621-7fdc4ba84333@intel.com>
Date:   Wed, 31 Mar 2021 14:39:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-8-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/12/2021 9:58 AM, James Morse wrote:
> The resctrl_schema struct holds properties that vary with the style of
> configuration that resctrl applies to a resource.
> 
> There are already two values for the hardware's num_closid, depending on
> whether the architecture presents the L3 or L3CODE/L3DATA resources.
> 
> As the way CDP changes the number of control groups that resctrl can create
> is part of the user-space interface, it should be managed by the filesystem

s/create is part of/create as part of/ ?

> parts of resctrl. This allows the architecture code to only describe the
> value the hardware supports.
> 
> Add num_closid to resctrl_schema. This is the value seen by the filesystem,
> and when the CDP resources are merged, will be different to the value
> described by the arch code when CDP is enabled.
> 
> These functions operate on the num_closid value that is exposed to
> user-space:
> rdtgroup_parse_resource()
> rdtgroup_schemata_show()
> rdt_num_closids_show()
> closid_init()
> 
> These are changed to use the schema value instead.
> 
> schemata_list_create() sets this value, and reaches into the architecture
> specific structure to get the value. This will eventually be replaced with
> a helper.
> 
> Reviewed-by: Jamie Iles <jamie@nuviainc.com>
> Signed-off-by: James Morse <james.morse@arm.com>


...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index c6f749f54765..0ff10468940b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -165,10 +165,12 @@ struct rdt_resource {
>    * @list:	Member of resctrl's schema list
>    * @conf_type:	Whether this entry is for code/data/both
>    * @res:	The rdt_resource for this entry
> + * @num_closid:	Number of CLOSIDs available for this resource

It is not clear what "this resource" is. This description is essentially 
the same as its copy found in rdt_hw_resource. Could you please improve 
these descriptions to capture the differences between the two num_closid 
values?

Thank you

Reinette
