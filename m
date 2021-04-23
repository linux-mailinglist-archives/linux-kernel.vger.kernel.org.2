Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39779369579
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbhDWPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243434AbhDWPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF1C06134C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n127so14395539wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCpiiCQz4n2K9iobxaVb23hXxM/13FWIKgaoFavgS9Q=;
        b=ELWrR2ZuwBKahpByxdc2iD2psYXGXrE1IMAt5LjDvvsABmjmhs7YfEd7bqEgpt/Rz8
         ITnNVROT/Vw3medKBriweN2pyDvJ67o4Sngp5vV+g+maOA/KGMj7v58lNOKEXQ+V1aYK
         dN8aOJ1JJyYGDI4MNq+Lz5ReDN9xERQCpnd4T/q200wE5LlcFlLQYDxQpJWLbWSJd8LA
         qEbtB40X0EIB9q8Ic9KCwWxd1pS6BTn8nSBawZ5+GB/WUGpiyF33xi9Jp/ZoYh+SUdz2
         MBqN1MHMbm5s190JF0jz7JsSX4KRQTeX+5IxcFeULFyZN9IuXNX9mK1xJ1rBpuZHPdXQ
         Z4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCpiiCQz4n2K9iobxaVb23hXxM/13FWIKgaoFavgS9Q=;
        b=ekATs22e4OdoboKqpWpJWRk8TW+pO1dM9M4aeK4Op3LFU06PJF52rfZ0tttwMtP4+P
         vb1/8ExvgsDfTgARkgg+wmcU79cnHe+gJTERjh58Z1IAjVUcQu2m6Ma5/d2/0qFpRuKC
         5Lu6N2ejQpzG5PmhXbr4/1agsZZmAr3QeC4BG5sH7e5WzT5JVfwzKGRxqEx9NGgK8D3y
         65VJOkucqzfltr5oerLi0pBmXdu5tzWgAUhhBzrIenwpYnQdYd9eMagBKMouXM82QzKP
         Ci9sY8YmneS/xCbWP4fe3x00hMjlLXo4GFvati00S4YiDAqZRF5OS3M+EKFTlWVm+e7l
         eApQ==
X-Gm-Message-State: AOAM532Y6IXeHqK6/fVQTx9KTZtFqKt0HQ2krczQj2f/lLMVK0yEzOAl
        PqAiyU2/b+f4r3CFvWAeraU9Smk5L4c=
X-Google-Smtp-Source: ABdhPJxbrrsVdRWSqhZiA19ZmY3z0UHlKWFQdPQ3G6Jp9RkuuMXQVU6MibDcUd/2Ngl8em1PvmpSnA==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr4699087wmj.97.1619189996430;
        Fri, 23 Apr 2021 07:59:56 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id 3sm13305985wma.45.2021.04.23.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 45/49] staging: rtl8723bs: remove unused debug macro definitions
Date:   Fri, 23 Apr 2021 16:58:36 +0200
Message-Id: <56208b7232cd36058aec931cb1d7037c9c9b63fb.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index cde4b1d6a4b7..ad96fe1de971 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,11 +7,8 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define	_module_rtl8192c_xmit_c_ BIT(28)
-#define _module_hal_xmit_c_	BIT(28)
 #define _module_efuse_			BIT(29)
 #define _module_rtl8712_recv_c_		BIT(30)
-#define _module_rtl8712_led_c_		BIT(31)
 
 #undef _MODULE_DEFINE_
 
-- 
2.20.1

