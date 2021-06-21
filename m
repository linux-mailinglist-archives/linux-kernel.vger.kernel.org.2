Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E783AEB24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFUO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhFUO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:26:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357AAC061574;
        Mon, 21 Jun 2021 07:23:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v7so14305636pgl.2;
        Mon, 21 Jun 2021 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=kVtvrkXwk8kxj6gf2PfX3z+ND5YYrSne7FW7uUZ08Dw=;
        b=dCHE9btcAzLdOQNJxrfq5n3gJYinNziLY0jlOiSL9JROQMDzUAajHgn9svP3Oe3JJK
         6mOfRue2H5FEI/vLv51iVQPaq5yGuXP77BATzpOKrf85nRPFGwT+Oj1bVuQhbOYaLrfj
         b4Es2ukCzR01vc3oQO+ptqlqsXM2QpQ9OokusqaeNmg3KFd63GYvTarM6DipF9gPWCMT
         ErtLhAbZ0VznZIq/XtzslxfoxBJRZh0SSbghf2yn+P5VHHHZ3Wi4LR7RIkLijJVaOOYk
         N5dQjwWdAGyJkQT/pwN4E9kANLKmdepn9lIucdxnWaUlsy7CF/1GxvrpJEJNiAZiM8zL
         u0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=kVtvrkXwk8kxj6gf2PfX3z+ND5YYrSne7FW7uUZ08Dw=;
        b=eUoCc7MwKSIfxMW4c7nPBficEjIVP2QFl+5U7fhNO4lt/KlHW/nk58zaQsR3MDEfLA
         u/vpISYHZebemLklrOGGe4/7w4IeDvRodPWE3C6zluWqut5pO6wYkf4Geutf0NUZQ153
         XaktWRe91Y7ctL4LVa3H5P6Pcs51vljSyPAW9wZ29Flwae2Dy3WoGFXAz4hGf6nMufFU
         +Z897eRQYVaWNyIPS2uOVaEKwrdY93XKh4eOjV6lLt+EbYqAkGwdG+kuxFne184i3RAg
         j7lYxeS/3YKyaltrtYlR9bSzE8ZyOoXZsEY8u5Jx06GpiRGfeJUYxpJ1aOzYWnkulGSG
         NAHQ==
X-Gm-Message-State: AOAM532iTpUfsxVy2zLiTYFuQo0xcmWDTqW4J7UU7upr2OVocsVtD1Fm
        zpWU/dGG6nBsfN6jyWciCtOIRJXjDt6bWV+kF5piqw==
X-Google-Smtp-Source: ABdhPJx6n4RsO3FpTM1sGeIPMkBKHgRDvBpaGzbYt9EsytZKaCMXqgsu2xMZ9I5dj5w2tHMKbog02Q==
X-Received: by 2002:a63:ec43:: with SMTP id r3mr23909330pgj.344.1624285436618;
        Mon, 21 Jun 2021 07:23:56 -0700 (PDT)
Received: from localhost ([101.190.237.11])
        by smtp.gmail.com with ESMTPSA id gz15sm2827138pjb.49.2021.06.21.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:23:56 -0700 (PDT)
Date:   Tue, 22 Jun 2021 00:23:46 +1000
From:   Ian Fleming <wholehepple@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] certs: Documentation/admin-guide/module-signing.rst and
 root .gitignore
Message-ID: <20210622002212.0c069334@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Fleming <wholehepple@gmail.com>

Commit b31f2a495debc71bdfefefea8056ade429f79c4b changes mrproper targets for files generated from module signing.
Root .gitignore also has 5 lines to be removed. One thing to note is how the openssl command example has been changed in module-signing.rst: kernel_key.pem to signing_key.pem so mrproper cleans up automatically generated and in case of manually generated from the example.

Signed-off-by: Ian Fleming <wholehepple@gmail.com>
---
.gitignore                                   |  9 ---------
Documentation/admin-guide/module-signing.rst | 32 +++++++++++++++-----------------
2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..624604e3ec6a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -133,15 +133,6 @@ ID
 *~
 \#*#
 
-#
-# Leavings from module signing
-#
-extra_certificates
-signing_key.pem
-signing_key.priv
-signing_key.x509
-x509.genkey
-
 # Kconfig presets
 /all.config
 /alldef.config

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 7d7c7c8a545c..2ac462b6c832 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -132,23 +132,19 @@ it can be deleted or stored securely.  The public key gets built into the
 kernel so that it can be used to check the signatures as the modules are
 loaded.
 
-Under normal conditions, when ``CONFIG_MODULE_SIG_KEY`` is unchanged from its
-default, the kernel build will automatically generate a new keypair using
-openssl if one does not exist in the file::
+If ``CONFIG_MODULE_SIG_KEY`` is unchanged from its default, the kernel build will
+automatically generate a new keypair using openssl if one does not exist in the file::
 
 	certs/signing_key.pem
 
-during the building of vmlinux (the public part of the key needs to be built
-into vmlinux) using parameters in the::
+the public part of the key needs to be built into the kernel using parameters in the::
 
 	certs/x509.genkey
 
 file (which is also generated if it does not already exist).
 
-It is strongly recommended that you provide your own x509.genkey file.
-
-Most notably, in the x509.genkey file, the req_distinguished_name section
-should be altered from the default::
+It is strongly recommended that you provide your own x509.genkey file.  Most notably the
+the *req_distinguished_name* section should be altered from the default::
 
 	[ req_distinguished_name ]
 	#O = Unspecified company
@@ -160,15 +156,17 @@ The generated RSA key size can also be set with::
 	[ req ]
 	default_bits = 4096
 
+It is also possible to manually generate the private/public key files using openssl
+and the key generation configuration file::
+
+        certs/x509.genkey
 
-It is also possible to manually generate the key private/public files using the
-x509.genkey key generation configuration file in the root node of the Linux
-kernel sources tree and the openssl command.  The following is an example to
-generate the public/private key files::
+The following is an example of how to generate the X.509 keypair to be used for
+signing modules::
 
-	openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
-	   -config x509.genkey -outform PEM -out kernel_key.pem \
-	   -keyout kernel_key.pem
+	$ openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
+	     -config x509.genkey -outform PEM -out signing_key.pem \
+	     -keyout signing_key.pem
 
 The full pathname for the resulting kernel_key.pem file can then be specified
 in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
@@ -276,7 +274,7 @@ Administering/protecting the private key
 Since the private key is used to sign modules, viruses and malware could use
 the private key to sign modules and compromise the operating system.  The
 private key must be either destroyed or moved to a secure location and not kept
-in the root node of the kernel source tree.
+in the certs/ directory of the kernel source tree.
 
 If you use the same private key to sign modules for multiple kernel
 configurations, you must ensure that the module version information is
