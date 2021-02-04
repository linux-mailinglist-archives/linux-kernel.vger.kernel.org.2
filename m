Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108630F1C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhBDLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhBDLLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C2C061355
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f16so2735714wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trb1gYFzPUUg8uq7WKCS8xTgh11NyriG6ftUBu1Ewok=;
        b=Gi5+E6fczIL1TMNS+SiiMfhWSn0MgAOwW1Y5q9y/wnnkLhri4gsMZWClg6sD4Myxdb
         Id3u6wIwHCsme2xp1E+1czYA94c5X8WJVuI9jgFdM+MCQCA2UVV25HGh5Svnk1iZ/2Wz
         LiqZyE5ktBUaAiPNZl4Lr7E/DkBTvONVsE+/eN3T/rv+Mi65h6gw2F6Oy1dbexkrq5gA
         qAvYwzAf/ZowfI4hiteB1SwUB3SZv9bo5iB5aBuFwe0MmOSlrtQkJmhB1IImzYghg7j8
         Im/MPx/TrceWNYgDeWguc5nH+fEbRR7GT4USjgjaapE1OYp2B4WlzBN0mVpuIPxNbI8g
         G+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trb1gYFzPUUg8uq7WKCS8xTgh11NyriG6ftUBu1Ewok=;
        b=akN3j1f/xbUfxqg/iGjil0WiWqIwQrhhSnNBqJfnIUVg73ocZAOEYy5+Bhh7PiszK9
         IcenvTgeOjgS8ViieyfGuass5fUfvjcYP8SGrT/1Jilk5jNvixjFv9xPxBiTwRzqEQZs
         FznkxM6ux1zS+xqje2FKq1R4IiyWxHAi8UWLgB8dUd22JSDds0V+5trCvzSVmv2gWEL/
         C5jPAvgGIakCwxLVz/d8F1K3P7oPmhhhIkdxjNf98eDZAAH6pDKskdonsKYQQjcrybXh
         7ROaLcAj9qKLczUXpbIp6c1M6AyNdQEqR/B4l5B5VJcWnXWD4w0e1Jgfd8aQOaTFiCJV
         10pQ==
X-Gm-Message-State: AOAM533LB8q09KS6dLzBjVYK959oR3v40J1Yj+cq0hjfC/mvs/kcA8pf
        hpB8KXPMJbVpRQWUqrHM9B2hYA==
X-Google-Smtp-Source: ABdhPJzrfuBFqr+PYF2oOLIi5LxzlWlKdWdoKlj475mia7KZa9QKAXn+t2C1kmSmxVpmFfknLtFEvQ==
X-Received: by 2002:a1c:65d5:: with SMTP id z204mr7053809wmb.184.1612437014285;
        Thu, 04 Feb 2021 03:10:14 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shujuan Chen <shujuan.chen@stericsson.com>,
        Jonas Linde <jonas.linde@stericsson.com>,
        Joakim Bech <joakim.xx.bech@stericsson.com>,
        Berne Hebark <berne.herbark@stericsson.com>,
        Niklas Hernaeus <niklas.hernaeus@stericsson.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 09/20] crypto: ux500: cryp_irq: File headers are not good kernel-doc candidates
Date:   Thu,  4 Feb 2021 11:09:49 +0000
Message-Id: <20210204111000.2800436-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/ux500/cryp/cryp_irq.c:21: warning: Function parameter or member 'device_data' not described in 'cryp_enable_irq_src'
 drivers/crypto/ux500/cryp/cryp_irq.c:21: warning: Function parameter or member 'irq_src' not described in 'cryp_enable_irq_src'
 drivers/crypto/ux500/cryp/cryp_irq.c:21: warning: expecting prototype for ST(). Prototype was for cryp_enable_irq_src() instead

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Shujuan Chen <shujuan.chen@stericsson.com>
Cc: Jonas Linde <jonas.linde@stericsson.com>
Cc: Joakim Bech <joakim.xx.bech@stericsson.com>
Cc: Berne Hebark <berne.herbark@stericsson.com>
Cc: Niklas Hernaeus <niklas.hernaeus@stericsson.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/cryp/cryp_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_irq.c b/drivers/crypto/ux500/cryp/cryp_irq.c
index 7ebde69e8c76b..6d2f07bec98a7 100644
--- a/drivers/crypto/ux500/cryp/cryp_irq.c
+++ b/drivers/crypto/ux500/cryp/cryp_irq.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) ST-Ericsson SA 2010
  * Author: Shujuan Chen <shujuan.chen@stericsson.com> for ST-Ericsson.
  * Author: Jonas Linde <jonas.linde@stericsson.com> for ST-Ericsson.
-- 
2.25.1

