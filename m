Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91962456E61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhKSLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhKSLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC8C061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u18so17645144wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAECHsMB1BAMNzWLYuy9BF+/NzkUHBVu82pDhfW+Dp0=;
        b=pqWXeOt4hAsCFrYPQA3XEg4mS9Oyi/2dF++yqkpVsXizOeUdNkFJAfXRCBLoZmiavc
         wA7SFr0zV3eoIAr6Wc6ERgwJsXB8b/Ww55uqzN8XdvVQQnLLSvU8s+gW2zvjxg9cARcM
         rG458rZyUpdIGs9sO52weUCP+GcPT7iwSlISz6Ceqtd/GG5VHCM/Dw70HSsoF85C2SX6
         JkFWVI5DJfJBv5L3qxaBqWTh/L3pXbaxMicfO9paH3N2EGWFjtj4qd4QbYkDlF8YDxHH
         6NyT2U9kAGar3nF4Oui/cZKBCvkA1zGAD9eTpf+QGVcBHAc5QmI3W7NGApbDPPVDQYvi
         L8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAECHsMB1BAMNzWLYuy9BF+/NzkUHBVu82pDhfW+Dp0=;
        b=V2yTNg+lBdZVrLT58xGrZAtqiCz5rvhZPN8VuvlzzqfVPgBa5TjtHtfqO4Dn2G0WUr
         wHD6Ws8qX2oYiogJktlg9w9KAvBJJNEcrq0B4ntgyy3Xkm5ZJLkrQ2uuGWusd2Tv78z9
         FIcj1HCDZKyGTQ6gckJo6ISphNXIdJCXClciYmB493d8ODExnNss+vltr8F7O+ZU32E9
         3piFGx563OyPAKiBcxxe2g5jD81krH3nuhANEbLx7tQGEk+f0q6k6GbCb5YcFye6o+zp
         Ue/ZJF+1dr3IzxKu/fbk0YP9MqASL2gRLmiU9fcEW0NYICRk632fTsZ2zKPe+MmHpisv
         MwKw==
X-Gm-Message-State: AOAM530RDQMKdKGpE81EeiLMIYztatV8XvviL7qG3DGUWyWah9qaaWyr
        olTXm3FuCs0tZuU3kRQF7gcfnUon/XsgGQ==
X-Google-Smtp-Source: ABdhPJwxe4QJ2G61hGD2HcTwbkq1v8CA5FFkdfVe4CY/60UAZLgEtqkjqtsD7bXWo5W193np5KhmWQ==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr6602142wru.182.1637321837729;
        Fri, 19 Nov 2021 03:37:17 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:17 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 09/17] linux/offsetof.h: Implement offsetof() in terms of memberof()
Date:   Fri, 19 Nov 2021 12:36:37 +0100
Message-Id: <20211119113644.1600-10-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memberof() instead of explicitly dereferencing a null pointer.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/offsetof.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/offsetof.h b/include/linux/offsetof.h
index d0e2f1c34aae..809aed37ad29 100644
--- a/include/linux/offsetof.h
+++ b/include/linux/offsetof.h
@@ -3,13 +3,14 @@
 #define _LINUX_OFFSETOF_H
 
 #include <linux/compiler_types.h>
+#include <linux/memberof.h>
 
 
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
 #else
-#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
+#define offsetof(TYPE, MEMBER)	((size_t)&memberof(TYPE, MEMBER))
 #endif
 
 
-- 
2.33.1

