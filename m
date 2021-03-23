Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C43465E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCWRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:05:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhCWRF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:05:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 809361042;
        Tue, 23 Mar 2021 10:05:29 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24123F718;
        Tue, 23 Mar 2021 10:05:27 -0700 (PDT)
Subject: Re: (subset) [PATCH v5 00/19] coresight: Add support for ETE and TRBE
To:     Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     leo.yan@linaro.org, catalin.marinas@arm.com,
        Linu Cherian <lcherian@marvell.com>,
        Will Deacon <will@kernel.org>, coresight@lists.linaro.org,
        Peter Zilstra <peterz@infradead.org>,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <161651726490.2050093.5536833570808361940.b4-ty@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bd50ab75-19eb-1957-942a-f045e3df8a51@arm.com>
Date:   Tue, 23 Mar 2021 17:05:26 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <161651726490.2050093.5536833570808361940.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 16:34, Marc Zyngier wrote:
> On Tue, 23 Mar 2021 12:06:28 +0000, Suzuki K Poulose wrote:
>> This series enables future IP trace features Embedded Trace Extension
>> (ETE) and Trace Buffer Extension (TRBE). This series applies on
>> v5.12-rc4 + some patches queued. A standalone tree is also available here [0].
>> The queued patches (almost there) are included in this posting for
>> the sake of constructing a tree from the posting.
>>
>> ETE is the PE (CPU) trace unit for CPUs, implementing future
>> architecture extensions. ETE overlaps with the ETMv4 architecture, with
>> additions to support the newer architecture features and some restrictions
>> on the supported features w.r.t ETMv4. The ETE support is added by extending
>> the ETMv4 driver to recognise the ETE and handle the features as exposed by
>> the TRCIDRx registers. ETE only supports system instructions access from the
>> host CPU. The ETE could be integrated with a TRBE (see below), or with
>> the legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same
>> firmware description as the ETMs and requires a node per instance.
>>
>> [...]
> 
> Applied to fixes, thanks!
> 
> [01/19] kvm: arm64: Hide system instruction access to Trace registers
>          commit: 4af0afe252a2701732c317585f7c3ef6596b8f3d
> 

Thanks Marc !
