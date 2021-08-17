Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990763EF07C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhHQQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:53:53 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58583 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230354AbhHQQxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:53:52 -0400
Received: from [192.168.0.3] (ip5f5aeb65.dynamic.kabel-deutschland.de [95.90.235.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA12561E5FE00;
        Tue, 17 Aug 2021 18:53:16 +0200 (CEST)
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
Date:   Tue, 17 Aug 2021 18:53:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc: +Dell.Client.Kernel@dell.com as it’s a Dell device]

Dear Keith,


Thank you for your prompt response.

Am 17.08.21 um 18:16 schrieb Keith Busch:
> On Tue, Aug 17, 2021 at 05:10:40PM +0200, Paul Menzel wrote:
>> On a Dell OptiPlex 7780 AIO/04G47W (BIOS 1.6.3 03/08/2021) Linux 5.10.47
>> shows the warning below:
>>
>>      $ dmesg | grep nvme
>>      [    3.015392] nvme 0000:02:00.0: platform quirk: setting simple suspend
>>      [    3.021861] nvme nvme0: pci function 0000:02:00.0
>>      [    3.026593] ahci 0000:00:17.0: version 3.0
>>      [    3.026922] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>>      [    3.035020] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part ems deso sadm sds apst
>>      [    3.035219] nvme nvme0: missing or invalid SUBNQN field.
>>      [    3.044518] scsi host0: ahci
>>      [    3.051632] nvme nvme0: 12/0/0 default/read/poll queues
>>      [    3.052590] ata1: SATA max UDMA/133 abar m2048@0xd1339000 port 0xd1339100 irq 125
>>      [    3.058538]  nvme0n1: p1 p2 p3
>>
>> Should it be added to the quirk list in `drivers/nvme/host/pci.c` or is it a
>> real issues, the manufacturer should fix? If so, do you have SK Hynix
>> contacts?
> 
> It would be great if device makers would be spec compliant, but the
> driver will continue to work with the device the same whether you add
> the quirk or not.

Could you please point me to the NVMe specification section, so I can 
refer to it, when contacting the manufacturer?

> The quirk just suppresses the nqn check and warning. Feel free to add
> it if you don't like seeing the warning message or if the
> manufacturer can't resolve the compliance issue.
Understood. I am going to do that, when it can’t be resolved.


Kind regards,

Paul
