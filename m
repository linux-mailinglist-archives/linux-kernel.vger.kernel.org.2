Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF143F4F22
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhHWROt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhHWROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DADC061796
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g73-20020a379d4c000000b003d3ed03ca28so12291966qke.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=waqY876EwA/wk10n7+SSCq5/Bx3gIEi3wIv2LvfyQCY=;
        b=Jp/LpTkJvrx/sDMDUbafviqe/BIpw0Q0Iw9S012k1J5qr5lLEsQ7CcLwEjilPsyAK/
         t4JdvEUg8hjrAfWV3ou7LKIZ1Bv6g5i7L9aToNYYK9I/X4GdNTEHdvsww5MnFcga8Flb
         GXsy2CaLfwKBUYk9Mkcv8gwiGNcu8EE1uaeHIHYyWmMlHkeKv4SaJ245C/ZY0JN8Xhxo
         /fY9AkfD7Lc5YoLVMwJLOIBXyvE9nIjdduEp+vp0N/wbmyo4dkF1XR868WBU3LModhZL
         HCS41r0u5bDPK5jET/CSXmWxTkQnn8Yaiy/66VJrExxs9JRmHD3Ow3y6VPYeVvQmQc7/
         xAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=waqY876EwA/wk10n7+SSCq5/Bx3gIEi3wIv2LvfyQCY=;
        b=ifGmC3HAfdJcqWIsUxnDdcYMa7nN0qdgueKd+BayQTp+PHKu15xpkLMoQUSO4nJVVi
         PlvrBtngvwF5XLJHfbJv5vnmmKdSibcsXGEgIb7CnSFn54OthuouK2TmQjCipGHLqpcR
         MyNExfkzQOOv0MxJk8lXC2A/6QzEBuWP1S8dRtDU2L9U75cFfDKhS6QyFAgDRNOqUnWW
         2btFvkWyib7Y+rXRe8Tx7e/Ezq6Ck/zvoqikcSyflYxVblKn0ceBDlxU1TcwavH1QE0Y
         Quvzbd7m56EAkYTQZc44wivjSXcoXdCr4Fj5esEcUNjBuEa+8xS8FKtM1q+VehsGMaAy
         eQuw==
X-Gm-Message-State: AOAM533TKZ80OTQE2ZporEjuSwtgCNrMIXhtOsaGTFoBcvW7c/sgDZs/
        1MZXv5KJVdmZ8IFXtLYvmPtDMZAJoGbqNmRbRJU=
X-Google-Smtp-Source: ABdhPJyAAT4G2P2y3Rd6p+yDNiiZk1Dv35k6zoSb0dk6V1YPkj0AB+++cFdUOBDwyyE04+wwAPby9ZbuWKPzKqQgrRI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e887:: with SMTP id
 b7mr14559706qvo.54.1629738827298; Mon, 23 Aug 2021 10:13:47 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:15 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 11/14] x86, module: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the __typeid__ relocations generated with CONFIG_CFI_CLANG
when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b5bd74..c4aeba237eef 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -197,6 +197,10 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 			val -= (u64)loc;
 			write(loc, &val, 8);
 			break;
+		case R_X86_64_8:
+			if (!strncmp(strtab + sym->st_name, "__typeid__", 10))
+				break;
+			fallthrough;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
-- 
2.33.0.rc2.250.ged5fa647cd-goog

