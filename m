Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B848B36FD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhD3O6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhD3O6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B4C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f24so7143359ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZ9GqwS1PPNPtRn+ut+6mZGIBFXs5PoH/wfecY65hmw=;
        b=bhLu2/oTRWyIzj2UV8+NfW3op9aBa9qldGvAKgRoC9EwlHzCkAnIwxxmm0yI8mYpGr
         li5k4bO1ahwQsE9UCMc6x+Bjbv6becBXuib30gWQMvtE6kPTgs5jUKkzo0Y8FbNGcaXN
         B2rMB55YocTMZGTcvQ6tilDY3UwgV2vSy/nNld4pINWwRUTIG1ZzmT/aMPsT+zcOdTE9
         OXIKf/qQih212Z5f1M8ENZJn1f/WjLD9rAx1Wnvj+Oga2zGdr7vLho+IZjQLl/h9Rs8l
         RdBi8DSZp1rvcwSBQz5wmCpWwCcq8mu86swaonraLSAJbTtw5iNEaAUxdElbtL3JUoFY
         lKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZ9GqwS1PPNPtRn+ut+6mZGIBFXs5PoH/wfecY65hmw=;
        b=sQ8lznj/eA6ejaPkXTQ+93dR6DvZ53ZZI4hGjY6uEv5mtXKYMAXbntD8Fzyf7D3jwC
         wcpaNiBKw0gUlyxZxGXuI0b7PbmBh6SuWZb9tdr8SoxTzUTnUMtfsvv7rLAexzfgFkk0
         fWEwp10Agn2qgrjJAXngYBAh4tBmxIDpc1tn0B1WnIN4mopQM5BNQQMMIOsETILlFFmr
         UQSPfVucLrnt5gjsZMkneNyWfmIrxuEvgkXptt+f25k6lDlUEl+x9eT+TJHkXMoawCys
         YbuRu8f69g3X0v7y5/82W+WYBXXcDIeW+CKNUJQ0bFHV6R9B+SAujXT0Srba+N4VCmS6
         5x8g==
X-Gm-Message-State: AOAM533YnXWMerPTSu9wc7fnYGVPxELA3Xfnsn0+pB3tKVmdPi4+qdTO
        N1uOyJ0O+2o2AzoqcyP0AKx8GC0Dqvs=
X-Google-Smtp-Source: ABdhPJw01xjPEUi0taulog9SrlEy/M73yn1WjUOr491dPEADO8i/uMMHJmRCkqwJueEA+LicKodhkw==
X-Received: by 2002:a17:906:828b:: with SMTP id h11mr4805236ejx.305.1619794654939;
        Fri, 30 Apr 2021 07:57:34 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id l1sm1474830edt.59.2021.04.30.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/43] staging: rtl8723bs: remove empty #ifndef block
Date:   Fri, 30 Apr 2021 16:56:39 +0200
Message-Id: <2caae2efcfbe74cafe6aa000ca7b330cc371dca2.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty ifndef block.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 78b9b4548dcb..3faf4da42bd7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -91,9 +91,6 @@
 		DbgPrint("%s(): " fmt, __func__, ## args)
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
-#ifndef ASSERT
-#endif
-
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

