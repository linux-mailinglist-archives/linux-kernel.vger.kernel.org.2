Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39E43CEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhJ0QwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:52:17 -0400
Received: from foss.arm.com ([217.140.110.172]:45312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhJ0QwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:52:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4165DED1;
        Wed, 27 Oct 2021 09:49:50 -0700 (PDT)
Received: from [10.1.196.31] (eglon.cambridge.arm.com [10.1.196.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6489A3F70D;
        Wed, 27 Oct 2021 09:49:48 -0700 (PDT)
Subject: Re: [PATCH v2 09/23] x86/resctrl: Switch over to the resctrl mbps_val
 list
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-10-james.morse@arm.com>
 <af0d23a9-61b3-8a2b-7f4c-4d2d6d510238@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <8dbfa092-685d-dc74-b8e5-449ad0ab5222@arm.com>
Date:   Wed, 27 Oct 2021 17:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <af0d23a9-61b3-8a2b-7f4c-4d2d6d510238@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/10/2021 23:26, Reinette Chatre wrote:
> On 10/1/2021 9:02 AM, James Morse wrote:
>> Updates to resctrl's software controller follow the same path as
>> other configuration updates, but they don't modify the hardware state.
>> rdtgroup_schemata_write() uses parse_line() and the resource's
>> ctrlval_parse function to stage the configuration.
> 
> parse_ctrlval ?
> 
>> resctrl_arch_update_domains() then updates the mbps_val[] array
>> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
>> call that would update hardware.
>>
>> This complicates the interface between resctrl's filesystem parts
>> and architecture specific code. It should be possible for mba_sc
>> to be completely implemented by the filesystem parts of resctrl. This
>> would allow it to work on a second architecture with no additional code.
>>
>> Change parse_bw() to write the configuration value directly to the
>> mba_sc[] array in the domain structure. Change rdtgroup_schemata_write()
> 
> mpbs_val[] array?
> 
>> to skip the call to resctrl_arch_update_domains(), meaning all the
>> mba_sc specific code in resctrl_arch_update_domains() can be removed.
>> On the read-side, show_doms() and update_mba_bw() are changed to read
>> the mba_sc[] array from the domain structure. With this,
> 
> mbps_val[] ?
> 
> Should rdtgroup_size_show() also get a similar snippet?

Yes! Good catch!


Thanks,

James
