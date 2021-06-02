Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7823987EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhFBLWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:22:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52952 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFBLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:07 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1loOvA-0005EQ-Gc
        for linux-kernel@vger.kernel.org; Wed, 02 Jun 2021 11:20:24 +0000
Received: by mail-ej1-f69.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso501156ejt.20
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqpBs4pq4Sjb8nYynK90LyYUsmuWivvDhwxtdT36aGM=;
        b=Qmvcv7eN6cBMX18L6mM5/CHqQKP2EjVnmfsEcHcxoq/qtSsm2Mi93k6S22ep89VKxL
         5HWa0xEJvpBPZ129U5oZbAwf/XXarJSXPWy0JN8hcFYereoClh/H3C/+x5f2OjHnZXnN
         uDFL158x/3Cf2i+3MtmDvpbhF4hE2iZwkdPgJx2QXjLyKdxHpLMzwRk1CbLPUmlxbWH0
         ptQMiO1Sw0gOUqlji39oUR+hA+jufJb2GxSLek64XQK/weYUxc5nO3DlJM2IZR4YpUus
         onpgWMejloKagOFYkJ73/drd5RizNZxf5mAycJ9Zj26AUaMH4iCD2WsqdnO6AylPeWVs
         msFw==
X-Gm-Message-State: AOAM533+OflpfERlNSYNrnoTPSTijxAbAPSUC4PaLsUhwkrKJtROjFrt
        4OBSc/0yU4HPnSo3NbVH7y8yTv8OUBeB9KuTcIhwoy9Fp1QZyOsFW6AsgGoHYYUjaAuq8ijHEp3
        tOUIFZ33fvF2Bz4JHd/h6pnhCB15dZTJ3mDMIht9bkA==
X-Received: by 2002:a17:906:6dd0:: with SMTP id j16mr34042642ejt.208.1622632823958;
        Wed, 02 Jun 2021 04:20:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5uDKKjhvZNChEoO4ybm2CwDwYSd/9CN/DhLa25b0dk8xmRpWdyHyyezW0S/p4r6YRC2Iqiw==
X-Received: by 2002:a17:906:6dd0:: with SMTP id j16mr34042633ejt.208.1622632823790;
        Wed, 02 Jun 2021 04:20:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id jp6sm3699705ejb.85.2021.06.02.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:20:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>
Subject: [PATCH v2 1/2] nfc: mrvl: remove useless "continue" at end of loop
Date:   Wed,  2 Jun 2021 13:20:10 +0200
Message-Id: <20210602112011.44473-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "continue" statement at the end of a for loop does not have an
effect.  Entire loop contents can be slightly simplified to increase
code readability.  No functional change.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Make it if-else-if as Joe suggested.
---
 drivers/nfc/nfcmrvl/usb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index bcd563cb556c..6fec20abfd1e 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -319,13 +319,9 @@ static int nfcmrvl_probe(struct usb_interface *intf,
 		if (!drv_data->bulk_tx_ep &&
 		    usb_endpoint_is_bulk_out(ep_desc)) {
 			drv_data->bulk_tx_ep = ep_desc;
-			continue;
-		}
-
-		if (!drv_data->bulk_rx_ep &&
-		    usb_endpoint_is_bulk_in(ep_desc)) {
+		} else if (!drv_data->bulk_rx_ep &&
+			   usb_endpoint_is_bulk_in(ep_desc)) {
 			drv_data->bulk_rx_ep = ep_desc;
-			continue;
 		}
 	}
 
-- 
2.27.0

