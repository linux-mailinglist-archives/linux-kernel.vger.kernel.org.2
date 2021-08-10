Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799863E865F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhHJXS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhHJXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:18:27 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA04EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:18:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m3-20020a17090b0683b0290178cb50bc1aso746894pjz.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E8Aj/fL5iGPfl9iYHtcSD7Ifgdxa0r41M3PNgmyPyak=;
        b=p/c5xE+4cJjJDX/cyiXUQQUoZPUgIToX7/lcdt/0nChru9fCTjdkOQKWFnEfc89zTy
         7K5QPv+YdxATjxQmrBaMiRwC7OpCbfFfPqX+tkkOp6CKHA+kQo7jUi1xCJu8zWlDTzCY
         j1m0sn8wybItzq3EUXjbnbbkJmbEslCtaPv+pWGLIgex3aJti2NzMB4uYj2A1Mo0n1jj
         1VE5IleS3SOEF7sp684nd2fkMH7gnKe1oBP0qeiPiIMhoou83/SHhkq9Tq8gW1uIQS6O
         BuA6CYlJma4k0TrNf3WfIWe3hLE7litvV1Se3P+FxnlaXZwMjWkAVNZoJVsAkX3gfaGW
         l7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E8Aj/fL5iGPfl9iYHtcSD7Ifgdxa0r41M3PNgmyPyak=;
        b=WQUmP+Q3+NrBrlVlIZWJNM/3vWW2C/CGkui3rtg35w9tp/drTWiOrq9e1LcfzLXIAe
         9hjrzkfdRB1AUIhABkt1VBlTwwaMRLRPMGTEesp6EbZz+TQjzwP5KZCGzi+ew1wsMmBI
         /cjQz4PeWyv757ERxj+Dmj2KEhMI7x0A0cl+Pxb5mi48lTflrkjPZ4cwVGlL4dKJirFp
         686tBPCkaOKC6HSHBLg/3HiNNef3CUtNA1IJxwkB/1VeEBrf/4cU/FLZRS9kr++pmdKP
         +nUOD+WPiYJQ8j4t3VF0K5iLtyGoflxQwEoRZAmLz5FuaA08lMdZ1ovjGDg18aAG1TJZ
         M9ng==
X-Gm-Message-State: AOAM5307QMNs66tzXNxx4m4KgdiqmGe8dmOnCBUKwr+ifd7iTr8G4lBQ
        kqq1wdmh8Evu9Y1EgzJ/M8RZeVhTog==
X-Google-Smtp-Source: ABdhPJyb51vgZGJ83rqquzLnLshtObvbPMhnS6d+bkM6fAJDJP8gMjmKZgFb1YsAnccZYEE6WYj9iue2xg==
X-Received: from adelg-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d1f])
 (user=adelg job=sendgmr) by 2002:a05:6a00:a94:b029:384:1dc6:7012 with SMTP id
 b20-20020a056a000a94b02903841dc67012mr31128194pfl.53.1628637484118; Tue, 10
 Aug 2021 16:18:04 -0700 (PDT)
Date:   Tue, 10 Aug 2021 23:17:55 +0000
Message-Id: <20210810231755.1743524-1-adelg@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2] arm64: clean vdso & vdso32 files
From:   Andrew Delgadillo <adelg@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Delgadillo <adelg@google.com>, stable@vger.kernel.org
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

Similar results are obtained for the vdso32 equivalent.

Signed-off-by: Andrew Delgadillo <adelg@google.com>
Cc: stable@vger.kernel.org
---
Changelog since v1:
- Also descend into vdso32 upon archclean
- Add stable to cc in signoff area

 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b52481f0605d..02997b253dee 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -181,6 +181,8 @@ archprepare:
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=arch/arm64/kernel/vdso
+	$(Q)$(MAKE) $(clean)=arch/arm64/kernel/vdso32
 
 ifeq ($(KBUILD_EXTMOD),)
 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
-- 
2.32.0.605.g8dce9f2422-goog

