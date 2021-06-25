Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205123B3A03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhFYALl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhFYAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42EBC061767
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r7so6232818qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtxaWROpfO0bcAlJuni6gQt7KMZIbHvkYw12HLaO8Lg=;
        b=Z3tEldslfajBlOBIvZcga1zFWstbQUobxVYa2w6QENTLa5R84xxlLWDyCTJE/WqOX7
         0s6RgLxbYiA10yc68rUQ3BVxni90/MPezY4+CohHWPEocwNe3GhrNId9sxVJWaGeu/UO
         mZe2DZQ4Xlw6SNrDYrPugPK/HcP/G6GVCM05muX1HTRud0edL/e586uKp8E9H2K/xmU7
         LW6+xeLwA1Tmg/PDaWSfHxOzGKYPoVeuUuvUlRy16O1OuODiOefwNDxBo50b9+2p1RYV
         sCMR3IEHNcN/E6r4BFvF/g5llgQ1hznQwCt1USj5+GaM5F1PmtyEtEXaTC9ek2POI7h7
         xAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtxaWROpfO0bcAlJuni6gQt7KMZIbHvkYw12HLaO8Lg=;
        b=tybZU6IeFU5eBDhtC22qtcStV9lyzClHccOKWPOm70uFK6jkcfeg9nc8WGazJP6ly6
         o02xx55uW12q1BiNC9CsrK2fjbivmMg3bYk7i9aDrmISsjasWJiKOD3vwV/8Hr3Ehb11
         MwhiXJAhKLx5VbgEUTAKlKQoltDmYXw0WqU/yDtZMNTTf0lInkhbO7l+WPrBnvi/EjUW
         I85zpZjKTxpxNC+80xRba/IIgg+kWj4QKy42SF1nqCqzfL1AFvISm17wwF6YGHgENpxW
         7fMEmHdZlN8qpNkNGkvh6z+PvuoGZQROfD+MwsjIFFAkLXCxvs+B/XIxqCDWOxC/0DoH
         qnfQ==
X-Gm-Message-State: AOAM531xvYnbAOY7DIRxWAcDBH8JR3X6EDI9hfw/Sl8povPIMX88oeJt
        Xc+QN4j61lr6atvUL1U6/3UooVca/4gnPQ==
X-Google-Smtp-Source: ABdhPJxUwanW+ZIwpK+FVZgJOnbteFLIgqWu8+GVW9mv913bhiQHu7favLbhVfOy1N0EIKtQrkK8qA==
X-Received: by 2002:aed:2162:: with SMTP id 89mr7157614qtc.182.1624579710864;
        Thu, 24 Jun 2021 17:08:30 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:30 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 20/23] staging: rtl8188eu: remove RT_TRACE macro
Date:   Fri, 25 Jun 2021 01:07:53 +0100
Message-Id: <20210625000756.6313-21-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro from include/rtw_debug.h, as it now has no
callers, and does not follow best practices and kernel coding
conventions.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/include/rtw_debug.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
index 72a18ec3ee32..88575c4a4633 100644
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ b/drivers/staging/rtl8188eu/include/rtw_debug.h
@@ -58,13 +58,4 @@
 
 extern u32 GlobalDebugLevel;
 
-#define RT_TRACE(_comp, _level, fmt)					\
-	do {								\
-		if (_level <= GlobalDebugLevel) {			\
-			pr_info("%s [0x%08x,%d]", DRIVER_PREFIX,	\
-				 (unsigned int)_comp, _level);		\
-			pr_info fmt;					\
-		}							\
-	} while (0)
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.31.1

