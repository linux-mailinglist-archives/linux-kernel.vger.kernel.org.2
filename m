Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9F3F76F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbhHYOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:16:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14320 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:16:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gvp0Y4cY3z7tFX;
        Wed, 25 Aug 2021 22:15:25 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:15:40 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:15:40 +0800
Subject: Re: [PATCH 0/4] ARM: Support KFENCE feature
To:     Marco Elver <elver@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <CANpmjNMnU5P9xsDhgeBKQR7Tg-3cHPkMNx7906yYwEAj85sNWg@mail.gmail.com>
 <YSYiEgEcW1Ln3+9P@elver.google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <f0cb0ebd-2b4e-7a65-8107-f7e1f23d310f@huawei.com>
Date:   Wed, 25 Aug 2021 22:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YSYiEgEcW1Ln3+9P@elver.google.com>
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


On 2021/8/25 18:57, Marco Elver wrote:
> On Wed, Aug 25, 2021 at 12:14PM +0200, Marco Elver wrote:
>> On Wed, 25 Aug 2021 at 11:17, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>> The patch 1~3 is to support KFENCE feature on ARM.
>>>
>>> NOTE:
>>> The context of patch2/3 changes in arch/arm/mm/fault.c is based on link[1],
>>> which make some refactor and cleanup about page fault.
>>>
>>> kfence_test is not useful when kfence is not enabled, skip kfence test
>>> when kfence not enabled in patch4.
>>>
>>> I tested the kfence_test on ARM QEMU with or without ARM_LPAE and all passed.
>> Thank you for enabling KFENCE on ARM -- I'll leave arch-code review to
>> an ARM maintainer.
>>
>> However, as said on the patch, please drop the change to the
>> kfence_test and associated changes. This is working as intended; while
>> you claim that it takes a long time to run when disabled, when running
>> manually you just should not run it when disabled. There are CI
>> systems that rely on the KUnit test output and the fact that the
>> various test cases say "not ok" etc. Changing that would mean such CI
>> systems would no longer fail if KFENCE was accidentally disabled (once
>> KFENCE is enabled on various CI, which we'd like to do at some point).
>> There are ways to fail the test faster, but they all complicate the
>> test for no good reason. (And the addition of a new exported function
>> that is essentially useless.)
> I spoke too soon -- we export __kfence_pool, and that's good enough to
> fail the test fast if KFENCE was disabled at boot:
>
> 	https://lkml.kernel.org/r/20210825105533.1247922-1-elver@google.com
>
> will do the trick. So please drop your patch 4/4 here.
Sure , please ignore it.
>
> Thanks,
> -- Marco
> .
>
