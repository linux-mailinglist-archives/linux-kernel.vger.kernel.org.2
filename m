Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F360943347B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhJSLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:18:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:18:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BAD7D6E;
        Tue, 19 Oct 2021 04:15:52 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B1963F70D;
        Tue, 19 Oct 2021 04:15:50 -0700 (PDT)
Subject: Re: [PATCH v5 02/15] arm64: errata: Add detection for TRBE overwrite
 in FILL mode
To:     Will Deacon <will@kernel.org>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-3-suzuki.poulose@arm.com>
 <20211019110443.GE13251@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fa6177aa-e84d-3928-f202-0dd70df3164a@arm.com>
Date:   Tue, 19 Oct 2021 12:15:49 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019110443.GE13251@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 12:04, Will Deacon wrote:
> On Thu, Oct 14, 2021 at 11:31:12PM +0100, Suzuki K Poulose wrote:
>> Arm Neoverse-N2 and the Cortex-A710 cores are affected
>> by a CPU erratum where the TRBE will overwrite the trace buffer
>> in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
>> when it reaches the limit and wraps to the base to continue
>> writing upto 3 cache lines. This will overwrite any trace that
>> was written previously.
>>
>> Add the Neoverse-N2 erratumi(#2139208) and Cortex-A710 erratum
>> (#2119858) to the  detection logic.
> 
> Weird typo and double space in this sentence.

I have fixed this now.

Thanks
Suzuki

