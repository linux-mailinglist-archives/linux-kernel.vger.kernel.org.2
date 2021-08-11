Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28F83E88B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhHKDNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhHKDNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:13:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D61C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:12:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a8so1195731pjk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nA6s5SUKPBQ0dyQ+8gQLVtYbBBkn3UOaZ+NSfCbjMkg=;
        b=p5LDgZ2t+B+JteWwdlOOKCismHfQQXlCRhIDfxKJg64yBCytrfwvqhyPLHbmNHDc3H
         WI5qCmW6TFZxjefGoteq1BOf7SbmmCyy5HN1TP0JEKib8gthBm/vP9RbbW0uyR0ASLPg
         RY0RtCK62UPLIn6CmgPOrEGOwNT2hh2XYosr4RT9SDrrOQZ9mnC5qdQGg7lYqvdOtnmi
         18Cqa6mKu0ogxFQMm7gphFFzxaX9CowRtlZ5yJx6UOmzXj/8dRbHe77V/nF2qcJlHdKS
         CkLHd9rFQz5thhQpvia9wf9aQxJNSmxAszcI79LsRmcl2cf7O6IY9UqRavRdDREtOG7T
         AQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nA6s5SUKPBQ0dyQ+8gQLVtYbBBkn3UOaZ+NSfCbjMkg=;
        b=Bptg97i0wNA+wWqQh4bCvJeYHRMy7Ds1gV64FhexeYjL7mpRIHElZvTSic44mKw/TG
         5Z+Ubn00lI+IQoSof+7Nbqtjy53UCYwnvc+ciSF7/NDuFcZbwyz8JjwxE1ggh+9aUkFO
         /qhuX/92/kfpKB1nb7oi90uUWC3MfNFygAfXwLS0T6OhGN44PQYskdQkonbbw9Da70Eu
         OyoXSMBgrp/h1k5hBcwcpSy3loMlEgtJyqx41kmJYIsLP/G8D6bJ4prSQab0vUxHj3qY
         1dCt2S2v4hiOJ0Z+zFB0plF7ZH/SgcriLzy9/PcTXtKoyvVmn0/bwCVZBPlnt+pV/GzN
         v5jg==
X-Gm-Message-State: AOAM533CA2TyRS9f3AghsZlTjucbsP3ZBtNP0eUx8Gr/FmKQ0vfFogFx
        bzcL1xMgGMojkN9QvJDlSk4=
X-Google-Smtp-Source: ABdhPJyysRuUq7d4TEhgCa6TpIX0ck1p4VhxU7XDNRsw74KRlsI/BERlTGNzeP/A2anDTf2uYAM4UA==
X-Received: by 2002:a62:864b:0:b029:3c7:7197:59fc with SMTP id x72-20020a62864b0000b02903c7719759fcmr28120433pfd.59.1628651556775;
        Tue, 10 Aug 2021 20:12:36 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.103])
        by smtp.gmail.com with ESMTPSA id q21sm28800989pgk.71.2021.08.10.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 20:12:36 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        will+git@drnd.me, romain.perier@gmail.com, yashsri421@gmail.com,
        apais@linux.microsoft.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] staging: rtl8192e: rtl_core: Fix possible null-pointer dereference in _rtl92e_pci_disconnect()
Date:   Tue, 10 Aug 2021 20:11:35 -0700
Message-Id: <20210811031135.4110-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable dev is checked in:
  if (dev)

This indicates that it can be NULL. If so, a null-pointer dereference will 
occur:
  priv = rtllib_priv(dev);

However, the value of priv is not used in the remaining part of this 
function. Thus the else-branch can be removed to fix this posible 
null-pointer dereference.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index e85d9c2cdc96..0eb37a95b519 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2557,8 +2557,6 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
 			release_mem_region(pci_resource_start(pdev, 1),
 					pci_resource_len(pdev, 1));
 		}
-	} else {
-		priv = rtllib_priv(dev);
 	}
 
 	pci_disable_device(pdev);
-- 
2.25.1

