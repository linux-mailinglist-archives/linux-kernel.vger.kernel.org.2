Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6238B34345E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhCUTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCUTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:33:07 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 12:33:06 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 7so8532791qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYt1+2HCu7k5aZ8/g486KLARiNGxPsaUgbkKy2Ddv2Q=;
        b=Is9kxmI0Imm8gwNwYd2XbBF0KA0IXkeiAhH9wk6atqpQX4upDtfxEN3COYXN7X6jAk
         DEGANTfAJi55SxMZlrad27dTujRom5ARfd2TDE99Vc+MewdK5OU1yZjFTgDQJvayWItA
         ufegkT4+gIo8Bj4jRVIsR1jacTs6fFuERfXmrC4CWW+ZNbnJJy35ykG32AYkF1RprDLV
         flsRw50qk4AwO0XYs3zoKywrVmDO3dMXvein/unCt5Rsl3Ap4CU2tGfZXuHf3bJ5ErYx
         AomESrkVpIu959xQhAsclNdrvDLIhbUDwIcZUIO+/q4KXw642MeppkRlSMHaIR5ffJN2
         64LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYt1+2HCu7k5aZ8/g486KLARiNGxPsaUgbkKy2Ddv2Q=;
        b=njF43yIYmqMmQ0VIePtzjb9WJ2O2lRzEq/dZumDM83ePFV00/z6TbpAtffOnsdd9Hi
         IVHK85v9RQMxsxE9B6XfJPk7IoJdB+4qiPe3r/sgo0Yz5vLXFvf+kRMaDmFd81fw5QuP
         ertNTQ9N9SCCzUj9FgWssjRHfszFl+jd6MuXqvRGgRgNHdi+RcMhqxp+VupzOiEwJyZe
         yOKtxAJSYPE3jCN0efwVhqVFv+G4B7iiLR9nh2rhqvxvF6kQIzcYF48nD301swsMDg6B
         8ecx5TtMrh7XYCJ6FEHN23Bsrb26ubbDkD2flcgg4VPmOWcWeEgVzdInASc2iGbuh4wx
         9Elw==
X-Gm-Message-State: AOAM532129v9Hi/BMATpTIHVMmxr2ohI1FrUsY1oo5GtQUhuW6ZcHQO5
        l2BH1aE4hgz0RBUFZ/7mF/NWCglkqjifM6WO
X-Google-Smtp-Source: ABdhPJxrkLXA/cazeosQVEN0DttIad5cGUhfNqW4esg9W2iucBDLl8VPPQkCMOX3Fe3XcRnIyhYrrQ==
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr7923557qkg.168.1616355184875;
        Sun, 21 Mar 2021 12:33:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.163])
        by smtp.gmail.com with ESMTPSA id z2sm9434171qkg.22.2021.03.21.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 12:33:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, rppt@kernel.org,
        jroedel@suse.de, unixbhaskar@gmail.com, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] x86/realmode: Fix a typo
Date:   Mon, 22 Mar 2021 01:02:46 +0530
Message-Id: <20210321193246.3559073-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/perfomed/performed/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/realmode/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 22fda7d99159..1be71ef5e4c4 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -103,7 +103,7 @@ static void __init setup_real_mode(void)
 		*ptr += phys_base;
 	}

-	/* Must be perfomed *after* relocation. */
+	/* Must be performed *after* relocation. */
 	trampoline_header = (struct trampoline_header *)
 		__va(real_mode_header->trampoline_header);

--
2.31.0

