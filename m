Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D403FFD3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbhICJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348878AbhICJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:35:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A5C061764
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:34:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b6so7292055wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ApEY98xhN5gp0CgU7AnzqI8rYPys3K5CiH3JVol8qbg=;
        b=m8CFzFwXJfCVwzVDB+xfrkNn/GMDk2eIkBoHtBqTRTAF/6bZNKwWiZtH8yNBwYMCgB
         yfH8MHlbLa8d6slDhCJ4rRBtVwrsTH8EGCRaTMt5DfNwnjylRYbpNZd7lcCsrfBM0BYy
         O42ztNv5w1yI7I4x5mzTjBwkdMhYOylZn4FdKp08eGqBZCZNTUurep7XBji5clQOP2G6
         Z60dfbBWYPIucq9k4lmMaOCk9LU6zw6nbGcpm+p283PkHK7euHzOZjfjs4BQWoUugJqk
         krPsSK301uMQDfcsgyc/Wo0SPsgCTmt4aGKfac65q7680bdeCJK781UXk4Lj3Q78NiwI
         U6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ApEY98xhN5gp0CgU7AnzqI8rYPys3K5CiH3JVol8qbg=;
        b=rjj3JqcyiJvesc2NTaL3qYZEQUiQlJ3B+kOOMwx3dVGLtQjxBvEtCI6UXTltcHODxF
         ENM7llRH0yDYNPb9FSc3nJyoyQKYjOObhmx5NKXzvmcYw5NfLyfTVVDmx5U2BbGGjdZI
         4+qDIbqQyCO/4GEPi6YIGWLs+f24BxwjuCt72PLxCeRjsEGvs0heyiNowLDn4DMHMB7b
         /PIZYw67IaTJnmSobEVdBQKjzpw1Kv9+KGGFbTi9FEmfTNTRqSGAJqHm/3DeXXGJf9Sz
         HINWKtAKvUo4Z0Nzpn03F+DpaAJJxNKYXhCUmlOQQSujTG63q6x9OsJGHduO6W9M5pRP
         Ry5A==
X-Gm-Message-State: AOAM531u9y4RL2JLO2ovYmkf9qHCFJtGgmdJwWprS8VBAbvz0bgMoY50
        YYQVxSACouGWgaVm2DiIrE8=
X-Google-Smtp-Source: ABdhPJzr2o2iLy6DWjzEJ1GHl+jNwERg29P8wB9rNUrs98d4YhoxQr4Z1WXeyX0SpCEzJOCI9Sriyg==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr2891850wrv.117.1630661655937;
        Fri, 03 Sep 2021 02:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm3853060wmk.21.2021.09.03.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:34:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: remove enum hardware_type
Date:   Fri,  3 Sep 2021 11:33:54 +0200
Message-Id: <20210903093354.12645-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903093354.12645-1-straube.linux@gmail.com>
References: <20210903093354.12645-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From enum hardware_type only HARDWARE_TYPE_RTL8188EU is used in the
driver. Remove the enum and define HARDWARE_TYPE_RTL8188EU.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/hal_intf.h | 23 +---------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 117a98e5444e..5f6ef4d6333a 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -260,28 +260,7 @@ struct hal_ops {
 #define RF_CHANGE_BY_HW		BIT(30)
 #define RF_CHANGE_BY_SW		BIT(31)
 
-enum hardware_type {
-	HARDWARE_TYPE_RTL8180,
-	HARDWARE_TYPE_RTL8185,
-	HARDWARE_TYPE_RTL8187,
-	HARDWARE_TYPE_RTL8188,
-	HARDWARE_TYPE_RTL8190P,
-	HARDWARE_TYPE_RTL8192E,
-	HARDWARE_TYPE_RTL819xU,
-	HARDWARE_TYPE_RTL8192SE,
-	HARDWARE_TYPE_RTL8192SU,
-	HARDWARE_TYPE_RTL8192CE,
-	HARDWARE_TYPE_RTL8192CU,
-	HARDWARE_TYPE_RTL8192DE,
-	HARDWARE_TYPE_RTL8192DU,
-	HARDWARE_TYPE_RTL8723AE,
-	HARDWARE_TYPE_RTL8723AU,
-	HARDWARE_TYPE_RTL8723AS,
-	HARDWARE_TYPE_RTL8188EE,
-	HARDWARE_TYPE_RTL8188EU,
-	HARDWARE_TYPE_RTL8188ES,
-	HARDWARE_TYPE_MAX,
-};
+#define HARDWARE_TYPE_RTL8188EU 17
 
 #define GET_EEPROM_EFUSE_PRIV(adapter) (&adapter->eeprompriv)
 
-- 
2.33.0

