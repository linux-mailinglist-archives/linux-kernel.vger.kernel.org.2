Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4623BAB9E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 07:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhGDFsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 01:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDFsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 01:48:24 -0400
X-Greylist: delayed 1556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Jul 2021 22:45:49 PDT
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98171C061764
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V3yPwR7+YeC6xknNR77GPBVizIUsddgSSRhXK7mwpYM=; b=MuMG4kQs8QHUSyiEFwE0JQi4cb
        7gnlIv04axby5lJQUf/vnutoE5Fmqm6YOSj7vCs8vDmtpjDkGwo8bSpctoLDMakGXb1a7WicnkIPo
        8i+KoBZTGG3UWKNl+yTZlIbrf7t8ClhjXuh57dNgjwJSSu0hn5efiuw6NVU++SGie+63CmVFlC84F
        73QaIBH7TfrFDvrGHj2AIe8WnLFSB4bWs+6CwiE3DurhUuTco+N75nUkLlJd2vaaVeo6Pz/VL9vUp
        Qzvbntg+EtXVz1o8x8QUEIucL5GroQqsNqoIpa+742VeDNyop3XgSWWu6bXQgMQJl45pHJ2lsapVs
        7bhpU7Tw==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lzuXl-000785-Rm
        for linux-kernel@vger.kernel.org; Sun, 04 Jul 2021 05:19:50 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id DA62B17205FD9; Sun,  4 Jul 2021 14:19:44 +0900 (JST)
Date:   Sun, 4 Jul 2021 14:19:44 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org
Subject: PCI SATA adapter marks all devices as removable
Message-ID: <YOFE8BqRVMxU1RbF@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

(please Cc)

(kernel 5.13, Debian/sid)

I recently installed a PCI SATA adapter:
06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9215 PCIe 2.0 x1 4-port SATA 6 Gb/s Controller (rev 11) (prog-if 01 [AHCI 1.0])
        Subsystem: Marvell Technology Group Ltd. 88SE9215 PCIe 2.0 x1 4-port SATA 6 Gb/s Controller
        Flags: bus master, fast devsel, latency 0, IRQ 146
        I/O ports at c050 [size=8]
        I/O ports at c040 [size=4]
        I/O ports at c030 [size=8]
        I/O ports at c020 [size=4]
        I/O ports at c000 [size=32]
        Memory at df540000 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at df500000 [disabled] [size=256K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [70] Express Legacy Endpoint, MSI 00
        Capabilities: [e0] SATA HBA v0.0
        Capabilities: [100] Advanced Error Reporting
        Kernel driver in use: ahci

and now disks attached via these sata ports show up as "Removable".

In 2016 (kernel 4.4) this was introduced and some fix was done in git
commit dc8b4afc4a04fac8ee55a19b59f2356a25e7e778
Author: Manuel Lauss <manuel.lauss@gmail.com>
Date:   Sat Feb 27 16:10:05 2016 +0100

    ata: ahci: don't mark HotPlugCapable Ports as external/removable

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 513b3fa74d78..85ea5142a095 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1168,8 +1168,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,

        /* mark esata ports */
        tmp = readl(port_mmio + PORT_CMD);
-       if ((tmp & PORT_CMD_HPCP) ||
-           ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
+       if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
                ap->pflags |= ATA_PFLAG_EXTERNAL;
 }


I also miss the possibility to disable hotplug in the SATA extension
card, so I see now all connected devices as removable devices in DE.

Is this to be expected? Is there a way around this?

(Please Cc)

Thanks

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research  +  IFMGA Guide  +  TU Wien  +  TeX Live  + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
