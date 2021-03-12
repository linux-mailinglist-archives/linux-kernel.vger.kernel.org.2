Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5333945C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhCLRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:13:18 -0500
Received: from foss.arm.com ([217.140.110.172]:57634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhCLRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:13:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387D111FB;
        Fri, 12 Mar 2021 09:13:12 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5956F3F7D7;
        Fri, 12 Mar 2021 09:13:10 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 06/24] x86/resctrl: Store the effective num_closid in the
 schema
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-7-james.morse@arm.com>
 <14fa276a-ce44-07f4-203e-d1c8f5967b0b@intel.com>
Message-ID: <52acfce6-8043-30eb-8300-648ed613cdaa@arm.com>
Date:   Fri, 12 Mar 2021 17:13:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <14fa276a-ce44-07f4-203e-d1c8f5967b0b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 22:04, Reinette Chatre wrote:
> On 10/30/2020 9:11 AM, James Morse wrote:
>> resctrl_schema holds properties that vary with the style of configuration
>> that resctrl applies to a resource.
>>
>> Once the arch code has a single resource per cache that can be configured,
>> resctrl will need to keep track of the num_closid itself.
>>
>> Add num_closid to resctrl_schema. Change callers like
>> rdtgroup_schemata_show() to walk the schema instead.

> This is a significant patch in that it introduces a second num_closid available for code
> to use. Even so, the commit message is treating it quite nonchalantly ... essentially
> stating that "here is a new closid and change some code to use it".

The difference already exists, the number of closid that resctrl exposes to user-space may
be different from what the hardware supports. Currently the arch code does a
bait-and-switch with the L3CODE/L3DATA resources, but this is specific to x86, it
shouldn't be required for another architecture to copy it if its not necessary to support CDP.

I'll expand the commit message with this.

An earlier version tried to use different types for the 'hw' number of closid, and the
version used by resctrl, but I figured it was too noisy.


> Could you please elaborate how the callers needing to "walk the schema instead" were chosen?

These all want the num_closid value that is exposed to user-space:
rdtgroup_parse_resource()
rdtgroup_schemata_show()
rdt_num_closids_show()
closid_init()

If resctrl is in control of that, it should come from the schema instead of being pulled
straight out of the architecture code.


> This seems almost a revert of the earlier patch that introduced the helper and I wonder if
> it may not make this easier to understand if these areas do not receive the temporary
> change to use that helper.

Its a trade-off between churn for a self contained change (i.e. all the 'fs' bits,
regardless of if they are around later), and keeping the patches that are to do with the
schema together.

I don't think its a good idea to have "these are left alone as they will be changed
differently later" as that is liable to break (or just get weird) as the series is
restructured to fix it.

It will probably be fewer lines of change to do it the other way round. v2 does this,
hopefully that is easier on the eye!


Thanks,

James
