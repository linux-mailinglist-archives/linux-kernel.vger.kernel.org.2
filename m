Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D033DE721
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhHCHSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhHCHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:18:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB43C061764;
        Tue,  3 Aug 2021 00:18:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so1466377wms.0;
        Tue, 03 Aug 2021 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R7jRP2Tedqq+hGXZvKzvn3HLtwG9FjDcSbLNCdl71UQ=;
        b=P3Se55rRFnRiMTcvMOG4AWu1eH1jKzHl+X7kIOhZ1pLxvmpVEGj0UIBpdLT9Gq3S8h
         827ovYguH3iSKTUGWivoX1lBBeo7jP7t9esgetlXlE7k2xZxrA5n+CbKWJbqPmYMpEa1
         lqxzBgt3k+WtQ6r1hQnw8Anaq8bPbOTZ3M1Bt0rTkhsfGWpoiI41JOi3BLBtI8KfXDWn
         drGPNv/3R7xo+BNqURiLRG0iHG2on9gotq4Rg9HphBv7YBfX6xiH5fFDF4spwwuCYLPN
         et8JYlkLWZPkeCfNR8vPWxfUf9+Be0gnbT8gFV9R/e1MAe3XSGzAGh4t+Hhr9nXnAYB8
         PKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R7jRP2Tedqq+hGXZvKzvn3HLtwG9FjDcSbLNCdl71UQ=;
        b=bOpuE9f+XtqF6pHZD8giPGkCz173hiK42YVAEbybUz55W9o57bCBLgRZjhF8w4m3YZ
         MxrqTgruHPeCtnLWx1G/RFdiSK8s6DsXyRbntI9U/LRKXLCmYWaEGsvr9B1jdF+mcsLd
         ud+MpeNlrS9Pzitbtq5aezr3HFuOzo/kcFcaGo0H2aUDA2h0EqIsYMH9cFY4xpLfQqVK
         Ayh3CLr3US/YuO4A6eRfCNmOEEGQ3H4XcJ4TwRSEbtAm1MpIhLoPjJnytMwSWvZyWzfH
         IeFObFTR2GNfB/H81cAVw2OCNhqGw7tGFWE23hqoPlkmoXL8lJWparw3xVP4rWE8ns8q
         Onuw==
X-Gm-Message-State: AOAM531PN38AVVmJUM85Q97yGi/L6ANh+3C97p6wc5EMD6oTowvsZftN
        OFJm3WMbEAlI2AvkHAGOqQ0=
X-Google-Smtp-Source: ABdhPJz15WXfbXnB3Jgx5n8wJATHxTWfIkhJ3CxAInNyLptfe7aFt4GS6wlefW+qxNz8Viwtbd70jQ==
X-Received: by 2002:a7b:cb19:: with SMTP id u25mr2661765wmj.25.1627975101615;
        Tue, 03 Aug 2021 00:18:21 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id v15sm1657301wmj.39.2021.08.03.00.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 00:18:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update STAGING - REALTEK RTL8188EU DRIVERS
Date:   Tue,  3 Aug 2021 09:18:11 +0200
Message-Id: <20210803071811.8142-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 55dfa29b43d2 ("staging: rtl8188eu: remove rtl8188eu driver from
staging dir") removes ./drivers/staging/rtl8188eu, but misses to adjust
the STAGING - REALTEK RTL8188EU DRIVERS section in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  no file matches    F:    drivers/staging/rtl8188eu/

A refurnished rtl8188eu driver is available in ./drivers/staging/r8188eu/
and there is no existing section in MAINTAINERS for that directory.

So, reuse the STAGING - REALTEK RTL8188EU DRIVERS section and point to the
refurnished driver with its current developers and maintainers according
to the current git log.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210803

Philipp, Larry, please ack.

Greg, please pick this minor cleanup on your staging-next tree.

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36aee8517ab0..ef32c02b3e4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17723,8 +17723,9 @@ F:	drivers/staging/olpc_dcon/
 
 STAGING - REALTEK RTL8188EU DRIVERS
 M:	Larry Finger <Larry.Finger@lwfinger.net>
-S:	Odd Fixes
-F:	drivers/staging/rtl8188eu/
+M:	Phillip Potter <phil@philpotter.co.uk>
+S:	Supported
+F:	drivers/staging/r8188eu/
 
 STAGING - REALTEK RTL8712U DRIVERS
 M:	Larry Finger <Larry.Finger@lwfinger.net>
-- 
2.17.1

