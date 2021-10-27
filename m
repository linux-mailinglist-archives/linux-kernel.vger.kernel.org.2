Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CA43CF07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbhJ0Qwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:52:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243030AbhJ0Qwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:52:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9A0B106F;
        Wed, 27 Oct 2021 09:50:20 -0700 (PDT)
Received: from [10.1.196.31] (eglon.cambridge.arm.com [10.1.196.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4B1E3F70D;
        Wed, 27 Oct 2021 09:50:18 -0700 (PDT)
Subject: Re: [PATCH v2 12/23] x86/resctrl: Abstract and use
 supports_mba_mbps()
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-13-james.morse@arm.com>
 <TYAPR01MB633002CD0CC9019A98EB517D8BB19@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <66c1dd99-2ff2-21d3-630f-7265b814faab@arm.com>
Date:   Wed, 27 Oct 2021 17:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB633002CD0CC9019A98EB517D8BB19@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 07:13, tan.shaopeng@fujitsu.com wrote:
>> To determine whether the mba_MBps option to resctrl should be supported,
>> resctrl tests the boot cpus' x86_vendor.
>>
>> This isn't portable, and needs abstracting behind a helper so this check can be
>> part of the filesystem code that moves to /fs/.
>>
>> Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
>> on this system. An 'alloc_capable' test is added so that support for the controls
>> isn't implied by the 'delay_linear' property, which is always true for MPAM.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>

Thanks!

James
