Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38E3BD70D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbhGFMvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:51:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3369 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbhGFMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:51:36 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GK2GW3z2Lz6J695;
        Tue,  6 Jul 2021 20:40:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 14:48:56 +0200
Received: from [10.47.92.124] (10.47.92.124) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Jul 2021
 13:48:55 +0100
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
 <7cd02103-66e8-b544-3483-8c6c2134067c@huawei.com>
 <DB8PR04MB67958BF70501FB79BFC6F786E61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6e2fab9a-ba7b-98b6-69c1-cc19e8c32ea4@huawei.com>
Date:   Tue, 6 Jul 2021 13:41:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67958BF70501FB79BFC6F786E61B9@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.124]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2021 13:28, Joakim Zhang wrote:
>> right?
>>
>> Right, just userspace perf tool needs rebuild. Same kernel which you used
>> before should be ok.
> Hi John,
> 
> Test env:
> perf version 5.13.rc7.gf9a8701c7091
> 5.13.0-rc1-next-20210514
> 
> I tested on i.MX8MQ, i.MX8MM and i.MX8MP, there is no function breakage, but I have not verified metric includes "duration_time" event.
> 

ok, I appreciate that.

 > but I have not verified metric includes "duration_time" event.

I didn't think that any imx8 metrics included duration_time. Anyway, 
I'll ensure that metrics which contain "duration_time" would not break.

> A nitpick, there is no comma at the end of "Unit".

I'll check it.

Thanks a lot,
John

