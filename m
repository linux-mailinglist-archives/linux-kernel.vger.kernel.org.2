Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E597428D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhJKMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:48:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9054 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhJKMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633956417; x=1665492417;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jR4VLxh2n5xrvKbxAr/Rz+ZWsobmRxxPA6ztv3jzo5Y=;
  b=HnjOgo44w8EECvo5yMzsnRxG6VeYlTp5BQp15Xa+9rXQ73lA3SydkxAZ
   bu4TxdsSQydf8r+EjlBGli5OK0rFSruwmtrSDIJ/DlbOcvauh6U/MsqLP
   Vvl85r+1OFeMhe8FWfFeKCheVQnEVm++jVQoH5uwY1W14cJGfeJToxxJi
   f7hGyCAgV91QJ9WWA/gKTG59LQZnsYP34EdOhYK64f2fUm0zWvoqhrjBz
   JRcvihDFzJMpA5/oDBAVKH/h7nnqOCHqVeBL00t9Dz7aoMYV7eYpc+bek
   Atul/gFrjld4Iref5K1n7+z+XIohMQd7D+rL34L4ZQiTrVQyHeADmqCud
   A==;
IronPort-SDR: X42KZZDPyQaa+T8ATntHjJcZxHb52QJuGuGjbsyKrSRRFVNbBTdE3QGejyswvNRYX43DXglH5j
 cM5PUXq2ceda7Svum7SfewApl+pA+C6w6ncQf8XGN3vdeM9Hs3g6eB+cE6kvXlkhoA276BBYCM
 oAUjJPfrebXWIk9ZE9YitXJbc0NY2FQx2E5BYFUMpf86nwu0lCRQUlRpPumI+onWAIT1mygVb8
 wH0YpHYNeSuKAytnc7B0DW+1uiUh4aDZ/ZE3fXz3fMFKPT71vXfyeDItVFOeasMtVAYiQVAhIF
 EJAaaHtU97W1iYZBe1vBsbRc
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="72502423"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 05:46:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 05:46:56 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 11 Oct 2021 05:46:54 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kavyasree Kotagiri - I30978 
        <Kavyasree.Kotagiri@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: soc for 5.16
Date:   Mon, 11 Oct 2021 14:46:50 +0200
Message-ID: <20211011124650.17218-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the at91 soc changes for 5.16. We are really at the beginning for
lan966 family with an ongoing activity in the clock sub-system, for instance.

Thanks, best regards,
  Nicolas

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.16

for you to fetch changes up to 3efc443121180c2acc987929b3b7b86ca83e3ee5:

  ARM: at91: add basic support for new SoC family lan966 (2021-10-04 14:50:18 +0200)

----------------------------------------------------------------
AT91 SoC #1 for 5.16:

- Documentation for sama7g5 and lan966 families
- Kconfig entry for lan966 new SoC.

----------------------------------------------------------------
Kavyasree Kotagiri (3):
      ARM: at91: Documentation: add lan966 family
      dt-bindings: arm: at91: Document lan966 pcb8291 and pcb8290 boards
      ARM: at91: add basic support for new SoC family lan966

Nicolas Ferre (1):
      ARM: at91: Documentation: add sama7g5 family

 Documentation/arm/microchip.rst                      | 20 ++++++++++++++++++++
 .../devicetree/bindings/arm/atmel-at91.yaml          | 12 ++++++++++++
 arch/arm/mach-at91/Kconfig                           |  9 +++++++++
 3 files changed, 41 insertions(+)

-- 
Nicolas Ferre
