Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D763916B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhEZLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234573AbhEZLwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:52:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D54C1516;
        Wed, 26 May 2021 04:50:49 -0700 (PDT)
Received: from [10.57.31.7] (unknown [10.57.31.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 675A13F73B;
        Wed, 26 May 2021 04:50:47 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
 <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
 <17d88121-4809-dc31-1b57-2134ec868c8b@arm.com>
 <fb80ceef-a2af-6f70-4863-fd376a438f3e@arm.com>
Message-ID: <4a3db514-bec5-394f-ec3f-15c23b44b8f6@arm.com>
Date:   Wed, 26 May 2021 12:50:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fb80ceef-a2af-6f70-4863-fd376a438f3e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 11:39 AM, Lukasz Luba wrote:
> 

[snip]

To summarize:
- we don't want to disable some OPPs
- we want to give a 'hint' from energy perspective
- we rely on SchedUtil 2nd stage which clamps this
freq hint value to allowed OPPs which might set
actually not the one what we see as 'efficient'
-- we don't harm some existing platform which might
    needs these 'inefficient' OPPs in some use cases
- we pay some extra cost in this SchedUtil freq
switch path, which shouldn't harm too much.
-- we pay this cost only for arm/arm64 platforms
    which use EM
-- this cost is balanced by the benefit that we see in
    benchmarks and measured energy
-- the LUT might limit the impact

I hope this would help to better understand the scope and
impact of this patch set.

Regards,
Lukasz
