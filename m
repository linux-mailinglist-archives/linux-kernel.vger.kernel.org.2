Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68683A884A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhFOSLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:11:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:8557 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhFOSLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:11:17 -0400
IronPort-SDR: DgBN2PPNoiT6asw+rlgkLbxt55ybJszkPPN5ajalZkkfRJFA/FL6asfrdyQopn3kWQabEYk/MR
 VXc4wCkff/hA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204214845"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="204214845"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:09:12 -0700
IronPort-SDR: WM91ExTKNFaPBV41HRFQh0uyAnxlBkylfxhahAd+UNc3mWLPvPH50KyiWIuMxo+/HM367/ATHO
 Eua1+24Eo9nA==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554528877"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:09:11 -0700
Subject: Re: [PATCH v4 18/24] x86/resctrl: Make ctrlval arrays the same size
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
 <20210614200941.12383-19-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <bfb7310d-7a38-e0b9-b63b-d12ec453ac85@intel.com>
Date:   Tue, 15 Jun 2021 11:09:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-19-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/14/2021 1:09 PM, James Morse wrote:
> The CODE and DATA resources report a num_closid that is half the
> actual size supported by the hardware. This behaviour is visible
> to user-space when CDP is enabled.
> The CODE and DATA resources have their own ctrlval arrays which are half
> the size of the underlying hardware because num_closid was already
> adjusted. One holds the odd configurations values, the other even.
> 
> Before the CDP resources can be merged, the 'half the closids'
> behaviour needs to be implemented by schemata_list_create(), but
> this causes the ctrl_val[] array to be full sized.
> 
> Remove the logic from the architecture specific rdt_get_cdp_config()
> setup, and add it to schemata_list_create(). Functions that
> walk take num_closid directly from struct rdt_hw_resource also

This is unclear to me ... "Functions that walk ..." seems like it is 
missing to describe what they are walking.

> have to halve num_closid as only the lower half of each array is
> in use. domain_setup_ctrlval() and reset_all_ctrls() both copy
> struct rdt_hw_resource's num_closid to a struct msr_param. Correct
> the value here. This is temporary as a subsequent patch will merge
> the all three ctrl_val[] arrays such that when CDP is in use, the

the all three -> all three ?

Reinette
