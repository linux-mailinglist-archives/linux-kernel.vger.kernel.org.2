Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620233DCE1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhHAXc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhHAXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:32:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE3C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 16:32:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y7so19775077eda.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nycSytXCZfYCR8LzQF81gm2hXQJ8owxI3Y1HaRP+Y8g=;
        b=Ek3CzkJjSfBdOm8c+TtTSerBkrRRLsGQgKrQ/4TcNnygf4BN4pfC2MnQZpNDSB165m
         KYlk5eVY+yYRMVmGsbPuUbN+79G0B1f+vaUFFx7E+xbV2W9HxR8YzfKW3kDzQMHe+EpC
         tVCPER5xomz5RXA/qYJ0os1uRubJbZGx9w6+2zzcXEYNhzNvEObwh26tIC6c5/f+mDTE
         quz+DlOXPC6TNNSyxpvBYC03sCZAzeSeDWYjqFY7YZSHJ50/SOpZkU/tw4QmWdf5gxuG
         YTxUgbByjmaZQrISs0cPioLWTm1DwtE9fF9hv+22C8A21F2VR7h/W05nK4keCt6ZW6r4
         rbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nycSytXCZfYCR8LzQF81gm2hXQJ8owxI3Y1HaRP+Y8g=;
        b=TWZLxnl5mbb9QiRJPD/H2s0OABM4oITDFNQkoe3pAs1CzxjhzNj/fpJoR2Yqb7cKa3
         LgfL/LZfkv/4Z4O/RSxOe78G4B0KTAO9EHBH+2/LsNODWOAmbtMkYGrDviOJJShyaY8x
         LNSTN2GvvDSkUlBgrbhrRO8vQQ8CkVSTaIndLcsrD7lQSRJFfkKtu4pqLdUQFvT94Jj+
         2jbxJvvrokLi6Xqd9hSOjwv5T5t4/uiLu0KHDk0PHG8ASA9fe+zGrh1FwCekofYdA1+R
         7OGlZ1tr/tuHAk15u5leqlzisKsi7d7I4m1uNJst8/dzxtPqBDCU04jrB+/HdTFKncjY
         QGFA==
X-Gm-Message-State: AOAM530/tZhWrxCHaO7Wym1LY56ODeZ3OsBtQomd0XW7JV0P/Znl5bVT
        1AekgW22ZjlxCdc0Ofj15+Y=
X-Google-Smtp-Source: ABdhPJxwWXVeM0etOWnSk+DNRBJSiSVlb5Z+e+QBQfONfWUkYuQxilkf1BFBXIG6oyMayLXlRuHVvQ==
X-Received: by 2002:a05:6402:4246:: with SMTP id g6mr16039128edb.95.1627860765496;
        Sun, 01 Aug 2021 16:32:45 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id bs13sm3610308ejb.98.2021.08.01.16.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 16:32:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Fix cast between incompatible function type
Date:   Mon,  2 Aug 2021 01:32:41 +0200
Message-Id: <20210801233242.20436-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings of casts between incompatible function
types from ‘void (*)(void *)’ to ‘void (*)(long unsigned int)’
[-Wcast-function-type].

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 2e3f624d0f22..ef722b4a9ddb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -38,7 +38,7 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 	struct recv_buf *precvbuf;
 
 	tasklet_init(&precvpriv->recv_tasklet,
-		     (void(*)(unsigned long))rtl8188eu_recv_tasklet,
+		     (void *)rtl8188eu_recv_tasklet,
 		     (unsigned long)padapter);
 
 	/* init recv_buf */
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index e44a01af7f5c..510df3f3e6bd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -14,7 +14,7 @@ s32	rtl8188eu_init_xmit_priv(struct adapter *adapt)
 	struct xmit_priv	*pxmitpriv = &adapt->xmitpriv;
 
 	tasklet_init(&pxmitpriv->xmit_tasklet,
-		     (void(*)(unsigned long))rtl8188eu_xmit_tasklet,
+		     (void *)rtl8188eu_xmit_tasklet,
 		     (unsigned long)adapt);
 	return _SUCCESS;
 }
-- 
2.32.0

