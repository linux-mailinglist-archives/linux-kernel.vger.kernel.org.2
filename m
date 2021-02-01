Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06CF30A9CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBAOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:31:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2465 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBAObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:31:15 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTqvZ1rsbz67gPV;
        Mon,  1 Feb 2021 22:24:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 15:30:33 +0100
Received: from [10.47.11.37] (10.47.11.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 14:30:32 +0000
Subject: Re: [PATCH v4 4/4] perf vendor events: Add Fujitsu A64FX V1.2 pmu
 event
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nakamura.shun@fujitsu.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-5-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <66d5411e-222a-224f-1099-f476e3dcf6df@huawei.com>
Date:   Mon, 1 Feb 2021 14:29:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210201111310.3231469-5-nakamura.shun@jp.fujitsu.com>
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

About the subject, include "arm64", like other commits in same arch path

about "V1.2", we use wildcard for matching MIDR, so will these JSONs 
really just patch V1.2?

> Add pmu events for A64FX.
> 
> Documentation source:
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_PMU_Events_v1.2.pdf
> 
> Signed-off-by: Shunsuke Nakamura<nakamura.shun@fujitsu.com>

nit: generally we put whitespace before "<"
