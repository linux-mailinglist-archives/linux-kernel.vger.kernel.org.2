Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79533509A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhCaViy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:38:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:11505 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232585AbhCaVil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:38:41 -0400
IronPort-SDR: EppeCfZ2t4TJk7J9++CWPaAceC/HbAOUiDXPiTlSmVga0tZOVLEs21rXh7xreOGq3VAylTijk5
 8nsEW6Q1ZB7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192198657"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192198657"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:38:41 -0700
IronPort-SDR: eTMnI4kwUh8lBZ+cBTDQzKt0wulN5uZWbQvjA/de7czjWZDmmGm8vd5ZAk9ecG3eVrPgiWjStg
 f3Z92azyL2EA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377433229"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:38:40 -0700
Subject: Re: [PATCH v2 06/24] x86/resctrl: Walk the resctrl schema list
 instead of an arch list
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
 <20210312175849.8327-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <aad608d2-660d-89b9-5191-551ad8b0c66d@intel.com>
Date:   Wed, 31 Mar 2021 14:38:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-7-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/12/2021 9:58 AM, James Morse wrote:
> Once the arch code is abstracted from the resctrl filesystem code
> the separate schema for CDP are created by the filesystem code. This
> means the same resource is used for different schema, or types of
> configuration.
> 
> Helpers like rdtgroup_cbm_overlaps() need the resctrl_schema to
> retrieve the configuration (or configurations). Before these
> helpers can be changed to take the schema instead of the resource,
> their callers must have the schema on hand.
> 
> Change the users of for_each_alloc_enabled_rdt_resource() to walk
> the schema instead. Schema were only created for alloc_enabled resources
> so these two lists are currently equivalent.

Currently equivalent? Does this mean that at some point they will not be 
equivalent and this change will be impacted?

> 
> schemata_list_create() and rdt_kill_sb() are ignored. The first
> creates the schema list, and will eventually loop over the resource
> indexes using an arch helper to retrieve the resource. rdt_kill_sb()
> will eventually make use of an arch 'reset everything' helper.

Please elaborate on what "eventually" means here. It does not seem to 
indicate this patch series so please clarify that and any impacts.

> 
> After the filesystem code is moved, rdtgroup_pseudo_locked_in_hierarchy()
> remains part of the x86 specific hooks to support psuedo lock. This code

psuedo -> pseudo

Thank you

Reinette
