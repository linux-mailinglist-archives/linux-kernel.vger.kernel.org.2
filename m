Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16A4428D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhJKNKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:10:18 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42625 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235410AbhJKNKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:10:16 -0400
Received: from [192.168.0.7] (ip5f5aef5a.dynamic.kabel-deutschland.de [95.90.239.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A062561E5FE33;
        Mon, 11 Oct 2021 15:08:15 +0200 (CEST)
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
 <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f02a8989-d255-26ee-2fca-c9db2d1e158c@molgen.mpg.de>
Date:   Mon, 11 Oct 2021 15:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Keith,


Am 17.08.21 um 19:02 schrieb Keith Busch:
> On Tue, Aug 17, 2021 at 06:53:15PM +0200, Paul Menzel wrote:
>> [cc: +Dell.Client.Kernel@dell.com as it’s a Dell device]
>> Am 17.08.21 um 18:16 schrieb Keith Busch:
>>> On Tue, Aug 17, 2021 at 05:10:40PM +0200, Paul Menzel wrote:
>>>> On a Dell OptiPlex 7780 AIO/04G47W (BIOS 1.6.3 03/08/2021) Linux 5.10.47
>>>> shows the warning below:
>>>>
>>>>       $ dmesg | grep nvme
>>>>       [    3.015392] nvme 0000:02:00.0: platform quirk: setting simple suspend
>>>>       [    3.021861] nvme nvme0: pci function 0000:02:00.0
>>>>       [    3.026593] ahci 0000:00:17.0: version 3.0
>>>>       [    3.026922] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>>>>       [    3.035020] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part ems deso sadm sds apst
>>>>       [    3.035219] nvme nvme0: missing or invalid SUBNQN field.
>>>>       [    3.044518] scsi host0: ahci
>>>>       [    3.051632] nvme nvme0: 12/0/0 default/read/poll queues
>>>>       [    3.052590] ata1: SATA max UDMA/133 abar m2048@0xd1339000 port 0xd1339100 irq 125
>>>>       [    3.058538]  nvme0n1: p1 p2 p3
>>>>
>>>> Should it be added to the quirk list in `drivers/nvme/host/pci.c` or is it a
>>>> real issues, the manufacturer should fix? If so, do you have SK Hynix
>>>> contacts?
>>>
>>> It would be great if device makers would be spec compliant, but the
>>> driver will continue to work with the device the same whether you add
>>> the quirk or not.
>>
>> Could you please point me to the NVMe specification section, so I can refer
>> to it, when contacting the manufacturer?
> 
> In the section for "Identify Controller Data Structure" (section
> 5.17.2.1, figure 257 in spec version 2.0), the NQN definition says:
> 
>    "Support for this field is mandatory if the controller supports revision
>    1.2.1 or later"
> 
> The driver does confirm the controller's reported revision meets this
> requirement before emitting the warning.

The Dell support came back to me, and said, that Hynix refuses to 
publish a fixed firmware unless I show them a use case, where I need 
that field.

Can somebody think of a use case, and why this field was made mandatory 
in the specification?


Kind regards,

Paul
