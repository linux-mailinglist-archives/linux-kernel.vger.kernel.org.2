Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686EF38E6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhEXMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:42:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbhEXMmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:42:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A76D7113E;
        Mon, 24 May 2021 05:41:10 -0700 (PDT)
Received: from [10.57.31.86] (unknown [10.57.31.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8363F719;
        Mon, 24 May 2021 05:41:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] PM / EM: Fix inefficient state detection
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-2-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7c6806f5-3546-080b-c0b8-de5b9602aff7@arm.com>
Date:   Mon, 24 May 2021 13:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1621616064-340235-2-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 5:54 PM, Vincent Donnefort wrote:
> Currently, a debug message is printed if an inefficient state is detected
> in the Energy Model. Unfortunately, it won't detect if the first state is
> inefficient or if two successive states are. Fix this behavior.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 0c620eb..c4871a8 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
