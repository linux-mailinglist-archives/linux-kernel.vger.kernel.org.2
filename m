Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E766E39131F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhEZI6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:58:16 -0400
Received: from foss.arm.com ([217.140.110.172]:41830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhEZI6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B9B41516;
        Wed, 26 May 2021 01:56:44 -0700 (PDT)
Received: from [10.57.31.7] (unknown [10.57.31.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D37643F73D;
        Wed, 26 May 2021 01:56:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <068fa9c4-2b55-3d75-adc7-cf5ef2174b12@arm.com>
Date:   Wed, 26 May 2021 09:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 5/26/21 4:47 AM, Viresh Kumar wrote:

[snip]

> 
> First of all, sorry about not replying earlier. I have seen this earlier and was
> shying away to receive some feedback from Rafael/Peter instead :(
> 
> I think the problem you mention is genuine, I have realized it in the past,
> discussed with Vincent Guittot (cc'd) but never was able to get to a proper
> solution as the EM model wasn't there then.
> 
> I have seen your approach (from top level) and I feel maybe we can improve upon
> the whole idea a bit, lemme know what you think. The problem I see with this
> approach is the unnecessary updates to schedutil that this series makes, which
> IMHO is the wrong thing to do. Schedutil isn't the only governor and such
> changes will end up making the performance delta between ondemand and schedutil
> even more (difference based on their core design philosophy is fine, but these
> are improvements which each of them should enjoy). And if another governor wants
> these smart decisions to be added there, then it is trouble again.
> 
> Since the whole thing depends on EM and OPPs, I think we can actually do this.
> 
> When the cpufreq driver registers with the EM core, lets find all the
> Inefficient OPPs and disable them once and for all. Of course, this must be done
> on voluntarily basis, a flag from the drivers will do. With this, we won't be
> required to update any thing at any of the governors end.
> 
> Will that work ?
> 

No, these OPPs have to stay because they are used in thermal for cooling
states. DT cooling devices might have them set as a scope of possible
states. We don't want to break existing platforms, don't we?
We want to 'avoid' those OPPs when possible (no thermal pressure), but
we might have to use them sometimes.

Regards,
Lukasz
