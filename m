Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3F32C2A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhCDABE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:01:04 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51828 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387977AbhCCUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614802127; x=1646338127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cq6Qiw/Z67SYWe44YS0p0slZ5t+6fb9uqLYw/KGGbCY=;
  b=rVlyVPmvO58jYSfAtlNSp+j1gAx9ctwaLlkubRBjajSmRQnbe0Dhg/9+
   pJ6VLJ3h7lz3oMYFfGpnO3mrw873f41T/5CdbNLlHEphfbSdcbpSywI2w
   mfDMt8Iu4HA6W4CFsHoWNd0PKw1Y7vtjpa7s24Y+VSdwwYRJ16LfSrOrp
   R8fmFVyBH9uhVSo1VhQbXV3Bv8NcwJWxMCqSRrNXezsRATg/DxH5n2v6d
   cD0+QjLYvoPQKVQIvJlTdK7TVAgcXP6RpoOiqZLsj5Vx1XoctUadwMsID
   GKqRaXTZewXvMdbWaHQubN6o2smwcjaIKrP552emLu+ZRjBapOtWNmP5f
   g==;
IronPort-SDR: 0A8a37SxwyNQtfGag9ihbogBDWNkH2cA/zEyU64Us+2nPaH2RGn709bRrZsbkArSQdn5uglt23
 5n6KYLUXKPwTbbT/qhN7XA1cUDN6JN17wQpjeku+gKsFnk/MjD8LVwISxrjYfoaz7fN4N6ps7/
 tTFC6SDM9wy8IW7zZOd6aLRJrXykeeNxPPpX7uAA3Awr8dorLU7WcOgLn6hf95vi/gOCt7KH8p
 DT+vVqIU4IxkgO/39x8FO38AhOXczAHAeLGMp/e/UYpun2KSKe2QLpdAXT1Mx6Q4poH6w6mwiM
 uvk=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; 
   d="scan'208";a="161271858"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 04:06:58 +0800
IronPort-SDR: 60ncR626wY2PkTpAd6VnWAICHjPBe6XfRe/HiuQkszj/r9iO8vLymqKh7T+dTgVZx7zF8h6dxv
 kO/mfYCPmcBs3ES45vOvVpj6eaPktT2S2AxPrnw+77/lnabxAbzbvzSvLvgGxqnzmcEVyqAwxX
 FpVyVhXQomkv1tjmhfHK2BcGdMifm2gfA1HuudYYNt/FEBaDcTJxMJ/Nj2GqjsyMzfwcg5CLlt
 VmcwlHkLhE1bvBlF3nDB58ZCYFOCa5vMnPfUFotR5ZHCtZahvf/RUIj6QA5wbaePb+kH+zxozD
 4wq1wiTl2AOFBqtlWXOrBhWf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:50:02 -0800
IronPort-SDR: UyakJ0SZO7XUdwUi2bQqA9gRsyIoV1MxrFz3ZohZDW3j2KqOBSYY2TacBraXG2n5oQSk6mDxLG
 SeWwZDw6y6/UYK08/r0zovxNgZ8nCTEz6XZUHgAqAqudbhuDqWWB73omgGxxeIHBMoEfUUpf12
 5497zkXoYEEjSZdx3OiuewEen7iMn+RPkAaIrvEMdZbqUMHQWvDYxJoeWEnbRdKJNPuRiDdn6B
 JpoVU7ITC2917OdiVsmzz5czL1Vz2AD5w6kZatKLSKzq8Vz9iBpW7Ruuq7C0/DolRhTnsHOSgF
 4rI=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 12:06:58 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v4 1/5] RISC-V: Add Microchip PolarFire SoC kconfig option
Date:   Wed,  3 Mar 2021 12:02:49 -0800
Message-Id: <20210303200253.1827553-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303200253.1827553-1-atish.patra@wdc.com>
References: <20210303200253.1827553-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Microchip PolarFire kconfig option which selects SoC specific
and common drivers that is required for this SoC.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig.socs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 7efcece8896c..82b298bfd3be 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,12 @@
 menu "SoC selection"
 
+config SOC_MICROCHIP_POLARFIRE
+	bool "Microchip PolarFire SoCs"
+	select MCHP_CLK_MPFS
+	select SIFIVE_PLIC
+	help
+	  This enables support for Microchip PolarFire SoC platforms.
+
 config SOC_SIFIVE
 	bool "SiFive SoCs"
 	select SERIAL_SIFIVE if TTY
-- 
2.25.1

