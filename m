Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C959D445EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 05:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhKEEDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 00:03:47 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:49974 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhKEEDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 00:03:37 -0400
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1A5403LU022540;
        Fri, 5 Nov 2021 13:00:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1A5403LU022540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636084807;
        bh=jddleuDKBxe/P3YZOxewL3DfC/cVOoAyPm2jkKAyeJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znEQ3uNNcjfWQy7WHIJDrMJrbRaezPQtjncDyWGVBSV1gOL7OWj3YxD5y+DtBhg4a
         HHOoRWdaLUdUCFHAyg7g+2RbltS5LUJFFzJE9gpTRoRsT9yKnVw0cRs9j+u7/Qr4Ph
         ezZ5Kn7Tnw92ceksGCUAQYAGy+z08aWAPNCN54VdAt7OZkK/2/4J3pTVLYhmNTEQAE
         Zo5WgNbByaEHlCugjDlXzKDunfN85wiXF2tlTDP5EV3+5cKJWbR8y7Z6QH1xrm30LH
         6m3SRMWr2Jbb6OMnONhcLH/nLITLjZ1LWzx1M071vpv2dpAtO/nd49IOBXxFTyDqtM
         MdfEaQ2d0iIdA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] certs: use if_changed to re-generate the key when the key type is changed
Date:   Fri,  5 Nov 2021 12:59:58 +0900
Message-Id: <20211105035959.93748-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211105035959.93748-1-masahiroy@kernel.org>
References: <20211105035959.93748-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the key type of the existing signing key does not match to
CONFIG_MODULE_SIG_KEY_TYPE_*, the Makefile removes it so that it is
re-generated.

Use if_changed so that the key is re-generated when the key type is
changed (that is, the openssl command line is changed).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index fdf206022113..a702b70f3cb9 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -51,41 +51,23 @@ ifdef SIGN_KEY
 #
 ###############################################################################
 
-openssl_available       = $(shell openssl help 2>/dev/null && echo yes)
-
 # We do it this way rather than having a boolean option for enabling an
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
 ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
-ifeq ($(openssl_available),yes)
-X509TEXT=$(shell openssl x509 -in "certs/signing_key.pem" -text 2>/dev/null)
-endif
-
-# Support user changing key type
-ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
-keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
-ifeq ($(openssl_available),yes)
-$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
-endif
-endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
-
-ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
-ifeq ($(openssl_available),yes)
-$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
-endif
-endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
+keytype-$(CONFIG_MODULE_SIG_KEY_TYPE_ECDSA) := -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
 
 quiet_cmd_gen_key = GENKEY  $@
       cmd_gen_key = openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
 		-batch -x509 -config $(obj)/x509.genkey \
 		-outform PEM -out $(obj)/signing_key.pem \
-		-keyout $(obj)/signing_key.pem \
-		$(keytype_openssl) \
-		2>&1
+		-keyout $(obj)/signing_key.pem $(keytype-y) 2>&1
+
+$(obj)/signing_key.pem: $(obj)/x509.genkey FORCE
+	$(call if_changed,gen_key)
 
-$(obj)/signing_key.pem: $(obj)/x509.genkey
-	$(call cmd,gen_key)
+targets += signing_key.pem
 
 quiet_cmd_copy_x509_config = COPY    $@
       cmd_copy_x509_config = cat $(srctree)/$(src)/default_x509.genkey > $@
-- 
2.30.2

