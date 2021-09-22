Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0601E41414A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhIVFle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:41:34 -0400
Received: from foss.arm.com ([217.140.110.172]:43188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhIVFld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:41:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B341811B3;
        Tue, 21 Sep 2021 22:40:03 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7FC3F40C;
        Tue, 21 Sep 2021 22:39:59 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] coresight: trbe: Fix incorrect access of the
 sink specific data
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-2-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <93a52488-708a-828d-5c4e-38cd4ab42ebc@arm.com>
Date:   Wed, 22 Sep 2021 11:11:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-2-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> The TRBE driver wrongly treats the aux private data as the TRBE driver
> specific buffer for a given perf handle, while it is the ETM PMU's
> event specific data. Fix this by correcting the instance to use
> appropriate helper.
> 
> Fixes: 3fbf7f011f242 ("coresight: sink: Add TRBE driver")
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index d4c57aed05e5..e3d73751d568 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -363,7 +363,7 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
>  
>  static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>  {
> -	struct trbe_buf *buf = perf_get_aux(handle);
> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
>  	u64 limit = __trbe_normal_offset(handle);
>  	u64 head = PERF_IDX2OFF(handle->head, buf);
>  
> 
