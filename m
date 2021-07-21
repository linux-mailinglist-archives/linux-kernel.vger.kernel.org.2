Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE23D0FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhGUM52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbhGUM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec55so2445757edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HaElkBZukImqyfYUL4Ia9Q9pWYvEVfPFLl5fxZCgIg=;
        b=EwNYuz70VcWo3edhithhQnESoF1zBsTjupyu3hqtJxjw+C/G84BB8OcYMbna//aKKt
         QnJw6duc6OlBaTAYYcVNb5JtzyZfJQ3K/2LzsB5KqOiFPpjDbIPZyCHRPPhoBi1n6iqk
         lq6ncK6kWMVXdgb/TKXWGaI2i5wrkPEKKeizgsLq65pSux2EcfAPOW0FkG3+FWL9ynNc
         Od/auxZF8+AC9wA/eai8Lxcib9T5EqUhyC5DBYAFcdUuxrbdCExsoQWH3LuSu4HJluE0
         hRC7yGsSILmg0Sij8Q/F13xKPKnKHJpodcVNjqbcpsLCkM1iwa190qYz4RrbsCZSpAUK
         N4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HaElkBZukImqyfYUL4Ia9Q9pWYvEVfPFLl5fxZCgIg=;
        b=nXOeFsQOif8sJYhjiRoMuTxVjsVd410dxmcU9raF02mLKjD+uT7qX+uAmtElmRBh15
         epdLJzXyHW5DABwIn5t6OTRzaLkjfh5UVmPvTeIsEgReWkJtu42mlmdnGLDlH9zHrBYZ
         DSba7R/WUN+XyoEBVZVwd/DTI29EU+NIu0kCJ++v4ZNe6PFUDJt4GiQwg6ACj5fXK1sa
         Pe+Qxnhgr8YixJJHLXpdPyzun4nz8vFOggnRaGlGQDddqOQG/qyTqJvRQXtIzQImGpxR
         g6+wjh9HT+ZF6FOP22twW3gLs7vq34ZkWzrF8EweqC6r/ZaZ03mLPgFWToVtYhMGQjVG
         ZpBg==
X-Gm-Message-State: AOAM531ng25yV5GWMOf7mmM2ShHUJ79Y94SGQCmM1rJ7R+XBdSF5u8Ph
        whVUPhfJCHf1waglB1QBT5B6y4LKonY=
X-Google-Smtp-Source: ABdhPJwISIpcXoohRXxKz8GthXSnt0bBzPR4mmrKhBnOinVE+dd4xYP+ZSg3DErMeHBg5kF1rb9h7Q==
X-Received: by 2002:aa7:c4c7:: with SMTP id p7mr47484243edr.290.1626874667341;
        Wed, 21 Jul 2021 06:37:47 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id p13sm6430879edq.86.2021.07.21.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] staging: rtl8723bs: remove unused struct ndis_801_11_ai_resfi
Date:   Wed, 21 Jul 2021 15:37:22 +0200
Message-Id: <23f5764080f84e3704654b11db455e4d5ad499bb.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused struct ndis_801_11_ai_resfi.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/wlan_bssdef.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index f0977b15c81e..b101a3ac40ff 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -107,12 +107,6 @@ enum {
 #define NDIS_802_11_AI_RESFI_STATUSCODE        2
 #define NDIS_802_11_AI_RESFI_ASSOCIATIONID     4
 
-struct ndis_801_11_ai_resfi {
-	u16 Capabilities;
-	u16 StatusCode;
-	u16 AssociationId;
-};
-
 /*  Key mapping keys require a BSSID */
 
 struct ndis_802_11_wep {
-- 
2.20.1

