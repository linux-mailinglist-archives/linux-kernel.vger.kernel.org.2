Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1734B799
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhC0OZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC0OZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8EC0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso6314903wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bDUFCmEc/JgFVMSYx3LH+3oCkwKnVB4YXQ1zRko3yE=;
        b=sVh6F6LrZ8LqBgRGbKRVJbJLbhs4ipKSApPtZP/Kg2mDsx+XGbVTje8mFWe1X/AKnU
         audcO7MC60tppVo/GfZ7k3iUR/V2uNpCijquMqEe/pE1oCKW3cQg21mBtPS2yVPPrv8w
         tKvz2BwlwBsqwMEuOGA/gMxdbZvB3jG6GnoNBb5Qd5+n+6PsQoH0srOyZgDcPCTNN5TG
         NvvwohDjbTni/URGIWs0tyE8HRVWo1itxMy8QA8iSrpjXkCRDPLvrI1IPEp3Fi/2GJrY
         AVv2seKFrnnas8wslXV4xNZEQL2A4wi6hDmzj8QDsA2Qu7BByx7vOkX5jyuDYVq3XoGw
         +7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bDUFCmEc/JgFVMSYx3LH+3oCkwKnVB4YXQ1zRko3yE=;
        b=Un2y5F0LY+oMimk29/xtDUtRNfZS7Fd0NL6ARLRdmMjSNpepXDLuAKbrsWObbtEfgo
         gdve6kNTh6cHuIJXitMu7uwF8ALi+Fu7uLpGf3QI4E41137u7VO79vJBxuI+kEzQ1/1b
         rrELKGMZl3fMt5X+E7ZIIdwogL4sXebutIdvHxaiRbMjLGuBkmEzjT1Duu9U2eKYyZ1t
         AT5g/Zl/b42Yc1RsiKpUeK1T3XREAXLR0Qa3wGFNNtOY+pz/9U8NYkNKnIjulCdljRVK
         m/arOLR9gf7aiK5lmLVoGyQt5in50kPENdJNjX15GqxzHBWbGIeXvGiDPNnVCBRT+5ul
         HqUg==
X-Gm-Message-State: AOAM532wesOdFcdXKOxF+pny1sFFAdLKV5BXKdYTMJZXYM3DutA9nq3D
        ieXIYNZP4Qni8b21YwjbaFo=
X-Google-Smtp-Source: ABdhPJxA61eWCHJWJNa4WTQ+9rN8MxNQcWBTVVXG1jY8U1zBhOSKO9vPOQuOoCHqKkqIzBIrdkFqwg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr17313579wmi.132.1616855104065;
        Sat, 27 Mar 2021 07:25:04 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id u17sm19607092wrw.51.2021.03.27.07.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 11/20] staging: rtl8723bs: remove unused field in rereg_nd_name_data struct
Date:   Sat, 27 Mar 2021 15:24:10 +0100
Message-Id: <e47b4092f12c4930b7185ecdd59b1d0611dd09e7.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused field old_ips_mode in struct rereg_nd_name_data

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index df1dd9fa7b90..7eb59a16d00e 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -412,7 +412,6 @@ struct adapter {
 	struct rereg_nd_name_data {
 		struct net_device *old_pnetdev;
 		char old_ifname[IFNAMSIZ];
-		u8 old_ips_mode;
 		u8 old_bRegUseLed;
 	} rereg_nd_name_priv;
 
-- 
2.20.1

