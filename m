Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AB84234C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhJFAHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhJFAHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:11 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA09C061749;
        Tue,  5 Oct 2021 17:05:20 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w10so1037128ilc.13;
        Tue, 05 Oct 2021 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iygZcmzrLB3e1K8hChm09B8oQxVJNXkOlhdGKacTC4c=;
        b=U2olciHgRkvmmp16T4kKhc30f4v2PNNKP9ZrgmspGxIV3DM2ghZw5VOdcBw35N9a1q
         KCnjiJieZcTRqeY2XOpP9xAxAaxVF7hGUrXvD6SUrOq6PlPeM/BlHvw7jFA33PHpgpqb
         6K0H+WKnsj8yCk0yVOSlui5ou0woWIJmlNks1m+wDcSTxkN/EdptuGbvScEU4+Em7iF0
         4v0nj+IrkDfQxeba2kcppcZUyAZchZG8wUD2FkHg+oCK1ANahc8KP7YqPsZJuPlfwwJV
         bpaiqe6qBpJwgsdNs6N2ZhnlMC389rf4kolieAR89jVOxS36kC8MIxahhPUCza+VgHA3
         3LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iygZcmzrLB3e1K8hChm09B8oQxVJNXkOlhdGKacTC4c=;
        b=V510Px9fFWo+taiTIAPVdkzqefrRH6hkzmS5zZrhJVwc66A55lHOkK8abmwijZeHRS
         PqPkQNVbVFqlsPX9fRG2EyY2NMWCCbDQf8f5yW7DF5zVxGLeyBvkEx/JkMVwUfWyIHe6
         755zy4lmgIDgTgpIN5dSvE4Xf78Nr+y6uPCz0D/6G61S4SWTTrRLBXWcX48IrnFcxV+J
         kAZQmLqfs4dfw1juOGe+S+0LR5bTlFEL3QUn/cyW4thF5A1Kip4C2HOXr0uRmJUVwjGW
         Ls+esT613WPJ6QZnU0HWO5B0Ma2y9r/wensJnvP++/TrXVP/r4rw3UFx2kXnsuA+lf2+
         RVYQ==
X-Gm-Message-State: AOAM531JIhYTo42aoec71cRknxR8qWgBibNAKZsfE9i7XbrpfAVpbRTs
        usGD46zuBtR75SR/lXKC5zA=
X-Google-Smtp-Source: ABdhPJwwbFOjXGXMQ+NxJxbxLXnQNP9FoSWtwrTv2KLasH77OsYCj4sf0T0+6jUTbbAuoOP4KZAsfw==
X-Received: by 2002:a05:6e02:1c4d:: with SMTP id d13mr5121152ilg.49.1633478719642;
        Tue, 05 Oct 2021 17:05:19 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:19 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
Date:   Tue,  5 Oct 2021 19:04:58 -0500
Message-Id: <20211006000505.627334-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the defines for the power domains provided by the DISP
blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 include/dt-bindings/power/imx8mn-power.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/power/imx8mn-power.h b/include/dt-bindings/power/imx8mn-power.h
index 102ee85a9b62..eedd0e581939 100644
--- a/include/dt-bindings/power/imx8mn-power.h
+++ b/include/dt-bindings/power/imx8mn-power.h
@@ -12,4 +12,9 @@
 #define IMX8MN_POWER_DOMAIN_DISPMIX	3
 #define IMX8MN_POWER_DOMAIN_MIPI	4
 
+#define IMX8MN_DISPBLK_PD_MIPI_DSI	0
+#define IMX8MN_DISPBLK_PD_MIPI_CSI	1
+#define IMX8MN_DISPBLK_PD_LCDIF	2
+#define IMX8MN_DISPBLK_PD_ISI	3
+
 #endif
-- 
2.25.1

