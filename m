Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62293174C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhBJXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhBJXxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:53:34 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:52:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u15so2167117plf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sw+4hTERsJ95x3OUdaatH7l2UPgiDomv1hcpD2ZxNqI=;
        b=iJXkbpWf9Xp9xhd3DRYZ2iFa+7t+86a8D1EhkB4lVs1Jtkp98ZoO0ydYq8PgTIPRr4
         dSaxK+vQmGFp9dQB0ww/CwlfJfiTutb1O8n9myj/Wmm33DjVB5MncTpa43TXJ13vv7V+
         ferU4u8NBVxNEEaAJ4Mg1LtlV3GgwwL3I0+BEoZq6WofvfSJ0AY+iZJZreNVB4ye9KdY
         1wPlb+xVvc8U7Ju38o22ipV6TGntk8LGOjhpP7nhuXJ8e7kLur9RicbJROdLeVc5YXjl
         vIIxnvVra6opi/iIvwS5QntTDhyVL12trjJwws+W2pT5m/Xc8zRqA6eFfdYBufAsRnZS
         nRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=sw+4hTERsJ95x3OUdaatH7l2UPgiDomv1hcpD2ZxNqI=;
        b=hVOChk75ifDgtDhxI4639nCW7zJzO1Lnko1IuJAmaNrkZQ6CjE0kRcwwNdgGRZLmUJ
         TpWhnsP8qC9KfRhmbqyXbs6ncgz9t5iTtQ/IWScM2KsZ24OAE39+h/tIqnwt8IBhv0Bm
         WSx192Q9MQI/yGvKw2IGmK4bBejH/DUxbhXQUBnp8SBZs6qDuy70ipMeaZNz9IlD0IXw
         tHoATvI4bU21VlxJZw9uD7Oul1doiag0QxsuMDVeIYUhbLu9fFvVpz621J6mcofl045E
         P1hkjhB6ox12xgcdWux0mtotd35sIallP0oFWaAIeZv5rXgjrbLQG5YRJzLl9DOtCvj8
         l6YA==
X-Gm-Message-State: AOAM531CbW/4b6w6ZYG9SQ3XUBQf8Kqmk7a7AAiRDhjaUFmmiymQG2Yi
        og5HTqyAvl/bkH1O4yyM3PE=
X-Google-Smtp-Source: ABdhPJzSFkYB5GmLFSQZ4TnxB4yVnLTWzjlffBbDKs0fNJIFqC+FmWj5cvxz/qSViIuEQeRal1XKjA==
X-Received: by 2002:a17:90a:1f4c:: with SMTP id y12mr1356739pjy.52.1613001174226;
        Wed, 10 Feb 2021 15:52:54 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id y16sm3288419pgg.20.2021.02.10.15.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:52:53 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: kexec: Remove unused kexec_reinit callback
Date:   Thu, 11 Feb 2021 10:22:43 +1030
Message-Id: <20210210235243.398810-1-joel@jms.id.au>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last (only?) user of this was removed in commit ba364fc752da ("ARM:
Kirkwood: Remove mach-kirkwood"), back in v3.17.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/include/asm/kexec.h    | 3 ---
 arch/arm/kernel/machine_kexec.c | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index 22751b5b5735..e62832dcba76 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -56,9 +56,6 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	}
 }
 
-/* Function pointer to optional machine-specific reinitialization */
-extern void (*kexec_reinit)(void);
-
 static inline unsigned long phys_to_boot_phys(phys_addr_t phys)
 {
 	return phys_to_idmap(phys);
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 2b09dad7935e..f567032a09c0 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -147,11 +147,6 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	pr_info("Loading crashdump kernel...\n");
 }
 
-/*
- * Function pointer to optional machine-specific reinitialization
- */
-void (*kexec_reinit)(void);
-
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list, reboot_entry_phys;
@@ -187,9 +182,6 @@ void machine_kexec(struct kimage *image)
 
 	pr_info("Bye!\n");
 
-	if (kexec_reinit)
-		kexec_reinit();
-
 	soft_restart(reboot_entry_phys);
 }
 
-- 
2.30.0

