Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC33F0EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhHRXtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhHRXtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:49:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77DC0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k29so6061076wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQuW1UPh3Qs0vR7u5Lk7AhOqAgYjFhwozqp9XjEra30=;
        b=LjMMxr8+48vSzkduH9suiWS3ftr4PGwOKXPDm9GP1o5TMbSHANEnuOTem1LDMac0Le
         EjakbP8nw+HFWZ5GwGehyjeZQTPcTmIE3meez+OGb0Yho4Xm0Bf1DFyBuHB7iY0RT/t7
         Jdk4guS128Eehp7GASg96z9qWYaXwdy87dwKjAdOkiAuQCj3hEB86C0pNhjF1TtMYu6s
         R6dUgnKSNmwpC+eKay3tl7ebFc4kNtBAX6scicVGV3FtUj3P6WxyuUTVfd6uP6UrE4yv
         /7zeFneTaPHJR6VPA8PXPTICXHrMMG8wq86zaGn95Q4t6QO5lje3B9v1GXKOpVjtudGn
         xbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQuW1UPh3Qs0vR7u5Lk7AhOqAgYjFhwozqp9XjEra30=;
        b=cUxXosUwRwJfGvRT3CFtHvJ0/6+7hn/glNS7NwZquvD90dZ8aJOnRzGppg7pbqyd/9
         w0o2xQt/YuU5Bw6c40VB5oCrosQSB/hzhRe8PjEmrKtGEs5W3muZDFs4OJVe5DqRL6e+
         CncgWJWUbVbDFSv4X0n5xO5Wvl8yJ04qOAEmJOJX3Momu5w3VCTlMY1uh37lUi5v3TPO
         E8yHB0HKINhw5ioh0UuzHzleuZ0qTAyojtxE6HwiN/aDXbv0O2P9EY6ZJsyxM+DzYC/r
         j+Op8+PuqVn9e7rXFyCclf8n/r8YvuBf3F0vmMrTXyg/3x/baIHGMV0gcoZXzWQJDIwK
         XA6g==
X-Gm-Message-State: AOAM531gDGKMdVj2iuQLIBvwk+iuwiYvMxnW0aqVtheMcGhSJIMxgWl7
        5y8/OJTaB1L16/9e5kkxqud4Rw==
X-Google-Smtp-Source: ABdhPJyxDilCGdCZiE90L6A5eSL+XivMU1+LsH8vV6Po34fGDaIUIZMjfGz4jB0CqcF9E6cVR6Z3+A==
X-Received: by 2002:adf:f282:: with SMTP id k2mr73219wro.255.1629330536679;
        Wed, 18 Aug 2021 16:48:56 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1205916wrt.77.2021.08.18.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:48:56 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 2/7] staging: r8188eu: remove rtw_vmalloc preprocessor definition
Date:   Thu, 19 Aug 2021 00:48:48 +0100
Message-Id: <20210818234853.208448-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234853.208448-1-phil@philpotter.co.uk>
References: <20210818234853.208448-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_vmalloc preprocessor definition from include/osdep_service.h
as it now has no callers.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 157ffe46c3d2..a9f147cd42fe 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -173,7 +173,6 @@ extern unsigned char RSN_TKIP_CIPHER[4];
 #define rtw_update_mem_stat(flag, sz) do {} while (0)
 u8 *_rtw_vmalloc(u32 sz);
 u8 *_rtw_zvmalloc(u32 sz);
-#define rtw_vmalloc(sz)			_rtw_vmalloc((sz))
 #define rtw_zvmalloc(sz)			_rtw_zvmalloc((sz))
 
 void *rtw_malloc2d(int h, int w, int size);
-- 
2.31.1

