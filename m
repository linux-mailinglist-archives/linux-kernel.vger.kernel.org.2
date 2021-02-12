Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA89319C27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBLJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:54:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2556 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBLJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:54:24 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DcTGK5d6xz67lQJ;
        Fri, 12 Feb 2021 17:48:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Feb 2021 10:53:41 +0100
Received: from [10.47.10.68] (10.47.10.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Feb
 2021 09:53:40 +0000
Subject: Re: [PATCH v6 3/3] perf vendor events arm64: Add Fujitsu A64FX pmu
 event
To:     Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210212090318.1522292-1-nakamura.shun@jp.fujitsu.com>
 <20210212090318.1522292-4-nakamura.shun@jp.fujitsu.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f580a590-924d-ea44-f06f-f402df3582e1@huawei.com>
Date:   Fri, 12 Feb 2021 09:52:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210212090318.1522292-4-nakamura.shun@jp.fujitsu.com>
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
> Add pmu events for A64FX.
> 
> Documentation source:
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_PMU_Events_v1.2.pdf
> 
> Signed-off-by: Shunsuke Nakamura<nakamura.shun@fujitsu.com>

Reviewed-by: John Garry <john.garry@huawei.com>
