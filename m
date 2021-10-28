Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94643E374
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhJ1OXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhJ1OWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCE6C061243;
        Thu, 28 Oct 2021 07:20:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o14so10456127wra.12;
        Thu, 28 Oct 2021 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0+Ewf3zoYKYSWZPJecgoccdfTSC37HrqNABHJ/zSx4=;
        b=qQ1E19YcuVT5BdjCL+cmlKQONdyDux+CcDXoljj3sR/mw/MbHxYEUXfiB/v6dFUVKs
         8wfkCTpArL5db/Y2QwkhAPh/a0UAVBIb5LYjUYjWMwY7DH4NcutzkEcbsyDkui6fDJvQ
         yzbVHDh+EN3Pi+ifIu9haL5Vtn1wL1SoY2GMawHxP98gKS0h66oPLUL7b9eQaIPSa6RS
         KjAhHWPi71XeN7bXQbSnavaIMdAPxAL7+VNnOuHhEoPcBEaRb4x50Sz3lQLmgaqfGqYN
         jrOlLY7FCbPwkBw0OBBd5aUYiaSEQoBqeXESKvxAoJO/53291Pn7AJoE1ZCgD0pAVPA/
         JvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0+Ewf3zoYKYSWZPJecgoccdfTSC37HrqNABHJ/zSx4=;
        b=YHkvORQIqfx46aolLgyCagjsYxB+4Bxo2Ach1k/1K0rSQORcS/7XC42jMPJZNOZCPT
         v4KUrcubP0ohmu6b7zmQM6o71c4zBt346WYb1HdFw3Cy9Gz+Jb8AVPROpSoR8b5H10a2
         zmlvau4EQfVYNtUbi31XMgVxK9Xixq+pfS1HCwsCq0jv2MKZLv2Bzlwu1zBjp8/NFUj+
         dcVlJYi9ber8YQEqrUxJGIP15Y8Wml/M3OkFwQe6os2WXfiuR5XExIDd83f4q1np2wML
         dvrqHzy76b5/QciXUtL/SBAyggRF+SfJ/Wjyhq2iQIWazq2j8FR6WHRPJVGDl6sjJ/Rs
         WUTw==
X-Gm-Message-State: AOAM532E3JPQVDrLVe/9jtrBzD+OckPPGrwSAwUdUsCBmA+1tUph+G2f
        hg4fc5G/qwnhNNLHYYvSlpQ=
X-Google-Smtp-Source: ABdhPJyQqCEoBp5Xz9+BZw2NcATVGQ8YNlBwKwxvu8ASJ7d5NPYrqSJPGxWZa2Pga/Uj2nf1pomHkQ==
X-Received: by 2002:adf:e489:: with SMTP id i9mr6257310wrm.22.1635430822842;
        Thu, 28 Oct 2021 07:20:22 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:22 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 13/13] arm: pgtable: refer to intended CONFIG_ARM_LPAE in comment
Date:   Thu, 28 Oct 2021 16:19:38 +0200
Message-Id: <20211028141938.3530-14-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow
memory") adds some nested ifdef's in ./arch/arm/mm/pgd.c, and follows the
good practice to annotate the endif's with a comment to indicate the
corresponding ifdef condition.

One comment annotation refers to CONFIG_LPAE, whereas the config is
actually called CONFIG_ARM_LPAE. That imprecision in a comment is probably
tolerable for all human readers.

However, the script ./scripts/checkkconfigsymbols.py, which checks the
kernel tree for references to non-existing Kconfig symbols, identifies and
reports that the reference to CONFIG_LPAE is invalid.

The script ./scripts/checkkconfigsymbols.py has been quite useful to
identify a number of bugs with Kconfig symbols and deserves to be executed
and checked regularly.

So, repair the comment to reduce the reports from this script and simplify
to use this script, as new issues are easier to spot when the list of
reports is shorter.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mm/pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index f8e9bc58a84f..bf2935f21c12 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -80,7 +80,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	       * sizeof(pmd_t));
 	clean_dcache_area(new_pmd, PTRS_PER_PMD * sizeof(pmd_t));
 #endif /* CONFIG_KASAN */
-#endif /* CONFIG_LPAE */
+#endif /* CONFIG_ARM_LPAE */
 
 	if (!vectors_high()) {
 		/*
-- 
2.26.2

