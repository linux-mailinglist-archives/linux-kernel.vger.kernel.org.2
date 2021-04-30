Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCC36F68D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhD3Hpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhD3HpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2CC061349
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so103868582ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g9oz5Ic1TCmyXqC+DaCK2PY+uamXld+Xrd0WiL5ARM=;
        b=jtWasIzfeB3HThE5WNkVGBjNzzs/ezVGmm/nfnq96q7DwYlnKK6FX0vtjsZjujgoSU
         A+KkZQAPP9HHxv3N2ioO5sIimY5WmVi92tWSVV93cB0FEGV4mprz9uHD5vdYibmqN3oe
         MDdGtUvW7GAnyklEj435kjY5Vf1+p1CG4dI/PtUTGC/ZMRteZn0iI6gujuvQue6ngrrC
         t20t9skmco3LMPgxOnoJRze94oLJnuozp/QGCUmbOVe1babL2y9l0bZVUAQBLV1N3a7r
         qq/HqZPg8I1HZPOuDveZKD/DZBPrF2UBjNKQTj3qgiBQ3Oyqci+DAheKrHtsDgA5/BG6
         Gj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g9oz5Ic1TCmyXqC+DaCK2PY+uamXld+Xrd0WiL5ARM=;
        b=ajeoYP7wF+H80I9zfqNab/vh9Sn+y4VOM8iLU06SgMmKAchMFGI4F10HsLvtEbwNMZ
         HgqQ0e0+7deWnE4KLTVtldeofvVuCe5O4rhRUd/SYMYzAyxjn+J22dHKdkB+Mw5CiHry
         aKPVmBpSo4CnrCg1mCeki+WE5CawZIn9FJh+o0171Y6j27Vdv/WovCJIns+Rw+3jXwzq
         axqG04LO2e+uPSsHMDsmAlhpof+C85Xe2fJZQBSrcuUElnZtsHqPV3krzR8KQZO5zs7s
         qvIWGpLDaGrfHcayH917c4Bh9F+QGNsaVmShGvUE3eQIaZ2Jg0GbGw7hWjSFtUta480h
         ol2g==
X-Gm-Message-State: AOAM531fXZhbu8mQyxXOPZ/QPbsbURA8xT5lTndqicfvem5kwGWL/5S9
        WiBLzZq6W8jH3HTs1x4ZdJx8OKfaw9K9Vg==
X-Google-Smtp-Source: ABdhPJwM4pBUsPyTlUtgxhGjYASUNYxYBZNtL0l0pcU7pqA5UqTNKGOzotW5oybvmPaPivDG6E4nKw==
X-Received: by 2002:a17:906:cb1:: with SMTP id k17mr2771315ejh.307.1619768667663;
        Fri, 30 Apr 2021 00:44:27 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id f25sm649547eds.73.2021.04.30.00.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/43] staging: rtl8723bs: remove unused ODM_dbg_exit macro
Date:   Fri, 30 Apr 2021 09:43:32 +0200
Message-Id: <b460dc555a70a80ed0ce9aceae7cf266c549bfb2.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_exit macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 7c9a87fb8e51..c359eabebb67 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -97,7 +97,6 @@
 
 #if DBG
 #else
-#define ODM_dbg_exit()					do {} while (0)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

