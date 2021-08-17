Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019683EF00A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhHQQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhHQQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:17:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78C860FBF;
        Tue, 17 Aug 2021 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629217001;
        bh=EBYGH6hRtooqnI079c6XGEWroZ0teF2V9k2LXqsCqmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUEcmk35C3XBTpqvhFSayUxnTIIzpcDiXtnTMDIW2xHlHU4/39rgodISFoqdpJMBn
         gTR2PjCq5+PUUnLZFO871nrD1V0uCMrTz/XWDzoFsrNJfioklGtrWVunlT2fy44FTR
         lDGb1QdnR7WoDINd9wvszFWeF4Rh2Bqm4XdVCepF+DzfU0LYJ2ayfB16/mHrK4ZSTC
         LL4Z7KHsqvDA2IJkzfms35b63gv2IzTBeRAEBgeGxlOMuwk926KMJ2O9wqFOSzn3ev
         XHhe1AbHN+aVFswGYcESQ1VwdB9xdiSMRvxMBrU65qcWPNx5ourF5D2NBElkmlmqI3
         Tk5mwRrPyU7Dw==
Date:   Tue, 17 Aug 2021 09:16:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
Message-ID: <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 05:10:40PM +0200, Paul Menzel wrote:
> On a Dell OptiPlex 7780 AIO/04G47W (BIOS 1.6.3 03/08/2021) Linux 5.10.47
> shows the warning below:
> 
>     $ dmesg | grep nvme
>     [    3.015392] nvme 0000:02:00.0: platform quirk: setting simple suspend
>     [    3.021861] nvme nvme0: pci function 0000:02:00.0
>     [    3.026593] ahci 0000:00:17.0: version 3.0
>     [    3.026922] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps
> 0x1 impl SATA mode
>     [    3.035020] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio
> slum part ems deso sadm sds apst
>     [    3.035219] nvme nvme0: missing or invalid SUBNQN field.
>     [    3.044518] scsi host0: ahci
>     [    3.051632] nvme nvme0: 12/0/0 default/read/poll queues
>     [    3.052590] ata1: SATA max UDMA/133 abar m2048@0xd1339000 port
> 0xd1339100 irq 125
>     [    3.058538]  nvme0n1: p1 p2 p3
> 
> Should it be added to the quirk list in `drivers/nvme/host/pci.c` or is it a
> real issues, the manufacturer should fix? If so, do you have SK Hynix
> contacts?

It would be great if device makers would be spec compliant, but the
driver will continue to work with the device the same whether you add
the quirk or not. The quirk just suppresses the nqn check and warning.
Feel free to add it if you don't like seeing the warning message or if
the manufacturer can't resolve the compliance issue.
