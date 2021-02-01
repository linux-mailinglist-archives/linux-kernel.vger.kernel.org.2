Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF530A0CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBAERN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:17:13 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45259 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhBAEQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:16:59 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1114FZfL022124;
        Mon, 1 Feb 2021 13:15:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1114FZfL022124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612152936;
        bh=BWvDAZ3N+AC9OuhoVtxd2bO/K6F8WGyX8EyIM1rsYLE=;
        h=From:To:Cc:Subject:Date:From;
        b=AB3gx3Of9x6WWaY2AyLWmbQrFGN7F+9M5ETAnfvyCzw1Vk4/JKfFula+8kwpFstji
         v5n7a8FDeY1nxS1u8Q66Y+fPAMwO4xKoL10FZBrNXY2+OyHAFDz4LMJ+FI+FNJCtZa
         Cw0tn0PAxGRutuMSewmmyoqwkCHkyr5kA0/DGB8ktXNbnr77KkG8uSxLOCK6o4imxO
         d9jyAh2RxyNszwie83x5vS5Xw9DmaNHkt4rR58QuRz7YbciYBNv2zZhIJd67KVXTWC
         DkybhofHOD+POv+PKSiDiXvCOjWybSAggPVHI/zOBTMtSCx1k/t91Dt94NGogliEpV
         D5X4OcA0+Ww3Q==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>
Subject: [PATCH] init: clean up early_param_on_off() macro
Date:   Mon,  1 Feb 2021 13:15:32 +0900
Message-Id: <20210201041532.4025025-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use early_param() to define early_param_on_off().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/init.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index e668832ef66a..ae2c2aace0d0 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -277,14 +277,14 @@ struct obs_kernel_param {
 		var = 1;						\
 		return 0;						\
 	}								\
-	__setup_param(str_on, parse_##var##_on, parse_##var##_on, 1);	\
+	early_param(str_on, parse_##var##_on);				\
 									\
 	static int __init parse_##var##_off(char *arg)			\
 	{								\
 		var = 0;						\
 		return 0;						\
 	}								\
-	__setup_param(str_off, parse_##var##_off, parse_##var##_off, 1)
+	early_param(str_off, parse_##var##_off)
 
 /* Relies on boot_command_line being set */
 void __init parse_early_param(void);
-- 
2.27.0

