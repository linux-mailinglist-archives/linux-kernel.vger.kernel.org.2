Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635B31E8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhBRKpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:45:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2582 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhBRJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:28:53 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dh8Md3t2Sz67q3h;
        Thu, 18 Feb 2021 17:21:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 10:28:01 +0100
Received: from [10.210.168.96] (10.210.168.96) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 09:27:59 +0000
Subject: Re: [PATCH v5] perf tools: Fix arm64 build error with gcc-11
To:     Jianlin Lv <Jianlin.Lv@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <ravi.bangoria@linux.ibm.com>,
        <anju@linux.vnet.ibm.com>
CC:     <iecedge@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20210218031245.2078492-1-Jianlin.Lv@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bd474bfa-2bdb-53ea-5142-3a6570d63b7f@huawei.com>
Date:   Thu, 18 Feb 2021 09:26:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210218031245.2078492-1-Jianlin.Lv@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.168.96]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2021 03:12, Jianlin Lv wrote:
> gcc version: 11.0.0 20210208 (experimental) (GCC)
> 
> Following build error on arm64:
> 
> .......
> In function ‘printf’,
>      inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
>      inlined from ‘regs__printf’ at util/session.c:1169:2:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
>    error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> 
> 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
>                  __va_arg_pack ());
> 
> ......
> In function ‘fprintf’,
>    inlined from ‘perf_sample__fprintf_regs.isra’ at \
>      builtin-script.c:622:14:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
>      error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
>    100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>    101 |                         __va_arg_pack ());
> 
> cc1: all warnings being treated as errors
> .......
> 
> This patch fixes Wformat-overflow warnings. Add helper function to
> convert NULL to "unknown".
> 
> Signed-off-by: Jianlin Lv<Jianlin.Lv@arm.com>

thanks
Reviewed-by: John Garry <john.garry@huawei.com>
