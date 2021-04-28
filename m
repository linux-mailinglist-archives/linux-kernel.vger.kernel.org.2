Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5736D356
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhD1HlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbhD1HlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:41:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:40:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so5266905wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r18HrmYIRACDIWPPxOL9xtuGamJUMKpi78NPG5ZEmUs=;
        b=CYUDuxtqwT3OQp1twKAloFfczV1Y/bTIpgT4OTkWGwzSQ50vmGPlSL7+UXiUdqcxg8
         SD04UZ91P2iUr2Z7JmMhgx8Ka6GP7SVW2VvXoIIhx/a7eGVesp6Ji4pZaHNLZZqbsZ/B
         dLdAfsKuwhmhTZrx1iZ8zLA7yBCyOyA+8PRYlzXg9V1ZWKXj9owZcBiA7/9C9cohrC76
         wZt3dPyKCI35OH4GV8ClJJ3i9KpnxCB7VgvgpVme7IdxS3OsKYHuUfsSOAoq1pg7VLh+
         ViLaBvfIhnNUQa/kX50yynGQ8xqzyjeoqt72Borp3Yd95sAaDAZ4Owc/yZj+W0TF3SZL
         Kx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=r18HrmYIRACDIWPPxOL9xtuGamJUMKpi78NPG5ZEmUs=;
        b=auSyFKrQmVj6/kjrrABftO6E9IYG+oxKPb08RnUdw4Z020lr6AkWoIzoMEUkGrfRW8
         4QznfXSiDZfEdTnUmePqjHeWvGGX4pSr8qwIfGq7e/tIeKiqM5n8v72viS/ja1wcfQhb
         IRh9qmD8GvxOCghOuRPy620YDEW4UTVPTOcU8Erdhq71lAJms3CDdaw5vxrCaioxcKE2
         OGE3QyjjYuRZXU9no3L/zdtl15OOwjqON3ijNbndyiXf7tF6kGQppib0IgkO99i2o3C9
         7CFg+HD83nChqiTJ4XZ4uCo1Vr+hB5EsYrpbM+QXUM2Wa/uH/CzodXCLdGkbRSiGBmw8
         krVw==
X-Gm-Message-State: AOAM531q2C7UeB5xcVFub2cIDWAg3+r7xOcmLeYHtBoXbxdBdDtwJ4YN
        XZ12flWrXWVgq1wTeLJTQngP6Buzrc0=
X-Google-Smtp-Source: ABdhPJwEzdDyoysipgTHWktEvHv5ADpAzs9Xl53U2PueWD2zshjX81Hkzf1gRaZccMMsbuy9EywUgQ==
X-Received: by 2002:a1c:dc41:: with SMTP id t62mr2860557wmg.14.1619595629644;
        Wed, 28 Apr 2021 00:40:29 -0700 (PDT)
Received: from gmail.com (2E8BA22B.catv.pool.telekom.hu. [46.139.162.43])
        by smtp.gmail.com with ESMTPSA id 3sm2745992wms.30.2021.04.28.00.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:40:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 28 Apr 2021 09:40:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool updates for v5.13
Message-ID: <20210428074027.GA206401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2021-04-28

   # HEAD: 7d3d10e0e85fb7c23a86a70f795b1eabd2bc030b x86/crypto: Enable objtool in crypto code

Objtool updates in this cycle were:

 - Standardize the crypto asm code so that it looks like compiler-generated
   code to objtool - so that it can understand it. This enables unwinding
   from crypto asm code - and also fixes the last known remaining objtool
   warnings for LTO and more.

 - x86 decoder fixes: clean up and fix the decoder, and also extend it a bit

 - Misc fixes and cleanups

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (13):
      objtool: Support asm jump tables
      x86/crypto/aesni-intel_avx: Remove unused macros
      x86/crypto/aesni-intel_avx: Fix register usage comments
      x86/crypto/aesni-intel_avx: Standardize stack alignment prologue
      x86/crypto/camellia-aesni-avx2: Unconditionally allocate stack buffer
      x86/crypto/crc32c-pcl-intel: Standardize jump table
      x86/crypto/sha_ni: Standardize stack alignment prologue
      x86/crypto/sha1_avx2: Standardize stack alignment prologue
      x86/crypto/sha256-avx2: Standardize stack alignment prologue
      x86/crypto/sha512-avx: Standardize stack alignment prologue
      x86/crypto/sha512-avx2: Standardize stack alignment prologue
      x86/crypto/sha512-ssse3: Standardize stack alignment prologue
      x86/crypto: Enable objtool in crypto code

Peter Zijlstra (11):
      objtool: Allow UNWIND_HINT to suppress dodgy stack modifications
      objtool,x86: Renumber CFI_reg
      objtool,x86: Rewrite LEA decode
      objtool,x86: Rewrite LEAVE
      objtool,x86: Simplify register decode
      objtool,x86: Support %riz encodings
      objtool,x86: Rewrite ADD/SUB/AND
      objtool,x86: More ModRM sugar
      objtool: Add --backup
      objtool: Collate parse_options() users
      objtool: Parse options from OBJTOOL_ARGS


 arch/x86/crypto/Makefile                       |   2 -
 arch/x86/crypto/aesni-intel_avx-x86_64.S       |  28 +--
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S   |   5 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S      |   7 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S         |   8 +-
 arch/x86/crypto/sha1_ni_asm.S                  |   8 +-
 arch/x86/crypto/sha256-avx2-asm.S              |  13 +-
 arch/x86/crypto/sha512-avx-asm.S               |  41 ++--
 arch/x86/crypto/sha512-avx2-asm.S              |  42 ++--
 arch/x86/crypto/sha512-ssse3-asm.S             |  41 ++--
 tools/objtool/arch/x86/decode.c                | 282 ++++++++++++++-----------
 tools/objtool/arch/x86/include/arch/cfi_regs.h |  12 +-
 tools/objtool/builtin-check.c                  |  43 +++-
 tools/objtool/builtin-orc.c                    |   5 +-
 tools/objtool/check.c                          |  53 +++--
 tools/objtool/include/objtool/arch.h           |   1 -
 tools/objtool/include/objtool/builtin.h        |   5 +-
 tools/objtool/objtool.c                        |  64 ++++++
 18 files changed, 384 insertions(+), 276 deletions(-)
