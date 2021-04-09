Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5C35A53C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhDISHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhDISHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:07:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A79C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:07:29 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id n4so5413479ili.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXhHFiYFF9iWch/VwVE0yX0wx2RhwOIfVPloQrSS3Fw=;
        b=mbNLrHibsxMliMZoSJFoQ2UV3n6ebW6uxI8EsiRIxq1T8yEoj2tw2lr/F+dmsCJf9q
         MaZX2mEMWvID+8xCF1gM8pVf4CZWcW3twZur3Bio1wBIH1pk0jcKm4IfGdGkrjMAAYsh
         SCObZJ+PCmRCwEtG06u2UK3wfRPQUlqV1BpNIvmCMhS9bxQ97rFZc2p69tjKUGUXvxdj
         I/HIsCb9V7hFyWb81WRsbCEfrSIr+dZ7dMR7D/SGRb3VAVOgd4207OEphPQnQMB95pbP
         zHtNrv+Ju3CUpEaNUUGCR+TPbfasSykxI3Fybk2IqS5LxyddmSi+hLIKG9tUyvXmlVO0
         wf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXhHFiYFF9iWch/VwVE0yX0wx2RhwOIfVPloQrSS3Fw=;
        b=K407zmuaD4rblLklm8pDXX1H7Iy1ZL5h4A7cywZUsmp8DJmcm26R9tUgR/iSEqvaJ7
         mORm2elWfUvbdCpATNuYXkGcpl/Us5Jf//ZaP6MJ6m/B3SWshajmY6fimQn059PN8QE5
         XmjKklDMiUmq2dog8iCVA5CTQPR+zLhG+tqh4LCZhPpA2cDnDnG24S5CtQ3dBex8bVsf
         nCmaXh3bbI86j9nRbyVr7QXQBE4VR0tQjm+YbRe0QBwxqfsffnu5TQT2AvRsEZkMj1KQ
         qGcbzF9rApS6sAab2is3kKxwR83VmFaz/pIprURmnK9h+2g/FN6W/9iUa25j9UH5Kr4e
         JtKQ==
X-Gm-Message-State: AOAM531xSGKTetuS3YlEaOLoL0YRTn0GptjXMYMXFbPw4F4L8tCiFWKX
        4zTC+/JmUA3lvSFJ82nSvNCxaw==
X-Google-Smtp-Source: ABdhPJxp0Mxac1torzxQcagsV44T65URh3TaZPLpQ2uY6tbaCoGP7hjX/SL1LsVItI+TOdPC+BSQWQ==
X-Received: by 2002:a05:6e02:1a06:: with SMTP id s6mr11782812ild.289.1617991648619;
        Fri, 09 Apr 2021 11:07:28 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g12sm1412786ile.71.2021.04.09.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:07:28 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: ipa: only set endpoint netdev pointer when in use
Date:   Fri,  9 Apr 2021 13:07:18 -0500
Message-Id: <20210409180722.1176868-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409180722.1176868-1-elder@linaro.org>
References: <20210409180722.1176868-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipa_modem_start(), we set endpoint netdev pointers before the
network device is registered.  If registration fails, we don't undo
those assignments.  Instead, wait to assign the netdev pointer until
after registration succeeds.

Set these endpoint netdev pointers to NULL in ipa_modem_stop()
before unregistering the network device.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 9b08eb8239846..8a6ccebde2889 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2020 Linaro Ltd.
+ * Copyright (C) 2018-2021 Linaro Ltd.
  */
 
 #include <linux/errno.h>
@@ -213,18 +213,18 @@ int ipa_modem_start(struct ipa *ipa)
 		goto out_set_state;
 	}
 
-	ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = netdev;
-	ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = netdev;
-
 	SET_NETDEV_DEV(netdev, &ipa->pdev->dev);
 	priv = netdev_priv(netdev);
 	priv->ipa = ipa;
 
 	ret = register_netdev(netdev);
-	if (ret)
-		free_netdev(netdev);
-	else
+	if (!ret) {
 		ipa->modem_netdev = netdev;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = netdev;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = netdev;
+	} else {
+		free_netdev(netdev);
+	}
 
 out_set_state:
 	if (ret)
@@ -263,6 +263,8 @@ int ipa_modem_stop(struct ipa *ipa)
 		if (ret)
 			goto out_set_state;
 
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = NULL;
+		ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = NULL;
 		ipa->modem_netdev = NULL;
 		unregister_netdev(netdev);
 		free_netdev(netdev);
-- 
2.27.0

