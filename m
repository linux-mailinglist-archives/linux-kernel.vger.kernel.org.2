Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500603D3CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhGWPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:48136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235470AbhGWPJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4649139F;
        Fri, 23 Jul 2021 08:49:46 -0700 (PDT)
Received: from [10.57.8.76] (unknown [10.57.8.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0262A3F73D;
        Fri, 23 Jul 2021 08:49:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
To:     Will Deacon <will@kernel.org>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
 <20210722095010.GA12012@willie-the-truck>
 <43b32e77-52b1-8524-63a1-c99578c2dd1d@arm.com>
 <20210722153814.GA12566@willie-the-truck>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <53f9359d-d3ac-5a3c-1e29-9fb7e9fda22c@arm.com>
Date:   Fri, 23 Jul 2021 16:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210722153814.GA12566@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 7/22/21 4:38 PM, Will Deacon wrote:
> Hi Vladimir,
> 
> On Thu, Jul 22, 2021 at 04:22:26PM +0100, Vladimir Murzin wrote:
>> On 7/22/21 10:50 AM, Will Deacon wrote:
>>> As an aside: I'm more and more inclined to rip out the CnP stuff given
>>> that it doesn't appear to being any benefits, but does have some clear
>>> downsides. Perhaps something for next week.
>>
>> Can you please clarify what do you mean by "it doesn't appear to being any
>> benefits"? IIRC, Cortex-A65 implements CnP hint and I've heard that some
>> payloads seen improvement...
> 
> Has anybody taped that out? I'd have thought building an SMT design in 2021
> is a reasonably courageous thing to do.

As you said three can be niche for that...

> 
> The issue I'm getting at is that modern cores seem to advertise CnP even
> if they ignore it internally, maybe because of some big/little worries?

Should we employ CPU errata framework for such cores to demote CnP?

> That would be fine if it didn't introduce complexity and overhead to the
> kernel, but it does and therefore I think we should rip it out (or at
> least stick it behind a "default n" config option if there are some niche
> users).

"default n" still better then no code at all :)

Cheers
Vladimir

> 
> There are also open questions as to exactly what CnP does because the
> architecture is not clear at all (for example TTBRx_EL1.CnP is permitted
> to be cached in a TLB).
> 
> CHeers,
> 
> Will
> 

