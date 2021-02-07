Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E924312500
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBGPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBGPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:14:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B84C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 07:13:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c12so14127076wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npRGieRx9sN3XQp2RVyJRR7pkmet7/uPGppQEGZDlB4=;
        b=EqNn9rwsbaNP7+lnW2sqiNUYVz/vSv4k8Xbi6qeAv8QyrdJz+iAL4XXbwLatza97p7
         8ZGNdMvlWG52oklrD7WzTTjs5QPK4el0yw816PwiIycAqxvAZZRYPjg8RgueXDlqa+rg
         3nBdVt3zrcKMtlgrPUVAb9sJF/4gftMuIIMG9PO9gZlthdkAf2/g/oeGNZKUkGxYVzGk
         vySsboz1sN9v7HOxw62WGfcB2Tfk7FfMSp72iXTWtxtKHQzWBVkVjoAwmA1DAcpgyb4x
         E/dE/NfJZSLK/YbfifuJrdcuX8mNRVvGL1JQ87noM+Kd6txAJLYJOWXOMZ++ilThuJ2k
         zong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npRGieRx9sN3XQp2RVyJRR7pkmet7/uPGppQEGZDlB4=;
        b=gE09QpWO5OakbqxGdyWvZsA0MrKJTvNFV21QA9TF8ieEyJjXL4BMjnFxCW7y9TtYkp
         L39IZd+aB1Ara2h7xVlOoTFUEhyWVorm9z+IoIwysNhXnwMtzyoedFCkgn2pqJIIOajH
         +0UznQ0gkjhvgukLXBEYANEghmMeP23Zg4/w5kiWqUtCDQuVaZcBTVb+ehIkhCV+mbcw
         ynYbaYtn/G1KSxYM3rMxeqvC4/kIs+WOXb58ZdHYq+n4twqR22b8YKj8p6z5aDZMcJIE
         A61DcYjI7gdv1T25HzA7L3Igd8xM0sRlyj/woGv9UPSm4qzvkzCtdaU0Ay7d7UNo2bpb
         WMkw==
X-Gm-Message-State: AOAM530noqYxJNTSuQ74afowcutDgVGcjaiPh24u2Y2EakOfs/9HqmcY
        9+LRTy7xbR61I3f/cACBkmfWcg==
X-Google-Smtp-Source: ABdhPJzyM7/V6H9r/1lycXwLEBnu1XJfn3RmQP0Xfnhdi2nB+rKeGHf5/nzguZHBCmGqoiFCzXxnTg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr16184510wrn.382.1612710804660;
        Sun, 07 Feb 2021 07:13:24 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id j40sm4855105wmp.47.2021.02.07.07.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:13:23 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     alexander.sverdlin@nokia.com, andrew@lunn.ch, davem@davemloft.net,
        chris.packham@alliedtelesis.co.nz, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: octeon: convert all uses of strlcpy to strscpy in ethernet-mdio.c
Date:   Sun,  7 Feb 2021 15:13:20 +0000
Message-Id: <20210207151320.88696-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert three calls to strlcpy inside the cvm_oct_get_drvinfo function
to strscpy calls. As return values were not checked for these three
calls before, change should be safe as functionality is equivalent.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

v2: Modified changelog to take account of feedback from Greg KH.

 drivers/staging/octeon/ethernet-mdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index b0fd083a5bf2..b3049108edc4 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -21,9 +21,9 @@
 static void cvm_oct_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strlcpy(info->version, UTS_RELEASE, sizeof(info->version));
-	strlcpy(info->bus_info, "Builtin", sizeof(info->bus_info));
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->version, UTS_RELEASE, sizeof(info->version));
+	strscpy(info->bus_info, "Builtin", sizeof(info->bus_info));
 }
 
 static int cvm_oct_nway_reset(struct net_device *dev)
-- 
2.29.2

