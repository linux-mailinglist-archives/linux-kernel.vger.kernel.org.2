Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8953636FD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhD3O67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhD3O62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE6C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a4so12348261ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxnsY7XxgR5LPkLt/HzBZqQVJx7TOeoHfiVCxdpmUW4=;
        b=j4JGWIvbwXGC57+Mfn3DaUM/wuFL0F6FTYluNcYgq6ICmQV9eGJSxxSjJlo9MNDFdG
         S+3MQ3rtjIBwVEGllK+3HzJRfdVd1rIoaZAIufvdirOiEbj9EcG1DERcOHlWB1oSa87s
         3PKQ3hkS8eW7cstLQQeSN0qd2MetUbLdhbTY1j1hZT7zVs+1rs1dOoNyOqt/0Y82Y1a8
         4QRaXDSzffIBbRw6nZ2ETTzZ02QvvssHJBEvJT02SlrhD9okw4xX+MKj1yugihv2BWJu
         NlDcv9y4wpuzYXVCKVzQ4Kiv8zp4YPL8+7wiTzlsVdDaz75JWmt/ADuZLeuLrrikCVtl
         Pzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxnsY7XxgR5LPkLt/HzBZqQVJx7TOeoHfiVCxdpmUW4=;
        b=SnPEi+MGGaNe2pWSaljP+mLdZLW7hLCpgNhRW+HJ9NxxxyAskI4Usn0kHsaaKYh2uu
         w+p7rxHcAhOGdXDE+IfiqCGCefRbZjy03UiplaN0L47jHYRHu0enwHL3Tg8d7BrlrFP9
         KXeG5AYwx3vN9R8buvstvrc1f1l9Rvy7SK8p285tCSN6RAKx/sZVxAHk7cRk3d3fn5GP
         Kx6eV4twYypC6JRQY+qYSfx3n0cO6QRkZfbeIrWAtNdeKCcFvQTzV8zjhswVZzSfAPwD
         MY/kMjXRE0tcNinWTctvt9rcm+7kL9tdp9G6d8SMcqwDz156j9SFeQqyHZJ1xNe1n4Kc
         h4Sw==
X-Gm-Message-State: AOAM5334qGICO9s5JLTA86Re5kCALtD7zKKgNKiu5xcqf36uxSvfiHH8
        RNbM8oQEsnnBGFZy/XxqQMPQd0gRDr8=
X-Google-Smtp-Source: ABdhPJyi7EtRhj0YeM8fWzfhkdUBdWEQCASJEQYZYPo9pD8ZPOlca7k+9cxRIIz53BQxwlfvNnd79g==
X-Received: by 2002:a17:907:3e1f:: with SMTP id hp31mr4749102ejc.163.1619794658138;
        Fri, 30 Apr 2021 07:57:38 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id p24sm1495441edt.5.2021.04.30.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/43] staging: rtl8723bs: remove unused RT_PRINTK macro
Date:   Fri, 30 Apr 2021 16:56:41 +0200
Message-Id: <edf86e39fce8a53f52c8c8463d134ea426f58b60.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RT_PRINTK macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 3faf4da42bd7..5c4412bf6fbd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -87,8 +87,6 @@
 
 /*------------------------Export Marco Definition---------------------------*/
 	#define DbgPrint printk
-	#define RT_PRINTK(fmt, args...)\
-		DbgPrint("%s(): " fmt, __func__, ## args)
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

