Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96FD445713
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhKDQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhKDQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172FC06120B;
        Thu,  4 Nov 2021 09:18:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e144so7551588iof.3;
        Thu, 04 Nov 2021 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nykwHbMJSb3jIpYbl39RbFllqV3tdrxrztc8NuaqTc=;
        b=Y8fFSG9lyVDSOuwpjQVpYgeia9xkRyGyn9BhPkl4TClcmYxWehyN3bEgpZ7+mBbVqU
         y6QgYZ9CuSk0+M1aIeYj9hCisZ37xjbLGpYX/Jz379TkDnkpOi6Jg4CoYnNMusXTz3Ed
         nbdUrovIBaNasGvv9wKSotJp0V+glZR5tu2nHCeKt3W/DhQV0HmJsQILSrAHpNZ2wfrz
         EHbl7dBkJIl5y8m6Po0carrI0WWhpRZoyCZTJ9pCK9JqEUXdzLpYP0GkdQsn81H+X3n7
         JNxYn3ULvVIqqa70w/2ZPIUa5avGZ1AXXXJv1ItrsRiM9GrfNNMJog29zSr7E2X/W2QH
         j7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nykwHbMJSb3jIpYbl39RbFllqV3tdrxrztc8NuaqTc=;
        b=F82dinLqWsN8JdblLJRTjmTSNCZs02O//xhy+XBYgKYBCtzimZUFEq3kj7ozmsO0Fq
         yMRJJwesuHZMz9vN6cX6kGkRxepXQIppBHl55oB30KPsmGLEv7a6yP7V+AuuxRW3n8bm
         0Jh9sS97BOa3UNLaIJpwNjo7MhPPG8GCJAJ/zHRvZZ0H2varaOIOFvse1/4WMonxI5LW
         iaGhwC6NHRpTvLvcdVay3En7GYWH/JkMoUHP5e1FEmhbgwPnNABbnpFrBJb8YtmZkdlN
         YktAIteJA/S3tSmMbjQronVJyNPzczumP2WLEJOf0CCo6H5em8f7VrgdvKLOE/VlK4A1
         83Lw==
X-Gm-Message-State: AOAM530/DPAV+OTnOp1Xqsi7900Nqsb7+mLFwrFM5WH5hZubPBpQIU+Y
        4/QYf0nAA9/WWitTERDLbfY=
X-Google-Smtp-Source: ABdhPJw2eSGb+4IR/QWTYIJuwBIaYtjVT/gjiZ0g0VKV1MM/WdxEJv/MLHX3hCc7B7qy+GZN0myqBw==
X-Received: by 2002:a5d:8903:: with SMTP id b3mr38383017ion.44.1636042711498;
        Thu, 04 Nov 2021 09:18:31 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:30 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/9] dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
Date:   Thu,  4 Nov 2021 11:17:58 -0500
Message-Id: <20211104161804.587250-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the defines for the power domains provided by the DISP
blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>

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

