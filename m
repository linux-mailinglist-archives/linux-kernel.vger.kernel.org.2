Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80D43FCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhJ2NDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:03:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhJ2NCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:02:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 805A9ED1;
        Fri, 29 Oct 2021 06:00:23 -0700 (PDT)
Received: from [10.57.25.71] (unknown [10.57.25.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA00D3F73D;
        Fri, 29 Oct 2021 06:00:21 -0700 (PDT)
Subject: Re: [PATCH v5 09/15] coresight: trbe: Add infrastructure for Errata
 handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Marc Zyngier <maz@kernel.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-10-suzuki.poulose@arm.com>
 <CAK8P3a0=GC26FBuyoj2Q02VXdfkOd4k0DiDfp+0KF3C6tNO3XQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d56183ca-7592-a81c-9404-a07b364cc13c@arm.com>
Date:   Fri, 29 Oct 2021 14:00:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0=GC26FBuyoj2Q02VXdfkOd4k0DiDfp+0KF3C6tNO3XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

Thanks for the report.

On 29/10/2021 11:31, Arnd Bergmann wrote:
> On Fri, Oct 15, 2021 at 12:31 AM Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> +static void trbe_check_errata(struct trbe_cpudata *cpudata)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < TRBE_ERRATA_MAX; i++) {
>> +               int cap = trbe_errata_cpucaps[i];
>> +
>> +               if (WARN_ON_ONCE(cap < 0))
>> +                       return;
>> +               if (this_cpu_has_cap(cap))
>> +                       set_bit(i, cpudata->errata);
>> +       }
>> +}
> 
> this_cpu_has_cap() is private to arch/arm64 and not exported, so this causes
> a build failure when used from a loadable module:
> 
> ERROR: modpost: "this_cpu_has_cap"
> [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> 
> Should this symbol be exported or do we need a different workaround?

This should be exported. I can send in a patch.

Suzuki
