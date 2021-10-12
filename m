Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CAF42A6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhJLORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:17:19 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:9376 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236943AbhJLORR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634048116; x=1665584116;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=iUmLh3CsVMxHyGYUA+CsYzjS6qlWUZk+JjHi+567Uko=;
  b=QkgRcDYMOF0SCFJwxdNE1Rzn6RRi3Cs7SFl9kqosP3+6ZDrKsD4miaAU
   gpYzktnnSkrCWZyXDf7hU1avkKerOxx4P6cy6uLq5zpRFeqInLPvUZn5l
   n03DeADrWb1U0gPS6zcG6GP8lScWMvAfCS3zqlbS35nOiVTqUbeX32d3K
   RGc99MaBDVvFOgF3b/GJ8/pDGbibhqxu9Sp5R885xchtbSaBXglrEGash
   eBem3cKJ9oMkpGyHkgrMuaZHJj/LFLA1a3SaoJehmL8YS3g1AT18MyDOY
   A/9gbDEpsXbZCLELd5g1JRD25pIVlydU7akcm1hOhLDMGF1LjyTp1rV4v
   w==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624312800"; 
   d="scan'208";a="20001100"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Oct 2021 16:15:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 12 Oct 2021 16:15:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 12 Oct 2021 16:15:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634048114; x=1665584114;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=iUmLh3CsVMxHyGYUA+CsYzjS6qlWUZk+JjHi+567Uko=;
  b=MeGmzVtKgnGcpLjKMHO/8wIsjfJ+VPbHXQxDRz8phTnRXa7aDvZk81uH
   00OE1Q6DyJDyDWLHRQIQe8yo8AwKcADnouwv3FLdXkemx0rFNCaObR5Io
   +ydkPpTROGwTR1u1CbMJG0ecxeiV6CZ0ymrbfACQpRQ7eVncdyG+40Cmf
   A33uKcAjdLP/cN1kXPQLHqlULJnw/PkIByDnlmMwz7ojp43DTqQcKByl8
   MJKgdbgA0Uru/NxF37HG818XCS8c9BXLf4o+7m/bIm2H7fApUaPbG+LVV
   G7Igx/HvKGG7NoMlhnUfcE14JWMAwCL0s5IYA09fCrUL5wDquL/YFGvGF
   A==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624312800"; 
   d="scan'208";a="20001099"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2021 16:15:14 +0200
Received: from vtuxmail01.tq-net.de (localhost [127.0.0.1])
        by vtuxmail01.tq-net.de (Postfix) with ESMTP id A5484280065;
        Tue, 12 Oct 2021 16:15:14 +0200 (CEST)
Received: by vtuxmail01 (kopano-spooler) with MAPI; Tue, 12 Oct 2021 16:15:14
 +0200
Subject: AW: [PATCH 7/7] arm64: dts: freescale: add initial tree for TQMa8Mx
 with i.MX8M
From:   "Alexander Stein" <Alexander.Stein@ew.tq-group.com>
To:     "Rob Herring" <robh@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        =?us-ascii?Q?devicetree=40vger=2Ekernel=2Eorg?= 
        <devicetree@vger.kernel.org>,
        =?us-ascii?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        =?us-ascii?Q?linux-arm-kernel=40lists=2E?=
         =?us-ascii?Q?infradead=2Eorg?= 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Oct 2021 14:15:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.82
Message-Id: <kcEE.777nLr4LStyXyKESb7HpgA.AIUNk3O/1wE@vtuxmail01.tq-net.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On Wed, Oct 06, 2021 at 15:23 +0200, Alexander Stein wrote:
> This adds support for TQMa8Mx module on MBa8Mx board.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>=C2=A0 arch/arm64/boot/dts/freescale/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>=C2=A0 .../dts/freescale/imx8mq-tqma8mq-mba8mx.dts=C2=A0=C2=A0 | 416 ++++++++++++++++++
>=C2=A0 .../boot/dts/freescale/imx8mq-tqma8mq.dtsi=C2=A0=C2=A0=C2=A0 | 369 ++++++++++++++++
>=C2=A0 3 files changed, 786 insertions(+)
>=C2=A0 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
>=C2=A0 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi

This can not be applied as is. The board does not boot if the RTC driver is compiled-in.
Reason is that the RTC clkout is connected to the RTC pad which is the 32KHz ISC input.
So once the core system started and all unused clocks are disabled, 'pcf85063-clkout'
will be disabled as well, essentially halting the ccm input.
I've yet to come up with a solution to this setup, so the TQMa8Mx related patches can
be ignored for now.

Best regards,
Alexander

