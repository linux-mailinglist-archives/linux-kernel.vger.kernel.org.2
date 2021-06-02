Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6E399145
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFBRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:19:04 -0400
Received: from foss.arm.com ([217.140.110.172]:50422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhFBRTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:19:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E75F11FB;
        Wed,  2 Jun 2021 10:17:19 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066933F719;
        Wed,  2 Jun 2021 10:17:17 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
References: <87fsyc6mfz.mognet@arm.com>
 <20210524225508.GA14880@e120325.cambridge.arm.com>
 <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <20210526121546.GA13262@e120325.cambridge.arm.com>
 <20210526125133.GB13262@e120325.cambridge.arm.com>
 <d4dc6630-041f-bf61-898a-6f402b993fbc@arm.com>
 <20210526214004.GA1712@e120325.cambridge.arm.com>
 <14593ba7-eed9-f035-724c-5cadbb859adc@arm.com>
 <20210527170729.GA20994@e120325.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4f43a9a8-b64e-bb47-b3c1-f51165f40249@arm.com>
Date:   Wed, 2 Jun 2021 19:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527170729.GA20994@e120325.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2021 19:07, Beata Michalska wrote:
> On Thu, May 27, 2021 at 05:08:42PM +0200, Dietmar Eggemann wrote:
>> On 26/05/2021 23:40, Beata Michalska wrote:
>>> On Wed, May 26, 2021 at 08:17:41PM +0200, Dietmar Eggemann wrote:
>>>> On 26/05/2021 14:51, Beata Michalska wrote:
>>>>> On Wed, May 26, 2021 at 01:15:46PM +0100, Beata Michalska wrote:
>>>>>> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
>>>>>>> On 25/05/2021 12:29, Beata Michalska wrote:
>>>>>>>> On Tue, May 25, 2021 at 10:53:07AM +0100, Valentin Schneider wrote:
>>>>>>>>> On 24/05/21 23:55, Beata Michalska wrote:
>>>>>>>>>> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
>>>>>>>>>>> On 24/05/21 11:16, Beata Michalska wrote:

[...]

>>> We could possibly add a warning (like in EAS) if the asymmetry is detected
>>> for SMT which would give some indication that there is smth ... wrong ?
>>
>> Maybe, in case you find an easy way to detect this.
>>
>> But the issue already exists today. Not with the topology mentioned
>> above but in case we slightly change it to:
>>
>>   cpus = { ([446 1024] [871 1024] [446 1024] ) ([1024 1024]) }
>>                                        ^^^^
>> so that we have a 1024 CPU in the lowest sd for each CPU, we would get
>> SD_ASYM_CPUCAPACITY on SMT.
> The asymmetry capacity flags are being set on a sched domain level, so
> we could use the SD_SHARE_CPUCAPACITY|SD_SHARE_PKG_RESOURCES (cpu_smt_flags)
> flags to determine if having asymmetry is valid or not ? If this is enough 
> this could be handled by the classify function?

Or maybe something directly in sd_init(), like the WARN_ONCE() which triggers
if somebody wants to sneak in a ~topology flag via a
sched_domain_topology_level table? 

IMHO checking `SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY` will be sufficient
here.

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 62d412013df8..77b73abbb9a4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1561,6 +1561,11 @@ sd_init(struct sched_domain_topology_level *tl,
        sd_id = cpumask_first(sched_domain_span(sd));
 
        sd->flags |= asym_cpu_capacity_classify(sd, cpu_map);
+
+       WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
+                 (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),
+                     "CPU capacity asymmetry not supported on SMT\n");
+
        /*
         * Convert topological properties into behaviour.
         */

In case we can agree on something simple here I guess you can incorporate it into v7.
