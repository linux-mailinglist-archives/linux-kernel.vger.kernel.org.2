Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62636F68B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhD3Hpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhD3HpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFAC061346
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n2so103822192ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBMRL9okd6exFYzTetsEZ3MsVPUnPB4cIvHOO2Zf8iE=;
        b=gR8QCiv4DsNCkhpvliRh2repO+rv/67cRocKOSqQvp7PByEaOkkkiakifFoXYtvrSy
         KisK/LLhWh7HRsS4evkf/DBYfs4k9A5oQeaRxXpcykl57tkyVpBtz0OCvDKQyiOXmif7
         Fi2nqsWyhghVM/q440OyNUjo888IA1kOXoNiLZD2AHrF6vynj4/utspkUPX3DG60TxhM
         Uf7mwq/d6pOLvPxr0BSjGpQm08aMdnmRXTCY57HH+pEsn/oBbON/1p8ZQeRylyOi27N5
         YRkNzVIaRV4APXb+lJ8wjoit9ib7VnTo4W/ggmO4dGggi5Y5YuzxVdyCli9/WUYaYHiq
         6XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBMRL9okd6exFYzTetsEZ3MsVPUnPB4cIvHOO2Zf8iE=;
        b=EMEhETHmE6Cp55Snl8JXMDME7miORHJP68rTOvcIann/HB8u8JfqE7wr6ba8YSQkPJ
         E7Gl67dMufxS+WIlATuXXCZnosbKmJuztkfU+/7dUv027Ai06fn56WGEjERORdWjPB9g
         sA+8ekAFfyn8D+gRITiTdpIPJHFvxhQDiCw/HN9b2ByLxi2neaGYxvI+txpRhF7NnQDb
         0dsDXqJa9hhZmQ4ifWAetmsqBFt5P0yggaU2vh8sY1tugrcyYPOtTw8fOe6XnqkNAwA/
         B7Zp+f/osI6QS0OwJPKN3iogzza8deZzUFo//eYlBwTVEIakccEvFCEKyh87vz5rP+fD
         vTrw==
X-Gm-Message-State: AOAM532oMsuxNIlKl3XXfijkgi6WCJgV/iyADCvPmqBEndg1otKScP+8
        KrWjrQIedlcm+u+oC+Yo+vDr/xQadwFxhg==
X-Google-Smtp-Source: ABdhPJzKo7X5KfG+V7g1JhtrVbUmWWo3xAnineM3BRSuH/4cbReedk9VqWXDy7p4ETXRczVszXjM8Q==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr2852043ejs.522.1619768664606;
        Fri, 30 Apr 2021 00:44:24 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id bh14sm1437662ejb.104.2021.04.30.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/43] staging: rtl8723bs: remove unused ODM_dbg_trace macro
Date:   Fri, 30 Apr 2021 09:43:30 +0200
Message-Id: <7ea9367680c709edeec463111ddb2f7284cc11c2.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_trace macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 58de4d16335e..cd68c583699a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -96,11 +96,9 @@
 #endif
 
 #if DBG
-#define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 #else
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
-#define ODM_dbg_trace(str)				no_printk("%s", str)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

