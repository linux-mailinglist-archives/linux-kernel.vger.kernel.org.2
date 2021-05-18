Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88952387FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbhERSwL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 May 2021 14:52:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3023 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhERSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:52:10 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fl4lQ11xnzmWcC;
        Wed, 19 May 2021 02:48:34 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 02:50:49 +0800
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 02:50:48 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.2176.012;
 Tue, 18 May 2021 19:50:46 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Andrew Jones <drjones@redhat.com>
CC:     "wangyanan (Y)" <wangyanan55@huawei.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Igor Mammedov" <imammedo@redhat.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
        yangyicong <yangyicong@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu
 members
Thread-Topic: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu
 members
Thread-Index: AQHXSj7Bs+01wvGUNEWbtmBiG2lmC6rn8VxQgACpzgCAADVmEP///x2AgADF7hA=
Date:   Tue, 18 May 2021 18:50:46 +0000
Message-ID: <0ff033fa8eac400fade06e6be0a98847@huawei.com>
References: <20210516102900.28036-1-wangyanan55@huawei.com>
 <20210516102900.28036-5-wangyanan55@huawei.com>
 <6c8f9c3502384f648f30c7381e87dda9@huawei.com>
 <68883a1b-5303-da13-a051-e909e1d1f71b@huawei.com>
 <6d8b9142e8a34d1390f2f0b4bfb53a00@huawei.com>
 <20210518075027.wjpdjvoam7dlzign@gator.home>
In-Reply-To: <20210518075027.wjpdjvoam7dlzign@gator.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.29.209]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, May 18, 2021 8:50 AM
> 
> On Tue, May 18, 2021 at 07:04:51AM +0000, Salil Mehta wrote:
> > > From: wangyanan (Y)
> > > Sent: Tuesday, May 18, 2021 5:43 AM
> > >
> > > Hi Salil,
> > >
> > > On 2021/5/18 4:48, Salil Mehta wrote:
> > > >> From: Qemu-arm
> > > [mailto:qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org]
> > > >> On Behalf Of Yanan Wang
> > > >> Sent: Sunday, May 16, 2021 11:29 AM
> > > >> To: Peter Maydell <peter.maydell@linaro.org>; Andrew Jones
> > > >> <drjones@redhat.com>; Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> > > >> <imammedo@redhat.com>; Shannon Zhao <shannon.zhaosl@gmail.com>; Alistair
> > > >> Francis <alistair.francis@wdc.com>; David Gibson
> > > >> <david@gibson.dropbear.id.au>; qemu-devel@nongnu.org;
> qemu-arm@nongnu.org
> > > >> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; zhukeqian
> > > >> <zhukeqian1@huawei.com>; yangyicong <yangyicong@huawei.com>; Zengtao (B)
> > > >> <prime.zeng@hisilicon.com>; Wanghaibin (D)
> <wanghaibin.wang@huawei.com>;
> > > >> yuzenghui <yuzenghui@huawei.com>; Paolo Bonzini <pbonzini@redhat.com>;
> > > >> Philippe Mathieu-Daudé <philmd@redhat.com>
> > > >> Subject: [RFC PATCH v3 4/9] hw/arm/virt: Initialize the present cpu members
> > > >>
> > > >> We create and initialize a cpuobj for each present cpu in
> > > >> machvirt_init(). Now we also initialize the cpu member of
> > > >> structure CPUArchId for each present cpu in the function.
> > > > [...]
> > > >
> > > >>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
> > > >> +
> > > >> +        /*
> > > >> +         * As ARM cpu hotplug is not supported yet, we initialize
> > > >> +         * the present cpu members here.
> > > >> +         */
> > > >> +        machine->possible_cpus->cpus[n].cpu = cpuobj;
> > > >
> > > > when vcpu Hotplug is not supported yet, what necessitates this change now?
> > > >
> > > The initialization will gives a way to determine whether a CPU is
> > > present or not.
> > > At least, for now it will be used when generating ACPI tables, e.g.
> > > DSDT, MADT.
> > > See patch 5 and 6.
> >
> > yes,  but why do you require it now as part of the vcpu topology change?
> >
> > As-far-as-i-can-see, PPTT table changes(part of patch 5/9) do not require
> > this change. Change in Patch 5/9 has also been done in anticipation of
> > some future requirement(vcpu Hotplug?).
> >
> > Please correct me here if I am wrong?
> >
> 
> Hi Salil,
> 
> The problem is that we've never required smp.cpus == smp.maxcpus, so
> a user could have smp.cpus < smp.maxcpus. We want the topology to match
> maxcpus, but only enable cpus. However, if you think we should just not
> allow cpus < maxcpus until hot plug is sorted out, then we could discuss
> a way of trying to enforce cpus == maxcpus, but I'm not sure how we can
> without breaking existing command lines.


Hi Andrew,
Ideally, if the vcpu Hotplug is not supported the check in the smp_parse()
should impose (cpus == maxcpus). This as of now is just a warning of invalid
configuration I think. Beside this does not breaks any prior usages which you
suggested might happen?

Again, this is not a blocking issue from my side but just a humble suggestion.
You might want to take a call on this :)


Thanks
Salil.
