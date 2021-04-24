Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50036A066
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhDXJGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbhDXJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068AC061348
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x5so384579wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AedyWXn8rMwjV4hec6YOWAkym+19jwGe7xRprf/SrlY=;
        b=epQyqZ6ltD1dxx97cm/nNeLkZa7hwfHcm5+du5Bhe2IgiwDGXS9JZEmjnfdIKwSzp9
         sI0JYNKhfxvVEbFfchHhqF2XD7y3iqkN5mEUGJSs/MeyHxWxR5V0QBukbY9IOReN0F+I
         nHw0vMrqgwrwaR3fhAFtsotczFd9L881UVZhTty/uK32oDtr5WMh9Y9p8mRD6kranGzu
         kYSLc9/xQKKCu7LbRqMzmtLDqRg0t39VOINwkS+HXzKLd1WzsI20x0SVyURcSEiitVCw
         gZ706RiGCcI2SQVry0XzCZVCtSxZKoVYeD5OagXlDXXYV0I2KOUOyowOC9QT//9kMAyc
         1UTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AedyWXn8rMwjV4hec6YOWAkym+19jwGe7xRprf/SrlY=;
        b=WiLuoPt14ypmtUhCMU8jrktdNuR7LqjvdzknLWviRxY6NAECJZYtkfHu8EbROjduM3
         7clT+54Kcj3DIebRCGESPNOIO1vTIaFj4cph3UGoKzEW0k/shhPYimjQjq6AGaBzg18w
         yBIhMuYlRPlfJy1DSCuNXgKTjh0wEZM1L2UljVtFJX31997fGJWoksfFMA18SeGwmkYP
         3b4pblQofcDLhWPFMfp7JFWx4pUGA2sQe8uVgNawdHLVHKqErErA3uUUt5jASmaQonUE
         Fhlsb15fxju3zuc304tNTyYOW4OvnQa3QxFlwtmo4Sx0cAO7vCCS0ZErpSnIpj7uiWJz
         /1tA==
X-Gm-Message-State: AOAM530Act5lk0veRjc2I1L7XR/h9WOAYfaNwumledHu1U9RQVyXpUPP
        TKujrx+K6CFClMhQorVqdXB4rb7UYsrfoQ==
X-Google-Smtp-Source: ABdhPJzXWXy1WdshRSy0n8uh2Hp2/d/v80tKsKKf6WNC5ABY2khO/hQnp1ABBkfZKd3F76/YAab+Bw==
X-Received: by 2002:adf:d1e1:: with SMTP id g1mr9974252wrd.218.1619255019272;
        Sat, 24 Apr 2021 02:03:39 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id y125sm10129608wmy.34.2021.04.24.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/50] staging: rtl8723bs: remove unused debug macros tied to _HCI_OPS_C_ definition
Date:   Sat, 24 Apr 2021 11:02:21 +0200
Message-Id: <044b8f9e0ea4f09287b73be0c65a526606c86d89.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
_HCI_OPS_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 130cfe3d2032..3becb1b8d15e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_ops_c_			BIT(21)
 #define _module_osdep_service_c_			BIT(22)
 #define _module_mp_			BIT(23)
 #define _module_hci_ops_os_c_			BIT(24)
@@ -22,9 +21,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HCI_OPS_C_
-	#define	_MODULE_DEFINE_	_module_hci_ops_c_
-#elif defined _SDIO_OPS_C_
+#if defined _SDIO_OPS_C_
 	#define	_MODULE_DEFINE_ 1
 #elif defined _OSDEP_SERVICE_C_
 	#define	_MODULE_DEFINE_	_module_osdep_service_c_
-- 
2.20.1

