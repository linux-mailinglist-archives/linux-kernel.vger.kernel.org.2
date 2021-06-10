Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E03A3540
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFJVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhFJVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:00:10 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B28C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 13:58:13 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4G1GXM1KY0zQjhX;
        Thu, 10 Jun 2021 22:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:mime-version:date:date:message-id:subject:subject
        :from:from:received; s=mail20150812; t=1623358687; bh=8DNpmKTXNd
        Sq1ifPtsy7Fm/QubhY8gRgwIKquoH/6pg=; b=YN3BRYuY/NmUeb7nclIP0L6PeP
        dTLL1NiYZCUEd3imEkcHJZT8jAvjP0m8s///0+PBhYIIMEkJUZ4DqwFiHteDtrxe
        mfq9bRMCGtzuTIulKqfsGb0UpbRiF2uKij2K7Y28EtzSdxhVj2w+24OZ5zbDBbCq
        /MuK+iYVOBj5+ZB5H5IBxNwWLQaoSWkAUwH0oSsAHuTvt0rG5ev8FKR+Ugl8CY4e
        wCTJBvGBqA9oTobsyNcSJcanBRQIKeUrG6noxwYIkWzom0HKdfk9rtpwbTKQr/zo
        Ywuz+J6WvVnhr74G+FQX6DmI5LoZ/hKbSkpNrh4uMujswWkuDe3hv5hB1V1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1623358689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TC/huu5w6Vq+jWW3wxo62gGwMM9Lr1uzxzAJMRLZVQw=;
        b=gvi7Y4glHZfDMejrTcM0P1jYMoy+BKHufvXhVAHxkWl7p5YfVdGHO/skOSM8338a3Bumk6
        6aEMH+AVx0mOd7J2y/bm+SszxykV2O7k+tDIK4AaTMe4D8Z4ll47mWFuzjACS7JCtBDMP9
        rIGZ8fyefTl/2QPafoBJ1qrpn+O1A9iOQz9XZABdbV4lA8kpbDYCHjifPfQpcNwaAccUq3
        lGDIMi41Qo1Joav1HsdsNvNesCXkLmQ+jodkTwY4eCuXlGYGayiL8bZ1vp5UHN0RY4T6aJ
        Csbfg5T3rC9WVJqmczLx/vIWPlnVUW8U2MFGHuvUzeu/eq7WcHvfScSGROCKww==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id An5_chuNxmli; Thu, 10 Jun 2021 22:58:07 +0200 (CEST)
From:   Tor Vic <torvic9@mailbox.org>
Subject: [PATCH v2 1/1] x86/Makefile: make -stack-alignment conditional on LLD
 < 13.0.0
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "x86@kernel.org" <x86@kernel.org>
Message-ID: <f2c018ee-5999-741e-58d4-e482d5246067@mailbox.org>
Date:   Thu, 10 Jun 2021 20:58:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.23 / 15.00 / 15.00
X-Rspamd-Queue-Id: F1254180C
X-Rspamd-UID: 88ee33
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since LLVM commit 3787ee4, the '-stack-alignment' flag has been dropped
[1], leading to the following error message when building a LTO kernel
with Clang-13 and LLD-13:

    ld.lld: error: -plugin-opt=-: ld.lld: Unknown command line argument
    '-stack-alignment=8'.  Try 'ld.lld --help'
    ld.lld: Did you mean '--stackrealign=8'?

It also appears that the '-code-model' flag is not necessary anymore
starting with LLVM-9 [2].

Drop '-code-model' and make '-stack-alignment' conditional on LLD < 13.0.0.

These flags were necessary because these flags were not encoded in the
IR properly, so the link would restart optimizations without them. Now
there are properly encoded in the IR, and these flags exposing
implementation details are no longer necessary.

Changes from v1:
- based on mainline
- provide more information about the flags (Nick)
- use correct tags

Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/1377
[1]: https://reviews.llvm.org/D103048
[2]: https://reviews.llvm.org/D52322
Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
 arch/x86/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 307529417021..cb5e8d39cac1 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -200,8 +200,9 @@ endif
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)

 ifdef CONFIG_LTO_CLANG
-KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
-		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
+KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+endif
 endif

 ifdef CONFIG_X86_NEED_RELOCS
-- 
2.32.0
