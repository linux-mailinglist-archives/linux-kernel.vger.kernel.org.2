Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A543344BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhCVQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:37:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2727 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhCVQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:36:50 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F40NH1yb1z681SV;
        Tue, 23 Mar 2021 00:30:23 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 17:36:48 +0100
Received: from [10.210.167.192] (10.210.167.192) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 16:36:46 +0000
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>,
        Peter Maydell <peter.maydell@linaro.org>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
 <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com>
 <CAFEAcA-oH=9RLdzhsLcSTxNLBLcyEcJtO4L5EqRSiGWHdApgqA@mail.gmail.com>
 <CAK8P3a2aQ0C7M2p3DBwjvK5mGyg2_8PQK2=FnkPFp3bVmt_xMw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <771d89a8-b7e0-6095-b101-e7ae91bcdc85@huawei.com>
Date:   Mon, 22 Mar 2021 16:34:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2aQ0C7M2p3DBwjvK5mGyg2_8PQK2=FnkPFp3bVmt_xMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.192]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> There's apparently a bit in the PCI spec that reads:
>>          The host bus bridge, in PC compatible systems, must return all
>>          1's on a read transaction and discard data on a write transaction
>>          when terminated with Master-Abort.
>>
>> which obviously applies only to "PC compatible systems".
> 
> Right. As far as I can tell, all ARMv8 and most ARMv7 based SoCs
> do this to be more compatible with PC style operating systems like
> Linux, but you are right that the specification here does not
> mandate that, and the older ARMv5 SoCs seem to be compliant
> as well based on this.
> 
>>> Linux has a driver for DPC, which apparently configures it to
>>> cause an interrupt to log the event, but it does not hook up the
>>> CPU exception handler to this. I don't see an implementation of DPC
>>> in qemu, which I take as an indication that it should use the
>>> default behavior and cause neither an interrupt nor a CPU exception.
>>
>> Hmm, maybe. We should probably also implement -1/discard just because
>> we're not intending to have 'surprising' behaviour.
>>
>> TBH I'm having difficulty seeing why the kernel should be doing
>> this at all, though. The device tree tells you you have a PCI
>> controller; PCI supports enumeration of devices; you know exactly
>> where everything is mapped because the BARs tell you that.
>> I don't see anything that justifies the kernel in randomly
>> dereferencing areas of the IO or memory windows where it hasn't
>> mapped anything.

BIOS has described a CPU-addressable PIO region in the PCI hostbridge, 
and the kernel has mapped it:

[    3.974309][    T1] pci-host-generic 4010000000.pcie:       IO
0x003eff0000..0x003effffff -> 0x0000000000

So I don't see why any accesses there should fault.

>> You shouldn't be probing for legacy ISA-port
>> devices unless you're on a system which might actually have them
>> (eg an x86 PC).
> 
> It only happened in this case because there is also a bug in
> the 8250 serial port driver that is configured to assume four ports
> exist at port zero. On real arm64 hardware, this is apparently
> harmless because the driver has coped with this for 30 years ;-)
> 
> There are a few other drivers that assume hardware is accessible
> at the legacy addresses, and applications can also still open /dev/ioport
> (if that is enabled at compile time) for the same purpose. Examples
> could be PC-style mouse/keyboard (emulated by a server BMC),
> PATA/SATA controllers in pre-AHCI mode, VGA console, and a
> couple of industrial I/O drivers that have ISA devices behind a
> PCI bridge.
> 
> Most other actual ISA add-on card drivers can only be enabled
> on kernels that support machines with real slots, so you could
> get them on an i386 kernel running a virtualized x86_64 machine,
> but not on ARMv6 or later kernels, and you can't run pre-ARMv7
> kernels on ARMv8 hardware.
>   There are also lots of the hwmon drivers which use super IO, and probe 
a fixed PIO addresses for HW detection. These may be enabled on any 
architecture (apart from PPC, who explicitly disabled them to avoid 
issues like this).

Thanks,
John
