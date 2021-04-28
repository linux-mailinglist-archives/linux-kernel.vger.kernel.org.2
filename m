Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87436D31C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhD1H3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhD1H25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:28:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:28:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so6460771wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inaZ11OshVUyUcdzLFDTaYvVRptIXVcvuczMgFqs544=;
        b=AAXaIywtb66F4KWBO70Z+UEAm60DjqqIOzhYSEdJGLLCQ1d852aL5f3kzf+TSFOAgL
         6MYs/4ZmDWlhHFhp23W90MudYErdst7mwA7+OnSwBp9ULeDcfpT410N7nH8/YDXPCk6j
         CeS/fBeKXzBB8CJenjGxup1Nrcwf+d33j4z+x6OHULrs8tfJXoBwJAV3Ux5kIce066rO
         HUcyz8Ma7m9Mp9LB3/dC1N2il7//zpCy72V/2/0VH8DzUO1deuoq07emLDoP0y49wcL7
         B7lBy4QuKPwhpApCMeq7y+MV6fx14VLStphAm7jl5LQV8li3O0Fq0R9ria8u790BgxES
         9pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inaZ11OshVUyUcdzLFDTaYvVRptIXVcvuczMgFqs544=;
        b=IFKCmnr6ujEyEXoiT33MaHw1rTEe3iQaf327+vNWUD0bPhfvZeeTLRiFP8P1akIu5d
         LNelblGrBZLjEFDr6EulGC4BTu4Jp0oBj+FNPiNcQmij/LVGUOMrcXyybvszfWFlTj5x
         v6P2AbO7WmIjoYke4gGeLUfPOZGcGxrm+4T4qgAPUBITzA+0N5QvIVcj9wntgb75pN+A
         VcSlyr+eIR/DWFHjvIFgkgIo4PS/SY+R4vMYeQOYq2Gx4rg9LqlnG7GlxNwmbZd+jtj8
         zZwYCg2xeTbPVNnABX08VOAOlOk62Ax0ZbwYAH19yIcN+5gQ8zS9FK46LAe/Y6pe0CVq
         /MAA==
X-Gm-Message-State: AOAM532CsW9i0b8Oq8ykFtKCDCS4hrhiPQDiWloQjxxKGBKk3t2hFiQR
        THm1m44Gxzcv72Z9836ePX5XdKNli4sIZg==
X-Google-Smtp-Source: ABdhPJyPItVQLktV27LqfZnn2D+AHVpgGd//euZ4qsJYX6704Hm6HN17zQwChv89MIb2AuZRvz/1fA==
X-Received: by 2002:a1c:7707:: with SMTP id t7mr2689822wmi.76.1619594890782;
        Wed, 28 Apr 2021 00:28:10 -0700 (PDT)
Received: from agape ([5.171.72.119])
        by smtp.gmail.com with ESMTPSA id a2sm7315785wrt.82.2021.04.28.00.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:28:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: remove unused macro DRIVER_PREFIX
Date:   Wed, 28 Apr 2021 09:28:05 +0200
Message-Id: <2fac5d7f2334f0a9765f2ddfb31502323e49fce1.1619594707.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619594707.git.fabioaiuto83@gmail.com>
References: <cover.1619594707.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro DRIVER_PREFIX.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 3a5b083e95a1..7f96ff66915f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,8 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define DRIVER_PREFIX "rtl8723bs: "
-
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
 void rf_reg_dump(struct adapter *adapter);
-- 
2.20.1

