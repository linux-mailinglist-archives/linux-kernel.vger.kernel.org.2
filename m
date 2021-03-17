Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1051133EA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhCQGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhCQGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842FC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id u20so39848257iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFXZks/INjEF8pTkRuljwm0Oeo04QnBE29qDauxs3lo=;
        b=txd/12obtBPNQcnqrp2ZqB/KsRoibhrdU/WohULFeJ0cMClWJDp+jdhtb7HJYzam3/
         /ucmYaZkIgXkK1GyKwFYesGNxoJs6KWvxuHqpAVgZzitFdVhEo35BAhnJTvE/JI0w5US
         mA02UK6Puyc+f74wxhyaPfNBk9We4vi7MHdQSl9O1XbRhw8PceFxLTGTo2t/QsgMSboL
         bgbIXbmtR8cMIr/Qn3X/5ZHL8U+BcHwYTmlq3pPiklZA9Dh3pil76jZ2YvRoalcChCNf
         WcrhdBs3RxZcjwlubVPC7IC7V9tNL/QIdchtjuDsV3FqPcwaeohtlCQEG6jhEHREr/B9
         Y6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFXZks/INjEF8pTkRuljwm0Oeo04QnBE29qDauxs3lo=;
        b=kAWURHTpRSqAWBK2WgrOOsEtQA+oHvjMKE0jTn/5d25GELIl4FSVTewIFCKcKlaVJh
         6JmK1c//tVOz5X6TY3KsAT5u9DACfkg8feJ2skAdgKjY3EQWWNNe74L0yJlOPJg0biZI
         mdsCcu/aIbd4jVff30IuflLe6u2ZSyiP18FQaND4gw1xh1CVk3YJr1MXXw/w9NDuulTt
         EvFikS4O1Mtjf2ghPNAHtyMcDvKnCtafUoGobgfc6O7vQMyIEdfkrOIXKG6Ki3/FpT9x
         rzTFb8zjPJp8Shs0AKFGnnAYvJnbILAuGXsfG+5JmR0FhzVcTYiowVbfQ9nY9C161pu/
         3YZw==
X-Gm-Message-State: AOAM533tL7UWQdIBIg8Bjft2FGh5hZowvePTTnrc02ZaOaBxp0pql6NL
        lhkZi9VTYimR5TCiqnVpUI41DoyS2l5OGQ==
X-Google-Smtp-Source: ABdhPJzMc5PBm0hm/Xjw6G+U0rBEoUCeB68FTUnHdUoU3dPzvbixnwOdI59ZHoJLNHGiia8lWtXTJA==
X-Received: by 2002:a02:6a14:: with SMTP id l20mr1836246jac.12.1615964078330;
        Tue, 16 Mar 2021 23:54:38 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 19/19] dyndbg: RFC add linker rules to module.lds.h
Date:   Wed, 17 Mar 2021 00:54:12 -0600
Message-Id: <20210317065412.2890414-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the DYNAMIC_DEBUG_DATA macro, that works in vmlinux.lds.h,
into module.lds.h  This does not work here

The point of the KEEPS is to pack section pairs into consecutive
memory, a property we need in order to drop the _ddebug.site pointer.

The problem (ISTM) is that for linking vmlinux, the data is linked
into .data (and the sections are subsumed), and it is is accessed by
iterating beteween __(fstart|stop)___dyndbg(_sites)? symbols.  That
breaks down here cuz kernel/module.c specifically grabs the __dyndb*
sections by name.

I lack the linker-fu to sort this, so I left my commented out
attempts, to show my errors.

no-bisect: expect linker error
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/module.lds.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/asm-generic/module.lds.h b/include/asm-generic/module.lds.h
index f210d5c1b78b..0074c5f2421b 100644
--- a/include/asm-generic/module.lds.h
+++ b/include/asm-generic/module.lds.h
@@ -7,4 +7,25 @@
  * Empty for the asm-generic header.
  */
 
+/* implement dynamic printk debug section packing */
+#if defined(CONFIG_DYNAMIC_DEBUG) ||					\
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE)				\
+	 && defined(DYNAMIC_DEBUG_MODULE))
+#define DYNAMIC_DEBUG_DATA()						\
+	. = ALIGN(8);							\
+	KEEP(*(__dyndbg_sites .gnu.linkonce.dyndbg_site))		\
+	KEEP(*(__dyndbg .gnu.linkonce.dyndbg))
+#else
+#define DYNAMIC_DEBUG_DATA()
+#endif
+
+SECTIONS {
+__dyndbg	: { (*(__dyndbg .gnu.linkonce.dyndbg)) }
+__dyndbg_sites	: { (*(__dyndbg_sites .gnu.linkonce.dyndbg_site)) }
+
+	//.data.dyndbg : { DYNAMIC_DEBUG_DATA() } // syntax ok
+	//: { DYNAMIC_DEBUG_DATA() }
+	//DYNAMIC_DEBUG_DATA()
+}
+
 #endif /* __ASM_GENERIC_MODULE_LDS_H */
-- 
2.29.2

