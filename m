Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2940FE45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbhIQQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:41 -0400
Received: from foss.arm.com ([217.140.110.172]:55616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244799AbhIQQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 603B6101E;
        Fri, 17 Sep 2021 09:58:03 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250953F99C;
        Fri, 17 Sep 2021 09:58:00 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 03/20] x86/resctrl: Add domain online callback for
 resctrl work
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-4-james.morse@arm.com>
 <fc092644-0f5d-b0d1-d14d-765bd42b9cf8@intel.com>
Message-ID: <9e008971-f26f-e0c5-4745-a5f4e019aea7@arm.com>
Date:   Fri, 17 Sep 2021 17:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <fc092644-0f5d-b0d1-d14d-765bd42b9cf8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/09/2021 22:19, Reinette Chatre wrote:
> On 7/29/2021 3:35 PM, James Morse wrote:
>> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>> +{

>> +
>> +    if (is_mbm_enabled()) {
>> +        INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
>> +        mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
>> +    }
>> +
>> +    if (is_llc_occupancy_enabled())
>> +        INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>> +
> 
> You also seem to address an issue where this work was not properly cleaned up on the error
> paths of the replaced domain_setup_mon_state(). Thank you.

Oops ... if I'd thought of it like that I'd have sent it as a fix!
(huh, it'll need a backport too, bother)


>> +    /* If resctrl is mounted, add per domain monitor data directories. */
>> +    if (static_branch_unlikely(&rdt_enable_key))
> 
> Should this be rdt_mon_enable_key instead?

Yup, fixed.


Thanks,

James
