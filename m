Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9A30A9A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBAOZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:25:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2464 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBAOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:24:58 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTqqM3D0Nz67jmg;
        Mon,  1 Feb 2021 22:20:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 15:24:14 +0100
Received: from [10.47.11.37] (10.47.11.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 14:24:10 +0000
Subject: Re: [PATCH v4 2/4] perf vendor events: Add L2I_TLB, SVE, SIMD, and FP
 events
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nakamura.shun@fujitsu.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-3-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fd65e539-d8cf-e1d0-103b-ad8154a42173@huawei.com>
Date:   Mon, 1 Feb 2021 14:22:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210201111310.3231469-3-nakamura.shun@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 11:13, Shunsuke Nakamura wrote:

I think that you will need to fix the subject, like:

perf vendor events arm64: Add more common and uarch events

> Add the following events.

It would be good to mention your reference document.

> 
> Common architectural events:
>    - L2I_TLB_REFILL
>    - L2I_TLB
>    - SIMD_INST_RETIRED
>    - SVE_INST_RETIRED
> 
> Common microarchitectural events:
>    - UOP_SPEC
>    - SVE_MATH_SPEC
>    - FP_SPEC
>    - FP_FMA_SPEC
>    - FP_RECPE_SPEC
>    - FP_CVT_SPEC
>    - ASE_SVE_INT_SPEC
>    - SVE_PRED_SPEC
>    - SVE_MOVPRFX_SPEC
>    - SVE_MOVPRFX_U_SPEC
>    - ASE_SVE_LD_SPEC
>    - ASE_SVE_ST_SPEC
>    - PRF_SPEC
>    - BASE_LD_REG_SPEC
>    - BASE_ST_REG_SPEC
>    - SVE_LDR_REG_SPEC
>    - SVE_STR_REG_SPEC
>    - SVE_LDR_PREG_SPEC
>    - SVE_STR_PREG_SPEC
>    - SVE_PRF_CONTIG_SPEC
>    - ASE_SVE_LD_MULTI_SPEC
>    - ASE_SVE_ST_MULTI_SPEC
>    - SVE_LD_GATHER_SPEC
>    - SVE_ST_SCATTER_SPEC
>    - SVE_PRF_GATHER_SPEC
>    - SVE_LDFF_SPEC
>    - FP_SCALE_OPS_SPEC
>    - FP_FIXED_OPS_SPEC
>    - FP_HP_SCALE_OPS_SPEC
>    - FP_HP_FIXED_OPS_SPEC
>    - FP_SP_SCALE_OPS_SPEC
>    - FP_SP_FIXED_OPS_SPEC
>    - FP_DP_SCALE_OPS_SPEC
>    - FP_DP_FIXED_OPS_SPEC
> 
> Signed-off-by: Shunsuke Nakamura<nakamura.shun@fujitsu.com>

Apart from those, above:

Reviewed-by: John Garry <john.garry@huawei.com>
