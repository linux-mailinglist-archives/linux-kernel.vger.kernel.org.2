Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36E636FD08
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhD3O6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhD3O6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B8C06134A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h10so82958860edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6sZe3osaLDDSPNYI5JYp+0cY5GbbYZW8NCqEYTYFpk=;
        b=ZJzofE0NNuKbONIigmFF0JVfpGh+R5hX/IzBidzyuFDn10LGL6FjfbaoOHLoymPCK5
         CUdy+Dr4jX4GWehV2E7XN60l5TLBVN/XAYYa2H9PYsQZrr/a9pouMBpi64lD+j5rxm+f
         YMPUrqu8oF+3bpybdDOhxPZHFBfpHfq9T8wGJ5qIsxPRGzjAx357IzHugRwi3DX7rCBq
         CNNrdHschaagMI/OR5Bky+RL5Dg2IZzBwMyu8HwGt0/FyiFIhHXpUtkB93bzDirCnLhh
         fqCipELToemNe4EuqDiQvdlWvZJcMiDySkYL757tX7l9rZ16z0tIzSevFXlJHcNWade6
         ZOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6sZe3osaLDDSPNYI5JYp+0cY5GbbYZW8NCqEYTYFpk=;
        b=C4241zqmN0O6Ez8+muYcjTZL+KuKbpDSVrJ5PoownYq+49pEZF5nVTpIGgUC1qMNSS
         wFnJ8Cix1aAIbQvFl4uq0RdZpetpjTJpP1c19YYVGpSNYkU4yfgK1i3xxzl6z1xpmEok
         aPQozHVhLMTdFtsJBMNc6LDbBPSc4YJSdwFCLuQ1a8o9XCzP+LN5K742LH+pl/adyNTh
         LAWC6m5acjwGXKC9NlK6Zq/7Ixj3al9G8zWffLDx/Ntzk97s1tDagmgkj3w5QuMjZHSN
         3Ul+5so9PplaqjOzVJxTpi/2E9Brl3StjW20L5ktK6VOGryYDlAXZIYjbvLj8FiHtiJN
         f0eg==
X-Gm-Message-State: AOAM530Vb3gNyMnpu9VXCRIEsiI3rWkaTitI2fOAS4cKLfHVTY4y73uW
        guHqxCy4gMrj+umh3Zdy2FuhSoomVtM=
X-Google-Smtp-Source: ABdhPJxOyHqhJwlXhFGFifdR9Naz9OS82vDud9nrSMsxaI+cMdzLQoMAaRaHUtmSKZXn+1ZbK+/nQA==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr6461563edt.152.1619794651336;
        Fri, 30 Apr 2021 07:57:31 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id w13sm1547883edx.80.2021.04.30.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/43] staging: rtl8723bs: remove empty ifdef block
Date:   Fri, 30 Apr 2021 16:56:37 +0200
Message-Id: <e30ccbe6cf20069e1a24a7a150d0b6241a7b57f8.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty ifdef block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index c359eabebb67..8ae9948fb0c6 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -95,10 +95,6 @@
 	#define ASSERT(expr)
 #endif
 
-#if DBG
-#else
-#endif
-
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

