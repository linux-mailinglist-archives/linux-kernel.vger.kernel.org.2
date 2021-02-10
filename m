Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD932317461
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhBJXaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhBJXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:30:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:29:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gb24so2072151pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4S8hj3rJ53Szx3MHUGcJcRDsqdQPJWanquERrIv09dU=;
        b=nH2lxpSvtKfmW+z9GjIAhM2Z0snSrJySHKrQkv7R/Riz23/7r6XKiGD7zkC0Fo+8r8
         QryGZkDQ9WYBuRb+rUi6RT7s7FtO03mtZuVKXAmezup2ouyttU/0H3L2slDUaqGdNFUW
         rIZC48t+CkCTR894yiYF9l/wT7hQHnpajDdBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4S8hj3rJ53Szx3MHUGcJcRDsqdQPJWanquERrIv09dU=;
        b=eIURT6xRehVhycjtqkk/Ix/T+1TfrsClw5VHgkLuP81h4A1p5unkYGDNKbXylHvscW
         or+OTY2wR2hzOrt5iyWlPzcs859yl5+UHRRFCvVIXEMGdzB6fEVAZrEoLnAxXowQw/5X
         T+i1CviUK76tOSqqhN0bIAL6s9oJwnHDe2LwR27TLmI4DXQhYhBqbung9yLZqNvNeV4K
         plcdRIlfjTGdBBpJu43bSUdeMJduENuknrUDp4uE+ax+PGtwcboy0fEibhBHOCd4DtlA
         7ob3CJB0KN5W0Tutstko3Il5gKrg3wxbF9emKurP6hTe9hrDh3fFTG9c+dH8Soz1XYRM
         Cpkg==
X-Gm-Message-State: AOAM53257WrJUQIwqsxlAAIO0uvRyjRm2CFMj/PQjEg43WM4l6L5BV3L
        LJtWqcsu5bNGAuAE/wB5ZBx6ew==
X-Google-Smtp-Source: ABdhPJwvYyChakoqVVRsAHqASTL/7IGPt8bqhSLMmBFJc1sOFQ4rQCeZpoSwmoFhBe8sxYLmOLqZqw==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr1238309pjo.234.1612999760556;
        Wed, 10 Feb 2021 15:29:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e23sm3288592pfd.145.2021.02.10.15.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:29:19 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Joe Perches <joe@perches.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] arc: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:28:49 -0800
Message-Id: <20210210232849.1358703-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=62ea86fcf95c26acaffb8d4f65a2a3ab984343c1; i=9LF/zUeDcs00Mwnr51UoClfwbmHzImPNgodF6PK4+cU=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=fwSUZEPS2PRAQw1xpYPbJJWYmUPZHe4oenX/nvvkJoQ=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkbDAACgkQiXL039xtwCbLiA/+PF2 Qzh2Afv4KUvrC7lqCxNXnPl+qzndKkD0JKtMcytzITO508GyprBWMwn0PyrvjeZaWwV3YLvJXLrTf txu9o3oRjBS65NhCpNSgmIdKIQrqvAi75H92MbR2L2IoFqHiH2Su2lMQlgSnqD5nx3Nqck0bXSf6k gRszIuF6Kn4P/ljRVj1ANzjLKnDpUoF/oPTxNX/8EFoCi2oCH+QItizLc3VAQvAnQyxboGJdKlcie 0sVEcUFqU46KdfHdr+h2bbbot4DVVIjnaCxq4uCc217ruGoySA9oBMNfB297wImcfv2NxUpitQlZG QucbRliVdtZOXAUl5/5JoyAmlt3Nu4Ksqa9kcS4LLX/q85PkIqj7dflQ7pPqIUWGGRjjkdUbrP1mH 4PhmbuGRcUduo+eaj9Pb60UK2Odgr84Idp2J9rOdjRA+QbXkPr3Jy9nUFnBcXpnG1fVbP0GiEYG8w hvBl1PVsE+A2MkjeVqh0+shg9ilaqv8a8Ec5qeTXKClY8hOcEMRU2TX0n3zvTv0Ee0nubV3tIioJj 0YHwpt6velN7wuJODIVLhumAVFKhW3+ANUfn49Wp6yUXdlVvgnIzd3+9urZsGB9fW3A/w5/s7SKIx Mo+TutkQZzv3c8AdL2z+kLmLcbTClNj6c50neYJSe88Z7xOhmk3Ne9F+0/7wIK6Q=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arc/include/asm/irqflags-compact.h | 8 ++++++--
 arch/arc/mm/dma.c                       | 2 +-
 arch/arc/plat-axs10x/axs10x.c           | 2 +-
 arch/arc/plat-hsdk/platform.c           | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/irqflags-compact.h b/arch/arc/include/asm/irqflags-compact.h
