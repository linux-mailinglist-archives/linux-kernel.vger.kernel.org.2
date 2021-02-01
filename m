Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D227330A9F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBAOhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:37:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2466 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhBAOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:36:12 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTr4H3stNz67jv1;
        Mon,  1 Feb 2021 22:31:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 15:35:26 +0100
Received: from [10.47.11.37] (10.47.11.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 14:35:25 +0000
Subject: Re: [PATCH v4 3/4] perf tools: Fix lexical definition of event name
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nakamura.shun@fujitsu.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-4-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b25fe15e-f27b-fdb1-41ce-9728ce78d52b@huawei.com>
Date:   Mon, 1 Feb 2021 14:33:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210201111310.3231469-4-nakamura.shun@jp.fujitsu.com>
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
> Fix the lexical definition of event name so that the numbers are recognizable.
> 
> A64FX defines an event name that starts with a number.
>   - 0inst_commit
>   - 1inst_commit
>   - 2inst_commit
>   - 3inst_commit
>   - 4inst_commit
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

eh... I'm not sure if you will encounter other problems, so may be 
prudent to change the event name to not start with a number. Someone 
else may also advise on this.

> ---
>   tools/perf/util/parse-events.l | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 9db5097..e6bbbd0 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -205,7 +205,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
>   num_dec		[0-9]+
>   num_hex		0x[a-fA-F0-9]+
>   num_raw_hex	[a-fA-F0-9]+
> -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
> +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]]*
>   name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
>   name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
>   drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
> 

