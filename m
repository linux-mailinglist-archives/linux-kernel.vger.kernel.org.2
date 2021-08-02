Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B23DE0AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhHBUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHBUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:30:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E7C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 13:30:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x11so31950731ejj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5BlHIa31SmedtibzYHCu1kx34K4cgvKod6SsEyx6lc=;
        b=m9S6AwU68KLQmBFYoqGAkkV0gVEIQaFJEsFBwoDZUp/1Vcrt2mdJgOsuSQOCjXoN7T
         m6r9UmRfSEa5TV6Fa0NpltqNSO7LgvTYYL1XFk8grpFS96VAVmGD7pITYUCZSjsDfoFR
         A3KKW8Kk1MXg5hWD8lojuGgScbQoRP9so0p3TS1F8AAXmOwsYdEcC1xnhQbBDSX/vAJ2
         k/OQGZuHX30YQl2xhozVu9df47Bt4NSMBOWKczuzFeoBN9Rpfur4NBIYgbacUwtENBUP
         YurTKXMYxOdT63kxFGZ09r/SobF6q8FncsokwjIHDoCfs1CQB779TFLZhm/A+p0gDPtB
         m/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5BlHIa31SmedtibzYHCu1kx34K4cgvKod6SsEyx6lc=;
        b=rqFYtvoRgkqfCRmmrlx+jHA1+4laXRgROhxUFXxUuSL4DaQxww7oM03lBgaJ43xQaU
         Y7XS+FCE8np0Qomiy0TojOU3p4h9TGLYCDPjIy4LbNIZtb/aja38+JushfOzHTV4kvat
         C4P2qqMIMp4SGB6dz0L4DdccJu2oN7hk7MOylg2AXUlQ0uucxDBDaeyxZtLP8Tz3L0IK
         GnEuUjgXYppVm0pmg9v/QgclNTLVd1N511Bq+Y02EgNzkrHjWYmt17paiyllpX0uAf5T
         Kzt7dFUd3i2xgeLk5uygdNQ9h6/xeVZYSx6qkYiF99au5w5isjErAywWVXYZ0h0BqIfI
         CAQg==
X-Gm-Message-State: AOAM531U83xMNLOJ7+89mWrFdlD5fyXBq5zgY3Dgxb6OHM3K/TTL9M1Y
        gO/Dk41LoGp08VrmczSaDEU=
X-Google-Smtp-Source: ABdhPJzWWRtbvVQqxkcS4L/I+iXUA9t4k3WnRWMmyU/nohuJu1cVJkOM67UFVMimQSgFXiSWv+GnlQ==
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr8274709eje.341.1627936224458;
        Mon, 02 Aug 2021 13:30:24 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id n13sm5099084ejk.97.2021.08.02.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:30:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: r8188eu: core: Change the length of an array
Date:   Mon,  2 Aug 2021 22:30:20 +0200
Message-Id: <20210802203020.9679-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPX_NODE_LEN == 6, while addr.f1 should only have 4 elements.
Replace IPX_NODE_LEN with 4. In the while, remove the excess spaces
before the fields of the union.

Fixes: 56febcc2595e ("staging: r8188eu: Fix different base types in assignments and parameters")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes in v2:
	Add a "Fixes:" tag.

 drivers/staging/r8188eu/core/rtw_br_ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8f434768dd15..c585224080c6 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -137,9 +137,9 @@ static inline void __nat25_generate_ipx_network_addr_with_node(unsigned char *ne
 				__be32 *ipxNetAddr, unsigned char *ipxNodeAddr)
 {
 	union {
-                unsigned int f0;
-                unsigned char f1[IPX_NODE_LEN];
-        } addr;
+		unsigned int f0;
+		unsigned char f1[4];
+	} addr;
 
 	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
 
-- 
2.32.0

