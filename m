Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5A394686
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhE1Rg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:36:29 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:38884 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhE1Rg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:36:26 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14SHY8b6029413;
        Sat, 29 May 2021 02:34:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14SHY8b6029413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622223249;
        bh=hIQnqzynmLo9hMszJqE19NWWV0NJWCY4QuoiVpZ1eJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=rTvRNR605Nhm8D19DfZwz6GfFE76C4FCd/1ubDWnt6MZsvI2Wyrq+Rr8BJvue0Rfb
         JfUL5AAMPtwaeYlMf4E5a91Y1AgtjDAVYjMRsg6e+KdTMAhX6WWrEAnUYpNlM7939j
         OvTPZSDksipc/l3ua3lc7MYHBiCggySH7yISut4Feo3kUvaYRFJTBhbheVVvkUFRCW
         mVPtzYFT2CloOB6dFot9qrgE0lNigaK6iEzRbOz8I3eXM8Yazxp/nQhAvtG72BxRKu
         LGoSzbKwXriZD3FKqzNDhG/hPwc00dGrKzce0Kp+SEn+u1uD+FbP9Q+So7hvSBNQ66
         nKJHz61VvJ37A==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: remove unneeded 'comma' macro
Date:   Sat, 29 May 2021 02:34:03 +0900
Message-Id: <20210528173404.169764-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 553671b76859 ("firmware_loader: Fix labels with comma for builtin
firmware") added this line, which was unneeded.

The macro 'comma' is defined in scripts/Kbuild.include.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/base/firmware_loader/builtin/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 5fa7ce3745a0..101754ad48d9 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -8,7 +8,6 @@ fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
 obj-y  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))
 
 FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
-comma     := ,
 FWSTR     = $(subst $(comma),_,$(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME)))))
 ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
 ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
-- 
2.27.0

