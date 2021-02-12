Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9FB319C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBLJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:55:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2557 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBLJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:55:46 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DcTHx69NQz67lYN;
        Fri, 12 Feb 2021 17:50:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 10:55:05 +0100
Received: from [10.47.10.68] (10.47.10.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 09:55:04 +0000
Subject: Re: [PATCH v6 2/3] perf tools: Add lexical definition of event name
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
 <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1e786f11-708f-85db-e965-a6ade5781b32@huawei.com>
Date:   Fri, 12 Feb 2021 09:53:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210212090318.1522292-3-nakamura.shun@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.68]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2021 09:03, Shunsuke Nakamura wrote:
> Add the lexical definition of event name so that the numbers are recognizable.
> 
> A64FX defines an event name that starts with a number.
>   - 0inst_commit
>   - 1inst_commit
>   - 2inst_commit
>   - 3inst_commit
>   - 4inst_commit
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---

FWIW,

Acked-by: John Garry <john.garry@huawei.com>

I would prefer if more knowledgeable perf reviewers also checked this...

>   tools/perf/util/parse-events.l | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 0b36285a9435..33f627187415 100644
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

