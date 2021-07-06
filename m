Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB23BC941
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGFKPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:15:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3368 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:15:48 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJypm3Dm1z6FBs2;
        Tue,  6 Jul 2021 18:05:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 12:13:08 +0200
Received: from [10.47.92.124] (10.47.92.124) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Jul 2021
 11:13:07 +0100
Subject: Re: [PATCH V3 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210127105734.12198-1-qiangqing.zhang@nxp.com>
 <a35ea181-4beb-31d0-dd97-6d587b642a6e@huawei.com>
 <DB8PR04MB67958A087F20D46867066B2CE61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7cd02103-66e8-b544-3483-8c6c2134067c@huawei.com>
Date:   Tue, 6 Jul 2021 11:05:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67958A087F20D46867066B2CE61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.124]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2021 10:48, Joakim Zhang wrote:
>> Hi Joakim,
>>
>> I have done some rework to the metricgroup sys event support.
>>
>> If you have a chance, it would be appreciated if you could test this following
>> series for these imx8 metrics+events:
>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.c
>> om%2Fhisilicon%2Fkernel-dev%2Fcommits%2Fprivate-topic-perf-5.13-sys-rewri
>> te-3&amp;data=04%7C01%7Cqiangqing.zhang%40nxp.com%7Cbf35517133c3
>> 48ebd58e08d940587875%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
>> %7C637611570992762798%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s
>> data=RzNaXZubTrhO0MRl2sD45v7Vbs1KgzRWCRymTQIJLZM%3D&amp;reser
>> ved=0
> Hi John,
> 
> I only need build perf tool with above code, no need to update the kernel, right?

Right, just userspace perf tool needs rebuild. Same kernel which you 
used before should be ok.

Thanks!
