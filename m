Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA23D2216
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGVJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:48:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3448 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhGVJr5 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:47:57 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVpK53J9hz6H7l7;
        Thu, 22 Jul 2021 18:16:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 12:28:30 +0200
Received: from [10.47.26.161] (10.47.26.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 11:28:29 +0100
Subject: Re: [PATCH v1] perf pmu: Add PMU alias support
To:     Jin Yao <yao.jin@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <Linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <ak@linux.intel.com>, <kan.liang@intel.com>, <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210722014546.11948-1-yao.jin@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ef8cc210-1a0a-796c-effa-63af590d17aa@huawei.com>
Date:   Thu, 22 Jul 2021 11:28:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210722014546.11948-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.161]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2021 02:45, Jin Yao wrote:
> From: Kan Liang<kan.liang@linux.intel.com>
> 
> A perf uncore PMU may have two PMU names, a real name and an alias. The
> alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
> The perf tool should support the alias as well.
> 
> Add alias_name in the struct perf_pmu to store the alias. For the PMU
> which doesn't have an alias. It's NULL.
> 
> Introduce two X86 specific functions to retrieve the real name and the
> alias separately.
> 
> Only go through the sysfs to retrieve the mapping between the real name
> and the alias once. The result is cached in a list, uncore_pmu_list.
> 
> Nothing changed for the other ARCHs.
> 
> With the patch, the perf tool can monitor the PMU with either the real
> name or the alias.
> 
> Use the real name,
>   $ perf stat -e uncore_cha_2/event=1/ -x,
>     4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
> 
> Use the alias,
>   $ perf stat -e uncore_type_0_2/event=1/ -x,
>     3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,

Having a self-test case would be nice. And it's questionable why this 
goes in x86 code.

Thanks,
John
