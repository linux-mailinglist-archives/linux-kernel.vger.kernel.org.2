Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C63A8841
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFOSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:09:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:49511 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhFOSJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:09:51 -0400
IronPort-SDR: 7gnpVFo/UvS44MN3sKN2thUKI98WpWHV0g0LUfcryRbxNoWuWzPrvbAH6vFjwf0XGuazFR2Zst
 XhM+H5kGKhIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206080330"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="206080330"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:07:46 -0700
IronPort-SDR: OGpEapkgwJ2ija8VunQ5NTZdtY4ZHImtRdAf9IeAOjWn66ynwYuLmRmCYFlXu0+bD1GYtifBQ6
 hA1eacoM1JbQ==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554528620"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:07:45 -0700
Subject: Re: [PATCH v4 02/24] x86/resctrl: Split struct rdt_domain
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
 <20210614200941.12383-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <317be161-3316-729f-5c49-4a3275226e01@intel.com>
Date:   Tue, 15 Jun 2021 11:07:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-3-james.morse@arm.com>
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

rdt_resource -> rdt_domain ?
user-space users -> user-space uses ?

> 
> Continue by splitting struct rdt_domain, into an architecture private
> 'hw' struct, which contains the common resctrl structure that would be
> used by any architecture. The hardware values in ctrl_val and mbps_val
> need to be accessed via helpers to allow another architecture to convert
> these into a different format if necessary. After this split, filesystem
> code paths touching a 'hw' struct indicates where an abstraction
> is needed.
> 
> Splitting this structure only moves types around, and should not lead
> to any change in behaviour.
> 
> Reviewed-by: Jamie Iles <jamie@nuviainc.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reinette
