Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D54222FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhJEKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:01:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3915 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhJEKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:00:47 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNtJ4076Zz67bS4;
        Tue,  5 Oct 2021 17:55:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 5 Oct 2021 11:58:55 +0200
Received: from [10.47.95.252] (10.47.95.252) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 10:58:54 +0100
Subject: Re: [PATCH 2/4] perf vendor events: Add new armv8 pmu events
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <20211004160008.21645-2-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2e02fb64-743c-c201-89e2-f5f9ceb7ff20@huawei.com>
Date:   Tue, 5 Oct 2021 11:01:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004160008.21645-2-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2021 17:00, Andrew Kilroy wrote:
> Add new armv8 common events for use by Arm Neoverse V1 cores in a later
> commit. These are defined in the ArmV8 architecture reference manual
> available from
> 
>    https://developer.arm.com/documentation/ddi0487/gb/?lang=e >
> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>
