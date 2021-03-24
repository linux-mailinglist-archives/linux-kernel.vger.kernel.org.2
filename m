Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E913F34811E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhCXTAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:00:06 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52993 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237670AbhCXS7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:59:54 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lP8jF-001pZc-3g; Wed, 24 Mar 2021 19:59:41 +0100
Received: from p57bd9564.dip0.t-ipconnect.de ([87.189.149.100] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lP8jE-0004jc-St; Wed, 24 Mar 2021 19:59:41 +0100
Subject: Re: [PATCH] ia64: Ensure proper NUMA distance and possible map
 initialization
To:     Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        debian-ia64 <debian-ia64@lists.debian.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Anatoly Pugachev <matorola@gmail.com>
References: <20210318130617.896309-1-valentin.schneider@arm.com>
 <20210324115432.4102cd93d35a2edb1742dec7@linux-foundation.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <4e45a4a0-7611-a5cc-be8f-b43d6d5b2b0c@physik.fu-berlin.de>
Date:   Wed, 24 Mar 2021 19:59:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324115432.4102cd93d35a2edb1742dec7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.149.100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 3/24/21 7:54 PM, Andrew Morton wrote:
> On Thu, 18 Mar 2021 13:06:17 +0000 Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
>> John Paul reported a warning about bogus NUMA distance values spurred by
>> commit:
>>
>>   620a6dc40754 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
>>
>> In this case, the afflicted machine comes up with a reported 256 possible
>> nodes, all of which are 0 distance away from one another. This was
>> previously silently ignored, but is now caught by the aforementioned
>> commit.
>>
>> The culprit is ia64's node_possible_map which remains unchanged from its
>> initialization value of NODE_MASK_ALL. In John's case, the machine doesn't
>> have any SRAT nor SLIT table, but AIUI the possible map remains untouched
>> regardless of what ACPI tables end up being parsed. Thus, !online &&
>> possible nodes remain with a bogus distance of 0 (distances \in [0, 9] are
>> "reserved and have no meaning" as per the ACPI spec).
>>
>> Follow x86 / drivers/base/arch_numa's example and set the possible map to
>> the parsed map, which in this case seems to be the online map.
>>
>> Link: http://lore.kernel.org/r/255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de
>> Fixes: 620a6dc40754 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>> This might need an earlier Fixes: tag, but all of this is quite old and
>> dusty (the git blame rabbit hole leads me to ~2008/2007)
>>
> 
> Thanks.  Is this worth a cc:stable tag?

Looks like the regression was introduced 5.12-rc1, so no need for backporting.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

