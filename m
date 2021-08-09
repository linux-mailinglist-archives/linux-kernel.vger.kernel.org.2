Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3A3E4919
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhHIPrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:47:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3618 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHIPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:46:59 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gk0mZ0YBHz6C9Gl;
        Mon,  9 Aug 2021 23:46:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 9 Aug 2021 17:46:36 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 9 Aug 2021
 16:46:35 +0100
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
From:   John Garry <john.garry@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <yao.jin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <irogers@google.com>, <linuxarm@huawei.com>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
 <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
Message-ID: <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
Date:   Mon, 9 Aug 2021 16:46:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 09:19, John Garry wrote:
> So I think we need something like this:
> 
> ----->8--------
> 
>  From a08df563665e9ec088b1af86ceed058497e112a4 Mon Sep 17 00:00:00 2001
> From: John Garry <john.garry@huawei.com>
> Date: Tue, 3 Aug 2021 08:44:09 +0100
> Subject: [PATCH] perf jevents: Make build dependency on test JSONs
> 
> Currently all JSONs and the mapfile for an arch are dependencies for
> building pmu-events.c
> 
> The test JSONs are missing as a dependency, so add them.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 215ba30b8534..a055dee6a46a 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -6,10 +6,13 @@ pmu-events-y    += pmu-events.o
>   JDIR        =  pmu-events/arch/$(SRCARCH)
>   JSON        =  $(shell [ -d $(JDIR) ] &&                \
>               find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
> +JDIR_TEST    =  pmu-events/arch/test
> +JSON_TEST    =  $(shell [ -d $(JDIR_TEST) ] &&            \
> +            find $(JDIR_TEST) -name '*.json')
> 
>   #
>   # Locate/process JSON files in pmu-events/arch/
>   # directory and create tables in pmu-events.c.
>   #
> -$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
> +$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
>       $(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch 
> $(OUTPUT)pmu-events/pmu-events.c $(V)
> 
> 
> -----8<-----

Hi Arnaldo,

Shall I send this as a formal patch?

Thanks!
