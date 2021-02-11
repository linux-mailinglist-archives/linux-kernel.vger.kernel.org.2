Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF4319564
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBKVtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBKVta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:49:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E00C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:48:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so4539619pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1LR8bXA8m9yKBLdWfg/9jF4Dd+6Hiiy3Cbm06YIqOE=;
        b=AauGAUa8Z69t8uDWvSpHf3f8FsUWV80P9nRC4+xUeA3Wq7qTN7D/38hTGgs/Bf4fi+
         NfR89goWKn/X2atc8EfD77nAUyBn7PcZjfYv8Y06O9lmYnJeyFUVcoAQ1QClNjn6DDYa
         Dj3LWymwXnXepu8ou7LuHCyeD5DgIk4ET2Jl9is7SLCd74Sk5QEGlBYSIl5jJ0oyYMSA
         TITGHT0OXull26nXQf3y7ZmyfeLfAaa4Z/+mOFPs22dL83sJc4z8D2KGr4kVvUb7ppFG
         yrTInENIJU3fEHdmUZ3wnuuuD1FttHOQY2YNwqCOgXgmGdOEF/wSDYAMTji+1dks0u9N
         nbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n1LR8bXA8m9yKBLdWfg/9jF4Dd+6Hiiy3Cbm06YIqOE=;
        b=nJTucxxfod+DNh7zhJNDDMin4QuiBKUEETvXc8kPMrBt0+HgzoWAkRdC5d5Eul6TsI
         leyEzAIqfNz0pcDa4AdLwzmWfrThZxYbQXQe9iFB+4tKJTEIvbbILLOEBjzQAlUcaFPn
         6nszDbigT2azBYA8hF229/sqwjwLllhWIhV69nxEeTPhFiZf2FcgdswoP6obF8++OwW3
         YYnBai2mvgjs6BPj43B6priJ1dvMkRxghkAXvnBw9k4CysH1Oley3mlyO+gnAWV7PW7/
         gdzPZp/FfLKSAhI7+PfmLN8wyLoGSEdtvYWAH4WsvY/KFpDyx5KJUmwZn+xdnJOa8J71
         mF7w==
X-Gm-Message-State: AOAM532kFjP6uW7hxKOLWJA9GRWzqLbqbaipeohdD34zXawD+EIJdzuT
        Fx5Dz80NGJChveNCnLvpEA/Y87Sg5upo4g==
X-Google-Smtp-Source: ABdhPJwK1gQARuKwUrghUAY3dv6TbBMHswIcdfiEO747A2NrBrcHpV+/XMfT81czn8OsGsi8mNL0+Q==
X-Received: by 2002:a63:4623:: with SMTP id t35mr169739pga.294.1613080130191;
        Thu, 11 Feb 2021 13:48:50 -0800 (PST)
Received: from horus.lan (71-34-94-168.ptld.qwest.net. [71.34.94.168])
        by smtp.gmail.com with ESMTPSA id j20sm6556609pfe.172.2021.02.11.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 13:48:49 -0800 (PST)
From:   Jason Gerecke <killertofu@gmail.com>
X-Google-Original-From: Jason Gerecke <jason.gerecke@wacom.com>
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Cc:     Jason Gerecke <jason.gerecke@wacom.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] RFC: x86/jump_label: Mark arguments as const to satisfy asm constraints
Date:   Thu, 11 Feb 2021 13:48:48 -0800
Message-Id: <20210211214848.536626-1-jason.gerecke@wacom.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling an external kernel module with `-O0` or `-O1`, the following
compile error may be reported:

    ./arch/x86/include/asm/jump_label.h:25:2: error: impossible constraint in ‘asm’
       25 |  asm_volatile_goto("1:"
          |  ^~~~~~~~~~~~~~~~~

It appears that these lower optimization levels prevent GCC from detecting
that the key/branch arguments can be treated as constants and used as
immediate operands. To work around this, explicitly add the `const` label.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
Marked RFC since I'm not familiar with this subsystem or the asm blocks that
are impacted. Extra-close inspection would be appreciated.

 arch/x86/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 06c3cc22a058..7f2006645d84 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,7 +20,7 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
@@ -36,7 +36,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-- 
2.30.1

