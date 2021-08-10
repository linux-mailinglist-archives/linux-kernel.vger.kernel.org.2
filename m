Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE6F3E5DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhHJOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:25:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3622 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242414AbhHJOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:24:09 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GkZtT07Nmz6BD6W;
        Tue, 10 Aug 2021 22:23:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 10 Aug 2021 16:23:42 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 15:23:42 +0100
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
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
 <88294bb8-6fb1-b485-446c-4ec15ff28d4a@huawei.com>
 <YRKGo1AtfBn85sZ7@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <40e85ad2-3db4-aecf-d972-7d4aa5c2278c@huawei.com>
Date:   Tue, 10 Aug 2021 15:23:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YRKGo1AtfBn85sZ7@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2021 15:01, Arnaldo Carvalho de Melo wrote:
>> Shall I send this as a formal patch?
> The question is when should I apply this patch? After this series? After
> the patch I commented about, before?
> 

Hi Arnaldo,

I think that you can apply it before the series. This is a pre-existing 
issue that there was no dependency checking on the test events folder 
for rebuilding pmu-event.c .

Thanks

