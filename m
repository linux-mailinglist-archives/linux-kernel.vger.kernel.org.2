Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0B3632DE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 02:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhDRAkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 20:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhDRAkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 20:40:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD4C06174A;
        Sat, 17 Apr 2021 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1jbPADBGzc593GHzdh/K8qvQUZIwB+uLs/zlYNey+1k=; b=eSUJQKHrhmcqxFM5HwDvf1ei3C
        itb1+9wNJRgSZ4OZnDkW765tLpBtB3UFLNElPcCG8GGQGrgm7KpcUvjcXWmXPeaFTpEXr2RISxu3c
        k8s3mq32cQtrIequ2NCk3em+CrqziFdtZyNXWxk+lY2pnNbgeihwtt+L4mCejS5pjbqSdMMRjNjGB
        5rxKl+7isMlhneFKx9bfnP6fSAGz8NN8iw47UJIKXymE6oWwO3vpK1bUFJfM+4Q/IioCgyQ3Kw+WZ
        V6C/giYOJk3oFrnQ15v/t1MemU4Bkj2kSay/1CqJTthkar65KDnF/uic6IPh3PvqOc+x4cKMnsXDa
        5YDA+uhg==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXvTK-006i2Z-Ew; Sun, 18 Apr 2021 00:39:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Siewior <sebastian@breakpoint.cc>,
        Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: camellia: drop duplicate "depends on CRYPTO"
Date:   Sat, 17 Apr 2021 17:39:29 -0700
Message-Id: <20210418003929.5065-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All 5 CAMELLIA crypto driver Kconfig symbols have a duplicate
"depends on CRYPTO" line but they are inside an
"if CRYPTO"/"endif # if CRYPTO" block, so drop the duplicate "depends"
lines.

These 5 symbols still depend on CRYPTO.

Fixes: 584fffc8b196 ("[CRYPTO] kconfig: Ordering cleanup")
Fixes: 0b95ec56ae19 ("crypto: camellia - add assembler implementation for x86_64")
Fixes: d9b1d2e7e10d ("crypto: camellia - add AES-NI/AVX/x86_64 assembler implementation of camellia cipher")
Fixes: f3f935a76aa0 ("crypto: camellia - add AVX2/AES-NI/x86_64 assembler implementation of camellia cipher")
Fixes: c5aac2df6577 ("sparc64: Add DES driver making use of the new des opcodes.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Siewior <sebastian@breakpoint.cc>
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 crypto/Kconfig |    5 -----
 1 file changed, 5 deletions(-)

--- linux-next-20210416.orig/crypto/Kconfig
+++ linux-next-20210416/crypto/Kconfig
@@ -1223,7 +1223,6 @@ config CRYPTO_BLOWFISH_X86_64
 
 config CRYPTO_CAMELLIA
 	tristate "Camellia cipher algorithms"
-	depends on CRYPTO
 	select CRYPTO_ALGAPI
 	help
 	  Camellia cipher algorithms module.
@@ -1239,7 +1238,6 @@ config CRYPTO_CAMELLIA
 config CRYPTO_CAMELLIA_X86_64
 	tristate "Camellia cipher algorithm (x86_64)"
 	depends on X86 && 64BIT
-	depends on CRYPTO
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
@@ -1256,7 +1254,6 @@ config CRYPTO_CAMELLIA_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
 	depends on X86 && 64BIT
-	depends on CRYPTO
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	select CRYPTO_SIMD
@@ -1275,7 +1272,6 @@ config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
 	depends on X86 && 64BIT
-	depends on CRYPTO
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
 	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
@@ -1291,7 +1287,6 @@ config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
 config CRYPTO_CAMELLIA_SPARC64
 	tristate "Camellia cipher algorithm (SPARC64)"
 	depends on SPARC64
-	depends on CRYPTO
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
