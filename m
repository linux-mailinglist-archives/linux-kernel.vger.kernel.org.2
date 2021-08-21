Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64533F39FB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhHUJqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhHUJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:46:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB6C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 02:45:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so17839157wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWcvF3CdsW6/HvLTh366imUGobTCEWgbc4g8Bfu5cxQ=;
        b=f1krvzgYj/9Mc9qBU578BAntDpqRZyRg3pfuAokh6VCxpepmb79U7vjBMVQnXOXK3y
         TvAhJ4Q/mV2TpFFs48ugL8NeOsPhp9oUEvUV3zWNaBWRsc1DIvpzsepq0scWCIgF4hsq
         Sovku6c68do8cq3ZGZ5jG0zmV2VAFNvJE8e6jgqRhK/cPZQy1utTNya2CR4+hhN6hSyj
         fyEPZFhO92sJtmSGF0SsPZX22cWMiQJUXbr1s61i12isl+4gLhKyGdNALbHSc08PwQx/
         sSphklyaSDTct8j7v50b8HEY9t0CQTw5CKEuc95ySNG7Ab4KLp+xSiJuewNdB2UI2OQs
         sXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWcvF3CdsW6/HvLTh366imUGobTCEWgbc4g8Bfu5cxQ=;
        b=XmAhRdBuOFBqvhWaDixelWy1ABzQu1PtQs7/Ee5Udf6faIaahqDjSQIITi4UNOApEB
         ymV85cyS4ez5yW284fxlS7Hk809biMNCOj3jKBSI/MZRo7utDHwkvKu4iMAZ4JNnWOxR
         dc8MFasmWLwhj649dQ7WLQm1RQAGGKTLMTF32GJUBkParUvAHAwYbYJpIvUIrBly9DTZ
         MtcHHfPRBwfwOXqLLUCNX34ITDB3er6Xswfsm4HWKQGl/AN1xn6POuj0n+TXmTLM3Zs1
         aAOzNeHmu+DY+yw0qdc/4a6itSW01v0CVafGJIlWWjNtZiZPTavMuugMjHNP7XjCNGzY
         CdfQ==
X-Gm-Message-State: AOAM532+EvwuFoJ40TQiZarD/6w700dDzF5735iPzb/aPzZ69IwoSlWT
        4IvZ7BpLZ/TAMUcpa31zqdpcOsyEhiI=
X-Google-Smtp-Source: ABdhPJweYwJEOUqrv8ou8X/Jym8rYOtwnEWHjg31afUVrhylKk18bAvI1UJJBfaz4H3qvu6oTm3iZw==
X-Received: by 2002:a05:6000:10c5:: with SMTP id b5mr3149698wrx.298.1629539131001;
        Sat, 21 Aug 2021 02:45:31 -0700 (PDT)
Received: from morpheus.home.roving-it.com (f.c.9.1.f.e.c.d.1.e.0.0.2.b.5.5.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:55b2:e1:dcef:19cf])
        by smtp.googlemail.com with ESMTPSA id p18sm8456500wrt.13.2021.08.21.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:45:30 -0700 (PDT)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] reset: simple: remove ZTE details in Kconfig help
Date:   Sat, 21 Aug 2021 10:45:28 +0100
Message-Id: <20210821094528.294579-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ZTE platform support in the simple reset driver has been
removed but the comment in the help wasn't removed so clean
this up too.

Fixes: 89d4f98ae90d ("ARM: remove zte zx platform")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/reset/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 328f70f633eb..ba50729a3371 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -207,7 +207,6 @@ config RESET_SIMPLE
 	   - Realtek SoCs
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
-	   - ZTE's zx2967 family
 	   - SiFive FU740 SoCs
 
 config RESET_SOCFPGA
-- 
2.31.1

