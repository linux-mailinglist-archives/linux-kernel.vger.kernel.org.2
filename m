Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E713036FCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhD3OqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD3Op1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A11C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so19288061edn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8g9oz5Ic1TCmyXqC+DaCK2PY+uamXld+Xrd0WiL5ARM=;
        b=Tj0ADbLDNc0uOnrKa6SGsh01aGDFVSeOgqRBKLMByEl6WiIz/TD/qb/nlHfPNIPInF
         bLOYklDzQSYxSIA9CujXxJSEyHCbkOS4iVm8sxPpwO6mjfCSdcL4a0ctd/pAvrnkUYzK
         OFYKzRTHFLlXaaVBWu2OsW286npGVf8pnQHWho0QuXi7FtbIRsykghvOp2HfITYeNVwN
         y2gV/seWlWs8ao9YlPgFpLLUlVx75j7w67mVpwoP1KXQL9L1aFkesjRjw6sE7repG4tI
         tBYppqSIUuA5WCjHOTLCfE0F2DyutJLnAABkf7QvsrSbUrTTHerMp8wbCYFnYmK/cgSs
         ye1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g9oz5Ic1TCmyXqC+DaCK2PY+uamXld+Xrd0WiL5ARM=;
        b=eS5qpI8JHkPNWOrUQhi6k/t4x1B2bRryOnFlAcFUiVxGpAeN/gQwHVlCmHv/+BAFV8
         5sGgVreVb6EYHcT0V7ANzZgO7AcAHdikXB6E/cjXqMk5TvQNUHhtYOwjNUAHXU8AAJPp
         I5cAJYoL5YiXHjjjbkmeVlVvr2u5+vQhAKzdMHYiNiNhP75cWFgi5fBsXBq/vXEVWvBq
         VMccfJYy4temoRcwyRI73AEReifZcDz2zm8MyCz73jdn4ZANLSIQy6pd8PdSAKqAxqFZ
         iuCey5qChvDi7HnPL2bipYYSiXQrF+DDllsktzeh/pTlf+GCnpUS0qNbc/Nb6RyNzhyZ
         zRPg==
X-Gm-Message-State: AOAM530TSChfgT/n3jmVLP8mJ8TcOytojInkRq800ajfPoa1lGhX3t6k
        lIYu6wQmrSC3ZLPSI2QRriClBI6oBmg=
X-Google-Smtp-Source: ABdhPJxutpph2AsljsAdsNGmJguKXFi+l1grJiSfnpP/ftdZaMJaZgjtF06aHBnbFRQ8VerLqXdfBQ==
X-Received: by 2002:a05:6402:17ef:: with SMTP id t15mr3613432edy.385.1619793875515;
        Fri, 30 Apr 2021 07:44:35 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id u19sm1426672edy.23.2021.04.30.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/43] staging: rtl8723bs: remove unused ODM_dbg_exit macro
Date:   Fri, 30 Apr 2021 16:43:44 +0200
Message-Id: <87faa19a23063ff9cfcbb66c86d8a1ac8e9d165a.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

