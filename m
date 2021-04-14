Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680F035FA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352627AbhDNSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347626AbhDNSMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D6C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m3so24830952edv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmKShNJOq6+2r/pcFVOsH3BuY6l+Ra5OlenQ7pEqnqQ=;
        b=HtOKDuoGu95gJsvLP+zYZwjWmOr5BtTfd4KX1etWcBAQoLUdWPopIHOQWQ8KhTuhho
         0MSWHDTJCo7h3hx2z593WazWNcl6i0t1gE0U4yJFm7ZAheNJwJ3He/dRC4C9r9SDvaPY
         uZ3rbqvBvFEu92pZQR/cn4UmVptzDzzlOq8jXyIlq9a5jPc2DEx5+VUA4nKXD3BF8Ejh
         CAuPqKB9m7k/MWie0o3R16Avo0GW6+2aR6HQGTv4VIhRkSoI8O8QzGPk+NSTv0Fp3XGy
         Cln3XUn4IWL+ui1s1EIQ5klVDwPlpQJPFNXxX9wM4cIUfvIdAQmnkAT/0tbA6cDBll1z
         B2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmKShNJOq6+2r/pcFVOsH3BuY6l+Ra5OlenQ7pEqnqQ=;
        b=YEPrEC92zNTucbivlceCAAIz3tN2CgGKzgtdELfO38xwsB6FCgUWgZCXP4h+Qg0aiz
         jujKwdh9Vr1dRUAhxXjKlJAbKJS4AmYE+xfKDXv+AE/C4eKXjNh4EK+GVDx+nsGFATVb
         cOiUN+R6IuCfJNlWMxkvPL4pZW+0QVimHZj2sUogu6fs3Jv1n2zNxL/J5GsrSUqQ4zwR
         87j9RnsJ79hRBF60mEHJlijkfdEH1H+y7bM+TAK0Z26k4YzCFL4s4B9kwkkzVr9hOCgu
         ia6M1Vn7VK1CLDRBfpWrZ/QSc49wOaUBrmwI7yLDA3BNKxzARQyEZwfbr/OzX15MiiFn
         BR+w==
X-Gm-Message-State: AOAM531SAogpvNgcj944ayy3Ey1mKCsvxpARR3r2hSdhyWjC8oiVAVio
        tHgjwYs0M/1Haf6ofc3Bhu0Sdg==
X-Google-Smtp-Source: ABdhPJxGCjbKgVr7boBMoGbxjfqHGMXuiWIsdwvVGeLqCS95sTCVJ4eSuTj0eKMpNKqJLmMhF/lg2w==
X-Received: by 2002:a50:d7d7:: with SMTP id m23mr178840edj.378.1618423910286;
        Wed, 14 Apr 2021 11:11:50 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 15/57] staging: rtl8723bs: core: rtw_security: Demote non-conformant kernel-doc header
Date:   Wed, 14 Apr 2021 19:10:47 +0100
Message-Id: <20210414181129.1628598-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/staging/rtl8188eu/core/rtw_security.c:10:
 drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'p1k' not described in 'phase1'
 drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'tk' not described in 'phase1'
 drivers/staging/rtl8188eu/core/rtw_security.c:478: warning: Function parameter or member 'ta' not described in 'phase1'
 drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'rc4key' not described in 'phase2'
 drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'tk' not described in 'phase2'
 drivers/staging/rtl8188eu/core/rtw_security.c:517: warning: Function parameter or member 'p1k' not described in 'phase2'
 drivers/staging/rtl8723bs/core/rtw_security.c:1937: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 9587d89a6b24e..60b724729900e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1921,7 +1921,7 @@ const u8 rcons[] = {
 	/* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
 
-/**
+/*
  * Expand the cipher key into the encryption key schedule.
  *
  * @return	the number of rounds for the given cipher key size.
-- 
2.27.0

