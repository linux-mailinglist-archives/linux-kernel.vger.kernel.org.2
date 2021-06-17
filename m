Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33653ABA30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhFQRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:05:28 -0400
Received: from foss.arm.com ([217.140.110.172]:56756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFQRFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:05:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A7CC13D5;
        Thu, 17 Jun 2021 10:03:14 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A2223F694;
        Thu, 17 Jun 2021 10:03:12 -0700 (PDT)
Subject: Re: [PATCH v4 18/24] x86/resctrl: Make ctrlval arrays the same size
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
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
 <bfb7310d-7a38-e0b9-b63b-d12ec453ac85@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <46b42971-724c-c585-efec-c824838d7434@arm.com>
Date:   Thu, 17 Jun 2021 18:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <bfb7310d-7a38-e0b9-b63b-d12ec453ac85@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/06/2021 19:09, Reinette Chatre wrote:
> On 6/14/2021 1:09 PM, James Morse wrote:
>> The CODE and DATA resources report a num_closid that is half the
>> actual size supported by the hardware. This behaviour is visible
>> to user-space when CDP is enabled.
>> The CODE and DATA resources have their own ctrlval arrays which are half
>> the size of the underlying hardware because num_closid was already
>> adjusted. One holds the odd configurations values, the other even.
>>
>> Before the CDP resources can be merged, the 'half the closids'
>> behaviour needs to be implemented by schemata_list_create(), but
>> this causes the ctrl_val[] array to be full sized.
>>
>> Remove the logic from the architecture specific rdt_get_cdp_config()
>> setup, and add it to schemata_list_create(). Functions that
>> walk take num_closid directly from struct rdt_hw_resource also
> 
> This is unclear to me ... "Functions that walk ..." seems like it is missing to describe
> what they are walking.

Yup, I'm missing at least a word here! Fixed as:
| functions that walk all the configurations, such as domain_setup_ctrlval() and
| reset_all_ctrls() , take the num_closids directly from...


>> have to halve num_closid as only the lower half of each array is
>> in use. domain_setup_ctrlval() and reset_all_ctrls() both copy
>> struct rdt_hw_resource's num_closid to a struct msr_param. Correct
>> the value here. This is temporary as a subsequent patch will merge
>> the all three ctrl_val[] arrays such that when CDP is in use, the
> 
> the all three -> all three ?

Yes. Thanks!

(I've never managed to spot things like this in text I wrote)


Thanks,

James
