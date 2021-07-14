Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782023C86BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhGNPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbhGNPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:14:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFBEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a13so3620530wrf.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyox365Ii1ilVd+ni/OL8Ydjg+OlcC8rNpEGzbROUls=;
        b=ZD8s4DPOC3TwbMAg+1aCt7u1StwxGMAUHjB03GK3mYEOflCSzbbxGSxgHg8E3JLna9
         0munI40MRScQQUqDXASBJTj3eOjUh5dv6YkKbWN5fQjkNDyneXJ1hXLnMZvzRd341s93
         3JRSt+xirFz8bRTHr14uzPYm7VDsQRhjwc48cx+fvlPXWIIhNKk7vm7IVlpDKNnWvm6c
         dv7GCiisgovNbXpa3V4/tIKjBXg0hs1JvtZ2qWkxNRHuNHy3h2x3Qbu33ZGLEP3x+Ejf
         6DUVKlejlA6vRkoON47p38Rs3jr7dfjlliwTj/2y6a4J+TcbiejwJZzET5vh8FYHW9Sx
         vSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyox365Ii1ilVd+ni/OL8Ydjg+OlcC8rNpEGzbROUls=;
        b=p4L5XPB9WzdrFGfu+0Rwt7lOwBhIIASpJ8nJarKBtwZFjSVOBZW6dwilvsziOSAMN1
         D+GzbezCz5xrHByknQdCjT/3V+/CrEhKocsY8zNu3XSJah7Ewyr84rJqNYDYHCKxH5q1
         9ztAcG2WVF5N+73kj+F4qCA6PQwIt4rCbzvxNuwqlBBR98FiqvSUJMQkFJR2lXhzScga
         Lj2PvTJzvOCE5YskjO1GxqzYUwbBrCia9VcFgDzSGhyfnXSokn5pqjkk8u0zs1HGqMyb
         kQGeJUIvncYVITQBRS8ikNLuA+IUjiSpRvr7EYkEAxizBfi6pnq6QSHwHbZafYdHGUvP
         +YIQ==
X-Gm-Message-State: AOAM533P/WVXqchINJQvGjRc0vDiEojHfUZDQ85CBbW2M4LypEUFYfjx
        crLRk/qEFN4amPRO0k1xwyukRPQqdQk=
X-Google-Smtp-Source: ABdhPJwoI0gHScSZ086DexxRaXyQoEy4B+/YFie/X2ZPOoFJxDlZDVbaU3twTVOjiDR9wyrVATmgXw==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr13428258wrr.107.1626275479758;
        Wed, 14 Jul 2021 08:11:19 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id 204sm2415441wma.30.2021.07.14.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:11:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: fix camel case issue
Date:   Wed, 14 Jul 2021 17:11:14 +0200
Message-Id: <a708b2b9902bedf5bd0466b05516a4c5b4f43723.1626275102.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626275102.git.fabioaiuto83@gmail.com>
References: <cover.1626275102.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post commit hook checkpatch issue:

CHECK: Avoid CamelCase: <NetType>
45: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:170:
+#define is_supported_ht(NetType) (((NetType)
	& (WIRELESS_11_24N)) ? true : false)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 8eb0557a077a..b2c1a7dafcee 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -167,7 +167,7 @@ enum network_type {
 
 #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
 #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
-#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
+#define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
 	u32 cmd;
-- 
2.20.1

