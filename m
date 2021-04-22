Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02053685D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhDVR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:27:16 -0400
Received: from foss.arm.com ([217.140.110.172]:54308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236651AbhDVR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A18D6E;
        Thu, 22 Apr 2021 10:26:40 -0700 (PDT)
Received: from [10.57.27.187] (unknown [10.57.27.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137D93F694;
        Thu, 22 Apr 2021 10:26:37 -0700 (PDT)
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <158a3969-6ef2-a532-7ae1-07e3d7fecfe5@arm.com>
Date:   Thu, 22 Apr 2021 18:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,


On 4/8/21 6:10 PM, Vincent Donnefort wrote:
> Some SoCs, such as the sd855 have OPPs within the same performance domain,
> whose cost is higher than others with a higher frequency. Even though
> those OPPs are interesting from a cooling perspective, it makes no sense
> to use them when the device can run at full capacity. Those OPPs handicap
> the performance domain, when choosing the most energy-efficient CPU and
> are wasting energy. They are inefficient.
> 
> Hence, add support for such OPPs to the Energy Model, which creates for
> each OPP a performance state. The Energy Model can now be read using the
> regular table, which contains all performance states available, or using
> an efficient table, where inefficient performance states (and by
> extension, inefficient OPPs) have been removed.
> 
> Currently, the efficient table is used in two paths. Schedutil, and
> find_energy_efficient_cpu(). We have to modify both paths in the same
> patch so they stay synchronized. The thermal framework still relies on
> the original table and hence, DevFreq devices won't create the efficient
> table.
> 
> As used in the hot-path, the efficient table is a lookup table, generated
> dynamically when the perf domain is created. The complexity of searching
> a performance state is hence changed from O(n) to O(1). This also
> speeds-up em_cpu_energy() even if no inefficient OPPs have been found.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 

I know we have discussed it internally, but I thought it would be good 
to send it also to LKML. The concept of inefficient OPPs makes perfect
sense. It doesn't cause that the CPU would not run on some inefficient
OPP when thermal forces it. The lookup table which is now used, makes
also sense because if we have example configuration:
1prime + 2bigs + 4littles and they have separate freq domains,
there might be a use case when we call 7 times em_cpu_energy()
(in a single feec()) which does this O(nr_opps) search, while
we can have 7 times O(1) lookups.
In your some other email the results are showing improvements
(especially for big core) and no regression.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
