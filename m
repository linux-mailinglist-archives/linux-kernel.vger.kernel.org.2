Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806223F775B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbhHYO3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:29:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14321 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbhHYO3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:29:03 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GvpH32k6fz88qB;
        Wed, 25 Aug 2021 22:27:59 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:28:14 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 22:28:13 +0800
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
Message-ID: <7d08a5d8-7637-d109-cbfc-56e6449ae083@huawei.com>
Date:   Wed, 25 Aug 2021 22:28:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YSYiEgEcW1Ln3+9P@elver.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/25 18:57, Marco Elver wrote:
> I spoke too soon -- we export __kfence_pool, and that's good enough to
> fail the test fast if KFENCE was disabled at boot:
>
> 	https://lkml.kernel.org/r/20210825105533.1247922-1-elver@google.com

I haven't received the mail, don't know why.

Whatever,  I tested it, this patch is good and it save a lot of times,  
so feel free

to add my tested-by, thanks.


>
> will do the trick. So please drop your patch 4/4 here.
>
> Thanks,
> -- Marco
> .
>
