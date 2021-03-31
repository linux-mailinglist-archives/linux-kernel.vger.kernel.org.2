Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D969335099B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhCaVgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:36:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:39282 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhCaVgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:36:17 -0400
IronPort-SDR: RhnTJeUHR6djQZQaYxoLtzS66zHDWMqAsutxspldzJOsYH5vvcCyQhIITBPK7BPdPl4Fz0CbfU
 WTlMTJ8r3TSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="253432328"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="253432328"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:36:17 -0700
IronPort-SDR: PuB3JKqewoBHbFhYMerf7tLLZ/xNJUhXA/KrG4R7zioEodkvLZg/l1kTu3TTO5XZMt6EDnAsGb
 0kPKfLJM8KSA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377432689"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:36:16 -0700
Subject: Re: [PATCH v2 02/24] x86/resctrl: Split struct rdt_domain
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
 <20210312175849.8327-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <9cb3f9c9-8295-6e40-9f98-1944b9b3c59b@intel.com>
Date:   Wed, 31 Mar 2021 14:36:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-3-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/12/2021 9:58 AM, James Morse wrote:
> resctrl is the defacto Linux ABI for SoC resource partitioning features.
> To support it on another architecture, it needs to be abstracted from
> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
> 
> Split struct rdt_domain up too. Move everything that that is particular

s/that that/that/

> to resctrl into a new header file. resctrl code paths touching a 'hw'
> struct indicates where an abstraction is needed.

Similar to previous patch it would help to explain how this split was 
chosen. For example, why are the CPUs to which a resource is associated 
not considered a hardware property?

Thank you

Reinette
