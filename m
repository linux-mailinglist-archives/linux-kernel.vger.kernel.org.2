Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301873A6A31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhFNP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhFNP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C18C06124A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g20so17440039ejt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qiJguyfqDey32XuRUsbQQb3E8cPJcAN2K8bbAeonWds=;
        b=Y1tFnPR/wIxPrvHeUyi8kQCqzu4h/YSe1mwmX5SYlfcYRBfYXuSRYHnb8XiFzpYn9Y
         3lPuA5CR0jerqiyBbMBbz5MEHCFNKAhjF/zfe1HFBSaLreHkSJjbY3L1fixpJfiT4H6D
         /123aOci5sqYApHFdymqObiRqt9817SDyAtB+VH3bkEMKLBYCbC0YavSmWc/0jRpbUz3
         Ml1qKMMQI+Y9jTONK9L4X+famK2j0GdHt1h/DQiLOkUTrXR2ZbG9kaD1r/T4LdsfnpLb
         tQtiX9dqnxPefO0SsvlqGWKDv2TcYThMaiNoTPqlixSwTEYErDZp0X0G+FFE0nezPhRq
         Jdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qiJguyfqDey32XuRUsbQQb3E8cPJcAN2K8bbAeonWds=;
        b=Tc/bXokIh43ZQlvyol/gr5ekK1erSca4JRHQUEskTAcHg9WL4+W8gPc50gA3gpEAOh
         9H+wGNnV1pUwp5XsRsjk+AobYu/oWPL/UfD+6sW1uzVAk9DlCnFdP8BtUjaTC7vD3UNu
         iaf6D6Wg90yn8qI7Do2evst7Om6j748Am6WSt7XvjtbQ3hwbgDggiPUujYUh9ARlX/ZT
         Pq0OvX3E0qUombjBazOlSK2PUKCUncJ1TU4CLGN1+jvJ0JQRlE03xgbwPjrQuxOKsCE5
         Lr6d4tVvTo7kjBS+bnsHNUWF2nLl2bhJC/fp4teZaYzEM3zMqWLS83waoTRgM8vqU9UM
         qNDQ==
X-Gm-Message-State: AOAM533iptt+12DHGyNaIePngkKaiP90ODr7rdnGi1ZpZ82lOg2NhEYO
        NJsuHaqB4ts1xG3KKN7ff9MPqrJ0pisrR0Tu
X-Google-Smtp-Source: ABdhPJyN6xgCUnvU8yatvX+iCpxha7cLj9bHiSn/aMOeyiL6QgvlwgOkUk3jWCbE8o1pXQKYufQMVA==
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr15531952ejc.441.1623684381496;
        Mon, 14 Jun 2021 08:26:21 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id v8sm9118369edc.59.2021.06.14.08.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:21 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 26/33] arm64: zynqmp: Move rtc to different location on zcu104-revA
Date:   Mon, 14 Jun 2021 17:25:34 +0200
Message-Id: <fe6c3f96fbd359409b7fef85d2c2ada584b3d0cc.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it the same location as is on zcu104-revC for easier comparison.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 84c4a9003e2e..048df043b45c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -417,10 +417,6 @@ conf-tx {
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &psgtr {
 	status = "okay";
 	/* nc, sata, usb3, dp */
@@ -441,6 +437,10 @@ flash@0 {
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &sata {
 	status = "okay";
 	/* SATA OOB timing settings */
-- 
2.32.0

