Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243AE3124E6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:03:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA905C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 07:03:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g10so14160916wrx.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcBq0RthQ+DH5oBAwj/q8W+Zfx6c0uwKy0XjB8s7FQs=;
        b=IdngARiMdpdlWWUR/BDwTzP3drGjZt7O2CWXYyXNPyGHdUJGpOfG+X/7R0/Nth2eMR
         P38VTG5vwtOtLmzdy8UHjS66QQxi3w8F7CBWATU9tL97vFV+h88ITXt059ntVpwJqKrO
         z93RyQBVNnn86m27ZfKYJircLv3uB6HIGwE8kmC3yidQzvSGWk5obCnE0tBv/ZEhM6A0
         BHqkGiMATMmE5As+uLct3P2XXg9YPaGXqtkU4ikO79CRGxTBZYnlqwxYIvqTPnOwEriN
         qvYCWsb0zO4UXpJgj+tRXP/C2nksY0uv5VRGgJyvyAxUsr23R/W5tKwvNbC9LMJo5tFx
         Or8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BcBq0RthQ+DH5oBAwj/q8W+Zfx6c0uwKy0XjB8s7FQs=;
        b=mRwGVUSDaz0/E7wf9OriAnEqegklfLlpm9nufiOIzr3pg3KOC89XiHb+jSoGs3tImJ
         N/gFud+AMGG+ZVa5pqiBrJqG64NrpBk42WOiIn2h2odKNDWPRZiTFOcTdt8+k6Vvqgsu
         AWaqmLCsfUzzMz4nQPAmpCWBGSMEYS23lwVFYRj0TLknZbBzuHSSVLqULljenRvWJbkO
         YtpYTmWmbC1wyUcLZp2d0djAyZdCiajzO65h4HccoRstOpPx46d60HgMpXvba+xhXMvS
         FW+cJMNMTv5hB+W1/BYurdzNxYPMeNGKKrY9rQ5mJOLuk50R42/7HL75U7AwuBOKubFe
         ltVg==
X-Gm-Message-State: AOAM533cXIbWvEaJkdyxmGFikx8rd7vmesXpCtre8D7xlN3M2LwwZipM
        RfnCxqebS1+Xez8PDUax9YnazA==
X-Google-Smtp-Source: ABdhPJx2DXTZwjRWKZsLX13Q/lcGpNBQFM47SFtQWrrAtDTxiHCWBTWrgz0B290oVCEAzVDprYDdig==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr15481546wro.3.1612710185307;
        Sun, 07 Feb 2021 07:03:05 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id z6sm4599925wmi.39.2021.02.07.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:03:04 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     alexander.sverdlin@nokia.com, andrew@lunn.ch, davem@davemloft.net,
        chris.packham@alliedtelesis.co.nz, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: octeon: convert all uses of strlcpy to strscpy in ethernet-mdio.c
Date:   Sun,  7 Feb 2021 15:03:02 +0000
Message-Id: <20210207150302.88560-1-phil@philpotter.co.uk>
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

