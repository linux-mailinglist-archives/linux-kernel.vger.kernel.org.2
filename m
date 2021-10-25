Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9952E439925
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhJYOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:50:56 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51450
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233485AbhJYOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:50:20 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8EDF63F332
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635173275;
        bh=NUqLZxU+ETk1A/0vgN0aobJH+DUj6dc03Bn80L2dseI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jOVK95wy48uN8jEHTUsC7zESOq8CFcquyE1YE+NK9S2t0yW2RSi1S0OZrUQhD8tDq
         pbCmB6XyaCZVTL78SqxXx8hpn7wpDUPA67nQ1t72qSVUhM+kYbYTU4tj+hwS+R3Se3
         SnzQW+yLTroWC/YpPz5m2MihYI8dx1StaE30NdtUO336fQSsB1a9sM+wDOUzL1FCxQ
         eCKplzfdm+goe6c0q4dOtXkScEusy1BQc1NaBewNy/wSu8bzvfkcNpts2JCxM+EemE
         PcGxoWVj3CzDQf/Dn6hmLd1mllTn1cXguldQQCl5rFLl1zy9EQdYv9C0bM2S+nQFaT
         RUDimQn0LiX6Q==
Received: by mail-lj1-f199.google.com with SMTP id w9-20020a2e9989000000b00210af61ebbdso2871717lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUqLZxU+ETk1A/0vgN0aobJH+DUj6dc03Bn80L2dseI=;
        b=lIzT22evDQy+G691iyox/R1JOsrYo6Z2C22h7FDwV1B6mObG+H0dNExEBOASvBsDjL
         cd0/BB9lNi8k1ZU1oeko6KIsmsxgRQcbS4NpYvvYcb8ub5Spey2Ogl1ti3PshUWhQvfS
         KLMcYWGm/MQjXrLQIZ1FcrQewrnqJv7LaFpt4jZx+IMIiD3jO12+zrE7xTh0ccpnypEe
         HjkV5giA7P6J6xxR6FgpuMxwgdlnKokBrgnpZit/Ri+yEhN2elrnmE0LcmludOuzCxJh
         2JpSHflh9MQclNm0nlTg/rU+AjA7nppsYJx+Nf3FpMyTuxsqvyCCzGjki7Zw5faU6bkB
         gY3g==
X-Gm-Message-State: AOAM530wxI2odQ6lZ2hcmWKBTU05l/Wr9WvqgvxScL6B0V1O2omjmn6J
        IxZ92nTgy0yr4on25JWwPp1glo8sOktHnSrijVe6IZEvpFtRpLdkrOP99DXAj4HesQRJ7j10UtY
        hFBLeFLfPS/yrRe0f9/0aYWey95JS8m96lylYyp7Peg==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr17209815lfd.330.1635173274962;
        Mon, 25 Oct 2021 07:47:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUji5AP34DKoiisxlbORPMw/PjYNY6RglMukjmgVGmeTMdxfjMOwhZDUsizlxDHiW1aa+/0g==
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr17209803lfd.330.1635173274797;
        Mon, 25 Oct 2021 07:47:54 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w19sm1757832ljd.84.2021.10.25.07.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:47:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Escande <thierry.escande@linux.intel.com>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] nfc: port100: fix using -ERRNO as command type mask
Date:   Mon, 25 Oct 2021 16:47:51 +0200
Message-Id: <20211025144751.555551-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probing, the driver tries to get a list (mask) of supported
command types in port100_get_command_type_mask() function.  The value
is u64 and 0 is treated as invalid mask (no commands supported).  The
function however returns also -ERRNO as u64 which will be interpret as
valid command mask.

Return 0 on every error case of port100_get_command_type_mask(), so the
probing will stop.

Cc: <stable@vger.kernel.org>
Fixes: 0347a6ab300a ("NFC: port100: Commands mechanism implementation")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/port100.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 1296148b4566..ec1630bfedf4 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1109,15 +1109,11 @@ static u64 port100_get_command_type_mask(struct port100 *dev)
 
 	skb = port100_alloc_skb(dev, 0);
 	if (!skb)
-		return -ENOMEM;
+		return 0;
 
-	nfc_err(&dev->interface->dev, "%s:%d\n", __func__, __LINE__);
 	resp = port100_send_cmd_sync(dev, PORT100_CMD_GET_COMMAND_TYPE, skb);
-	if (IS_ERR(resp)) {
-		nfc_err(&dev->interface->dev, "%s:%d\n", __func__, __LINE__);
-		return PTR_ERR(resp);
-	}
-	nfc_err(&dev->interface->dev, "%s:%d\n", __func__, __LINE__);
+	if (IS_ERR(resp))
+		return 0;
 
 	if (resp->len < 8)
 		mask = 0;
-- 
2.30.2

