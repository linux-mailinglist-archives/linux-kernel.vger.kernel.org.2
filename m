Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1716402618
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbhIGJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:20:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244918AbhIGJUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BDB131B;
        Tue,  7 Sep 2021 02:19:00 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4C7F3F766;
        Tue,  7 Sep 2021 02:18:58 -0700 (PDT)
Subject: Re: [PATCH 08/10] coresight: trbe: Workaround TRBE errat overwrite in
 FILL mode
To:     Linu Cherian <linuc.decode@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, maz@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-9-suzuki.poulose@arm.com>
 <CAAHhmWjR6XYo5j_h3jfLsmWzqD9i9L-pHq=zrrdrw9YTXmuCqg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e7241294-d7a3-2286-0bcd-a0cdbec77ffc@arm.com>
Date:   Tue, 7 Sep 2021 10:18:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAAHhmWjR6XYo5j_h3jfLsmWzqD9i9L-pHq=zrrdrw9YTXmuCqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linu

On 06/08/2021 17:09, Linu Cherian wrote:
> Hi Suzuki,
> 
> On Wed, Jul 28, 2021 at 7:23 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
>> an erratum, which when triggered, might cause the TRBE to overwrite
>> the trace data already collected in FILL mode, in the event of a WRAP.
>> i.e, the TRBE doesn't stop writing the data, instead wraps to the base
>> and could write upto 3 cache line size worth trace. Thus, this could
>> corrupt the trace at the "BASE" pointer.
>>
>> The workaround is to program the write pointer 256bytes from the
>> base, such that if the erratum is triggered, it doesn't overwrite
>> the trace data that was captured. This skipped region could be
>> padded with ignore packets at the end of the session, so that
>> the decoder sees a continuous buffer with some padding at the
>> beginning.
> 
> Just trying to understand,
> Is there a possibility that lost data results in partial trace packets
> towards the end of the buffer ? Or its always guaranteed that
> trace packet end is always aligned with buffer end/limit ?
> Thinking of a case when formatting is disabled.

Yes, trace could be partial towards the end with TRBE in the FILL mode.
The TRBE doesn't add any formatting and is thus raw ETE trace which
doesn't have any alignment requirements. This the case even without
the work around.

Suzuki
