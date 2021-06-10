Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B965B3A2D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFJNrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:47:15 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:14974 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231273AbhFJNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:47:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UbzAVm0_1623332700;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UbzAVm0_1623332700)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jun 2021 21:45:00 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 0/3] Introduce x86 assembler accelerated implementation for SM4 algorithm
Date:   Thu, 10 Jun 2021 21:44:56 +0800
Message-Id: <20210610134459.28541-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extracts the public SM4 algorithm as a separate library,
and introduces an accelerated implementation of the instruction set on
x86, and will also introduce more mode-specific accelerated
implementations later.

Tianjia Zhang (3):
  crypto: sm4 - create SM4 library based on sm4 generic code
  crypto: arm64/sm4-ce - Make dependent on sm4 library instead of
    sm4-generic
  crypto: x86/sm4 - add AES-NI/AVX/x86_64 assembler implementation

 arch/arm64/crypto/Kconfig              |   2 +-
 arch/arm64/crypto/sm4-ce-glue.c        |  14 +-
 arch/x86/crypto/Makefile               |   3 +
 arch/x86/crypto/sm4-aesni-avx-asm_64.S | 339 +++++++++++++++++++++++++
 arch/x86/crypto/sm4_aesni_avx_glue.c   | 115 +++++++++
 crypto/Kconfig                         |  30 +++
 crypto/sm4_generic.c                   | 164 +-----------
 include/crypto/sm4.h                   |  25 +-
 lib/crypto/Kconfig                     |   3 +
 lib/crypto/Makefile                    |   3 +
 lib/crypto/sm4.c                       | 184 ++++++++++++++
 11 files changed, 718 insertions(+), 164 deletions(-)
 create mode 100644 arch/x86/crypto/sm4-aesni-avx-asm_64.S
 create mode 100644 arch/x86/crypto/sm4_aesni_avx_glue.c
 create mode 100644 lib/crypto/sm4.c

-- 
2.19.1.3.ge56e4f7

