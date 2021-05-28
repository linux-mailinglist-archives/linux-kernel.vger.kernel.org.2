Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83463942DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhE1MoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:44:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42516 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbhE1Mnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:52 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmbof-0007zD-4g
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:17 +0000
Received: by mail-vs1-f70.google.com with SMTP id v27-20020a67c89b0000b02902227f70aa8fso951236vsk.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1E8+lV2yYHpfQvRilUCcibqrpA4/S/5sauZ+Rzzh9M=;
        b=njaB/PP4zfBiTrJuPwrcfaFtvtmbI9vl5nX8sIW3UvMnHltEH1M2jYyPga+0MaVpKn
         Kk57kX2n/W/jw0oy4gkkONwiFEmyQ7v3dp/iKnoK/ZXGe33C6YQhg7437RAvz/e64U1N
         ejl53EH4zAzzYJYm/95esQvpeZhNJ8lRGja0InZDjSKsRbnN071KghK7tO4P3QVFhh3Y
         PtR0IVk3q4ZRltqJuTT5mnDgrr8PvcVGXwGCI+KizffHoTdUlAJ5H+SYMaPCw3fyOWEl
         hdo4HoALMRXCOrLMHMev99d8ceovirQt6g3IeLhAudyJzdWrNeBvvHmuHigzdLpQSI4f
         LN6A==
X-Gm-Message-State: AOAM533ZfOWrVG+DhUgVuZk5YyPFsjEwcKvWAznTfcKy1N5GR97po0Ul
        c5FNQSjj06pquwUFVI6rLzofNknz77uAr+95XISiAse+sBa0yrnn2O81MRqMWOUsjEu/XwtGyM3
        HaVAaW9EkqYuQy7wSy3KkRBtZWepOwiBiSqqyDpGlfA==
X-Received: by 2002:a67:ef94:: with SMTP id r20mr6640877vsp.36.1622205736335;
        Fri, 28 May 2021 05:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc3my6SxlXZaZfhHX7W+xfeFllcqLbI3WOn1B07accNkRCVFE7nIIADJby3arfB1ew53uXBw==
X-Received: by 2002:a67:ef94:: with SMTP id r20mr6640861vsp.36.1622205736180;
        Fri, 28 May 2021 05:42:16 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] nfc: mrvl: skip impossible NCI_MAX_PAYLOAD_SIZE check
Date:   Fri, 28 May 2021 08:41:54 -0400
Message-Id: <20210528124200.79655-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nci_ctrl_hdr.plen field us u8, so checkign if it is bigger than
NCI_MAX_PAYLOAD_SIZE does not make any sense.  Fix warning reported by
Smatch:

    drivers/nfc/nfcmrvl/i2c.c:52 nfcmrvl_i2c_read() warn:
        impossible condition '(nci_hdr.plen > 255) => (0-255 > 255)'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index bafd9b500b2c..3c9bbee98237 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -49,11 +49,6 @@ static int nfcmrvl_i2c_read(struct nfcmrvl_i2c_drv_data *drv_data,
 		return -EBADMSG;
 	}
 
-	if (nci_hdr.plen > NCI_MAX_PAYLOAD_SIZE) {
-		nfc_err(&drv_data->i2c->dev, "invalid packet payload size\n");
-		return -EBADMSG;
-	}
-
 	*skb = nci_skb_alloc(drv_data->priv->ndev,
 			     nci_hdr.plen + NCI_CTRL_HDR_SIZE, GFP_KERNEL);
 	if (!*skb)
-- 
2.27.0

