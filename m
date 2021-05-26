Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAF392234
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhEZVl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:41:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234070AbhEZVlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:41:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A3C11D4;
        Wed, 26 May 2021 14:40:19 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA4D3F73B;
        Wed, 26 May 2021 14:40:12 -0700 (PDT)
Date:   Wed, 26 May 2021 22:40:05 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <20210526214004.GA1712@e120325.cambridge.arm.com>
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com>
 <87fsyc6mfz.mognet@arm.com>
 <20210524225508.GA14880@e120325.cambridge.arm.com>
 <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <20210526121546.GA13262@e120325.cambridge.arm.com>
 <20210526125133.GB13262@e120325.cambridge.arm.com>
 <d4dc6630-041f-bf61-898a-6f402b993fbc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4dc6630-041f-bf61-898a-6f402b993fbc@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:17:41PM +0200, Dietmar Eggemann wrote:
> On 26/05/2021 14:51, Beata Michalska wrote:
> > On Wed, May 26, 2021 at 01:15:46PM +0100, Beata Michalska wrote:
> >> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
> >>> On 25/05/2021 12:29, Beata Michalska wrote:
> >>>> On Tue, May 25, 2021 at 10:53:07AM +0100, Valentin Schneider wrote:
> >>>>> On 24/05/21 23:55, Beata Michalska wrote:
> >>>>>> On Mon, May 24, 2021 at 07:01:04PM +0100, Valentin Schneider wrote:
> >>>>>>> On 24/05/21 11:16, Beata Michalska wrote:
> 
> [...]
> 
> >>> BTW, how would this mechanism behave on a system with SMT and asymmetric CPU
> >>> capacity? Something EAS wouldn't allow but I guess asym_cap_list will be
> >>> constructed and the SD_ASYM_CPUCAPACITY_XXX flags will be set?
> >> Yes, the list would get created and flags set. I do not think there is
> >> a difference with current approach (?). So EAS would be disabled (it only cares
> >> about SD_ASYM_CPUCAPACITY_FULL flag) but the misift might still kick in.
> >>
> > That depends on the arch_scale_cpu_capacity. I would imagine it would
> > return SCHED_CAPACITY_SCALE for those, which means no asymmetry will
> > be detected ?
> 
> I was thinking about an erroneous dts file like:
> 
>                 cpu-map {
>                         cluster0 {
>                                 core0 {
> 					thread0 {
>                                         	cpu = <&A53_0>;
> 					};
> 					thread1 {
>                                         	cpu = <&A53_1>;
> 					};
>                                 };
>                                 core1 {
> 					thread0 {
>                                         	cpu = <&A53_2>;
> 					};
> 					thread1 {
>                                         	cpu = <&A53_3>;
> 					};
>                                 };
>                                 core2 {
> 					thread0 {
>                                         	cpu = <&A53_4>;
> 					};
> 					thread1 {
>                                         	cpu = <&A53_5>;
> 					};
>                                 };
>                         };
> 
>                         cluster1 {
>                                 core0 {
> 					thread0 {
>                                         	cpu = <&A53_6>;
> 					};
> 					thread1 {
>                                         	cpu = <&A53_7>;
> 					};
>                                 };
>                         };
>                 };
> 
> 		A53_0: cpu@0 {
> 			capacity-dmips-mhz = <446>;
> 	 	A53_1: cpu@1 {
> 			capacity-dmips-mhz = <1024>;
> 		A53_2: cpu@2 {
> 			capacity-dmips-mhz = <871>;
> 		A53_3: cpu@3 {
> 			capacity-dmips-mhz = <1024>;
> 		A53_4: cpu@4 {
> 			capacity-dmips-mhz = <446>;
> 		A53_5: cpu@5 {
> 			capacity-dmips-mhz = <871>;
> 		A53_6: cpu@6 {
> 			capacity-dmips-mhz = <1024>;
> 		A53_7: cpu@7 {
> 			capacity-dmips-mhz = <1024>;
> 
> Here I guess SD_ASYM_CPUCAPACITY will be attached to SMT[0-5]. So this
> 'capacity-dmips-mhz' config error won't be detected.
> 
> In case all CPUs (i.e. hw threads would have the correct
> capacity-dmips-mhz = <1024> or not being set (default 1024))
> asym_cap_list would corrcetly only have 1 entry.
We could possibly add a warning (like in EAS) if the asymmetry is detected
for SMT which would give some indication that there is smth ... wrong ?

---
BR
B.
