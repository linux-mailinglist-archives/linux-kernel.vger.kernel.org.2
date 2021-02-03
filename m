Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E481530DE47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhBCPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhBCPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:34:23 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA26C061573;
        Wed,  3 Feb 2021 07:33:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ew18so132762qvb.4;
        Wed, 03 Feb 2021 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SI4n9NRZTLZPCM1z1O/Whm3jwW/kVVyz3ohtgppebY=;
        b=ognypTVPaRprx4KGhNMOr7KJW6b8Q5wMYq4duWeFBV/k0DeFRAYmWFSrtezM7Pf9Ux
         8wn4aqcG1QhMbHOz94xAf5Zdc8rISmH3+RylcMY+WrWkR3odFAkI4ZS+sdVlyRtZgYD+
         ebUYKXvCqBl8rsrAQ216jAhA+ktVJawfzVVm8d1anqLY7/dG3CAgv2SMq5dSvMap4p2u
         EvJmKMM4h5tRFoYG/sE2YvayyLlwa31LLEx7XMhuBzw275dXMDpJCEfy2EBJVPqtULla
         MGObkr3rIqehI+UJCzWimvDcqRY7r2oUUMcINkuE2QPmC5BCdIolP8j4rDiSHn0vDHyE
         pbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7SI4n9NRZTLZPCM1z1O/Whm3jwW/kVVyz3ohtgppebY=;
        b=aaw900H8rsJCr97SfKt6moq2NEqeOOZgNzH1aMha2yF50JlXnx++YysDfEP1jo/Qm/
         Bs0nLwCouZvl0FkQa+z7Fnpx9P0Qvqb8HJ+lIsXHQ7/Yj3qzLm76nsdR00xChdaKAY/4
         TVrJ9yLJGkB70p4kTpORFey7GZ1mnbMNyvDy9uvLHFzy6uTMT4AvvdREB8jnS+EDFS4A
         msmgOkw64DwO/nvS6mmz/F6ns7Y4X8J8r7qv6B3NpXP7CousIG81RpCCMRWlX+pTiXi5
         J7/sgaeobAQwSldmrcKWOT7Pm1dyajl+QiiKA0o/wJ8PcPY7+fXvOyqsTPltStUGMFMw
         p+fg==
X-Gm-Message-State: AOAM532OQJmZU4XmlrMNkrDUcr8kgTPEJGt5u88mjlKM7OmW1Sjqemq/
        K9S97bQ6JSdSup8B7Bm6SAA=
X-Google-Smtp-Source: ABdhPJyItEqUqFxjseAE/4OK9GpQnJcKgnx9wwl+FeAa7y9UZjIDftPzycNNXzLn0/6LBWTigj6roA==
X-Received: by 2002:ad4:4e8a:: with SMTP id dy10mr3096084qvb.36.1612366422704;
        Wed, 03 Feb 2021 07:33:42 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.139])
        by smtp.gmail.com with ESMTPSA id c14sm1877515qkl.18.2021.02.03.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:33:41 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] doc: devicetree: bindings: usb:  Chnage descibe to describe in usbmisc-imx.txt
Date:   Wed,  3 Feb 2021 21:03:15 +0530
Message-Id: <20210203153315.15170-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/descibe/describe/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
index b353b9816487..b796836d2ce7 100644
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
@@ -1,7 +1,7 @@
 * Freescale i.MX non-core registers

 Required properties:
-- #index-cells: Cells used to descibe usb controller index. Should be <1>
+- #index-cells: Cells used to describe usb controller index. Should be <1>
 - compatible: Should be one of below:
 	"fsl,imx6q-usbmisc" for imx6q
 	"fsl,vf610-usbmisc" for Vybrid vf610
--
2.26.2

