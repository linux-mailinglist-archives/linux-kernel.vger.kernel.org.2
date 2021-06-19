Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051153AD9A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhFSKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhFSKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BFC061760
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso7257407wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77HnC0dTisnKWDPVh1Io+8wCN1+6InnJC2WdQmork9k=;
        b=ZBunn+aXi7XpJQKl+iv5ApLLwtRcpaJ70cinJA3ablAioeuZKp4VaSds5C4dApegIp
         O+9+X6+O9QgYK/G2p6ztnrkR4JjArbodggYKTJWyh5Bs71TYJcmhhSGX2+3hn1E54izP
         0GP8tF8J4vWLz9DwPhj2BBhd/d96d8HgQJP4eDEQm1MsKR5pSQ0YJ3NOvNJO4HxZQbO+
         rMUSaVxL2r1skhqvBHho6u5lWudI5aBuEnWw5oG+ysHvHAQQTqaPBO67lsBfLI8noxKL
         hItmgknGRWo+7+/J712F73tP8gHgz6so8K59/ZkGhEf6s5EGz2Q/4ccHz4vmieKNwpUA
         qTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77HnC0dTisnKWDPVh1Io+8wCN1+6InnJC2WdQmork9k=;
        b=IKy+2GYDIHMUX4QWuhrIchoQ/+J1Z9hlHRXVm0/i2l5Xoq0jWQX5kDI9IS4ULXMW9v
         UFFV09YFiYEHQFoOIvFekGse6PBK9x9dUEBHDw6Ju7pFcH2zFtoDx811syT0Aa2asK4A
         xMmXxbUicM+ZFLamckM221/QMqkEL6aUnVBzQc3HFfjRuzbP+EU+GRMckI5fkNa7UgQz
         xjRy052gSnXAm3+/73i5a3i/qIgSwZTCKYd2Y8YUbGe2f1/UTIWc8u2NM04n1IxNTSkV
         l2D+PgwDXwjfkr2d6fGA4sPfFK1KcIudXSUphjs7xKcFPnmVmmD08QNjoY8UNE123pfG
         E9gg==
X-Gm-Message-State: AOAM531DWFvfQry0HNoG562USKiJaaRDj9Dml/uCzecOoadxV/47fdVG
        D94yG2JuFLFNWj39cMOYfePmjCClvujtXQ==
X-Google-Smtp-Source: ABdhPJypFcwMpkn1Yn2tXDRvha5Tu5Dd5kFUaHKnCauKpVJ+hEDEK/auvFAMr5rCvR7QfRfI6iG/GQ==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr15712389wmg.44.1624099662482;
        Sat, 19 Jun 2021 03:47:42 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id f13sm11713215wrt.86.2021.06.19.03.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] staging: rtl8723bs: fix macro value for 2.4Ghz only device
Date:   Sat, 19 Jun 2021 12:47:17 +0200
Message-Id: <d4dc048406bb8972b17db51a76a5dce0fa4eabaf.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix IQK_Matrix_Settings_NUM macro value to 14 which is
the max channel number value allowed in a 2.4Ghz device.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index c349de205f93..abf6547518fb 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -195,10 +195,7 @@ struct odm_rate_adaptive {
 
 #define AVG_THERMAL_NUM		8
 #define IQK_Matrix_REG_NUM	8
-#define IQK_Matrix_Settings_NUM	(14 + 24 + 21) /*   Channels_2_4G_NUM
-						* + Channels_5G_20M_NUM
-						* + Channels_5G
-						*/
+#define IQK_Matrix_Settings_NUM	14 /* Channels_2_4G_NUM */
 
 #define		DM_Type_ByFW			0
 #define		DM_Type_ByDriver		1
-- 
2.20.1

