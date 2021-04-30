Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFD36F68F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhD3Hpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhD3HpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CDC06134C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id f24so5274806ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDyKLq5fjyeL62hL+6feutXGTzuTSzr50xAs4CUIRQM=;
        b=ZmpoSWhmVFsEPGYgXDKray/EBzI25ZlH/YI99h7hu+uqxlFN8GQMvHi2Ag/HB14fy0
         t/DrK8IZk3dcbDde0SfAEgTAn1nDxXB3oUxaCuEirAXMtlkcqglvZ37UHDkN/O5zKQ71
         gnbtFASbAXHjhk6g59hwR9476SfqoA5EA9I25uMJkyIWSVdr1pTMDsbc26/QQmx9GMo6
         kwa7Dhvn+G62KQx4tg6rlz56IyeTjvLbzbLl8iuMrNUJonfWvSg8ehEz16k9EmfP9dOM
         8kav5uxaoNhjzTVIXtWHa26fIbjqcf1doevV4G1Eixzfm07Gm0U6czRExLZ/YZ6FOsaC
         3mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDyKLq5fjyeL62hL+6feutXGTzuTSzr50xAs4CUIRQM=;
        b=l5vNwNXQ5XZvWhou4LRXavGlwbuJHRtTguduf8TNtWdMfNw4XHVKOtOQpXXTleJ1UV
         mKo8m+L8pvtZi3UFNDkg+tS3AUN13L3aS3nK/EBVK7MOhAeF20sF+A4/eBJDVeNuRxRK
         YA+e4/xNDmqO+0Lgpn/K/6JGCmsaRdbjGQinLNtnLZBQGAjuYvGyuypCE8mNNZ3wBj68
         vduCes9wYPPAaOSWQDqO0hsw5yVkBR0EOp8s10AueKNebQfwIL/8EJrgXmIPyWhS/iKw
         lIxucwEtqmQT2/nUfDB7mrJYtGOs/g1fQyVugnkAFHdvf40BYXldsnCLbjItVEKm7K7c
         Gnyg==
X-Gm-Message-State: AOAM533j5sznUP6hvkWlADMr4wL040Q43gbS6YMUWkoRpSofBNBmDgvf
        1lIXWf2L2UjHv2fEVRUxrEm4OcAe5o+RXg==
X-Google-Smtp-Source: ABdhPJxr1h+aFB3HGcPF7cWcGX2AbMkOLV2t85Epzc4lTzjBeoI9rk8lfBNsfiqkJN4qri+q7zmZ/w==
X-Received: by 2002:a17:906:5a83:: with SMTP id l3mr2847326ejq.50.1619768670965;
        Fri, 30 Apr 2021 00:44:30 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id f19sm652724edu.12.2021.04.30.00.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/43] staging: rtl8723bs: remove unused ASSERT macro
Date:   Fri, 30 Apr 2021 09:43:34 +0200
Message-Id: <007c7e1fd9681674dfa71ee2a4577b01a53764f9.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused do nothing ASSERT macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 8ae9948fb0c6..78b9b4548dcb 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -92,7 +92,6 @@
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 #ifndef ASSERT
-	#define ASSERT(expr)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

