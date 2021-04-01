Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B233511ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhDAJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhDAJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB9C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u5so1835838ejn.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=fqKPBTA4YqLvHiSqr0e/3V5WUlX09ghCtNP2BEZVo4yg1MYHYXSXCpyPy3wpjsz1US
         zlMl6TDiTEnmXN6s1/BLHBa/CEySzUeoF/03a2l+BzxtwTii0uzBZHkTySL3RvvLsyM1
         Y3LYnu4FWUbFwovnLiWlJzdB4J7lmAVrTWtWGm9DKQ1Wg/12yfeAGNU04cPGFHX4szZY
         Ny1qpYp4nMatqDYNh/vtqjjDTNijVD3KvClQeAd+H+3357JvtvkVci0+JFjnRBx4wfOJ
         vS7R2jK1K6sdL6DyFw7ALGMpdOo7yc2fKguP8z6tDIWcVweVW7pgkQoL6qNkNSlcy04O
         6XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JF/B2DTWQj/w/voWt1Q8G3VMWTtinDgQ1FwmaBkjzU=;
        b=RBTS75y7jjc9xNpvMRd9cLZcUatCUShU2HLFr9si/PEjWswW68RKSzItu62bMhYPTT
         z8Tq/HKSN4/6oHdlMAQ4VBhEI8YVIB5Yx1K9AfUgYoFezcCnQkG6fSpcPZxWTKnot1jX
         cDOsw83x8AqjCZnSq8uxEwqYDqyilHzJrellRtrKcmoGNH5XZrBd8KqwlI8+adhgvIY/
         jCeJAF7bc/I4AYwmUa0+YoJxbiGyk0SxZBJNwYvy6ZjjFLNcqhs1KXRWgSJcAac/ye7r
         pm+bAw6TZr56Nh1VgstfbC+U+mv5tjyqpNIkO+T7YcPFADJ8JyEZe1ecD44D+RFxs7LA
         YgkQ==
X-Gm-Message-State: AOAM530nuUz950nmg6+ClaeueGYnXPebOiFCAGEsNYkQvnDNpZaxHNUa
        UnKqKg36LoB3k+OKiSuHgHU=
X-Google-Smtp-Source: ABdhPJyowsWjq10HPM6L2qVdOerWWnxHTpPIRI+5Ii0QcEp4tm0KBdy6VnG9TNQoVAUiqmPL4JUfyQ==
X-Received: by 2002:a17:906:4705:: with SMTP id y5mr8189186ejq.119.1617268912668;
        Thu, 01 Apr 2021 02:21:52 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id g11sm3237786edw.37.2021.04.01.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 18/49] staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
Date:   Thu,  1 Apr 2021 11:20:48 +0200
Message-Id: <b89831a6ad12c895c6d78c3bac721ef28da747d1.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE call in core/rtw_ioctl_set.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 7d858cae2395..14eb01df69b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -451,9 +451,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 
 		/* SecClearAllKeys(adapter); */
 
-		/* RT_TRACE(COMP_OID_SET, DBG_LOUD, ("set_infrastructure: fw_state:%x after changing mode\n", */
-		/* 									get_fwstate(pmlmepriv))); */
-
 		spin_unlock_bh(&pmlmepriv->lock);
 	}
 	return true;
-- 
2.20.1

