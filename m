Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA90386F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbhERBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:38:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3011 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345928AbhERBir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:38:47 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fkdq60j5szlfZ1;
        Tue, 18 May 2021 09:35:14 +0800 (CST)
Received: from dggeme706-chm.china.huawei.com (10.1.199.102) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:37:29 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 09:37:28 +0800
Subject: Re: Virtio-scsi multiqueue irq affinity
To:     Thomas Gleixner <tglx@linutronix.de>,
        xuyihang <xuyihang@huawei.com>, "Ming Lei" <ming.lei@redhat.com>
CC:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, <minlei@redhat.com>
References: <20190318062150.GC6654@xz-x1>
 <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
 <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p>
 <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
 <20190325095011.GA23225@ming.t460p>
 <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com>
 <87zgx5l8ck.ffs@nanos.tec.linutronix.de>
 <9903df53-8a84-fe89-7ae0-aac8e6d3f42f@huawei.com>
 <87r1ifkoq5.ffs@nanos.tec.linutronix.de>
From:   "liaochang (A)" <liaochang1@huawei.com>
Message-ID: <eb893e8e-4805-1a04-d934-b7f821c64a8e@huawei.com>
Date:   Tue, 18 May 2021 09:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87r1ifkoq5.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

ÔÚ 2021/5/10 15:54, Thomas Gleixner Ð´µÀ:
> Liao,
> 
> On Mon, May 10 2021 at 11:19, liaochang wrote:
>> 1.We have a machine with 36 CPUs,and assign several RT threads to last
>> two CPUs(CPU-34, CPU-35).
> 
> Which kind of machine? x86?
> 
>> 2.I/O device driver create single managed irq, the affinity of which
>> includes CPU-34 and CPU-35.
> 
> If that driver creates only a single managed interrupt, then the
> possible affinity of that interrupt spawns CPUs 0 - 35.
> 
> That's expected, but what is the effective affinity of that interrupt?
> 
> # cat /proc/irq/$N/effective_affinity
> 
> Also please provide the full output of
> 
> # cat /proc/interrupts
> 
> and point out which device we are talking about.

the mentioned managed irq is registered by virtio-scsi driver over PCI (on X86 platform, VM with 4 vCPU),
as shown below.

#lspci -vvv
...
00:04.0 SCSI storage controller: Virtio: Virtio SCSI
        Subsystem: Virtio: Device 0008
        Physical Slot: 4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c140 [size=64]
        Region 1: Memory at febd2000 (32-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fe004000 (64-bit, prefetchable) [size=16K]
        Capabilities: [98] MSI-X: Enable+ Count=4 Masked-
                Vector table: BAR=1 offset=00000000
                PBA: BAR=1 offset=00000800

#ls /sys/bus/pci/devices/0000:00:04.0/msi_irqs
33 34 35 36

#cat /proc/interrupts
...
 33:          0          0          0          0   PCI-MSI 65536-edge      virtio1-config
 34:          0          0          0          0   PCI-MSI 65537-edge      virtio1-control
 35:          0          0          0          0   PCI-MSI 65538-edge      virtio1-event
 36:      10637          0          0          0   PCI-MSI 65539-edge      virtio1-request

As you see, virtio-scsi allocates four MSI-X interrupts,from 33 to 36, and the last one supposes to
be triggered when the data of virtqueue is ready to receive, then its interrupt handler will raise
ksoftirqd to process I/O.If I assign FIFO RT thread to CPU0, a simple I/O operation issued by command
"dd if=/dev/zero of=/test.img bs=1K cout=1 oflag=direct,sync" will never finish.

Although that's expected, do you think it is sort of risky for Linux availability? Given in cloud
based environment,services from different teams may have serious influence to each other because of
lack of enough communication or good understanding about infrastructure, Thanks.

This problem arises when RT thread and ksoftirqd scheduled on the same CPU, beside placing RT thread
carefully, I also tried to set "rq_affinity" as 2, but the cost is a performance degradation of some
I/O benchmark by 10%~30%. So I wonder if the affinity of managed irq supports configuration from user space
or via kernel bootargs? Thanks.

> 
> Thanks,
> 
>         tglx
> .
> 
BR,
Liao, Chang
