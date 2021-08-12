Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8733EAC19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhHLUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhHLUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:50:23 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6292C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:49:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q11-20020a05620a05abb02903ca17a8eef8so4411794qkq.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EEcmItRjp8Rm0JAsCYF3K+KT6iLKBKGG/FOXlRG+5Ik=;
        b=eAMZXGbnFvLxMVhR3gp86mUMmYHWjrLDcz6rCE8M4HpdlL57YmicGVKFLMpfSwTyyo
         Lo/0xfixfPgvJ6fclJdnhs48fKXYP5zydkg+2l4B/6QJDC8gnisa149VZ+eUcOx1woeV
         ghTqQB6krRcP+VEmBgShd9dngIIz9qCDrlR14W7mpq5rtW332fC80ialeFYuuIjtm+zb
         z6dLFQpBFk1oz1Bz/BsDoQ5G90N3h80UQgUOTFhp1oEOz01PQLix/43n3QbjIhFqet3Z
         AqIloDHl2SDJsWYRD490aevx5dg5DizH8FRex/MFf/g7DysGwt5R6t8SCQJu1o31wJVJ
         Y/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EEcmItRjp8Rm0JAsCYF3K+KT6iLKBKGG/FOXlRG+5Ik=;
        b=Uk+fsRNS5JWy9C1LDsJrjncoUFstWmHSG4zhgfFngLsSvGyZ++tHhpMNkwbJO/c5Zh
         kC7NWYjZXaP0bDNUtNbG6IndEwX5SLHFUjttUGgiPn6gjBImq5l1yTCYREoSbeqcGb8F
         De35ggNH1e4rmVu33tFegTBFGFK1DaP2EvqHYvOP0NkzlsIIk9QPAnDinawx2RM1e4ei
         AEvz/T+e6XhfGoh6JapRPNs5yphiLR1Udxnk+tvVYj3HPAr4H9ztSWLn8Hv2tbmA6weD
         gPbCcYDZjKTsV2RUNF163BVJ3nrzKHeGRh3UwZ7y3dCeUkn3NwmYv/3mwkwfZxQ3lfS4
         Bz3Q==
X-Gm-Message-State: AOAM5306de0LLQI2oEB0trjy5umUCAcbv+AQDydbFtqPRg6M6uP85bOU
        1pGkcLWwKkYDMxWbPFV/FmNfPRjT
X-Google-Smtp-Source: ABdhPJzYF7MyI9foK3XR/5POi74lS+GXilnDEKS8k7jS6nviaD6lyJyTJ+D2Jl6DyJhhGHTObKhsAzigXA==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:d96:5aae:6b0e:adc6])
 (user=morbo job=sendgmr) by 2002:a05:6214:892:: with SMTP id
 cz18mr5870385qvb.60.1628801396999; Thu, 12 Aug 2021 13:49:56 -0700 (PDT)
Date:   Thu, 12 Aug 2021 13:49:51 -0700
Message-Id: <20210812204951.1551782-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] ppc: add "-z notext" flag to disable diagnostic
From:   Bill Wendling <morbo@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "-z notext" flag disables reporting an error if DT_TEXTREL is set on
PPC with CONFIG=kdump:

  ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
    local symbol in readonly segment; recompile object files with -fPIC
    or pass '-Wl,-z,notext' to allow text relocations in the output
  >>> defined in built-in.a(arch/powerpc/kernel/misc.o)
  >>> referenced by arch/powerpc/kernel/misc.o:(.text+0x20) in archive
      built-in.a

The BFD linker disables this by default (though it's configurable in
current versions). LLD enables this by default. So we add the flag to
keep LLD from emitting the error.

Signed-off-by: Bill Wendling <morbo@google.com>

---
The output of the "get_maintainer.pl" run just in case no one believes me. :-)

$ ./scripts/get_maintainer.pl arch/powerpc/Makefile
Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Benjamin Herrenschmidt <benh@kernel.crashing.org> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Paul Mackerras <paulus@samba.org> (reviewer:LINUX FOR POWERPC (32-BIT AND 64-BIT))
Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT)
Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT)
linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT))
linux-kernel@vger.kernel.org (open list)
clang-built-linux@googlegroups.com (open list:CLANG/LLVM BUILD SUPPORT)
---
 arch/powerpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6505d66f1193..17a9fbf9b789 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -122,6 +122,7 @@ endif
 
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 
 ifdef CONFIG_PPC64
-- 
2.33.0.rc1.237.g0d66db33f3-goog

