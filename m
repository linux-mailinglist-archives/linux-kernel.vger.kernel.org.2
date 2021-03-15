Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4533AF26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCOJpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:45:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2693 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCOJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:45:15 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DzWXN3sNhz680KG;
        Mon, 15 Mar 2021 17:36:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 15 Mar 2021 10:45:10 +0100
Received: from [10.210.166.140] (10.210.166.140) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 15 Mar 2021 09:45:09 +0000
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>
CC:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Will Deacon" <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
 <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
 <CACT4Y+aTbdE1CeUOgCKLJ3XpjazN5=yTmToXN_03M9EQ_hhayg@mail.gmail.com>
 <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <48347b4d-9194-16f2-95a0-c3eb55ca9a80@huawei.com>
Date:   Mon, 15 Mar 2021 09:43:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.140]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2021 10:52, Arnd Bergmann wrote:
> On Fri, Mar 12, 2021 at 11:38 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Fri, Mar 12, 2021 at 11:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> It does not happen too often on syzbot so far, so let's try to do the
>> right thing first.
>> I've filed: https://bugs.launchpad.net/qemu/+bug/1918917
>> with a link to this thread. To be fair, I don't fully understand what
>> I am talking about, I hope I proxied your description properly.
> 
> Thanks, looks good. I provided a little more detail in a comment there.
> 
>          Arnd
> .
> 

 From looking at the bug report, my impression is that this is a qemu 
issue, as the logical IO space is mapped to the PCI host bridge IO 
space, and qemu does not handle accesses to that CPU addressable region 
at all. As Arnd said.

However, we really should not be accessing logical IO ports 0 or 0x2f8 
at all via ttyS3 if not enumerated from PCI device at that logical IO 
port. That is what I think anyway, as who knows what device - if any - 
really exists at that location. That is why I had this patch to just 
stop accesses to legacy IO port regions on arm64:

https://lore.kernel.org/lkml/1610729929-188490-2-git-send-email-john.garry@huawei.com/

Thanks,
John
