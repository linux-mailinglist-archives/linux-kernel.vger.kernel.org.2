Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93C33EBD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhHMUFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhHMUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:05:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45798C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 13:05:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p71-20020a25424a0000b029056092741626so10150405yba.19
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4EYkfl7u3c0fe6BZm+nywHzPnvU49Nzp4mTk0DIT6Qs=;
        b=tDG79y8JxkEeMITM/Dz4I+5ruSVrztX+8ungXNgGhNZjJf8sdiadYlyroOHQSkRkfh
         Bl6lclrN2WWca0OdrkgyfALXglNegzaXZq46X6yOKy1VWa/8b/lJEmEbytlXQJ62OUHV
         hFAoE27wYE7nhfiwyiC4XrPfhfuqGJS8647UVKLAujIMYmrS5/tVMdDuhQF5mnevCL+R
         jkfHmduS826o4/5KDRsfdBviGLDVwRMWx16xPYTr1XCFAoJcjRIe507ct0XKZQXWDdCv
         HKotn/TRxraXxsDE9+K/W0SQ2TqlA0vhIk0QOB9HIBaEWTl1rVT5bFhHPLcQtVuVjJnd
         RQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4EYkfl7u3c0fe6BZm+nywHzPnvU49Nzp4mTk0DIT6Qs=;
        b=H1lPR/v8U+jQl6vTKwlpvbd62+FGc5051jHbbqKVn+ndYrGsLDeQcjQeThGgP3N56i
         7NAHaHdDviMk5v+Wmbm5LoZblRwQ6y9GvdAO7+UomfbrsfmCaVrZfoiaGQL2VqQtcbyA
         Gombp9TxNDV+5rFPM0JR4r7Z6x4NFqlMC0eHmm7wJI9IhJLUN2gNCaFKr8OEWUZfm1dh
         DVPehjeQom3uq/6O3y5oCFCP34H0N/2Awhtmg26+zLgJ/C6Smwwqj3/PeQTKqXgsI1PG
         kYA6l/BfdPQFqQyU06D7JXVC6cYWBQQTin05KKB64PSSbORDnGwvGLAfe759TXGiBomd
         Q9Xg==
X-Gm-Message-State: AOAM530E2Gsro5MsaK8fTjTEUM804NwIvvq1J4GV2gZ5kmEasNow2pre
        5WVKc+NDD7iMDjeWBahZj1nRFpPd
X-Google-Smtp-Source: ABdhPJxOLdvxgHb9JGu7E7H94pvG+O55jjxNK8CLGUihMstI5TpU89TWclMjGii3Kz6pWo5nZlQMIyGZFg==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:47b8:ed1f:f8e9:a664])
 (user=morbo job=sendgmr) by 2002:a25:bb13:: with SMTP id z19mr5539560ybg.347.1628885116494;
 Fri, 13 Aug 2021 13:05:16 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:05:11 -0700
In-Reply-To: <20210812204951.1551782-1-morbo@google.com>
Message-Id: <20210813200511.1905703-1-morbo@google.com>
Mime-Version: 1.0
References: <20210812204951.1551782-1-morbo@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2] ppc: add "-z notext" flag to disable diagnostic
From:   Bill Wendling <morbo@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Daniel Axtens <dja@axtens.net>,
        Fangrui Song <maskray@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Itaru Kitayama <itaru.kitayama@riken.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fangrui Song <maskray@google.com>

Object files used to link .tmp_vmlinux.kallsyms1 have many R_PPC64_ADDR64
relocations in non-SHF_WRITE sections. There are many text relocations (e.g. in
.rela___ksymtab_gpl+* and .rela__mcount_loc sections) in a -pie link and are
disallowed by LLD:

  ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against local symbol in readonly segment; recompile object files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in the output
  >>> defined in arch/powerpc/kernel/head_64.o
  >>> referenced by arch/powerpc/kernel/head_64.o:(__restart_table+0x10)

Newer GNU ld configured with "--enable-textrel-check=error" will report an
error as well:

  $ ld-new -EL -m elf64lppc -pie ... -o .tmp_vmlinux.kallsyms1 ...
  ld-new: read-only segment has dynamic relocations

Add "-z notext" to suppress the errors. Non-CONFIG_RELOCATABLE builds use the
default -no-pie mode and thus R_PPC64_ADDR64 relocations can be resolved at
link-time.

Link: https://github.com/ClangBuiltLinux/linux/issues/811
Signed-off-by: Fangrui Song <maskray@google.com>
Co-developed-by: Bill Wendling <morbo@google.com>
Signed-off-by: Bill Wendling <morbo@google.com>
Reported-by: Itaru Kitayama <itaru.kitayama@riken.jp>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
v2:
  - Assign "Fangrui Song" as the proper author.
  - Improve the commit message to add more context.
  - Appending tags from original patch's review.
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

