Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B011D36DE19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhD1RVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbhD1RVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:21:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB75C061573;
        Wed, 28 Apr 2021 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+2Q7mwWekdxGc0zD9jcOc66YLSfbdYXbGYVnMPHUZ2U=; b=VJdILUNbh7CIXOSSmlhizYOqXv
        CtBuq4BUcPo7o4uhwMBNtdTU0l8eerV8sJ674eWSHI9pSue8iMbWwMQEne5ArW5NJD66lClgyhTai
        ZdQGNzPqKJbfAyarzhMTuAz9FItGnb2EUnmnBGV8LseRbtIzpVVu68KDmhrQcBZw2mRuNulQkd1ql
        fca/DYtAPSBRlJt1eCK4hTSd4O9wIdcJiRIsaEhWnP4A413lBAdgz4yMJvD2r+mr+vSvrSjIT3NtX
        1ED9ozSW2hHjddgHAIFD5Z0WBqHAkpb8lBlylHtijvPi+3mQrDEeqG2Vqfehs74UBwk5GeXVy/iYi
        Xg1JuKCw==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbnqJ-008b9P-R2; Wed, 28 Apr 2021 17:19:23 +0000
Subject: Re: [RFC PATCH v2 3/3] sched/doc: Update the CPU capacity asymmetry
 bits
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, linux-doc@vger.kernel.org
References: <1619602363-1305-1-git-send-email-beata.michalska@arm.com>
 <1619602363-1305-4-git-send-email-beata.michalska@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79223641-6b3e-6b48-50df-3a9c73c003cd@infradead.org>
Date:   Wed, 28 Apr 2021 10:19:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1619602363-1305-4-git-send-email-beata.michalska@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 2:32 AM, Beata Michalska wrote:
> Update the documentation bits referring to capacity aware scheduling
> with regards to newly introduced SD_ASYM_CPUCAPACITY_FULL shed_domain

                                                            sched_domain
I guess.

> flag.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  Documentation/scheduler/sched-capacity.rst | 6 ++++--
>  Documentation/scheduler/sched-energy.rst   | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
> index 9b7cbe4..92d16e7 100644
> --- a/Documentation/scheduler/sched-capacity.rst
> +++ b/Documentation/scheduler/sched-capacity.rst
> @@ -284,8 +284,10 @@ whether the system exhibits asymmetric CPU capacities. Should that be the
>  case:
>  
>  - The sched_asym_cpucapacity static key will be enabled.
> -- The SD_ASYM_CPUCAPACITY flag will be set at the lowest sched_domain level that
> -  spans all unique CPU capacity values.
> +- The SD_ASYM_CPUCAPACITY_FULL flag will be set at the lowest sched_domain
> +  level that spans all unique CPU capacity values.
> +- The SD_ASYM_CPUCAPACITY flag will be set for any sched_domain that spans
> +  cpus with any range of asymmetry.

     CPUs
please.

>  
>  The sched_asym_cpucapacity static key is intended to guard sections of code that
>  cater to asymmetric CPU capacity systems. Do note however that said key is
> diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
> index afe02d3..8fbce5e 100644
> --- a/Documentation/scheduler/sched-energy.rst
> +++ b/Documentation/scheduler/sched-energy.rst
> @@ -328,7 +328,7 @@ section lists these dependencies and provides hints as to how they can be met.
>  
>  As mentioned in the introduction, EAS is only supported on platforms with
>  asymmetric CPU topologies for now. This requirement is checked at run-time by
> -looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
> +looking for the presence of the SD_ASYM_CPUCAPACITY_FULL flag when the scheduling
>  domains are built.
>  
>  See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
> 

thanks.
-- 
~Randy

