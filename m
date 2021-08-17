Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161DD3EF08D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhHQRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhHQRC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51C8460EB5;
        Tue, 17 Aug 2021 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629219744;
        bh=iMXJ2ZuXkc0VvET6phdIHtfJVRrX7KNyRwOMYfQWSjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pG90qLWM0y3+P/nvw2oTT/2jkCLE14uE0ZVtMs9HeEI1ZUEZNOQIOaz9BP75jxaWe
         LbgBsEL7G5CnNSPwbXVI/aDgU6mTgGQwv5Vxx67JwvD2fHNBxL4rpgMqPykqC1mxjm
         GWTKZJ1nalVWGu94xKYBxzy8Wg16evZbx4Mk40DfAFQdRfNyMDOXw30zChhtC84F6p
         krDZeXE5xGXVWIT0fQmeRwa+m0NMWl9qDWrz6Biz+PPZ0j3Tpsq0x4nhwwHE6X5121
         VC60XyBeDWbyh4DaPd7Gc1TjOti1vnol0V+EiIUi4JA0y9w4wHEVtZ3km+yu6QSbHC
         hk7mggZAtsVmA==
Date:   Tue, 17 Aug 2021 10:02:22 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: SK hynix BC511: warning: nvme nvme0: missing or invalid SUBNQN
 field.
Message-ID: <20210817170222.GA224912@dhcp-10-100-145-180.wdc.com>
References: <67f74c8e-9d5e-22a1-f1c2-a4284b07ba56@molgen.mpg.de>
 <20210817161638.GC223727@dhcp-10-100-145-180.wdc.com>
 <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3f78d3c-d3f7-67f5-4263-f306b4f623d1@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:53:15PM +0200, Paul Menzel wrote:
> [cc: +Dell.Client.Kernel@dell.com as it’s a Dell device]
> Am 17.08.21 um 18:16 schrieb Keith Busch:
> > On Tue, Aug 17, 2021 at 05:10:40PM +0200, Paul Menzel wrote:
> > > On a Dell OptiPlex 7780 AIO/04G47W (BIOS 1.6.3 03/08/2021) Linux 5.10.47
> > > shows the warning below:
> > > 
> > >      $ dmesg | grep nvme
> > >      [    3.015392] nvme 0000:02:00.0: platform quirk: setting simple suspend
> > >      [    3.021861] nvme nvme0: pci function 0000:02:00.0
> > >      [    3.026593] ahci 0000:00:17.0: version 3.0
> > >      [    3.026922] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> > >      [    3.035020] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part ems deso sadm sds apst
> > >      [    3.035219] nvme nvme0: missing or invalid SUBNQN field.
> > >      [    3.044518] scsi host0: ahci
> > >      [    3.051632] nvme nvme0: 12/0/0 default/read/poll queues
> > >      [    3.052590] ata1: SATA max UDMA/133 abar m2048@0xd1339000 port 0xd1339100 irq 125
> > >      [    3.058538]  nvme0n1: p1 p2 p3
> > > 
> > > Should it be added to the quirk list in `drivers/nvme/host/pci.c` or is it a
> > > real issues, the manufacturer should fix? If so, do you have SK Hynix
> > > contacts?
> > 
> > It would be great if device makers would be spec compliant, but the
> > driver will continue to work with the device the same whether you add
> > the quirk or not.
> 
> Could you please point me to the NVMe specification section, so I can refer
> to it, when contacting the manufacturer?

In the section for "Identify Controller Data Structure" (section
5.17.2.1, figure 257 in spec version 2.0), the NQN definition says:

  "Support for this field is mandatory if the controller supports revision
  1.2.1 or later"

The driver does confirm the controller's reported revision meets this
requirement before emitting the warning.
