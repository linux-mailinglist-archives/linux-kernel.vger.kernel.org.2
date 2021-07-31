Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAF13DC1E7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGaAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhGaAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69704C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:23:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k4so2523406wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCgskwqPbTbe8zjqvIB45iWyLT95wxbQES202Eafyt8=;
        b=BiaWTml/rLMIAD4rVA1hxEzN61MktWob+7DjT/LqjKJtNZLkD+mANIPnfGYjL4dALj
         mGwOMqSewCqr7/KoRjZyNPueKdXN9UqcHzSFaOZVj/RQwuIRzaxPa+YTZWagC1LcUDvQ
         davsUL2rvoBiicePFWrabCAnol9Selt0OVXDsi98WlLDWKyrdSjVKANMSdX1J4/sxwpc
         +cubBOpFa+SP2CTBsYFStyg84xrElMfjG7HEqJMAz44bZMpfo2BMebs57Y0oNdbuBBQl
         FaJWngM9yVgqRQ3DL9baXeosQqV4xj85vlQchsES2bXmRPc+HJg6jUpHSIuf5X0XujIm
         br6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCgskwqPbTbe8zjqvIB45iWyLT95wxbQES202Eafyt8=;
        b=ENwF/RKsqrX1DsO7EQ6tyGPsnsijZaemqzBqenC/qf/DmtYVyPctvb8ZMu7yOlDvYa
         vzO/OBoi3hy0uKRwC6kPGLFXtlnW9vFhrpcpYIYhLO7AbEg0OBMtOCMJxsgPkDCB7WfI
         N+p3B2LPCKUoEVM2W+HW/cDHTXMUHenJsY4fshIWGQlfhn7Vb22aMJ+vMllwBbiDOGHa
         zWJyctBDFSf8U+E2fri17xBEgR/uOaHDem9lQSR3jtgfGBk8BluQxq8raKa6e3JoOkkC
         LfRQrJbODOZqyzZjnBDF88NlaDFgZOse7jpvNVRUVy3Z9JUH5lNnYDGtOIsktoE9H0v5
         r5sw==
X-Gm-Message-State: AOAM531mQpxhc/D3Vh6iSv8ysUPVybWTdUL8lDr07wRtr/Kv6qVpbKSN
        3fNEZah32sI8f6CqPLQq2fIqog==
X-Google-Smtp-Source: ABdhPJzRWVhVUEf++FiBCu6WsxUAxuQ5zfj/MHwPmpHnLK8WeLIKZGoQjX+ZxQqiyaIFGy7ddBhnhw==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr5737726wrt.107.1627691037002;
        Fri, 30 Jul 2021 17:23:57 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:23:56 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] staging: r8188eu: remove ODM_dbg_* macro definitions
Date:   Sat, 31 Jul 2021 01:23:41 +0100
Message-Id: <20210731002353.68479-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_dbg_* macro definitions from include/odm_debug.h, as
they are called from nowhere and are therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index 53ab6debb6f3..73fdea598707 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -104,9 +104,6 @@
 		RT_PRINTK fmt;						\
 		ASSERT(false);						\
 	}
-#define ODM_dbg_enter() { DbgPrint("==> %s\n", __func__); }
-#define ODM_dbg_exit() { DbgPrint("<== %s\n", __func__); }
-#define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
-- 
2.31.1

