Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784CC38E6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhEXMpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:45:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhEXMpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:45:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C673D113E;
        Mon, 24 May 2021 05:44:17 -0700 (PDT)
Received: from [10.57.31.86] (unknown [10.57.31.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47DA3F719;
        Mon, 24 May 2021 05:44:15 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] PM / EM: Extend em_perf_domain with a flag field
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-3-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <23dc27e4-9e16-9887-6dc6-3c1e1c1edc5d@arm.com>
Date:   Mon, 24 May 2021 13:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1621616064-340235-3-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 5:54 PM, Vincent Donnefort wrote:
> Merge the current "milliwatts" option into a "flag" field. This intends to
> prepare the extension of this structure for inefficient states support in
> the Energy Model.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 757fc60..9be7bde 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
