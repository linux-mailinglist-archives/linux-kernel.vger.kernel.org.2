Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A03210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBVGox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 01:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBVGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 01:44:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E737C061574;
        Sun, 21 Feb 2021 22:43:57 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b145so6001309pfb.4;
        Sun, 21 Feb 2021 22:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M1CBK07C46laJoyWYovF4lSgfEz56MEL8US4G4KcnR0=;
        b=VMN5tc4DR8o2nDN/b5KFvZqQa6duu77h7sBp5OmZ2ROJmMJVtJKZMpc9GHprk1jDHb
         ARN/Xf82uzfcaJdAHz/T4B+E2zuvrAo90wgUZG3Dld2wYmR6qqIR7z2r77JfUwca3UJY
         dFR3NNQosShszX7Znz7D1vysGEWDj7YwsJKFKAe+osnWMvYW5MWhiy/wfaKjaUNL5Xou
         tEsYM7mkvWZ2blnVtVAtemsQbZn9FMHy1w2ni/dBCw1Y+5dipyfkbxJPwz+fR429v1to
         /bL8TKN9onyiZDZefBqntXFS5G7dubbubE1pueIFhA/aL2cJTx46DxfBH7mxMDNPfiVV
         HbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M1CBK07C46laJoyWYovF4lSgfEz56MEL8US4G4KcnR0=;
        b=kxfcIyafIRhKVB8aCGf/xRlymWB4qll1sRFNer9tQPqdV65RDljPZWvYdmQaVYN2tC
         f5c/t1upXkz0Q03Yc1oncD4AA43uA5RsJNnsZZc5KTXOSg+J51Ct8SGIX5kU3hBFUXYk
         PWxJ69dhQNyIX+OL2NyWY9a7tQH198M/qhxlX7OI1UVviwNfQhWAxL8bhFt4wYDnDeu6
         cVPU4d1pq28lrWGerQkdftelAcRcGgXTloVsKcJQv8S0xcy4NvsR45sumVKI+G0Dx2Tu
         pOJUJlVAwFrtxb10ifrLvn9x7e9Xzrk/VUb6fvVFGv1hDTyXGTfs0wyubatnIW7Ky1kp
         wNCA==
X-Gm-Message-State: AOAM533voAlIKS76gZIKdDDUJUHXAmALnUdB/bXOb/HO/11/h81d2mI/
        wGXBLNBX0yMqZ8g45vJ+1Jo=
X-Google-Smtp-Source: ABdhPJyqLaJut8n4jfDP5K19sjmiimEx9q9MGmuYnzLAtKKOKI8pG9AFY6QqZaKgUXolFrpGwmf/Og==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr10843098pgt.355.1613976236773;
        Sun, 21 Feb 2021 22:43:56 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 188sm8688195pfz.119.2021.02.21.22.43.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2021 22:43:56 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 4/4] Documentation/admin-guide/module-signing.rst: add openssl command option example for CodeSign EKU
Date:   Mon, 22 Feb 2021 14:42:51 +0800
Message-Id: <20210222064251.13374-5-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210222064251.13374-1-jlee@suse.com>
References: <20210222064251.13374-1-jlee@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an openssl command option example for generating CodeSign extended
key usage in X.509 when CONFIG_CHECK_CODESIGN_EKU is enabled.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 Documentation/admin-guide/module-signing.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 7d7c7c8a545c..b57b30c7125f 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -170,6 +170,12 @@ generate the public/private key files::
 	   -config x509.genkey -outform PEM -out kernel_key.pem \
 	   -keyout kernel_key.pem
 
+When ``CONFIG_CHECK_CODESIGN_EKU`` option be enabled, the following openssl
+command option should be added for generating CodeSign extended key usage in
+X.509::
+
+        -addext "extendedKeyUsage=codeSigning"
+
 The full pathname for the resulting kernel_key.pem file can then be specified
 in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
 be used instead of an autogenerated keypair.
-- 
2.16.4

