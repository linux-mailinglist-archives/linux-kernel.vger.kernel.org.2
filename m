Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6894407593
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhIKIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhIKIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 04:21:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B728C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 01:20:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so3041953pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saE1f8RiGUDSi3LeDejUIjcolMwXrjPjncpfc34mabE=;
        b=DWdEZ6xNiwcKVJkG05/sCzPoM6U6pdwnTVoSH1qSpKkmHtgPz+yWVKG+cNqR9xpYtD
         ADSGDDwTmNQAEvkZW6a5vVLOyqFYmmXYr5zpIVvwW2/xgZZjXauNcbM0AhqhbWfH6xNg
         lWoWXUZdbaDz1NOHQxVtIbBweNb8yp3dcWbOoRE9XWJTxblPWpFZABtlbc399RcOlBUS
         78L1O6621ErMJtyQa0StjUMYGnsqIAr0xcBBMH4IZwYg+LUbXaSNZGqnuHflJALb9fyr
         QXNgHZaM7cL2zI70jvO5R4I2Ef4w7csQTqM8HOnM0SPNx5swcQmjfkDkOy/EdBcHKMJi
         VqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saE1f8RiGUDSi3LeDejUIjcolMwXrjPjncpfc34mabE=;
        b=NjPdsScXmc5Ahkg6O0MX/CzBbo1HHFRnPN5RPjixdtOYYTO2NK99zGCPXiYgSl9vT2
         cJH23v95LaWvMuznjuFpNgcuOzZ8j8iAyV0OeNwXBOlpOBzP+9AtG6jnwyKUiUOnfdi7
         CJo2CHkSezi+g5r+Xo9PcQbWBarqAGBzxNbYzom53YB309ajwqx6k4h+KOYVQ6wCGsWZ
         nzrf9siUC7mHNJRTWfMNKfOrOQDW592rjTKjl9g4xRupccKtyECTaIs1tpfmzJEANT+7
         alyoJk/0dsvKdhapDIumfJ97jWm3asIEHlBlqWrY80fJCg81H58OvJyog/Yj09shuAj6
         p83g==
X-Gm-Message-State: AOAM531B3k0t4Zj5D6LZ6yhnkECqMjwEM9kP4xsfdTE+iVqGsBYjRBpP
        /OHJGwH6mgFfSycQNKiy3u4=
X-Google-Smtp-Source: ABdhPJzZBawOSJqNGaJ1sI1Imp99By5xqqwhWWYyR5v2qijfzSMjnwnzjOJ9WehfDjQQ4Cgxj3MRvg==
X-Received: by 2002:a17:90b:194c:: with SMTP id nk12mr1906163pjb.50.1631348415689;
        Sat, 11 Sep 2021 01:20:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t3sm1219943pgo.51.2021.09.11.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 01:20:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] psi: Use DECLARE macro to extern static key
Date:   Sat, 11 Sep 2021 08:19:50 +0000
Message-Id: <20210911081949.52194-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

See patch 'locking/static_keys: Provide DECLARE and well as DEFINE macros'.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Tested-by: Zeal Robot <zealci@zte.com.cn>
---
 include/linux/psi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb1476ac70..cd1c205a9dd2 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -11,7 +11,7 @@ struct css_set;
 
 #ifdef CONFIG_PSI
 
-extern struct static_key_false psi_disabled;
+DECLARE_STATIC_KEY_FALSE(psi_disabled);
 extern struct psi_group psi_system;
 
 void psi_init(void);
-- 
2.25.1

