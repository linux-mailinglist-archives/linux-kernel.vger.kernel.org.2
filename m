Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23DF40FE40
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbhIQQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:29 -0400
Received: from foss.arm.com ([217.140.110.172]:55516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244962AbhIQQ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48391101E;
        Fri, 17 Sep 2021 09:57:53 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E356C3F59C;
        Fri, 17 Sep 2021 09:57:50 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 09/20] x86/resctrl: Abstract and use
 supports_mba_mbps()
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
 <20210729223610.29373-10-james.morse@arm.com>
 <c8ef35f7-efa1-0e2f-e1ab-7b0df4a5ae2d@intel.com>
Message-ID: <68dc7be2-9d07-15ca-1c53-d74e17e83ba6@arm.com>
Date:   Fri, 17 Sep 2021 17:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <c8ef35f7-efa1-0e2f-e1ab-7b0df4a5ae2d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/09/2021 22:27, Reinette Chatre wrote:
> On 7/29/2021 3:35 PM, James Morse wrote:
>> To determine whether the mba_mbps option to resctrl should be supported,
> 
> mba_mbps -> mba_MBps
> 
>> resctrl tests the boot cpus' x86_vendor.
> 
> CPU
> 
>>
>> This isn't portable, and needs abstracting behind a helper so this check
>> can be part of the filesystem code that moves to /fs/.

>> Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
>> on this system. An 'alloc_capable' test is added so that this property
>> isn't implied by 'linear'.

> Why can linear not imply alloc_capable? It is a property of a MBA resource so if it is set
> then it has to be a MBA resource.

mba_sc depends on controls and monitors. It checks for monitors with is_mbm_enabled(), and
assumes that the delay_linear property being true means the control feature must exist. I
think this is fragile.

For MPAM, delay_linear is always true. Any way of controlling the bandwidth has this
property. Its very likely to be set statically in the struct, regardless of whether the
controls exist. alloc_capable seems to mean 'controls exist'.

This is to avoid an annoying bug where supports_mba_mbps() reports true, but the controls
aren't available. Or equally annoying, for the arch code to set/clear that flag in
addition to alloc_capable.

I'll add some verbage about MPAM to the commit message.



Thanks,

James
