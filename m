Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80A3F7749
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbhHYO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:26:38 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60336
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241569AbhHYO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:26:35 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 359864075F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629901542;
        bh=dWQld40HyyuNpw/n+LSy4FsBoxLQ4dmEUGnFzO1qgBs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=q2LiEPDCrhumr2PIp5St7d+Xak8KLY0KqjvZYJmlNucM34HFc/aPqByx8eujWHh7y
         kbf2HTYXH+6gBcHChms3LUz2pT/RHjbA/5G04Xf9UKTdAyfJOHj/qFoVGhXXtTxJJJ
         mhgxzQfTjtQoteIT2xg3MYiV5GpIwwuLqM2l8kXDGZOp4F1V8birxO88EDIywJi2I7
         p2kWIYjp3QHawU7xlIDId+seYJD6bGmwME69Al3FsAG02ThTx9uY4hBL0UC3nE9fle
         VIOqzAzzZzn1+h7zOEsAUJsFTeAD0bnasmesE3K70F2Wraxeudmvv4F6nUzdpNBqLa
         e6Bwb2qmq7RsQ==
Received: by mail-wm1-f71.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so1904733wmr.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dWQld40HyyuNpw/n+LSy4FsBoxLQ4dmEUGnFzO1qgBs=;
        b=KgfC46wUpGdJdZdP21JjOR/uPTs9WGAj49zmAce/l1Y8SFXqR9OyMW+8c1rAOQqSpA
         eSygA3YVGoIr4Sj9ZF6hU8+C4l2Eub+lYWO07HCzF+zJaDM2NkjSarZyvrw1ujrO5HU5
         FDEUrYge0uXUJj6tDVwwnyjAHhM0p+1evDGBhw00k/d+2sJduNvbQWttOeQ+BeYAMC2r
         +XgL04CBpBEUSHElQQMEZmsPjyY9731eS3cjAbvUtKmf24Xg71TyCouWMIJY9UUUS3lp
         zFAtJ+OOwCgjGFRZipJTIOoO4PEduiKLHE/4KDBlhi8DisFrKaK9JP0l49VDqTs104mj
         9nkw==
X-Gm-Message-State: AOAM532imsVQhQXLRJsAYBe61EulBRneSRxmbeq5jf49qAsphgwvXpZ3
        MGrSB1bMDYxYCUyJ5EIHdJX3iiKguA9V3PeTF7k/B4ftaI4PNudoZQm3TSSm3YXMUZzCk660Mul
        Sf+dKyVYAwJeVRO1hRC4nk5LueovSJBl+hH5+9AAXYw==
X-Received: by 2002:adf:e702:: with SMTP id c2mr25237467wrm.397.1629901541927;
        Wed, 25 Aug 2021 07:25:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj7bYleGjuqJyKTtF7fT9/tz8jCKodiT+pN+DKFXdQTP4xquIQjc6L3KH5sb45BRycXVFuEA==
X-Received: by 2002:adf:e702:: with SMTP id c2mr25237449wrm.397.1629901541768;
        Wed, 25 Aug 2021 07:25:41 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id i68sm60375wri.26.2021.08.25.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 07:25:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] nfc: microread: remove unused header includes
Date:   Wed, 25 Aug 2021 16:24:54 +0200
Message-Id: <20210825142459.226168-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include unnecessary headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/microread/mei.c       | 1 -
 drivers/nfc/microread/microread.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/nfc/microread/mei.c b/drivers/nfc/microread/mei.c
index 8fa7771085eb..8edf761a6b2a 100644
--- a/drivers/nfc/microread/mei.c
+++ b/drivers/nfc/microread/mei.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/nfc.h>
-#include <net/nfc/hci.h>
 #include <net/nfc/llc.h>
 
 #include "../mei_phy.h"
diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 9d83ccebd434..bb4d029bb888 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -15,7 +15,6 @@
 #include <linux/nfc.h>
 #include <net/nfc/nfc.h>
 #include <net/nfc/hci.h>
-#include <net/nfc/llc.h>
 
 #include "microread.h"
 
-- 
2.30.2

