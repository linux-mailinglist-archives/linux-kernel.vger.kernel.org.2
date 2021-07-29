Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E953DA14B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhG2Kky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:40:54 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34530
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236420AbhG2Kkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:46 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id BDB0F3F227
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555242;
        bh=KXmULC4yNLbjXfZilnwZUymI+qeRnrLMQ/vMczDuSm8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YigS+8QfeZ9cIu40lqUKLt714vfWNx0XN68/ZNwZHyXW6+mXRoRsRjJIYZJubXgCG
         f0e1Ydt0P3HwUr8Fxj53zNmxgww9onUIY6VDUi5plo5tA2Rxq8WKDR7/QXjsjXxQeF
         DDAk38FYvBrbFwdVBdfY138E9QFtLb9aOOAXCy/+io48aKs5e+lQcPwe5cyi+gfcLX
         /8q7tEhRYfy643SeQ5PTL24b11mVeT9cQrzmuxIR86Zj6yuaOPfzbSTZmn74JexdPs
         7rbv7PiD1YskV2VwevqvwKYhVqFLMgYiGeXTUsg8gdtrD1/eqGAtJxDVGpF+byWEUT
         CU1mRDRzhJHfQ==
Received: by mail-ej1-f72.google.com with SMTP id q19-20020a170906b293b029058a1e75c819so1818736ejz.16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXmULC4yNLbjXfZilnwZUymI+qeRnrLMQ/vMczDuSm8=;
        b=GR1iSZuReOI+j3530Rm+Z9m6qnPCdnk1P8hWmisfbuPlVqtbuzJ2seaZyseJ8mWmKs
         1C56Z26DtYTrh8QT3tsCr7Jht15PYv4SwRGS5ZvtdRag73SgF8jNbFZo0askd1YE7Ry9
         ZsBSic3w+i4Yb06FQz04irYbJsyRlPHmYgfkoL1lCGobD/50gSnY0oejfj/sIBS1mQM6
         5acNr3dEnoERfcX3sv2QNcVkbwEcAn1ORu6K8DZ9eJeVut94FIPrbKo9na+DWQRG5sWm
         pt/08VOafu3iLtcxlzzuyl13DIUs4zhkDi1XJRXR8wxd0nSZGXCWi2hqWumobNBhgdVO
         G9sA==
X-Gm-Message-State: AOAM532HWiRvd9eu24y4d1XIbeUY5zuutTq7Y5zzxTG/CM4JljVzS4zc
        pBnGBL67FX+mK06GiFD8eQ3fs69ixqRDr8j8f8+fLUtUq4vZu+gmlfmkKQfXihrOJHW7uGCsOAK
        qil6u7VQ49sCXlWiW4FbF+R+21tZII7IN+9Oc/1/7mQ==
X-Received: by 2002:a05:6402:1cb6:: with SMTP id cz22mr5180753edb.148.1627555242546;
        Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjW5Qyti3uGsJQhjyg9e0Vg9hnF5ajD1dE9uX/LfyH7AIvIxTCmpWZpCLut6Hz/YpkiUBGxg==
X-Received: by 2002:a05:6402:1cb6:: with SMTP id cz22mr5180746edb.148.1627555242430;
        Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 07/12] nfc: fdp: drop unneeded cast for printing firmware size in dev_dbg()
Date:   Thu, 29 Jul 2021 12:40:17 +0200
Message-Id: <20210729104022.47761-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Size of firmware is a type of size_t, so print it directly instead of
casting to int.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/fdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index 3e542b7389cb..650a140bea46 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -276,8 +276,8 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
 		(data[FDP_FW_HEADER_SIZE + 2] << 16) |
 		(data[FDP_FW_HEADER_SIZE + 3] << 24);
 
-	dev_dbg(dev, "RAM patch version: %d, size: %d\n",
-		  info->ram_patch_version, (int) info->ram_patch->size);
+	dev_dbg(dev, "RAM patch version: %d, size: %zu\n",
+		  info->ram_patch_version, info->ram_patch->size);
 
 
 	r = request_firmware(&info->otp_patch, FDP_OTP_PATCH_NAME, dev);
@@ -293,8 +293,8 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
 		(data[FDP_FW_HEADER_SIZE+2] << 16) |
 		(data[FDP_FW_HEADER_SIZE+3] << 24);
 
-	dev_dbg(dev, "OTP patch version: %d, size: %d\n",
-		 info->otp_patch_version, (int) info->otp_patch->size);
+	dev_dbg(dev, "OTP patch version: %d, size: %zu\n",
+		 info->otp_patch_version, info->otp_patch->size);
 	return 0;
 }
 
-- 
2.27.0

