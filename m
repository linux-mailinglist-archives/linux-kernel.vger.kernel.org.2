Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF43E4CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 21:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhHITOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhHITOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:14:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD68C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:14:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mi10-20020a17090b4b4ab0290178b6d7574aso674610pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VXGYDTaRYeoaJIqdPZlhy5y2inb6mH52B9u2au448RA=;
        b=EcT+ace4zo3FGX2xRRCZRWsVs1JYWwQ1uTmeT+mGC9pbfhP5tSD7HZKmTrwl3/mHm8
         RUmi9cnb0hTk07jUIxib0hSChMJbQdRUMamhM0aobpNu67emPDMXtbHUDcy7HC4v98Z2
         nIqgkruFcbGZQhQAVxKd+FgxHgJ66vJBR6jlGOyopEad2fpWEYlDw9k8Acldzh+sUNIp
         UnvkN60x8PolsWixmoPCfZrWwwE1PfZ6dAxjrYRCKwFtvPJxK+XHGiGOIxKI8+BOfDkF
         QvFZjx4IKHqkSxyP752vuNbQVZ2Hs3KmtokWU+Sm/TyW5lsZoVJG0T0NTtq+yclO04kf
         LjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VXGYDTaRYeoaJIqdPZlhy5y2inb6mH52B9u2au448RA=;
        b=gw4wqx3SWxhuqDV7qYb08iACCeHOSP+fTWLM8f3vzRgDfauEwr9EqGuYAToKNG2ABC
         pZTBzlGqhYAnj3evrnoSmjv993YgnmNI+qo0jCjyfmdJoA6ZL5GTnOw2WOG62nGggUrd
         V5CMcUo2jvfPpj7A5Mx+JnbAfT6Nekh1wf0KWjUzPWv0EX1oGyF28oYRcROEjOCFu6jR
         q9DUqI4MwaMJjKLzXHGyllnjvbNSAVMOPvtHvUeWCibFqc+V3F2O0CvmFAuhJQudix7u
         zebceT6LJ7LDtQZ0N58zAjUwSPkoHecew4ufPACONNdPuU+oPu2aizaFKPzD4WmkeRvE
         KjfQ==
X-Gm-Message-State: AOAM53264vCHug6StYx1iWm2lmuH/tLvsj3aOXQRoejUyWLLXm7mo/jL
        mnUPNDkDa53D6Ma9Ot4ZYTi0yYmN7w==
X-Google-Smtp-Source: ABdhPJzSFtE2OpubeO66XVZwSWA9Ea7+82yrplbdPoy7dC24f8AanpR/xFXsguoS+udUR8gp+ZCj+GLANA==
X-Received: from adelg-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d1f])
 (user=adelg job=sendgmr) by 2002:a17:90a:7886:: with SMTP id
 x6mr113911pjk.1.1628536460691; Mon, 09 Aug 2021 12:14:20 -0700 (PDT)
Date:   Mon,  9 Aug 2021 19:14:14 +0000
Message-Id: <20210809191414.3572827-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH] arm64: clean vdso files
From:   Andrew Delgadillo <adelg@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrew Delgadillo <adelg@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a5b8ca97fbf8 ("arm64: do not descend to vdso directories twice")
changes the cleaning behavior of arm64's vdso files, in that vdso.lds,
vdso.so, and vdso.so.dbg are not removed upon a 'make clean/mrproper':

$ make defconfig ARCH=arm64
$ make ARCH=arm64
$ make mrproper ARCH=arm64
$ git clean -nxdf
Would remove arch/arm64/kernel/vdso/vdso.lds
Would remove arch/arm64/kernel/vdso/vdso.so
Would remove arch/arm64/kernel/vdso/vdso.so.dbg

To remedy this, manually descend into arch/arm64/kernel/vdso upon
cleaning.

After this commit:
$ make defconfig ARCH=arm64
$ make ARCH=arm64
$ make mrproper ARCH=arm64
$ git clean -nxdf
<empty>

Signed-off-by: Andrew Delgadillo <adelg@google.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b52481f0605d..ef6598cb5a9b 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -181,6 +181,7 @@ archprepare:
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=arch/arm64/kernel/vdso
 
 ifeq ($(KBUILD_EXTMOD),)
 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
-- 
2.32.0.605.g8dce9f2422-goog

