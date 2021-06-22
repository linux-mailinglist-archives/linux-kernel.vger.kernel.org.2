Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EE3B0592
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhFVNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhFVNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22422C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso2225799wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77HnC0dTisnKWDPVh1Io+8wCN1+6InnJC2WdQmork9k=;
        b=eV3bi0QWiS3dhAEukWk//V78hWjn1gLyuq01ztKAwHaJpvOxgK4ny0+fP8C3gt/vLU
         SEc4jsi4UEgeMDnfnz2sbrpl9pDuSwg8FAjlcnGGH3Q/M/mr7zd62FIVq9A4xunx/vMQ
         4oSj8GshgGw18zZGfEsRiWbNwzfCWmifzbRh3E6pwKZrig+f5NRcAnv9au+PYabNaF3F
         Fnus9byJgmfxx01prjaVst8aAc3nGIUPAtWqv2A4+zjZpqGSagr/WyVWIIc0Gr6vADkH
         7Mvb/X2blOXE35Wmrox7EckfLaUdLmFI8Nz/mqQfV4Z0V8+68cC2SbyhX1+SU43Pyuz6
         uesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77HnC0dTisnKWDPVh1Io+8wCN1+6InnJC2WdQmork9k=;
        b=QoV/Q3lahb36vVjllqPr1AXcOczqedRudsZiT00zEk1gqYLDn5YwAdFbmpPqoDcdA4
         LoAgX06mOCWGBqtJ6rLDUbkAtqrDqPcClAkhCVaSiWNWT2HNCrrbvkUSipd2vbM1Maeo
         XRxk6kb5rWViXKrAWZHDf7F0BMbaDze0THs7ClqlJv53vY90s+Z3m1h7cmcnr0+XfYoq
         VsGP187wCTLRLfQPm43mP6DRekNDFeqfdDg9VhTwUMrKsg2dXyCQ/srPhLX5Zic3aIqi
         2awafiBxQIRlvIRz1Iem5qiKgVOWAqzbiy6eRHGmJRRU6yD7s6T+WHBONZH3mmTI7sNZ
         MAyA==
X-Gm-Message-State: AOAM533Z/IKacSa27ldoP4LXlo5ww0QF6jozJ+k2G4ee67r4Smgrb1WU
        SxUyuZfHht/1ASuLdda8bnwX+kN7DUEqKA==
X-Google-Smtp-Source: ABdhPJyNqUwZwDZ+8p0Oocxb89SguUKQKGgjRotkGLlUznpJwrZchQPQVdPye1BU93oCshc553/iIA==
X-Received: by 2002:a05:600c:4f8f:: with SMTP id n15mr4299272wmq.116.1624367424579;
        Tue, 22 Jun 2021 06:10:24 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id b71sm2451847wmb.2.2021.06.22.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/17] staging: rtl8723bs: fix macro value for 2.4Ghz only device
Date:   Tue, 22 Jun 2021 15:09:58 +0200
Message-Id: <0b4a876929949248aa18cb919da3583c65e4ee4e.1624367072.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
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

