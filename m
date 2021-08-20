Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59E03F31B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhHTQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:50:53 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43826 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhHTQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:50:52 -0400
Received: by mail-ot1-f49.google.com with SMTP id x10-20020a056830408a00b004f26cead745so15135286ott.10;
        Fri, 20 Aug 2021 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjr8j38/Os90LSyEfVorRWiWmsdEDRT1v3ba1dHBUUE=;
        b=Hk+6U/osbztUDvYheEvn5jhPORo1YRM1VmeCdDzYBjVK+mhUHIe6VkFU10B4/FQOjJ
         g3yGeyxfydSOP5nRKkje1qJgiGYp1ADhyDwOZT6Kq3R22BHh1ecGpX8iyRqnk33tKj2e
         3taO4sbRsposoERlsz77k04YfIi/VQUa16YRVmX3OV4ywt5CnkaZlfbFTko2kydxqNsZ
         r2jKFOON1XRzfsLCNyTTESbIwayezbF4n85XL8/NDVury3JlwoK+LL9jsSwnFjXNUZ2j
         yKpS0H9Yu7WjICsyLsEU7UoMlmRTNX1dDzaz5JB4cPJRonv0o21pTRZ/VIzBstaRnRV+
         F6Mw==
X-Gm-Message-State: AOAM533eEgiuw7qB62+ybNTqcSJItzV46XiuZwXWjGQIhOmU5X0uk3KQ
        G9pwbGxEkqlioZawnEkzcCmrYUGdrQ==
X-Google-Smtp-Source: ABdhPJy5fLcI0xBVDHqTw60PRbNNC2mIVzZQpGLTCC3DLbu/aupFUri+AAM0yDq7nqUEeb2bZZBnGw==
X-Received: by 2002:a05:6808:140c:: with SMTP id w12mr3725698oiv.22.1629478213602;
        Fri, 20 Aug 2021 09:50:13 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id v11sm1601771oto.22.2021.08.20.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 09:50:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>, soc@kernel.org
Subject: [PATCH] kbuild: Enable dtc 'pci_device_reg' warning by default
Date:   Fri, 20 Aug 2021 11:50:11 -0500
Message-Id: <20210820165011.3257112-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's only a couple of instances of the 'pci_device_reg' warnings left
and they look legit, so let's enable the warning by default.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: soc@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
These are the 2 remaining warnings:

arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:464.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning (pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format error, expected "0,0"
---
 scripts/Makefile.lib | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 10950559b223..c57f14ac6f99 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -309,8 +309,7 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
 	-Wno-simple_bus_reg \
-	-Wno-unique_unit_address \
-	-Wno-pci_device_reg
+	-Wno-unique_unit_address
 endif
 
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
-- 
2.30.2

