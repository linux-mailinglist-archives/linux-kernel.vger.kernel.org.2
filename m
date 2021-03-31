Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907ED3509A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhCaViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:38:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:56905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhCaVh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:37:58 -0400
IronPort-SDR: yuDK7XMrYUnuqzfXDyfjZ6NR2MC0JT3r0H1har6s3ITfhE2a90C2j78K72Mmc8frvcSXLHcmhO
 9r7jTSeXnSKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="191575896"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="191575896"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:37:58 -0700
IronPort-SDR: FHmohomgvnJDA9mtHdrwa91RA3IpF0X1FypVWyctU3H6H+E3UuG78d9O8DmSdXFTPtDTgPQ08j
 XPo/BS2D1iyA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="377433046"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.177.63]) ([10.212.177.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:37:57 -0700
Subject: Re: [PATCH v2 05/24] x86/resctrl: Label the resources with their
 configuration type
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
 <20210312175849.8327-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <036004f2-828d-51f8-967d-a0b0625dd8d0@intel.com>
Date:   Wed, 31 Mar 2021 14:37:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210312175849.8327-6-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/12/2021 9:58 AM, James Morse wrote:

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 8a9da490134b..57484d2f6214 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -361,12 +361,14 @@ struct rdt_parse_data {
>   
>   /**
>    * struct rdt_hw_resource - hw attributes of a resctrl resource
> + * @conf_type:		The type that should be used when configuring. temporary

This is annotated with "temporary" but still remains after entire series 
is applied.

Reinette