index 863d63ad18d6..0d63e568d64c 100644
--- a/arch/arc/include/asm/irqflags-compact.h
+++ b/arch/arc/include/asm/irqflags-compact.h
@@ -50,8 +50,12 @@
  * are redone after IRQs are re-enabled (and gcc doesn't reuse stale register)
  *
  * Noted at the time of Abilis Timer List corruption
- *	Orig Bug + Rejected solution	: https://lkml.org/lkml/2013/3/29/67
- *	Reasoning			: https://lkml.org/lkml/2013/4/8/15
+ *
+ * Orig Bug + Rejected solution:
+ * https://lore.kernel.org/lkml/1364553218-31255-1-git-send-email-vgupta@synopsys.com
+ *
+ * Reasoning:
+ * https://lore.kernel.org/lkml/CA+55aFyFWjpSVQM6M266tKrG_ZXJzZ-nYejpmXYQXbrr42mGPQ@mail.gmail.com
  *
  ******************************************************************/
 
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 517988e60cfc..2a7fbbb83b70 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -32,7 +32,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 
 /*
  * Cache operations depending on function and direction argument, inspired by
- * https://lkml.org/lkml/2018/5/18/979
+ * https://lore.kernel.org/lkml/20180518175004.GF17671@n2100.armlinux.org.uk
  * "dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
  * dma-mapping: provide a generic dma-noncoherent implementation)"
  *
diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
index 63ea5a606ecd..b821df7b0089 100644
--- a/arch/arc/plat-axs10x/axs10x.c
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -50,7 +50,7 @@ static void __init axs10x_enable_gpio_intc_wire(void)
 	 * Current implementation of "irq-dw-apb-ictl" driver doesn't work well
 	 * with stacked INTCs. In particular problem happens if its master INTC
 	 * not yet instantiated. See discussion here -
-	 * https://lkml.org/lkml/2015/3/4/755
+	 * https://lore.kernel.org/lkml/54F6FE2C.7020309@synopsys.com
 	 *
 	 * So setup the first gpio block as a passive pass thru and hide it from
 	 * DT hardware topology - connect MB intc directly to cpu intc
diff --git a/arch/arc/plat-hsdk/platform.c b/arch/arc/plat-hsdk/platform.c
index b3ea1fa11f87..c4a875b22352 100644
--- a/arch/arc/plat-hsdk/platform.c
+++ b/arch/arc/plat-hsdk/platform.c
@@ -52,7 +52,7 @@ static void __init hsdk_enable_gpio_intc_wire(void)
 	 * Current implementation of "irq-dw-apb-ictl" driver doesn't work well
 	 * with stacked INTCs. In particular problem happens if its master INTC
 	 * not yet instantiated. See discussion here -
-	 * https://lkml.org/lkml/2015/3/4/755
+	 * https://lore.kernel.org/lkml/54F6FE2C.7020309@synopsys.com
 	 *
 	 * So setup the first gpio block as a passive pass thru and hide it from
 	 * DT hardware topology - connect intc directly to cpu intc
-- 
2.25.1

