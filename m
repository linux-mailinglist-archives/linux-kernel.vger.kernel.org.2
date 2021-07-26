Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173683D586F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhGZKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:45:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:51225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233113AbhGZKpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627298726;
        bh=ci9hKgw9ZpK5R8Rr9kidSzAQ7LebRavx39L3IleFBgM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Jm3n+Va6OnsjAyyPz/alHQGkuFKuLwMmjs7YygEbBIZeg1sEUlt0tXVy43p3QH5g7
         VZeV8GoO6Nvzo6J86hgk16XMW2AHTnpY9midn7WIBp+5br+1NAFUH2tgq5f8IJxPZB
         UT2EW23csYKAmpd0rLSUSUKQ0IFldVI5FKzeCfMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation.fritz.box ([88.152.144.157]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N8ob6-1l2HcO0G2w-015nBm; Mon, 26 Jul 2021 13:25:26 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/2] riscv: defconfig: enable BLK_DEV_NVME
Date:   Mon, 26 Jul 2021 13:25:11 +0200
Message-Id: <20210726112511.78350-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J2pEnBmcl/6kUvPt5Ucpu+qCUQ2Ksn5aX9IuWkWpclAG45E0oZL
 5gTpKu1soqQCnSoaMAdm5ocAfsAjMsDTvf0IR5J7CMSCMocjD8oXyk7Ozo6yhCA6p6XX2ep
 X5TgoaTI4UEUqBTuS4nwxGFREZi4syEpjXzBwBDOEnJwLaQGRAlu2trA5QW6lztX628+y3p
 x7Cc7fRN7QP3Z4R6rYdNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S8dUEILjgFQ=:M5QqZES8TMyvb8vIBs8iPB
 y7mUOqAMUsru/6texw5t8LYYmHaXlg3d6FyMbnY62MNckR7yZtCpz7c4Nfj8vTJ0pdIlRvyQF
 Zqlfbs1/Oez4hX08MPKx556uZAuQJ9UJ0x1/o6EbBvJcLxZgJEfRjAkQZfw3qtDC/aaPfIy9f
 LkdqcC/9TmalfVU+fpPWEI4m6wMsKWRzy3I8dHIX5KL5UWrSzrExFAEUAzEBufmuTpr9Rgd2O
 U074L78HDRFUzrOjk/pT4Tw6iJhRht8LZvP1E3pEAVx2DMsSmBCSDRYYM/niexZ5H/vFeKAc5
 nW4lKu+LjlmvqbFf0BJn7UGutjgREvTaOGfZfa2myDIcrf4z2u+iTyYcfQPPWXEaYX3Bs9nLM
 uElImLeAS6yyJ81Tm/vxDRSeXz7tGwP68ochRKCR/HRqD2HOWf9NB6sc1X73SrU5RrU5RPFh4
 RMqLn9AfbUmcQrADzMyOTShJfjtW5fDic8ARVo9tiL54ovv1xwFIWC3osLTZEueUOFRkkI0SM
 2Depe1jTTxvMMLRNBrkPXCIKOWjve/H9tS34tZ+Vwfw4KIsbeZJkNlQkRizlP2g9SZ9EZXC9n
 oTLo0OJEbH8PLwBz/uzt6VASSG8IoAdFYXghfWDhnFU6DZKGW0GeF+H7cMJoKaHB8WQgmzTzy
 wUTg73ig3CnLLvdIagXPmaajbOerl9mwn/bl/L/BcFjVaKjeJrBRwPJWLmFfeBVLaT1ThZATM
 OwHG5H7Juv6p33Yxn4EiUMipiJXvXfp0CsOPrARHcc+QrOo28GkSa+J+b6cMqZ1/2nVMjHM1g
 BM7GLksGisJNq0NpA60RNwwBNFbPuH6U7Z5EUlPSNBGdhTrcirdPiLmuCW2Ht/dMlyA95/uLU
 OStpLQolCvmA4m7UAohewoF1AjtZY2CcOomzxuYoBdwmTwAN/wFfvJUyqVLsskUPL+beTlXAf
 cP6lxWuzRyuxKI7PchS94ZEv1/Yw5MXYELfK0IFkYqlT4GP2zkF+QmXxJya75K7g6rQ3vHR4l
 xUNVabsfWNWvuS9zCjRA5l5K8Vps609dC7kukj6SWgyQprlifYmi5o2JbR1BexxD0wNSAQjE8
 RKMzR8r1OQ9mRH8iGy6/cguo2BC9DV3t2aX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe is a non-volatile storage media attached via PCIe.
As NVMe has much higher throughput than other block devices like
SATA it is a must have for RISC-V. Enable CONFIG_BLK_DEV_NVME.

The HiFive Unmatched is a board providing M.2 slots for NVMe drives.
Enable CONFIG_PCIE_FU740.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
=2D--
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be234b11c..393bf3843e5c 100644
=2D-- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -39,10 +39,12 @@ CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_PCI_HOST_GENERIC=3Dy
 CONFIG_PCIE_XILINX=3Dy
+CONFIG_PCIE_FU740=3Dy
 CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
 CONFIG_VIRTIO_BLK=3Dy
+CONFIG_BLK_DEV_NVME=3Dm
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_BLK_DEV_SR=3Dy
 CONFIG_SCSI_VIRTIO=3Dy
=2D-
2.30.2

