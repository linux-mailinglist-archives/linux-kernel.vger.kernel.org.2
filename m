Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4D03942BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhE1Mnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:43:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42480 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhE1Mno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:44 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboX-0007wT-Ey
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:09 +0000
Received: by mail-ua1-f72.google.com with SMTP id y10-20020ab025ca0000b0290221adb2995aso1858680uan.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFH/OkxJX+1bf3RA1MwdAa7s8lhCFQ3NsGd/fHMtrBU=;
        b=O1NxfxsNQakWsWqh638bUFtxKZy4rSAtapEE4V/KBocR5zXiY5KJOz2zS5Y15u22Ia
         Re9lVjrztrm8CiW4cxXYs5PvBZcO4FrlSCCSqVwaK8o/VKflhrbpx8Xo4VgxpkX4p27+
         8kQ6UXon2cz5PUNN6KVnJIsNKbDPTo/FL84Cazp88YTlzzIRR0awFePLZJkcRR/ku1WR
         kvB0Q4CEf2lbHkCgMwx/ZN5lEdx1d5FZn/DiP/3AK1/DhE3RlX0/5y1Ua8jSDntDlvKl
         /iFOomYeO/7zZ7euDbVeESetIXZY4CRzILB+m7RQ/owESAfaSFoNwHjJ+u5y4b7yCGzN
         t8aw==
X-Gm-Message-State: AOAM533qwesO5md//qYyEckWLAgk9kvSLtJFD/KXmesAu011uorjs6CW
        w5UMWU2Ofpptn2R5Rah3W6o+0r3AipPhT/aZcZZVRhu3zdkdUao9TezYazRr4IGGHgh5QXCXbNS
        HLcOX2L+ZCSgM4yTVz/pi8mXNmntESEtv1j5dGAI5DA==
X-Received: by 2002:a05:6102:5d0:: with SMTP id v16mr7076733vsf.31.1622205728643;
        Fri, 28 May 2021 05:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEVlZcqgPeeaF4dSVhZblaqkKUAk6rrB1qIKVtSVM+CD1gahWuLY4xUCoT2Axwd6Dn2W6LIg==
X-Received: by 2002:a05:6102:5d0:: with SMTP id v16mr7076718vsf.31.1622205728478;
        Fri, 28 May 2021 05:42:08 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] nfc: fdp: correct kerneldoc for structure
Date:   Fri, 28 May 2021 08:41:49 -0400
Message-Id: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since structure comments are not kerneldoc, remove the double ** to fix
W=1 warnings:

    warning: This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/fdp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index fe0719ed81a0..125d71c27b8b 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -149,7 +149,7 @@ static void fdp_nci_send_patch_cb(struct nci_dev *ndev)
 	wake_up(&info->setup_wq);
 }
 
-/**
+/*
  * Register a packet sent counter and a callback
  *
  * We have no other way of knowing when all firmware packets were sent out
@@ -167,7 +167,7 @@ static void fdp_nci_set_data_pkt_counter(struct nci_dev *ndev,
 	info->data_pkt_counter_cb = cb;
 }
 
-/**
+/*
  * The device is expecting a stream of packets. All packets need to
  * have the PBF flag set to 0x0 (last packet) even if the firmware
  * file is segmented and there are multiple packets. If we give the
-- 
2.27.0

