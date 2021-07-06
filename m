Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF23BC7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhGFIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:34:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3366 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhGFIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:34:15 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJwVY182vz6GCGS;
        Tue,  6 Jul 2021 16:20:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 10:31:36 +0200
Received: from [10.47.92.124] (10.47.92.124) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Jul 2021
 09:31:35 +0100
Subject: Re: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <kjain@linux.ibm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a35ea181-4beb-31d0-dd97-6d587b642a6e@huawei.com>
Date:   Tue, 6 Jul 2021 09:24:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.124]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2021 10:57, Joakim Zhang wrote:
> Add JSON metrics for i.MX8M platforms.
> 

Hi Joakim,

I have done some rework to the metricgroup sys event support.

If you have a chance, it would be appreciated if you could test this 
following series for these imx8 metrics+events:

https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.13-sys-rewrite-3

Thanks,
John

> ChangeLogs:
> V1->V2:
> 	* remove board level metrics (bandwidth metrics).
> V2->V3:
> 	* Add the missing "ScaleUnit".
> 
> Joakim Zhang (4):
>    perf vendor events: Fix indentation of brackets in imx8mm metrics
>    perf vendor events: Add JSON metrics for imx8mn DDR Perf
>    perf vendor events: Add JSON metrics for imx8mq DDR Perf
>    perf vendor events: Add JSON metrics for imx8mp DDR Perf

