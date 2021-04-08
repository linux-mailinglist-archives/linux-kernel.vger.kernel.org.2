Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B2358E23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhDHUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:13:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:39834 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhDHUNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:13:14 -0400
IronPort-SDR: ZuNRDsM7tic3xvfByCA5TShiz5wTNV4Drg2P+6TpoY0goUrEgHiE72RW0/QYTq4I2a7Rrwuh5d
 +EAmHrQBzm+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173708040"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="173708040"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 13:13:02 -0700
IronPort-SDR: Kg/e5hybWEdrP9XMToUwuG+GabS9yvdyTe5SKbIzit7KRFZoD1+sVF2rP/R+YoDVkg2suDOG+M
 kz2tdeEX8TGg==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="422399429"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.185.130]) ([10.212.185.130])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 13:13:01 -0700
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
 <9cb3f9c9-8295-6e40-9f98-1944b9b3c59b@intel.com>
 <c8c1a559-9045-a28c-46c0-dddeb9b38a14@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <905a2bbf-f117-4b20-b875-dc1133d83f0d@intel.com>
Date:   Thu, 8 Apr 2021 13:13:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c8c1a559-9045-a28c-46c0-dddeb9b38a14@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/8/2021 10:20 AM, James Morse wrote:
> On 31/03/2021 22:36, Reinette Chatre wrote:
>> On 3/12/2021 9:58 AM, James Morse wrote:
>>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>>> To support it on another architecture, it needs to be abstracted from
>>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>>>
>>> Split struct rdt_domain up too. Move everything that that is particular
>>
>> s/that that/that/
>>
>>> to resctrl into a new header file. resctrl code paths touching a 'hw'
>>> struct indicates where an abstraction is needed.
>>
>> Similar to previous patch it would help to explain how this split was chosen. For example,
>> why are the CPUs to which a resource is associated not considered a hardware property?
> 
> Similarly, because the meaning of those CPUs doesn't differ or change between architectures.

Got it. This seems to be a repeat of the discussion about patch 1. 
Please note that the description of rdt_hw_domain in this patch reads 
"hw attributes of a group of CPUs that share a resource". This can be 
understood to mean that the struct contains attributes discovered from 
hardware.


> I've expanded the middle paragraph in the commit message to explain why the arch specific
> things are arch specific:
> | Continue by splitting struct rdt_domain, into an architecture private
> | 'hw' struct, which contains the common resctrl structure that would be
> | used by any architecture.
> |
> | The hardware values in ctrl_val and mbps_val need to be accessed via
> | helpers to allow another architecture to convert these into a different
> | format if necessary.
> |
> | After this split, filesystem code code paths touching a 'hw' struct
> | indicates where an abstraction is needed.
> 
> and similarly changed the kernel doc comment.

Thank you. I assume this includes changing the "hw attributes of a group 
of CPUs that share a resource" I mention above.

> 
> Let me know if you prefer some other struct name.
> 

I am ok with current naming. Other folks may have better ideas.

Thank you

Reinette

