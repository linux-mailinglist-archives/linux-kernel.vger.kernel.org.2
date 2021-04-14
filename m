Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F02A35FA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352383AbhDNSOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbhDNSMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A284C06138F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z1so24829330edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suKchik7fkxJsbWv0EpdrzPIlTn55sc8L3ee+Nqts2M=;
        b=WbF8UtvVwzmb8yK9F48/oZ18yLEt+5DscFf7bjt1wb5liGXY1me+3cJVwo1CO6j7XM
         HTdApphufLPFEzdvn6mETHm/W9DMRq6pfn3ume7QKnNsRKXITu3iBcYtsFg+X9+IRAAp
         yWGzi52MMRmELdUDOMv9sni74jRBx+Ui0pkaJ/DiZ8+UYGXtPNmVQopQMRxQ+CPGHsZ0
         lshBmBgTdvMSmxrPYr4H6tD4XJCPz4vK8GCwbmE9rEFh0stk8JLaXkaSAJhrYPWQzFuU
         FMVtpxFNIlv2r8FbPqo4ZPohHX3XvK1tSpKk3qrKR5Z3nXrMUjIOLsu2yL0bepoEYerQ
         eLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suKchik7fkxJsbWv0EpdrzPIlTn55sc8L3ee+Nqts2M=;
        b=VbgCqgArx5miCfjWiBWU90sgVhL/1EqKn6m7wqCp9+cl5kxI9IGim1xJ08cfS9IeUb
         qgMQCeMXy5SF1e9IKosZKrOUqV7khKOXn8Ii4FShg8tBCjEEp5QLHNhISQrUI4Bru788
         AanYiev77RIGhWPZwH44KRa4UH/3s9/7on60P6VbwhkzAHPfdlITLL6LdZ+3XLIuOn3a
         e80JckEnAv0IDrvjzPIW88yd1zZbiBNW5xprdKkZeM1Rvsu6h8eZCB4R0ErwGLeBCqnR
         A2sNSDHOcK0gYifN52WOKuaYc1MrFWkyqvMFqu8dLBX/qW6PsE8vVG+LXs5d3TtKtf/X
         Vf3g==
X-Gm-Message-State: AOAM531mKG6W86UmGhhx+nXv7CKk+wnWWWDRn+xqqKSSF/Xi7mACPn+w
        SMRk8yTOWdaUjHO6EkazwdlGiw==
X-Google-Smtp-Source: ABdhPJxxaB7vg1VjWvnPfy0wQUMVRVTj6ZRbGFyi+lt8dP7Hv7ivz583lG85OuY/Dix8Q18eUEw+Kw==
X-Received: by 2002:aa7:cd7b:: with SMTP id ca27mr189673edb.354.1618423930097;
        Wed, 14 Apr 2021 11:12:10 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        linux-staging@lists.linux.dev
Subject: [PATCH 34/57] staging: most: dim2: hal: Fix one kernel-doc header and demote two non-conforming ones
Date:   Wed, 14 Apr 2021 19:11:06 +0100
Message-Id: <20210414181129.1628598-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/most/dim2/hal.c:99: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/staging/most/dim2/hal.c:788: warning: Function parameter or member 'buf_size' not described in 'dim_norm_isoc_buffer_size'
 drivers/staging/most/dim2/hal.c:788: warning: Function parameter or member 'packet_length' not described in 'dim_norm_isoc_buffer_size'
 drivers/staging/most/dim2/hal.c:788: warning: expecting prototype for Retrieves maximal possible correct buffer size for isochronous data type(). Prototype was for dim_norm_isoc_buffer_size() instead
 drivers/staging/most/dim2/hal.c:802: warning: Function parameter or member 'buf_size' not described in 'dim_norm_sync_buffer_size'
 drivers/staging/most/dim2/hal.c:802: warning: Function parameter or member 'bytes_per_frame' not described in 'dim_norm_sync_buffer_size'
 drivers/staging/most/dim2/hal.c:802: warning: expecting prototype for Retrieves maximal possible correct buffer size for synchronous data type(). Prototype was for dim_norm_sync_buffer_size() instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Shvetsov <andrey.shvetsov@k2l.de>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/most/dim2/hal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
index 39e17a7d2f24b..30112413f20a0 100644
--- a/drivers/staging/most/dim2/hal.c
+++ b/drivers/staging/most/dim2/hal.c
@@ -97,7 +97,7 @@ static int dbr_get_mask_size(u16 size)
 
 /**
  * Allocates DBR memory.
- * @param size Allocating memory size.
+ * @size: Allocating memory size.
  * @return Offset in DBR memory by success or DBR_SIZE if out of memory.
  */
 static int alloc_dbr(u16 size)
@@ -778,7 +778,7 @@ void dim_service_mlb_int_irq(void)
 	writel(0, &g.dim2->MS1);
 }
 
-/**
+/*
  * Retrieves maximal possible correct buffer size for isochronous data type
  * conform to given packet length and not bigger than given buffer size.
  *
@@ -792,7 +792,7 @@ u16 dim_norm_isoc_buffer_size(u16 buf_size, u16 packet_length)
 	return norm_isoc_buffer_size(buf_size, packet_length);
 }
 
-/**
+/*
  * Retrieves maximal possible correct buffer size for synchronous data type
  * conform to given bytes per frame and not bigger than given buffer size.
  *
-- 
2.27.0

