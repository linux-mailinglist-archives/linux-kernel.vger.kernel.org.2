Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD230EF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhBDJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:18:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12074 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhBDJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:18:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWXwJ00V6zMVS6;
        Thu,  4 Feb 2021 17:15:59 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 17:17:35 +0800
Subject: Re: [PATCH -next] RISCV: Add some depends for NUMA
To:     Atish Patra <atishp@atishpatra.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20210203142343.59781-1-wangkefeng.wang@huawei.com>
 <CAOnJCULd0=FoQjorjmz6EVB7_YphjGBwUCuY+ntOP6JiUb4P6w@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <80f2821a-1c08-ce16-b7a9-7d2debc7f16e@huawei.com>
Date:   Thu, 4 Feb 2021 17:17:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCULd0=FoQjorjmz6EVB7_YphjGBwUCuY+ntOP6JiUb4P6w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/4 3:59, Atish Patra wrote:
> On Wed, Feb 3, 2021 at 6:20 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> The numa feature is useless for riscv32 platform(MAXPHYSMEM_1GB if 32bit),
>> and it should depends on SMP feature, this also fix the build error,
>>
>>    riscv64-buildroot-linux-gnu-ld: mm/page_alloc.o: in function `.L0 ':
>>    page_alloc.c:(.text+0x4808): undefined reference to `node_reclaim_distance'
>>
> Thanks for the fix. The commit text is a bit ambiguous. The
> compilation issue error is due to SMP.
> RV32 dependency is just another fix  as NUMA is not very useful for RV32.

Yes, the two depends fix different issue，the lack of SMP leads to the 
compilation issue,  another

depend is to remove support on RV32.

Thanks for your review, if necessary, I could resend with changelog 
updated.

> Reviewed-by: Atish Patra <atish.patra@wdc.com>
