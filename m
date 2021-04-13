Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262335DB94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhDMJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:48:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2840 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbhDMJss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:48:48 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FKLG15VZBz688MD;
        Tue, 13 Apr 2021 17:41:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 11:48:25 +0200
Received: from [10.47.4.3] (10.47.4.3) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 10:48:17 +0100
From:   John Garry <john.garry@huawei.com>
Subject: perf arm64 --topdown support (was "perf arm64 metricgroup support")
To:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <linuxarm@huawei.com>, <kjain@linux.ibm.com>,
        <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <pc@us.ibm.com>,
        <huanglingyan2@huawei.com>
References: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
 <YG7xzXjFzIr9lQlz@krava>
Message-ID: <8b3e6667-ac48-9ca9-6645-b2eebbc828aa@huawei.com>
Date:   Tue, 13 Apr 2021 10:45:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YG7xzXjFzIr9lQlz@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.3]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2021 13:06, Jiri Olsa wrote:
> perf stat --topdown is not supported, as this requires the CPU PMU to
> expose (alias) events for the TopDown L1 metrics from sysfs, which arm
> does not do. To get that to work, we probably need to make perf use the
> pmu-events cpumap to learn about those alias events.

Hi guys,

About supporting --topdown command for other archs apart from x86, it 
seems not possible today. Support there is based on kernel support for 
"topdown" CPU events used in the metric calculations. However, arm64, 
for example, does not support these "topdown" events.

It seems to me that we can change to use pmu-events framework + 
metricgroup support here, rather than hardcoded events - has anyone 
considered this approach previously? Seems a pretty big job, so thought 
I'd ask first ...

Thanks,
John
