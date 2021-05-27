Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA57D3931E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhE0PLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:11:03 -0400
Received: from foss.arm.com ([217.140.110.172]:58974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbhE0PKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:10:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CCFD11D4;
        Thu, 27 May 2021 08:08:46 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5379F3F73B;
        Thu, 27 May 2021 08:08:44 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com> <87fsyc6mfz.mognet@arm.com>
 <20210524225508.GA14880@e120325.cambridge.arm.com>
 <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <20210526121546.GA13262@e120325.cambridge.arm.com>
 <20210526125133.GB13262@e120325.cambridge.arm.com>
 <d4dc6630-041f-bf61-898a-6f402b993fbc@arm.com>
 <20210526214004.GA1712@e120325.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <14593ba7-eed9-f035-724c-5cadbb859adc@arm.com>
Date:   Thu, 27 May 2021 17:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526214004.GA1712@e120325.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2021 23:40, Beata Michalska wrote:
> On Wed, May 26, 2021 at 08:17:41PM +0200, Dietmar Eggemann wrote:
>> On 26/05/2021 14:51, Beata Michalska wrote:
>>> On Wed, May 26, 2021 at 01:15:46PM +0100, Beata Michalska wrote:
>>>> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
>>>>> On 25/05/2021 12:29, Beata Michalska wrote:
>>>>>> On Tue, May 25, 2021 at 10:53:07AM +0100, Valentin Schneider wrote:
>>>>>>> On 24/05/21 23:55, Beata Michalska wrote:
>>>>>>>> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
>>>>>>>>> On 24/05/21 11:16, Beata Michalska wrote:

[...]

>>                 cpu-map {
>>                         cluster0 {
>>                                 core0 {
>> 					thread0 {
>>                                         	cpu = <&A53_0>;
>> 					};
>> 					thread1 {
>>                                         	cpu = <&A53_1>;
>> 					};
>>                                 };
>>                                 core1 {
>> 					thread0 {
>>                                         	cpu = <&A53_2>;
>> 					};
>> 					thread1 {
>>                                         	cpu = <&A53_3>;
>> 					};
>>                                 };
>>                                 core2 {
>> 					thread0 {
>>                                         	cpu = <&A53_4>;
>> 					};
>> 					thread1 {
>>                                         	cpu = <&A53_5>;
>> 					};
>>                                 };
>>                         };
>>
>>                         cluster1 {
>>                                 core0 {
>> 					thread0 {
>>                                         	cpu = <&A53_6>;
>> 					};
>> 					thread1 {
>>                                         	cpu = <&A53_7>;
>> 					};
>>                                 };
>>                         };
>>                 };
>>
>> 		A53_0: cpu@0 {
>> 			capacity-dmips-mhz = <446>;
>> 	 	A53_1: cpu@1 {
>> 			capacity-dmips-mhz = <1024>;
>> 		A53_2: cpu@2 {
>> 			capacity-dmips-mhz = <871>;
>> 		A53_3: cpu@3 {
>> 			capacity-dmips-mhz = <1024>;
>> 		A53_4: cpu@4 {
>> 			capacity-dmips-mhz = <446>;
>> 		A53_5: cpu@5 {
>> 			capacity-dmips-mhz = <871>;
>> 		A53_6: cpu@6 {
>> 			capacity-dmips-mhz = <1024>;
>> 		A53_7: cpu@7 {
>> 			capacity-dmips-mhz = <1024>;
>>
>> Here I guess SD_ASYM_CPUCAPACITY will be attached to SMT[0-5]. So this
>> 'capacity-dmips-mhz' config error won't be detected.
>>
>> In case all CPUs (i.e. hw threads would have the correct
>> capacity-dmips-mhz = <1024> or not being set (default 1024))
>> asym_cap_list would corrcetly only have 1 entry.
> We could possibly add a warning (like in EAS) if the asymmetry is detected
> for SMT which would give some indication that there is smth ... wrong ?

Maybe, in case you find an easy way to detect this.

But the issue already exists today. Not with the topology mentioned
above but in case we slightly change it to:

  cpus = { ([446 1024] [871 1024] [446 1024] ) ([1024 1024]) }
                                       ^^^^
so that we have a 1024 CPU in the lowest sd for each CPU, we would get
SD_ASYM_CPUCAPACITY on SMT.
