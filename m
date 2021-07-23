Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F03D3B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhGWNFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:05:15 -0400
Received: from foss.arm.com ([217.140.110.172]:46398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233486AbhGWNFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:05:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE3BD6E;
        Fri, 23 Jul 2021 06:45:47 -0700 (PDT)
Received: from [10.57.36.145] (unknown [10.57.36.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CFAC3F694;
        Fri, 23 Jul 2021 06:45:46 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] coresight: TRBE and Self-Hosted trace fixes
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <78d0f297-52b6-cd8d-1406-e646d5af2898@arm.com>
Date:   Fri, 23 Jul 2021 14:45:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2021 13:46, Suzuki K Poulose wrote:
> This series fixes the following issues with the TRBE and Self-Hosted
> trace for CoreSight.
> 
> The Self-hosted trace filter control registers are now save-restored
> across CPU PM event. And more importantly the Trace Filtering is now
> used to control per ETM session (rather than allowing the trace
> throughout the life time of the system). i.e, ETM configuration of
> the given run is used to enforce trace filtering (TRFCR) along with the
> Trace Exclusion controls in TRCVICTLR.
> 
> For the TRBE, we were using the TRUNCATED flag in the AUX buffer on
> every IRQ to indicate that we may have lost a few bytes of trace. But
> this causes the event to be disabled until the userspace re-enables
> it back, even when there is space left in the ring buffer. To make
> things worse, we were restarting the AUX handle, which would soon
> be disabled, potentially creating 0 sized records (without truncation),
> which the perf tool tends to ignore. This might cause the event to be
> disabled permanently. Also, sometimes we leave the buffer TRUNCATED,
> but delay the closing of the handle to event schedule out, which could
> cause significant black out in the trace capture. This was reported
> by Tamas Zsoldos.
> 
> This series removes the use of TRUNCATED flag for every IRQ. Instead,
> it is only used if we really run out of space in the buffer. And also
> we make sure the "handle" is closed immediately on TRUNCATED case,
> which triggers the userspace to take action. The core perf layer has
> been hardened to handle this case where a "handle" is closed out.
> Finally, we make sure that the CPU trace is prohibited, when the TRBE
> is left disabled. The ETE/ETM driver will program the Trace Filtering
> appropriately since we do this dynamically now with the first half
> of the series.
> 
> 

The series is also available here :

https://git.gitlab.arm.com/linux-arm/linux-skp.git 
coresight/trbe-self-hosted-fixes/v2

Suzuki
