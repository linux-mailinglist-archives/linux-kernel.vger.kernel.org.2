Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C193CC0BF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 04:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhGQCnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 22:43:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7022 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhGQCnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 22:43:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GRXJQ6H1gzYcrx;
        Sat, 17 Jul 2021 10:35:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 10:40:44 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 10:40:43 +0800
Subject: Re: [PATCH -next 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
To:     Marco Elver <elver@google.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, Daniel Axtens <dja@axtens.net>
References: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
 <20210705111453.164230-4-wangkefeng.wang@huawei.com>
 <YOMfcE7V7lSE3N/z@elver.google.com>
 <089f5187-9a4d-72dc-1767-8130434bfb3a@huawei.com>
 <5f760f6c-dcbd-b28a-2116-a2fb233fc534@huawei.com>
 <CANpmjNP8Js3nKeVfwPqV7oQaBbGebKxFYRWe8TifTduP2q86xA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <a0431275-2ca1-0d5e-72e2-9ec6b256cbf1@huawei.com>
Date:   Sat, 17 Jul 2021 10:40:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNP8Js3nKeVfwPqV7oQaBbGebKxFYRWe8TifTduP2q86xA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/16 15:41, Marco Elver wrote:
> On Fri, 16 Jul 2021 at 07:06, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Hi Marco and Dmitry, any comments about the following replay, thanks.
> Can you clarify the question? I've been waiting for v2.
>
> I think you said that this will remain arm64 specific and the existing
> generic kasan_populate_early_shadow() doesn't work.

Yes, I can't find a generic way to solve the issue, if there is no 
better way, I

will send a new version(fix the build error and the wrong __weak comment)

>
> If there's nothing else that needs resolving, please go ahead and send
> v2 (the __weak comment still needs resolving).
Thanks. will do.
>
> Thanks,
> -- Marco
> .
>
