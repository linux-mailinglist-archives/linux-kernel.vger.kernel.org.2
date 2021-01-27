Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC5305E09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhA0ORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:17:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2438 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhA0OQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:16:17 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DQlrQ63v1z67fqb;
        Wed, 27 Jan 2021 22:11:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 15:15:27 +0100
Received: from [10.47.4.0] (10.47.4.0) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 27 Jan
 2021 14:15:25 +0000
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
Message-ID: <83775741-8b38-0182-38af-71c60cee1292@huawei.com>
Date:   Wed, 27 Jan 2021 14:14:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.0]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2021 10:57, Joakim Zhang wrote:
> Add JSON metrics for i.MX8M platforms.
> 
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

For the series:
Reviewed-by: John Garry <john.garry@huawei.com>
