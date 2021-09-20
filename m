Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1241128E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhITKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhITKHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:07:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FF5760F5D;
        Mon, 20 Sep 2021 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632132356;
        bh=mEIhB5gFO41gQ3sUmqJQlg/kWWUDHL4ECHOeQmvQpg8=;
        h=From:To:Cc:Subject:Date:From;
        b=TWh7aaNP0ht/JZhEtvnli9sWjRSesj7JtMP1fhpkq/Ox6LbM8AIvwD3rMhYAdffZx
         DflCXf/CEy6LwylZWp8KNf1t21ESsN1wyu9afVi1xJXkb1y2R3+eXuRvGd2GqnprTC
         IAVp/G8ruQXI2gryAgv4TFgr3cwi3z8ZKMfJAiV1+Gv9fG91wT2WGUmKZ+i4+9DGet
         RluQGa6j62yzuh21hSnmars9IXYDzPZwP/HGPji3w7pSl1wi7JnOA7/1hvCc5gEn5R
         hCZA3EPTg4tULLUH/gVasPIZBSqNsEGhqVTTMLga+ZaZDcfhvTW3hB5+M84RRhw/G4
         0p8mQnqU74Juw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ecc: fix CRYPTO_DEFAULT_RNG dependency
Date:   Mon, 20 Sep 2021 12:05:35 +0200
Message-Id: <20210920100551.1568868-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ecc.c file started out as part of the ECDH algorithm but got
moved out into a standalone module later. It does not build without
CRYPTO_DEFAULT_RNG, so now that other modules are using it as well we
can run into this link error:

aarch64-linux-ld: ecc.c:(.text+0xfc8): undefined reference to `crypto_default_rng'
aarch64-linux-ld: ecc.c:(.text+0xff4): undefined reference to `crypto_put_default_rng'

Move the 'select CRYPTO_DEFAULT_RNG' statement into the correct symbol.

Fixes: 0d7a78643f69 ("crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm")
Fixes: 4e6602916bc6 ("crypto: ecdsa - Add support for ECDSA signature verification")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 536df4b6b825..285f82647d2b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -233,12 +233,12 @@ config CRYPTO_DH
 
 config CRYPTO_ECC
 	tristate
+	select CRYPTO_RNG_DEFAULT
 
 config CRYPTO_ECDH
 	tristate "ECDH algorithm"
 	select CRYPTO_ECC
 	select CRYPTO_KPP
-	select CRYPTO_RNG_DEFAULT
 	help
 	  Generic implementation of the ECDH algorithm
 
-- 
2.29.2

