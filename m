Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4030F1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhBDLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhBDLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A987C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p15so2978268wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFpX+AmGU+/V3bANCqUU3BguvAC+waEIfHhaAdI4zMs=;
        b=hv1VBzJc6RilH2aUMiuk9Ns6LYXu2wa4OjuB1dtlBKNQoUwuZi1zdEuhynoL4Qr0sl
         zqvRLwKWWrIX+Zuda0m/14lI0psfn2i9Ws28XwDAEcFS8uQgjaLBnuDAj2424NU/MZdg
         bJC0bjoXMrAW1YDA4a8iv3PIyPjcYzUVf44Zn8+D3L1kpHfZY91MGJ7OBj7M7xYxIbnT
         pC3d0vfoY4BZS2eDEImbR/BoeMQeUBxWFBDCBkvbZmUm5Z/adSkHh4ckAP1OnVAwWmRd
         EtlecuTomKf+rSFNglyaSRXiyLYh+uGQ49JqyVAqjji82ZXTFGBNEJiAWlWnq9KfRTY2
         SYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFpX+AmGU+/V3bANCqUU3BguvAC+waEIfHhaAdI4zMs=;
        b=aAFp75ZFdW8yW1C6UP/m97cRKT+kTgbZneuIfNi+zcafGUuobDVWe0g11WdxAKExbU
         ZcmfWzWLhf8AUOxRSnJlkLAAhMlI4m3vl9SNclxSVwNpa0ChfkJez2YkvMc0QKBpI+IH
         MylG6TK0FOUx3xJzBOmcgqwDaHkAf/VEbfxxpGRKriFqFgdCSGCikv4/KruefhftoUBU
         c37UsuLck8xXw3/8QbQrX1kZXQLQaorPMQ6ASIae5EcEXlo/yMIhZLyjiG3p5M5vLFgh
         PXvXXT+DCWv836jXuhmgO66bxqAThvVylV0YiAL0In58UoSApcIoGNexdE/2Du4BTEDa
         jD5Q==
X-Gm-Message-State: AOAM532COXdqST816+rJQq8a5l0UoZe3WJRJZGZKw3lnmmUMslW/GQt2
        wmU+h/fv7pbCCeJyxeJbxQM/MQ==
X-Google-Smtp-Source: ABdhPJwJoinTJrS70FP+INyhS5zItFKn/Hlz+JZP5Bfka/wi3Li3Vy649PizAtfAUivpTpZCP3jaxQ==
X-Received: by 2002:a5d:6b47:: with SMTP id x7mr8918819wrw.170.1612437007388;
        Thu, 04 Feb 2021 03:10:07 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Manoj Malviya <manojmalviya@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Jitendra Lulla <jlulla@chelsio.com>,
        M R Gowda <yeshaswi@chelsio.com>,
        Harsh Jain <harsh@chelsio.com>, linux-crypto@vger.kernel.org
Subject: [PATCH 03/20] crypto: chelsio: chcr_core: File headers are not good candidates for kernel-doc
Date:   Thu,  4 Feb 2021 11:09:43 +0000
Message-Id: <20210204111000.2800436-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/chelsio/chcr_core.c:2: warning: wrong kernel-doc identifier on line:

Cc: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Cc: Rohit Maheshwari <rohitm@chelsio.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Manoj Malviya <manojmalviya@chelsio.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>
Cc: Jitendra Lulla <jlulla@chelsio.com>
Cc: M R Gowda <yeshaswi@chelsio.com>
Cc: Harsh Jain <harsh@chelsio.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/chelsio/chcr_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index f91f9d762a45e..f03ef4a23f96d 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -1,4 +1,4 @@
-/**
+/*
  * This file is part of the Chelsio T4/T5/T6 Ethernet driver for Linux.
  *
  * Copyright (C) 2011-2016 Chelsio Communications.  All rights reserved.
-- 
2.25.1

