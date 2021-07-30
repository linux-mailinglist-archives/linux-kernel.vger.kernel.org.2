Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF03DB6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhG3KFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:05:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238323AbhG3KFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:05:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EB931FB;
        Fri, 30 Jul 2021 03:05:06 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ABF63F73D;
        Fri, 30 Jul 2021 03:05:02 -0700 (PDT)
Subject: Re: [PATCH 03/10] coresight: trbe: Add a helper to pad a given buffer
 area
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-4-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <576279c5-9f7a-7af1-e5c7-776816e5b378@arm.com>
Date:   Fri, 30 Jul 2021 15:35:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728135217.591173-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
> Refactor the helper to pad a given AUX buffer area to allow
> "filling" ignore packets, without moving any handle pointers.
> This will be useful in working around errata, where we may
> have to fill the buffer after a session.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index a0168ad204b3..0af644331b99 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -228,12 +228,18 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
>   * consumed from the user space. The enabled TRBE buffer area is a moving subset of
>   * the allocated perf auxiliary buffer.
>   */
> +
> +static void __trbe_pad_buf(struct trbe_buf *buf, u64 offset, int len)
> +{
> +	memset((void *)buf->trbe_base + offset, ETE_IGNORE_PACKET, len);
> +}
> +
>  static void trbe_pad_buf(struct perf_output_handle *handle, int len)
>  {
>  	struct trbe_buf *buf = etm_perf_sink_config(handle);
>  	u64 head = PERF_IDX2OFF(handle->head, buf);
>  
> -	memset((void *)buf->trbe_base + head, ETE_IGNORE_PACKET, len);
> +	__trbe_pad_buf(buf, head, len);
>  	if (!buf->snapshot)
>  		perf_aux_output_skip(handle, len);
>  }
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
