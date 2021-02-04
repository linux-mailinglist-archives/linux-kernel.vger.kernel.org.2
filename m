Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFE30F1D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhBDLPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhBDLMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B63C061226
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e15so2655358wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZFcUa8z9ij8GsVZGG8CeCF7Ivx0FCQR9n9Ud5IB6q0=;
        b=yoOOHsJmUFa9/ZMIOvUiWAVGaV0lecpKRROSNn73bOTaoWxilhWpNvougW3IaJU11M
         BVkhVn/LG7rzlvj+VFlMOu2jZ16XdmDP7j7nFPRSoQfbQGizNQ0MysoTX/Ih0sURIkkJ
         jj2NKa4nkkgpng7ay0Yb/XckBZF6BoHaNRvJxyE0CFDhvk/OQMGNw6P52ILsu/BLONMX
         sGU9ch76oz25jqxjuLtMuFlH5wg1GQjs8Su8XyxDU7H84HQ6aUmAroBCLgq4h+/I22QB
         U8SZRrv4BsmpmnvZt6lJ9Y4abHaGLyIEQ9BJGCbmgZEEN4Cbv/Cjar+aCibvBqgV7jDz
         IW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZFcUa8z9ij8GsVZGG8CeCF7Ivx0FCQR9n9Ud5IB6q0=;
        b=r/dJtG/BjZbUHRWqE/XmbTtk7/o/lbPpGK3Lk6fajuY5x/Wk67gMxghVC9qzSwIkKb
         430kqcU4XVYmvzQvWZ4bH9d+6Asn0fjjBaOkTQnpiGqZ9j3HivS11VtvM8PGgXvwm4E7
         /vVlroakfxG83jtcaC3MUSKUd6uX5fSTdzviBNLAWj2S9NQkTbA9ElBMMezD8+rFZvsQ
         KvtTAbyueWcBjXbhxdyWWzuFsBbjz2jX1bNDftqV9mP6mec+sG/kmM2IY36qZccMwjI2
         4V0iCRnfpQocSCfv99fqzdJNN1bNpMhJj8ZcollKnYEL0ravdfXFGJMGajDZalTUQU5k
         DZrQ==
X-Gm-Message-State: AOAM5327LrUXzLerHcJnCh+pPX1TefPEolrIODBvXTP23SUegD6ZVxW7
        9MsAK6G2pun63RLrkH2SVk41vu9oqTTASw==
X-Google-Smtp-Source: ABdhPJyH2Oy1OTUDZXbRtCQuenPHqsyeaSnIpQ8LSjm16+yMUa9mogmKK1zeOQjPoP79U3cAkVO7Jg==
X-Received: by 2002:a1c:1f4d:: with SMTP id f74mr7213122wmf.12.1612437022191;
        Thu, 04 Feb 2021 03:10:22 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Henrique Cerri <mhcerri@br.ibm.com>,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/20] crypto: vmx: Source headers are not good kernel-doc candidates
Date:   Thu,  4 Feb 2021 11:09:56 +0000
Message-Id: <20210204111000.2800436-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/vmx/vmx.c:23: warning: expecting prototype for Routines supporting VMX instructions on the Power 8(). Prototype was for p8_init() instead

Cc: "Breno Leitão" <leitao@debian.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Henrique Cerri <mhcerri@br.ibm.com>
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/vmx.c b/drivers/crypto/vmx/vmx.c
index a40d08e75fc0b..7eb713cc87c8c 100644
--- a/drivers/crypto/vmx/vmx.c
+++ b/drivers/crypto/vmx/vmx.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Routines supporting VMX instructions on the Power 8
  *
  * Copyright (C) 2015 International Business Machines Inc.
-- 
2.25.1

