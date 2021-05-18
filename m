Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A60387833
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348941AbhERL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:59:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3584 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbhERL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:59:43 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkvZx4X4vzsRnJ;
        Tue, 18 May 2021 19:55:37 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 19:58:22 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 19:58:21 +0800
Subject: Re: [RFC PATCH v3 6/9] hw/arm/virt-acpi-build: Use possible cpus in
 generation of MADT
To:     Salil Mehta <salil.mehta@huawei.com>
CC:     Peter Maydell <peter.maydell@linaro.org>,
        Andrew Jones <drjones@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>,
        "Alistair Francis" <alistair.francis@wdc.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
        yangyicong <yangyicong@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <20210516102900.28036-1-wangyanan55@huawei.com>
 <20210516102900.28036-7-wangyanan55@huawei.com>
 <6d3c643dc9174f8199ea9422f9e995e5@huawei.com>
 <14284387-dcf4-cfb2-127c-5d1e1d0ecb79@huawei.com>
 <82d006dab8b64e658f205246abc850c2@huawei.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <d99a32e6-99f7-6977-5f74-0d9f9a06b5ea@huawei.com>
Date:   Tue, 18 May 2021 19:58:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <82d006dab8b64e658f205246abc850c2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/18 14:47, Salil Mehta wrote:
>> From: wangyanan (Y)
>> Sent: Tuesday, May 18, 2021 6:03 AM
>>
>> Hi Salil,
>>
>> On 2021/5/18 1:07, Salil Mehta wrote:
>>>> From: Qemu-arm
>> [mailto:qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org]
>>>> On Behalf Of Yanan Wang
>>>> Sent: Sunday, May 16, 2021 11:29 AM
>>>> To: Peter Maydell <peter.maydell@linaro.org>; Andrew Jones
>>>> <drjones@redhat.com>; Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
>>>> <imammedo@redhat.com>; Shannon Zhao <shannon.zhaosl@gmail.com>; Alistair
>>>> Francis <alistair.francis@wdc.com>; David Gibson
>>>> <david@gibson.dropbear.id.au>; qemu-devel@nongnu.org; qemu-arm@nongnu.org
>>>> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; zhukeqian
>>>> <zhukeqian1@huawei.com>; yangyicong <yangyicong@huawei.com>; Zengtao (B)
>>>> <prime.zeng@hisilicon.com>; Wanghaibin (D) <wanghaibin.wang@huawei.com>;
>>>> yuzenghui <yuzenghui@huawei.com>; Paolo Bonzini <pbonzini@redhat.com>;
>>>> Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Subject: [RFC PATCH v3 6/9] hw/arm/virt-acpi-build: Use possible cpus in
>>>> generation of MADT
>>>>
>>>> When building ACPI tables regarding CPUs we should always build
>>>> them for the number of possible CPUs, not the number of present
>>>> CPUs. So we create gicc nodes in MADT for possible cpus and then
>>>> ensure only the present CPUs are marked ENABLED. Furthermore, it
>>>> also needed if we are going to support CPU hotplug in the future.
>>> Hi Yanan,
>>> Yes, these changes are part of the QEMU patch-set I floated last year.
>>>
>>> Link: https://www.mail-archive.com/qemu-devel@nongnu.org/msg712018.html
>> Yes, I noticed this. Thanks!
>>> Perhaps I am missing something, but how this patch is related to the vcpu
>>> topology support?
>> No related actually. But this patch together with patch 5 aim to provide
>> complete information (all cpus including enabled and the others) to guest,
>> which will be more consistent with requirement in ACPI spec.
>
> Well, if it is not related to the cpu topology support then this and other
> similar patches included with the same line of thought should not be
> part of this patch-set.
>
> I am already working with ARM folks in this regard.
Hi Salil,

I'm planning to pack this part into a separate patchset and may repost
it another time, given that there are still some issues to solve.

Thanks,
Yanan
> Thanks
>
>> We don't consider cpu hotplug at all in this patch, but it indeed pave way
>> for cpu hotplug in the future.
>>
>> Thanks,
>> Yanan
>>> Thanks
>>>
>>>> Co-developed-by: Andrew Jones <drjones@redhat.com>
>>>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>>>> Co-developed-by: Ying Fang <fangying1@huawei.com>
>>>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>>>> Co-developed-by: Yanan Wang <wangyanan55@huawei.com>
>>>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>>>> ---
>>>>    hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++----
>>>>    1 file changed, 25 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>> index a2d8e87616..4d64aeb865 100644
>>>> --- a/hw/arm/virt-acpi-build.c
>>>> +++ b/hw/arm/virt-acpi-build.c
>>>> @@ -481,6 +481,9 @@ build_madt(GArray *table_data, BIOSLinker *linker,
>>>> VirtMachineState *vms)
>>>>        const int *irqmap = vms->irqmap;
>>>>        AcpiMadtGenericDistributor *gicd;
>>>>        AcpiMadtGenericMsiFrame *gic_msi;
>>>> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
>>>> +    const CPUArchIdList *possible_cpus =
>>>> mc->possible_cpu_arch_ids(MACHINE(vms));
>>>> +    bool pmu;
>>>>        int i;
>>>>
>>>>        acpi_data_push(table_data, sizeof(AcpiMultipleApicTable));
>>>> @@ -491,11 +494,21 @@ build_madt(GArray *table_data, BIOSLinker *linker,
>>>> VirtMachineState *vms)
>>>>        gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
>>>>        gicd->version = vms->gic_version;
>>>>
>>>> -    for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
>>>> +    for (i = 0; i < possible_cpus->len; i++) {
>>>>            AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
>>>>                                                               sizeof(*gicc));
>>>>            ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
>>>>
>>>> +        /*
>>>> +         * PMU should have been either implemented for all CPUs or not,
>>>> +         * so we only get information from the first CPU, which could
>>>> +         * represent the others.
>>>> +         */
>>>> +        if (i == 0) {
>>>> +            pmu = arm_feature(&armcpu->env, ARM_FEATURE_PMU);
>>>> +        }
>>>> +        assert(!armcpu || arm_feature(&armcpu->env, ARM_FEATURE_PMU) ==
>> pmu);
>>>> +
>>>>            gicc->type = ACPI_APIC_GENERIC_CPU_INTERFACE;
>>>>            gicc->length = sizeof(*gicc);
>>>>            if (vms->gic_version == 2) {
>>>> @@ -504,11 +517,19 @@ build_madt(GArray *table_data, BIOSLinker *linker,
>>>> VirtMachineState *vms)
>>>>                gicc->gicv_base_address =
>>>> cpu_to_le64(memmap[VIRT_GIC_VCPU].base);
>>>>            }
>>>>            gicc->cpu_interface_number = cpu_to_le32(i);
>>>> -        gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
>>>> +        gicc->arm_mpidr = cpu_to_le64(possible_cpus->cpus[i].arch_id);
>>>>            gicc->uid = cpu_to_le32(i);
>>>> -        gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
>>>>
>>>> -        if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>>>> +        /*
>>>> +         * ACPI spec says that LAPIC entry for non present CPU may be
>>>> +         * omitted from MADT or it must be marked as disabled. Here we
>>>> +         * choose to also keep the disabled ones in MADT.
>>>> +         */
>>>> +        if (possible_cpus->cpus[i].cpu != NULL) {
>>>> +            gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
>>>> +        }
>>>> +
>>>> +        if (pmu) {
>>>>                gicc->performance_interrupt =
>> cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
>>>>            }
>>>>            if (vms->virt) {
>>>> --
>>>> 2.19.1
>>>>
>>> .
