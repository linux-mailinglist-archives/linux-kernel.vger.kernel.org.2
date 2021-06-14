Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89C3A6A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhFNP3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:29:52 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:41970 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhFNP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:52 -0400
Received: by mail-ej1-f44.google.com with SMTP id ho18so17334924ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJvFKFQ6I8y0jwp5m+y1cgcUlC7uDb3ZJJBW/6X0FrY=;
        b=OW0bd6QJWNc9V/UGcYXueIiC1yVxC7o4+fDM8hPj1nj8MeD8a4VLq5CsRlkyYre0UN
         r3VQIapzv+UBtseP1GtyjQwg08CdPXNcHHwxF5LPSxojj+41MB15fYrIYNXs6Ma/j8Bv
         6ax+7L0OqylRUORs+VkpDEdxxzYS9JgkITdrgDbqp+UGOAOnsSE/1Z4umlP26g8uXAMn
         9qZJZlHkjpfHFw7+ZUxlO2qqtII3y0MwTRsVS3+dDf9Oy7Z8kbXzUvZxwZwwHQdKir7q
         2msx0fUfVKaFYU0XNyJfAiEtEL/6sxqLeIkLpAqxRuUWmdHYHFfWE/F0ogOLBv0ZHep6
         gxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VJvFKFQ6I8y0jwp5m+y1cgcUlC7uDb3ZJJBW/6X0FrY=;
        b=IJvnYYLNP02wtstpWF6qRSf+68SxUpARLaBwDlwvajyRVo+T5P+CPfCwsaSNBPgiDl
         lxqSz3QNyKb8jSWAySGgaqFrobZ/dFW3PGviAB6iD3SIADGN++zgYn3APoDATpw/AFBU
         k766reSj8YhW0z7A+xs2Cz/myet/CLWWlKsxO59+VUlE8RDU+U7aDTShSkAoEsHKu+bX
         sm5pcjaztSgZgkD1KCj3b668mgmlHGEWYsCpVwfEBeQxGsL+U1Eb9qDwMXdygAbqf7cd
         mqg5VE1xng2AzUgvVX05So5PvLFktJ4XUS5RxAItoT4I38coSYkiNFbcEmcujPAlyXSM
         zotQ==
X-Gm-Message-State: AOAM532YHL6hXWjj6Pv61m1vifWyTWYBUtgP8kzZ/McE/yM1H0Fv2a8D
        aoe7a9bsYm9AP8vk2CDmRkIUH20sHFLt9fWU
X-Google-Smtp-Source: ABdhPJyxANpPti/h5Kim60GurBx/i7gfP9wUBnt2c26v0XvbVO1/2eO7ogyr/FN8wU0SdZGo4Gehcg==
X-Received: by 2002:a17:906:24db:: with SMTP id f27mr15744249ejb.321.1623684347864;
        Mon, 14 Jun 2021 08:25:47 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id b25sm9255996edv.9.2021.06.14.08.25.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:47 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/33] arm64: zynqmp: Enable fpd_dma for zcu104 platforms
Date:   Mon, 14 Jun 2021 17:25:11 +0200
Message-Id: <76d330bf2b2414efa2e98965a3ca7f7c43e3645f.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable fpd_dma for this board.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 5637e1c17fdf..99896db6b8ca 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -65,6 +65,38 @@ &dcc {
 	status = "okay";
 };
 
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
 &gem3 {
 	status = "okay";
 	phy-handle = <&phy0>;
-- 
2.32.0

