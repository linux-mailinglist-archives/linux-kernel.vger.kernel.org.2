Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB832A6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838972AbhCBPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351198AbhCBNgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:36:03 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F25C061222
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:34:41 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y12so11009930ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trttDswvIhw2oDhe4C3a6PzGyGhkWdNUCZs/hbkrosU=;
        b=kA0bv1fdcuJE5OD4Ch0Xe3/9GlOQhj9izk8RaMMbxY7NuDsOcPSvU1XulaCJQF4TOw
         BZ0S/hEDI+Ag/y+OEOwKNL1T+gZ6Npq2lDmDs/ABA6WLOJCoO2MHDZFUoaUhjMWHkgBn
         TvlYq8/uELxO3YX2gAEMkpnJGwaxdOo0EjzCTcsDmSA8Vm6E8IsRSiJ/d5gnKGWOQuBF
         XlCB6FePI7UXzXU21pvqOt14nlAhiIvscewHL5gcKz46rgZ4EabCUxBGdLI8w3r6E6eq
         qM0DaDd76MM+lLbpxbagWYepW8qa7JCDcxfBUn0iarE70/Gy4lbUN0aeK0B/QDUbWqJl
         RcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trttDswvIhw2oDhe4C3a6PzGyGhkWdNUCZs/hbkrosU=;
        b=nX8MA3qX/D5sFltOFoeSrNXWlUOZLln7pNaUvZXiN6KPNYz3svZECCtDcPFni0y11g
         cL4ha6UgOcJA1rYgmqu09wCChmyDtwhBzImzi+GcAla/zPas6cvco2+tWwni4rem/JKv
         1YnkhZ/2FW8qENYoKEmmSJY59vu3sg18Hx9lWEkej9kgvpfcoF4T9CeKqr4pyXaXCy83
         4LGbhL8xaflc1u0L1YxQqBE6Tp0tTDswUMz0RN5ufoUf76SGp1GGmodUOJ3YnmeUf/5C
         +uuCzgOfJsOdOFru3VibzApIt23JKwUHzrUR4b3vpZ8s5R3WNKxe1XaGNk1KIddCLgFd
         LVMw==
X-Gm-Message-State: AOAM5326RXzrF1Q70KZvvFIDtZQf6MXiW5TPczAyGbTdtuYGXFixtGlE
        osZEtYKfT4JEbU2Rtjrqz1E=
X-Google-Smtp-Source: ABdhPJxSNaI2fHIJG2oPtipihm74JWCeKU5GjFEkhJDXuPSc0+PkRrAdK7z/Czosp2hPguDnE2WcEA==
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr12212234ljl.257.1614692079637;
        Tue, 02 Mar 2021 05:34:39 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id s5sm483782lfd.284.2021.03.02.05.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 05:34:39 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suraj Upadhyay <usuraj35@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: remove redundant variable shadowing
Date:   Tue,  2 Mar 2021 16:32:17 +0300
Message-Id: <20210302133217.145994-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rtl92e_start_adapter() automatic variable 'i' referenced only
within certain loops, used as iteration counter. Control flow can't get
into such loop w/o 'i = 0' assignment.

It's redundant to shadow this variable by creating scope around loop.

This patch fixes the following sparse warning:

warning: symbol 'i' shadows an earlier one

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index ff843d7ec606..8cd085ebea81 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -800,12 +800,10 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	}
 	rtl92e_writew(dev, ATIMWND, 2);
 	rtl92e_writew(dev, BCN_INTERVAL, 100);
-	{
-		int i;
 
-		for (i = 0; i < QOS_QUEUE_NUM; i++)
-			rtl92e_writel(dev, WDCAPARA_ADD[i], 0x005e4332);
-	}
+	for (i = 0; i < QOS_QUEUE_NUM; i++)
+		rtl92e_writel(dev, WDCAPARA_ADD[i], 0x005e4332);
+
 	rtl92e_writeb(dev, 0xbe, 0xc0);
 
 	rtl92e_config_mac(dev);
-- 
2.30.1

