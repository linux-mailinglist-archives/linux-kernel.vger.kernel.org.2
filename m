Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F74360698
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhDOKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhDOKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:07:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8376AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y204so10759651wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYeDQWN22dNfUU8hmlX7IJ6l71kMbUkvgfCHONX5uus=;
        b=UAin33XQ/bLro+ZxmUd7EdVq7vVHR4XlW90mOHzrZ1voP8pXdJlesqnlMnh4ihyu2Y
         oRatm+kDWqwYpjlYWp2lkeAS+/Pl+eqnQlUe9abLdaOp5tqOfNb1hyLvGWbr9jk0NILS
         jhKkkGcS46WbWDD6SE6ARSbG6psi9Z6Xj2o7XU2/4wVFygoa+npObxSF9BjGNMsZtkS5
         lAAbS9TeBEwxoeLdw9wkicBFpKafisB3BE0emdFu7QGaz3F8yaW99LOWTclYSIBS4O/g
         uHVg1JJwfZeVaIMiiU0OMP42KOYjT4tG+MoS5XSunq8eZoCdRXcTpVk0uQO6OhQLU8QS
         3vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYeDQWN22dNfUU8hmlX7IJ6l71kMbUkvgfCHONX5uus=;
        b=WmvTrOBtlTt9/o5QUZKGKNMVg/iQTVIzaA1wBc59ZJKBHN+W+ywkvXr1ZBeW5CuOJK
         93oRN8noJeqDc4tu6SRf9GSiPziH8Ot6erdnHmmyc9zC/HoR8YWAZsYcPaauUiCsNT+z
         FZdthiE3HOjegSzNW4U51RL2gbEgv9y0jaure/3Nc2UM9Yc2nhh3Ze08HC7Jnsftzm8U
         U4GXN5dFHBxXiazYl0d0dMTPYCZujCQqaj6NqW4lIFqsHN6KMKkLcdPZcBa5HSyJy2qa
         grr080jIe7norDaJDasj8xZNVkMIPiC1UZN2Vv/uWEWTF531li+4/2dqLuC3zELDLhgS
         9yMg==
X-Gm-Message-State: AOAM531TeG5FkO3XslQzwuZrj7fXl2kFKPjUDby+8wiSgtSKXw4gtrcr
        DbRtO1VVUEY4uRXBJ6O9bZyMiY0TKNc=
X-Google-Smtp-Source: ABdhPJyhn23M/tKQxFYBZ9Ux5+xWUMpttsXf//X5eHLTswbzMJiiQE8+OgNeTVXLowpJPhJBTkxWHA==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr2264127wmj.108.1618481254105;
        Thu, 15 Apr 2021 03:07:34 -0700 (PDT)
Received: from agape ([5.171.72.223])
        by smtp.gmail.com with ESMTPSA id n14sm1851441wmk.5.2021.04.15.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 03:07:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8723bs: split too long line
Date:   Thu, 15 Apr 2021 12:07:22 +0200
Message-Id: <4e87fb741205b9f314aec739921405a7ebef908a.1618480688.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618480688.git.fabioaiuto83@gmail.com>
References: <cover.1618480688.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch issue.

WARNING: line length of 103 exceeds 100 columns
30: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:711:
+
receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 06544d0652b8..9031cf7657ae 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -708,7 +708,8 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 				if (!ret) {
 					netdev_dbg(padapter->pnetdev,
 						   "ap has changed, disconnect now\n ");
-					receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
+					receive_disconnect(padapter,
+							   pmlmeinfo->network.MacAddress, 0);
 					return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
-- 
2.20.1

