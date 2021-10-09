Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604C6427BF2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhJIQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhJIQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C48C061570;
        Sat,  9 Oct 2021 09:27:24 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a8so1030779ilj.10;
        Sat, 09 Oct 2021 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iygZcmzrLB3e1K8hChm09B8oQxVJNXkOlhdGKacTC4c=;
        b=SueyPpYeRdtbClDbV32Fbdsugs9CwA4G4GHpA4QWnuHeFB5tgnZ4bcoN5r2MgAfg1q
         YfMBv8AGr3egskORjhb+UHPoTGnuYFI9YlPr+pA+th3KIz53lEu6rVvKU5Xz9JkS1cIp
         ccR4zrQawFeQdSu8FfNSZzExhSXPH5/rMCcNGtZTfvdOk+BZmI2GsQ+QNA5QqMPmnjSs
         Q1J/SompcvIqj/Ko+u45T+QLZGyq6ODX/Go3wiuEa7aWjqahojbxUL7zMMVbyKKCqrb4
         K+DNsCLAnlZLu5hD4RTiRXr+xWJa+8sXqjcZo0eHaCeUgF2rw5JQL1SwuwwhOeQUHCi/
         XtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iygZcmzrLB3e1K8hChm09B8oQxVJNXkOlhdGKacTC4c=;
        b=bOvpjBmJ4TdQhsiOZr1KhuVfzoPEWkIrf8dtQfkNOIMccGNK7bJQptVNwLNANhDwrs
         AKePb20bu9Qx+PNnBkpszUq+Y5rYFG2AfR6LrY272QiovgDSCKo4/Y4zpT5sbzrpo/C6
         NCrKCGAnbSWqi4bO8FqjKfCNphhZGnPT9xMaK0/SHWrlBvCzklik7gznKmnr8kRqFWiC
         f9PFNxYIxlJMah+YYWkop5pV8vSvQS1ZFZn7oUJU3V7je98/vXf1IMRVXclbijjG0esf
         5q0jT/zDSz7nLRS/VIusd/HJK9eQVT2DVeQO9dYebHOzJ5bHGMQUDeMwJ1iP4fsCR2g8
         bifw==
X-Gm-Message-State: AOAM531ymApkXX9FxKyaw7MlNnNJpvtV7Zg3fGLMQB2CAB85LXNcdKqv
        8XKC80nrkg05QGh/4TvOm8o=
X-Google-Smtp-Source: ABdhPJztZMrexjH2//cp4lrbOeMl8JICEYue+8aVELGBn4YT+2wOL1dpO8JU258Rd8LsuoOF8+CIVA==
X-Received: by 2002:a05:6e02:1909:: with SMTP id w9mr13323400ilu.34.1633796843402;
        Sat, 09 Oct 2021 09:27:23 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:22 -0700 (PDT)
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
Subject: [PATCH V2 3/9] dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
Date:   Sat,  9 Oct 2021 11:26:53 -0500
Message-Id: <20211009162700.1452857-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
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

