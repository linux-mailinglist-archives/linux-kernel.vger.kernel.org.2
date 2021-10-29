Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9C440501
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhJ2VpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJ2VpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:45:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE67C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 14:42:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r2so9162922qtw.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yf6d4tFUMz+8SkZEpTdu+gxrEQvTmfREX/srqZ/vu/0=;
        b=GkcQfGnIqf26srXIX9vcdl6z1nhqOZMDJiR24QW5WWc+m3GzKjkVxNl9PJxo1lelxZ
         NnjMbgOh1rkdXz3X1wSBsSJYnEpdTsjS75XE26qCu/WN1aPRK3HjWUI3841eKqh4nTBq
         vJcPmDWn8kjNmXeEivXqS4SxwgOCbywnlRnGgg6YjiGdiSviFz5KbpgzNVtwSkViNs66
         BIJUV5pTsR7l5qgmrq03t8waK62M3nendgEpze1OQd8cenq26NFmR4KCxTwWeKrvTaZe
         bsanw8QyI5tveWECRIk8x6+qBBGzAvC8Wfg7fdOQo/4f5EbPJo0c7lACqtPoMcop7PAa
         nx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Yf6d4tFUMz+8SkZEpTdu+gxrEQvTmfREX/srqZ/vu/0=;
        b=CINTcJ9oUL6YxI37os6v3JMnIHewaoEOomTOyxcGGs4YY+fCdt7iIqAjEqGJavKjC9
         ig6lwfLseAscZ6m5rd+lBkHrdhpkclZVMGnapflp9SXG/fR01z3MrkXSflNI3HMgz1aB
         BxRYBegGuQuCamOLegANE4WjPahy92IxWF/htRNFHJ1bnpISdzW7HVqoQNcC6jpyfR/z
         n8/d6K6vt6XdB8ktWh8VbNkPZCiJBKopKx+TxHEdMl4cvDZ4rS/sB2GRKNl5J806K/xj
         RQgGr4lkkNS9p1jpRTLm3OpkgTuARu/y37s8df1DTIQbvr+FuvPOwjRUEV5FddnxC2Kj
         I7HA==
X-Gm-Message-State: AOAM533BnfbVPPIlorbUZ6cECuUtE8eCSL1dOKr0dZPddXKJtGGyWhjB
        q2e3scn4dW325jVCgmfEXg8=
X-Google-Smtp-Source: ABdhPJz4CusR5kP4o08FRFyFWwgEIzwehzVtdZx/ajcMJGCs+E01cLEY/n04jG7cPXGSf+sbhLcieQ==
X-Received: by 2002:a05:622a:1441:: with SMTP id v1mr14827659qtx.45.1635543765601;
        Fri, 29 Oct 2021 14:42:45 -0700 (PDT)
Received: from ubuntu-mate-laptop.eecs.ucf.edu ([132.170.15.255])
        by smtp.gmail.com with ESMTPSA id q4sm5212760qtw.19.2021.10.29.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:42:45 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, fabioaiuto83@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] staging: rtl8723bs: fix unmet dependency on CRYPTO for CRYPTO_LIB_ARC4
Date:   Fri, 29 Oct 2021 17:42:44 -0400
Message-Id: <20211029214244.17341-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RTL8723BS is selected, and CRYPTO is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
  Depends on [n]: CRYPTO [=n]
  Selected by [m]:
  - RTL8723BS [=m] && STAGING [=y] && WLAN [=y] && MMC [=y] && CFG80211 [=y] && m && MODULES [=y]
  - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]

This is because RTL8723BS selects CRYPTO_LIB_ARC4
without selecting CRYPTO, despite CRYPTO_LIB_ARC4
depending on CRYPTO.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/staging/rtl8723bs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index f40b3021fe8a..f23e29b679fb 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -4,6 +4,7 @@ config RTL8723BS
 	depends on WLAN && MMC && CFG80211
 	depends on m
 	select CFG80211_WEXT
+	select CRYPTO
 	select CRYPTO_LIB_ARC4
 	help
 	This option enables support for RTL8723BS SDIO drivers, such as
-- 
2.30.2

