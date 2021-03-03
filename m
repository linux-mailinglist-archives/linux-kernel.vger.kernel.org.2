Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC432C2A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCDAAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:00:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51828 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387974AbhCCUIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614802083; x=1646338083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cjT47Y+Foav4IUdFGeBZNjaxykl7ywcHlPHQ263WpSI=;
  b=hupSLZPsNNocg7dLrbdHKfBWFXbGv/Rc9F3ViBEUlfF1QMQ77iNQRUc9
   TVqdD9TeXuaMOTiPRA+J/pn5l4Rp+bVCbVgkBktnpSzk1LDdtfpBWI8ys
   k3eUFZLYigayCCEU7pbT+jRdh/FhHdIlmCVEVcAXyfABTxjBSaO5/JApa
   CaSpVP5obKxtQjWi/0lBdp9yGOUbQtl58cbPqQSkJGrjBSlaxLQRZl8/m
   1Bpx3zq5J2y1Ng9Do1tBuSZaq0X/9Wa1/KCDS803vx9rOO/0QU84JxcNX
   TCi+6AtV4MyZO7LNQ4MAP/nlSmB+Jby11Iqx0LeKHpdEYhq/Ly0LM4mZn
   w==;
IronPort-SDR: S9rN6e/o28n3RbNoRl1if+q+HAdZgyJrDZ7Px5dxOmr6pIa6FIw6vi1FMgKsOJzI3lVicH7Nly
 76jTuBKfSBAvfC++bQ3Pc6Yi+pLppE7+EJnUJ6UDIQKHQM2YkbJdgfbR04rqZj7s8hkeXo/rYD
 l/qdex3UW8IA8UVEfVfx8/isAk+2jShY8zxyczau4XjH4EkoCkpyKaohCmig9uhP2KXdaXu2if
 FBVYEWViyfZKICUWbXHWjFKqCcTAZRzKNDm7uZuZ+oYJNthxBzrAFI66RtPPicMKkysEQIIrtt
 CPU=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="161271856"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 04:06:57 +0800
IronPort-SDR: 2gsSjHtJchyLBuA7xmHuPwb7YaKgLg463NHiFNJ8ALB2/0tugJV5BpXucqynYG4BMoNs87QpUB
 ThmxgPOwm3S6FZBq1tF6/Pi22D1HlNhwZAbDIu0IqkHJ1JwWMkOjUKCYAcqsXihi8QSxodHUZ4
 hrOIOqhFbDdd5SYOeA3wmcInBd3ozByweBRoMWth71Wq1WLzF6u3OT6jAuiVd14iGQxNPcbLj0
 ciznJSKRIiRCmQdj1fwoilDEFmG4cOu46UbE3q5hgAbloqbfh/rA54H8lfiAyHSr/3NS5TEHbZ
 F6glbYiCwUn3VxNDMQSa03XH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:50:02 -0800
IronPort-SDR: lrp34JjvSOAuSzQgVDJ41RlatV5pePGDpkn4S+cKVuDlZtpeAAItGSWrNtG69Fihlf5tw5C0yZ
 lXPb4beU7vrOdo2k0rpc8bEvI3IPwOZQ+Yh6Mqt5KHpoaNjiayy9VhS8lvSIjLx2ACJ25V5jmE
 b2a5ueWc5o2sHqoKZ1DjyzXSkQwTf8pTlnZ1Ym/UJsWuIEdtQTxxtG/XHza63jFK/Q4NaEvArx
 a4SCUCrs9VP78Tbzy2ehWrVPUM2uqpb2zrCCpM8I3K+YIs2VBmOgwZB8dIDTex97SChR63ae46
 YQg=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 12:06:57 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, Conor.Dooley@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Ivan.Griffin@microchip.com, Lewis.Hanly@microchip.com
Subject: [PATCH v4 0/5] Add Microchip PolarFire Soc Support 
Date:   Wed,  3 Mar 2021 12:02:48 -0800
Message-Id: <20210303200253.1827553-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
It is rebased on v5.12-rc1 and depends on clock support. 
Only MMC and ethernet drivers are enabled via this series.
The idea here is to add the foundational patches so that other drivers
can be added to on top of this. The device tree may change based on
feedback on bindings of individual driver support patches.

This series has been tested on Qemu and Polar Fire Soc Icicle kit.
It depends on the updated clock-series[2] and macb fix[3].
The series is also tested by Lewis from Microchip.

The series can also be found at.
https://github.com/atishp04/linux/tree/polarfire_support_upstream_v4

[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
[2] https://www.spinics.net/lists/linux-clk/msg54579.html 

Changes from v3->v4:
1. Fixed few DT specific issues.
2. Rebased on top of new clock driver.
3. SD card functionality is verified.

Changes from v2->v3:
1. Fixed a typo in dt binding.
2. Included MAINTAINERS entry for PolarFire SoC.
3. Improved the dts file by using lowercase clock names and keeping phy
   details in board specific dts file.

Changes from v1->v2:
1. Modified the DT to match the device tree in U-Boot.
2. Added both eMMC & SDcard entries in DT. However, SD card is only enabled
   as it allows larger storage option for linux distros.

Atish Patra (4):
RISC-V: Add Microchip PolarFire SoC kconfig option
dt-bindings: riscv: microchip: Add YAML documentation for the
PolarFire SoC
RISC-V: Initial DTS for Microchip ICICLE board
RISC-V: Enable Microchip PolarFire ICICLE SoC

Conor Dooley (1):
MAINTAINERS: add microchip polarfire soc support

.../devicetree/bindings/riscv/microchip.yaml  |  27 ++
MAINTAINERS                                   |   8 +
arch/riscv/Kconfig.socs                       |   7 +
arch/riscv/boot/dts/Makefile                  |   1 +
arch/riscv/boot/dts/microchip/Makefile        |   2 +
.../microchip/microchip-mpfs-icicle-kit.dts   |  72 ++++
.../boot/dts/microchip/microchip-mpfs.dtsi    | 329 ++++++++++++++++++
arch/riscv/configs/defconfig                  |   4 +
8 files changed, 450 insertions(+)
create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
create mode 100644 arch/riscv/boot/dts/microchip/Makefile
create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi

--
2.25.1

