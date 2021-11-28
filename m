Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E3460673
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357769AbhK1NYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352670AbhK1NWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:44 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15831C061757;
        Sun, 28 Nov 2021 05:19:22 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z26so17499084iod.10;
        Sun, 28 Nov 2021 05:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN96dL5YplMiKmEGlGf3FGBjDnxSQTuGd03P+j6a0hQ=;
        b=Vv94NLs6jz7C6qUwDAuDla1Bd9orUTGrNoVCMIBzo6+NUfsa8ixQjHTu25O9qAeBks
         e1tcv/lVUuz/6TVVnmjn7Yoelp/OXRbNqb8Cy61r2DKwaGyin3sVCdRl6cP/TY6umu8D
         oo7Dipfa5OOTJ/oJNqsP8E5o+bgP44k2e0nKMJrwwoQyMlIArh1YlgExgAv0f4npD7nZ
         djO26RLlswAVembmjQDdFk9oYX4hoa/Yv656gVbbuoBZZlcANdQ9oshkGI3NOhyu1dTJ
         sWHcdQSQS1ZcgTS6YeOiBG/DtaOTACcbrIz3Siooo1kbKB3/1CUwVrwbwzBtpt7YF/2v
         TAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN96dL5YplMiKmEGlGf3FGBjDnxSQTuGd03P+j6a0hQ=;
        b=FwxCBVE7GoaIEWNm+cKceg+NImTZCSOdJyrB8xCTByI/y+82+lUz5ai5GeogwZTPHJ
         3K7I7MUnsc8GfM+rlYOyOOwfMQFvY0APuE3vMYm8Q8HmWiAAlbwKorng8MBP1fkwWTRV
         Ho02/uE8/eLDr6bHx6xafD10eZjYMUmKA99ky1u3dpx0+ddf6Yfwz5iLcenyCkV76vPA
         T3Iij62TdXu3gbdrSsNi/u3lq0/Ilm5HWJXh4XbH/FpMwErgMMyioY+L7jhixdWbFsff
         9dC53gIoQAY4P21jTCu5uL3zAelRj5VQ2rG9C583kJrjnp8sO+gnYKXZIj55Z/X7u6si
         h3sA==
X-Gm-Message-State: AOAM533cpfZ5d3UAx08FX2g49vZ4W/GNuEiAC2ymP6lnnZ5wqZTfN8QY
        Sb2STNIF4IxXHDZqtPxfdq8=
X-Google-Smtp-Source: ABdhPJxac8kd8EAMq/7yYTmwBTkfLi6XOc6Wjj6A+SF0UtYQ3eXlJ/DD/6odRXMMcEBlbkU7H8HxiA==
X-Received: by 2002:a5e:d502:: with SMTP id e2mr54969904iom.118.1638105561374;
        Sun, 28 Nov 2021 05:19:21 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:20 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/9] dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
Date:   Sun, 28 Nov 2021 07:18:46 -0600
Message-Id: <20211128131853.15125-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
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
2.32.0

