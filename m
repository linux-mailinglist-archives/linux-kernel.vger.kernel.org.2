Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AF3F4A38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhHWMDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbhHWMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C202C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so743488wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCQNOMNyM55BALmAbQOnxmGoDHPEw3FntTC8rnetrBc=;
        b=JMmmGDnOo3PY1Ix16BVcnJO8EwRXCPXX5sP54wcBNSKOh/vdQL3sK+sk98g+wiEQup
         ez3RcbHrhQ/tzeWwXrZs3q60PYo38SLegYLTsgwaDnXbhh73IKI7yxebHmHMMUbmTKKE
         p0LSZYgfKVRUXdc3KfRaBXYYgY0ZajCYh5WmoIaF2b3Fjv5GZOFfrBj/p1i2mIPp5TKk
         1bFFwT/QR/RLNJu2lMNgO1ZEgRfDEgzZUb+YCuAp8crf03P+Cb/2MQLYRr6KWpX+OAtM
         AHYWpQn3CoWBNEFKGh3vibi671p8RWM7bTSrMxlnp8EMg7OotRqrdgLqVjPKwJlkJvoL
         7HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCQNOMNyM55BALmAbQOnxmGoDHPEw3FntTC8rnetrBc=;
        b=XqdMSGMNGITO/34u4W62x6x+gDw0ag6hLH/lvYNq2Vnp5nnf7fMqci3kK1JJvdsHvN
         biBcpwP1cHq5ibxpNWmll4T3BLbzuaHM8KYEP6/TDGOq8LHV46PK4zJdXQejZQqQIysY
         XPaWvfJVZnLpGc3LnpZAHggLmdFbGFjt3mmVpJCtgXgBgwcyq4n1BLYvI3O7J9hzO5Gw
         OpoMJgXOgYxKbVE2oilfxUW4Ruj8mxLJ+xVDF8PZtxaxfRM2h+JsAbXYmY9nmb3tU6E3
         d+7CPCOOu1QscSnDMhlIcXFQVIV0vUW+KK36V+27x4HXtqmPtDdQPVO3JHMYlMTVmzIC
         qtfw==
X-Gm-Message-State: AOAM532w8H5XK8fJ8MMx4kDBKBVWNK5wHFNhD7s8VMWQF8xWoDh+8+TX
        29v4zaahjMY6i5kRIhWrHGk=
X-Google-Smtp-Source: ABdhPJzaVd7Im4aDpIuteTlfOL/2uidMM2lEf0wS2u53VUGzEIM7YpNuzG7PdC/8d9JSHFHX3A3kVw==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr16177352wmj.144.1629720140916;
        Mon, 23 Aug 2021 05:02:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: r8188eu: ensure proper alignment for eth address buffers
Date:   Mon, 23 Aug 2021 14:00:59 +0200
Message-Id: <20210823120106.9633-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823120106.9633-1-straube.linux@gmail.com>
References: <20210823120106.9633-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __aligned(2) to eth address buffers in structs rx_pkt_attrib and
pkt_attrib to ensure proper alignment for usage with functions from
<linux/etherdevice.h>

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_recv.h | 10 +++++-----
 drivers/staging/r8188eu/include/rtw_xmit.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 81594e7aed51..1b41f8d7d079 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -109,11 +109,11 @@ struct rx_pkt_attrib {
 
 	u16 eth_type;
 
-	u8	dst[ETH_ALEN];
-	u8	src[ETH_ALEN];
-	u8	ta[ETH_ALEN];
-	u8	ra[ETH_ALEN];
-	u8	bssid[ETH_ALEN];
+	u8	dst[ETH_ALEN] __aligned(2);
+	u8	src[ETH_ALEN] __aligned(2);
+	u8	ta[ETH_ALEN] __aligned(2);
+	u8	ra[ETH_ALEN] __aligned(2);
+	u8	bssid[ETH_ALEN] __aligned(2);
 
 	u8 ack_policy;
 
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index e1418a3f7ed1..5f6e2402e5c4 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -122,10 +122,10 @@ struct pkt_attrib {
 	u8	ack_policy;
 	u8	mac_id;
 	u8	vcs_mode;	/* virtual carrier sense method */
-	u8	dst[ETH_ALEN];
-	u8	src[ETH_ALEN];
-	u8	ta[ETH_ALEN];
-	u8	ra[ETH_ALEN];
+	u8	dst[ETH_ALEN] __aligned(2);
+	u8	src[ETH_ALEN] __aligned(2);
+	u8	ta[ETH_ALEN] __aligned(2);
+	u8	ra[ETH_ALEN] __aligned(2);
 	u8	key_idx;
 	u8	qos_en;
 	u8	ht_en;
-- 
2.32.0

