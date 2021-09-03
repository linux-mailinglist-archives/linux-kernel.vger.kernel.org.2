Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04E3FFD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348883AbhICJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348857AbhICJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:35:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF94C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:34:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g18so7293795wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWnFUkWigf/R5l4257MEx+ITJVpSAzZHXNuW2f9UJjE=;
        b=T/CMt57jPfAl9+I4JBaHsHapsIouKVbo+CwrONj1z9RdHb9+syjzLzRodBR7exOkBp
         AL+vY2myuqio1+Pn8QA5JEQhsAifFIZx5rTXd3yXT7d/x307cQeVBpe7aZ8U+PFw7q36
         akidkOTdbTIEVYODsAMmBcpEFukmZcA1QiV/xsHZmn1AAKpXIPbrtB6m8eW5cGnicfcO
         WvYt8mduXtsOIsTDOnn++HzTqpmL8NYIGxoXOu9RdLcO+IR4nElzK/NRwvQyDZAKGuTJ
         z/Pl29LbzNpOC+cnYwMTyL3d7imEIFv7PyU37Qg0AQhUHG4ZNuDoSidtr36mQcr3i6x+
         6vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWnFUkWigf/R5l4257MEx+ITJVpSAzZHXNuW2f9UJjE=;
        b=LJELGDNb+hLxgpf3QTyK0QT0SqjX95NuqqljlaNOzhpLHek1A8mBl8Mu8pmjjoKa7p
         AbJp1APZZ+s9Am2hOZmTAWAO3ZZdAFZMhL21F6QOD51tNXkd2WV/N1KB/ITC0MfL6zIH
         kR1YwrSN+Q7pfcFvm+ffav/vp1NomRXOW/GwlOYDhajFCmfWz5Dba639uFAXfX3ldddh
         nANGo9OFFiY7AvMxY6ekVCNlWr+XpyVTbZ/XfzkjXZdIiIgd4syW3XwVor9L4rdirJm4
         hAafPjGndewjRZNPVbGY8PfUvRXmQBCJmfyXGk8SIy0wufpinno/zm6fSjZFrynd95nc
         vryA==
X-Gm-Message-State: AOAM5339Lu3Ho3bFZIf3l286UuwYyKfcw7Yww6nK895kSb0gtVzXJI2+
        3ZvBkWaztG9sF7XDnQSUsag=
X-Google-Smtp-Source: ABdhPJwQZI3CDN3TxMei3yQ+d3GOz0ritWI9u/yQu8kRphixN7dizPsJBLuMmKaf2C67x6JdAdH/Nw==
X-Received: by 2002:adf:b741:: with SMTP id n1mr2929121wre.120.1630661650700;
        Fri, 03 Sep 2021 02:34:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm3853060wmk.21.2021.09.03.02.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:34:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: remove unused enum from ieee80211.h.
Date:   Fri,  3 Sep 2021 11:33:51 +0200
Message-Id: <20210903093354.12645-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903093354.12645-1-straube.linux@gmail.com>
References: <20210903093354.12645-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enum from ieee80211.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 28 ---------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index bc5b030e9c40..ef0a7c20bd58 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -19,34 +19,6 @@
 
 #define RTL_IOCTL_HOSTAPD (SIOCIWFIRSTPRIV + 28)
 
-/* RTL871X_IOCTL_HOSTAPD ioctl() cmd: */
-enum {
-	RTL871X_HOSTAPD_FLUSH = 1,
-	RTL871X_HOSTAPD_ADD_STA = 2,
-	RTL871X_HOSTAPD_REMOVE_STA = 3,
-	RTL871X_HOSTAPD_GET_INFO_STA = 4,
-	/* REMOVED: PRISM2_HOSTAPD_RESET_TXEXC_STA = 5, */
-	RTL871X_HOSTAPD_GET_WPAIE_STA = 5,
-	RTL871X_SET_ENCRYPTION = 6,
-	RTL871X_GET_ENCRYPTION = 7,
-	RTL871X_HOSTAPD_SET_FLAGS_STA = 8,
-	RTL871X_HOSTAPD_GET_RID = 9,
-	RTL871X_HOSTAPD_SET_RID = 10,
-	RTL871X_HOSTAPD_SET_ASSOC_AP_ADDR = 11,
-	RTL871X_HOSTAPD_SET_GENERIC_ELEMENT = 12,
-	RTL871X_HOSTAPD_MLME = 13,
-	RTL871X_HOSTAPD_SCAN_REQ = 14,
-	RTL871X_HOSTAPD_STA_CLEAR_STATS = 15,
-	RTL871X_HOSTAPD_SET_BEACON = 16,
-	RTL871X_HOSTAPD_SET_WPS_BEACON = 17,
-	RTL871X_HOSTAPD_SET_WPS_PROBE_RESP = 18,
-	RTL871X_HOSTAPD_SET_WPS_ASSOC_RESP = 19,
-	RTL871X_HOSTAPD_SET_HIDDEN_SSID = 20,
-	RTL871X_HOSTAPD_SET_MACADDR_ACL = 21,
-	RTL871X_HOSTAPD_ACL_ADD_STA = 22,
-	RTL871X_HOSTAPD_ACL_REMOVE_STA = 23,
-};
-
 /* STA flags */
 #define WLAN_STA_AUTH BIT(0)
 #define WLAN_STA_ASSOC BIT(1)
-- 
2.33.0

