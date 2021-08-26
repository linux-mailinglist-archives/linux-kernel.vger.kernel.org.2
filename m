Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97E3F8190
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 06:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhHZEWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 00:22:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9364 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbhHZEWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:22:19 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gw8gz44FJz8v71;
        Thu, 26 Aug 2021 12:17:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 12:21:29 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 12:21:28 +0800
Subject: Re: [PATCH] kfence: test: fail fast if disabled at boot
To:     Marco Elver <elver@google.com>, <akpm@linux-foundation.org>
CC:     <glider@google.com>, <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kasan-dev@googlegroups.com>
References: <20210825105533.1247922-1-elver@google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <9f1ba12f-1126-46a1-a1ed-4f47ed5a5ffa@huawei.com>
Date:   Thu, 26 Aug 2021 12:21:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210825105533.1247922-1-elver@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/25 18:55, Marco Elver wrote:
> Fail kfence_test fast if KFENCE was disabled at boot, instead of each
> test case trying several seconds to allocate from KFENCE and failing.
> KUnit will fail all test cases if kunit_suite::init returns an error.
>
> Even if KFENCE was disabled, we still want the test to fail, so that CI
> systems that parse KUnit output will alert on KFENCE being disabled
> (accidentally or otherwise).
>
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Marco Elver <elver@google.com>

Finally find this, it's better, and tested, thanks

