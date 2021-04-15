Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981C6361355
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhDOULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:11:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhDOULP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:11:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EEF11B3;
        Thu, 15 Apr 2021 13:10:51 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A103FA35;
        Thu, 15 Apr 2021 13:10:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] arm: topology: parse the topology from the dt
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Ruifeng Zhang <ruifeng.zhang0110@gmail.com>,
        linux@armlinux.org.uk, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        a.p.zijlstra@chello.nl, mingo@kernel.org,
        ruifeng.zhang1@unisoc.com, nianfu.bai@unisoc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210414122326.5255-1-ruifeng.zhang0110@gmail.com>
 <8735vrmnc7.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b7a76995-f6c3-67c5-b14e-d40587495d7e@arm.com>
Date:   Thu, 15 Apr 2021 22:10:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <8735vrmnc7.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 20:09, Valentin Schneider wrote:
> On 14/04/21 20:23, Ruifeng Zhang wrote:
>> From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
>>
>> In Unisoc, the sc9863a SoC which using cortex-a55, it has two software
>> version, one of them is the kernel running on EL1 using aarch32.
>>                 user(EL0)             kernel(EL1)
>> sc9863a_go      aarch32               aarch32
>> sc9863a         aarch64               aarch64
>>
>> When kernel runs on EL1 using aarch32, the topology will parse wrong.
>> For example,
>> The MPIDR has been written to the chip register in armv8.2 format.
>> For example,
>> core0: 0000000080000000
>> core1: 0000000080000100
>> core2: 0000000080000200
>> ...
>>
>> It will parse to:
>> |       | aff2 | packageid | coreid |
>> |-------+------+-----------+--------|
>> | Core0 |    0 |         0 |    0   |
>> | Core1 |    0 |         1 |    0   |
>> | Core2 |    0 |         2 |    0   |
>> |  ...  |      |           |        |
>>
>> The wrong topology is that all of the coreid are 0 and unexpected
>> packageid.
>>
>> The reason is the MPIDR format is different between armv7 and armv8.2.
>> armv7 (A7) mpidr is:
>> [11:8]      [7:2]       [1:0]
>> cluster     reserved    cpu
>> The cortex-a7 spec DDI0464F 4.3.5
>> https://developer.arm.com/documentation/ddi0464/f/?lang=en
>>
>> armv8.2 (A55) mpidr is:
>> [23:16]     [15:8]      [7:0]
>> cluster     cpu         thread
>>
> 
> What I had understood from our conversation was that there *isn't* a format
> difference (at least for the bottom 32 bits) - arm64/kernel/topopology.c
> would parse it the same, except that MPIDR parsing has been deprecated for
> arm64.
> 
> The problem is that those MPIDR values don't match the actual topology. If
> they had the MT bit set, i.e.
> 
>   core0: 0000000081000000
>   core1: 0000000081000100
>   core2: 0000000081000200
> 
> then it would be parsed as:
> 
>   |       | package_id | core_id | thread_id |
>   |-------+------------+---------+-----------|
>   | Core0 |          0 |       0 |         0 |
>   | Core1 |          0 |       1 |         0 |
>   | Core2 |          0 |       2 |         0 |
> 
> which would make more sense (wrt the actual, physical topology).

... and this would be in sync with
https://developer.arm.com/documentation/100442/0200/register-descriptions/aarch32-system-registers/mpidr--multiprocessor-affinity-register

MT, [24]

   0b1 ...

There is no 0b0 for MT.

