Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7898836A8AF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhDYR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 13:59:12 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:19094 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhDYR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:59:10 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 13PHvbLV030691;
        Mon, 26 Apr 2021 02:57:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 13PHvbLV030691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1619373460;
        bh=WPMOAoetHlwoC77DEFN4ntrJF0d2o3QlqMB4lX6w80Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXej5X7WPmbCm/83/+2lzCQeh8tYn71hXSnL1bcHlvM7I9c/cErIXneg6Dzq6oLz8
         XEpriLl3qdwyNMAKuLnBfe2uvkytSW0opskUGhoWUJFmu6JTdd1x+fhVLe2jn3DlGd
         6Ya6Q64AFvknRo1yaa5WU5J6PrHCx7bv4+u244Ptv7haSzlmXO5x+6Gpu0zVGLQuIO
         7Ijd+m2BuiL/I04XYnpBrOoVQetdNPBaekURgmERTs4mNsJiUYK0WlMX3y5jO2i97S
         k9WMImPaQo3LFuvSW7PODAEG6haCAQLU88t/VkfB3SFupl5F8sjHjrut1Qqr0aYcgU
         1A4kgwO01TSyg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] crypto: arm64: use a pattern rule for generating *.S files
Date:   Mon, 26 Apr 2021 02:57:34 +0900
Message-Id: <20210425175734.1310191-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210425175734.1310191-1-masahiroy@kernel.org>
References: <20210425175734.1310191-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify similar build rules.

sha256-core.S opts out it because it is generated from sha512-armv8.pl.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/crypto/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 592e52a08c62..09a805cc32d7 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -71,13 +71,10 @@ $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
-$(obj)/poly1305-core.S: $(src)/poly1305-armv8.pl
+$(obj)/%-core.S: $(src)/%-armv8.pl
 	$(call cmd,perlasm)
 
 $(obj)/sha256-core.S: $(src)/sha512-armv8.pl
 	$(call cmd,perlasm)
 
-$(obj)/sha512-core.S: $(src)/sha512-armv8.pl
-	$(call cmd,perlasm)
-
 clean-files += poly1305-core.S sha256-core.S sha512-core.S
-- 
2.27.0

