Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB435FA78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352498AbhDNSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbhDNSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4C5C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so32811322ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xo+FKasd3gyu4aP2gmz/WdWr4BgS5HtGq4NGSXvNMVw=;
        b=M3eRDjsaWUxrp72xFWXSAcoZRztWJY1Sq2nrcqq+joRbBQwXyF5a8JRuPpnMFVsvyr
         YGhH3JpHdqx1bnzM5Pgrgz2NbxogVSFAcB/T/hNkaJL3mlVycskNHHxoTK/WTKq0JXce
         tAZODtydWNyT4uzl1rFdZdhCEJKMdKW1ciBVjGa3Z/617fAFlpWeU60W6H7UBifraXSr
         MG1UBUsXxhgaOSOmkodojpQgGztcmnAJ+0EFHsFfbV4ZPXyICUEMNrV1vkk2QqrXGMsl
         lRUonzKICUsYBP8ktJ+wxsjvNN+YJFg98E275EpBgBfvi8U32fmY5XnfizLSPi5OrbFX
         vREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xo+FKasd3gyu4aP2gmz/WdWr4BgS5HtGq4NGSXvNMVw=;
        b=rjvidw+xT+r+S2fE0bxn2DjrwYTJ6X8Ngb7eASGkwGyhBAiH/cTkDv2BtthSZ7VIe1
         36+He+uC942L6+DGKKPZwriPKi5uzm3ENCR0DGkmPLVg2usVG7KOx9X3pTpNVUYhTvLy
         hJGZHrkHwK5wiiDGw+JyZ0X5isSVCR+wdhLeL8WG+HWFBmIOyn1uF/AiYvGbXUo70HYL
         H4aV89S4XadjnA7wgRBDWCmR8AAhn2rkQRKgkktGkv6ETNFX3PCLkOSvpXCqVAL8pjp8
         ZimWm9YZbLkm4WKJiQI+XgYbQ7ajYITc5GMUX6qAeqiap30/+Y4pQPiLIQv5oFSa/k+U
         szkA==
X-Gm-Message-State: AOAM531XkbC1jwCZhHJUFCrOoBJXiFRfQvBHvl7NOEJSahSvIsr3XX2I
        g4qAHKHsdn+34LhFPsenIyrJug==
X-Google-Smtp-Source: ABdhPJxjp9uvX4PC1R+SJpRYCTUUvvrn/t7fdrGvk/9TLxQ4RVKGvITHC0+F52asO0jZ9mASZpXDIg==
X-Received: by 2002:a17:907:2d94:: with SMTP id gt20mr149467ejc.552.1618423909349;
        Wed, 14 Apr 2021 11:11:49 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 14/57] staging: rtl8188eu: core: rtw_security: Fix some formatting and misdocumentation
Date:   Wed, 14 Apr 2021 19:10:46 +0100
Message-Id: <20210414181129.1628598-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/staging/rtl8188eu/core/rtw_security.c:10:
 drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'p1k' not described in 'phase1'
 drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'tk' not described in 'phase1'
 drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'ta' not described in 'phase1'
 drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'rc4key' not described in 'phase2'
 drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'tk' not described in 'phase2'
 drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'p1k' not described in 'phase2'
 drivers/staging/rtl8723bs/core/rtw_security.c:1937: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Straube <straube.linux@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 617f89842c812..4d0a23bf3f660 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -465,8 +465,9 @@ static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)
 
 /**
  * phase1() - generate P1K, given TA, TK, IV32
- * @tk[]: temporal key [128 bits]
- * @ta[]: transmitter's MAC address [ 48 bits]
+ * @p1k: placeholder for the returned phase 1 key
+ * @tk: temporal key [128 bits]
+ * @ta: transmitter's MAC address [ 48 bits]
  * @iv32: upper 32 bits of IV [ 32 bits]
  *
  * This function only needs to be called every 2**16 packets,
@@ -498,8 +499,9 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 
 /**
  * phase2() - generate RC4KEY, given TK, P1K, IV16
- * @tk[]: Temporal key [128 bits]
- * @p1k[]: Phase 1 output key [ 80 bits]
+ * @rc4key: Placeholder for the returned key
+ * @tk: Temporal key [128 bits]
+ * @p1k: Phase 1 output key [ 80 bits]
  * @iv16: low 16 bits of IV counter [ 16 bits]
  *
  * The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
-- 
2.27.0

