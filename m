Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195C936A063
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhDXJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbhDXJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C077C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so2420968wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSvvraOsyd4MG94jxJh7UJBUTaYacvAPHYnMkIY3E2M=;
        b=EXI/LACw4X+Jx6IsVtogqMzZTDSOGGmXw4RK1qBZFSdS0R0P8c7pxmWQrQdEl0fGPE
         A7pEroP1SbFu+m4/OQm4EfTEC1TPYVyQAbM6oBNWTvrcyHC3+sasl/Svb435TEctslZX
         sJwY8kezDk7i3+kUjWrKQrvgY6aim5w7GDfcEUKkqjCDg/sirW2ZN7vojECaLoAuW25w
         +/rEnE9TeAwIUPFozd11pXUSHUb3Pd5GrR6wQ3biuJVHyejkL8oz/9mPhpW41CkjUIdN
         dpG2583uEkS/g+xC6P+OZG9QBX/GiYgm7lgflKHXLvcQYSBZK0cn+kQYlYKRdFz6H40T
         rpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSvvraOsyd4MG94jxJh7UJBUTaYacvAPHYnMkIY3E2M=;
        b=iBnWCc58hxKSL0u+acUncCKiFKGt88C3g/agYWzuXnpnrYIZ568lnp9pYMu5U5fd4K
         flY2m7uKjUWYSyYE3dnYJIXKSR36pqbTM03WSuUA40Vun1qw7O9Au+SRIfo4TpJhW36e
         epiYkGTXETDilyUqqCmykpOKH8gPNx/GD7EZUuFUmiPp+cNUgrvW97iwtY1bjUdbvnpk
         IRmaRCbzo6S7AggnYJ1T0zeYp4IzGYz7D1Re6HS5U4MlwhrMYNgblJ1Jg4VGk6dao/Tr
         UyCp7Xng3wpgQwJwZnMxifD4amTGx5a5+wfhKyIo4y/0FEaRzih4UajTEWKHGoz7bzLP
         LzKg==
X-Gm-Message-State: AOAM53009B4VZG8smKPQ2hWMFnzlhqGu+FvIm89fCDoTM/QScguB/I6T
        VQmwXzQtgkkBdW9+sgI9cPMjnCcvagvG5g==
X-Google-Smtp-Source: ABdhPJwUHAkJhhmexmTtc58uRBDfeiZMo+2Mt9U8jKy64XMIp44G3NNKeFC1H1rQ9iHqeFE+rVkP5g==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr10149054wmj.152.1619255014234;
        Sat, 24 Apr 2021 02:03:34 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id c15sm11973133wrr.3.2021.04.24.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/50] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_PWRCTRL_C_ definition
Date:   Sat, 24 Apr 2021 11:02:18 +0200
Message-Id: <97a5e6be392933da40c4c31cebe7ad2d8d21cf33.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
_RTL871X_PWRCTRL_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index be44d72599d3..8e324313ebf9 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_pwrctrl_c_			BIT(19)
 #define _module_hci_intfs_c_			BIT(20)
 #define _module_hci_ops_c_			BIT(21)
 #define _module_osdep_service_c_			BIT(22)
@@ -24,9 +23,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_PWRCTRL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
-#elif defined _RTW_PWRCTRL_C_
+#if defined _RTW_PWRCTRL_C_
 	#define	_MODULE_DEFINE_	1
 #elif defined _HCI_INTF_C_
 	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
-- 
2.20.1

