Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185323321B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCIJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCIJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:11:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D0C06174A;
        Tue,  9 Mar 2021 01:11:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p21so8346235pgl.12;
        Tue, 09 Mar 2021 01:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wB1I6Nqq7AfdRuGhioLL2RWvT/EvSUrtBmeOoGNpC4c=;
        b=e6FOS+NacLfH/xWKXxkeAAl8YYsBU2mL4UMX6ikAkgoSs8yPJVmUIHx4/QxTYE7fw0
         w1ZHyv2GTZ/sZH0ktGLEAcY9a6ElhPgegk3vcOiSJ59PQbnGcuBEFKe6ix5bDKH60vTd
         ohs2TH4haNKwYDw8GY3L6JlMx2FWPsr52kbeGiLqCmYqEL/tp+s3Bpyh9FblH9Ba6dKs
         lEcuLqrhCNP20MShXa2M3UJkt387aYsqSMbnTFOQv8I4leMji6uZ/F5vPbZ8P7XG0qf5
         nDMdjI6r3ElkvoHfOay4uOTrV+d41TqT/cdppn1HaCzE5kO+KET84M7lFqb0X0/pCkdh
         e9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wB1I6Nqq7AfdRuGhioLL2RWvT/EvSUrtBmeOoGNpC4c=;
        b=aqn6uIwCULQHA4eeUsSf0Yzbh95pNyTABmcMFNW9y1TDsZA4lo4nABTTcpDL7242ar
         i9q32839fBhhElCQ+YYFxwQdKMDk1aDJ0Jg5PXWh6l85xwruqC4g8ep9HCO6tYJqWNDg
         o/c3942p+bh0EYXWSYFPE1DWAls9kS6Ej+Bz3ZnhMLWdwX8KCrjRST+hCXEqPYzJNMSV
         XGcsiuqV/WtSVFBYS0dcY2FNf9PwO1Yp/mHSMfAP+MJ6IyBVpkUwjLKrR4m54xrtFmzH
         bbzd3PFqi41gJeYq2gxloSuJn/thK7buf3ZXmYfzdogp07vL9rSfIeLm+Pdq+sWdu+jE
         ca+Q==
X-Gm-Message-State: AOAM530MFH+ZI9WPCasY6G7wkwgiznCgQmCxav0iVhfoMurWXjDaxgnh
        j6Yt5JJHsdtML1diiAUc/Bw=
X-Google-Smtp-Source: ABdhPJy79MblW78n0Euz3R9cSKXRk+Qbo1KkS1pr1AsyVwJFY6AjUqYDYZLO4jOyJPm0b9F9vDFHYw==
X-Received: by 2002:a63:c0a:: with SMTP id b10mr24874934pgl.251.1615281092137;
        Tue, 09 Mar 2021 01:11:32 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id js16sm2094860pjb.21.2021.03.09.01.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 01:11:31 -0800 (PST)
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
Date:   Tue,  9 Mar 2021 17:10:44 +0800
Message-Id: <20210309091044.2298-5-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210309091044.2298-1-jlee@suse.com>
References: <20210309091044.2298-1-jlee@suse.com>
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
index 7d7c7c8a545c..ca3b8f19466c 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -170,6 +170,12 @@ generate the public/private key files::
 	   -config x509.genkey -outform PEM -out kernel_key.pem \
 	   -keyout kernel_key.pem
 
+When ``CONFIG_CHECK_CODESIGN_EKU`` option is enabled, the following openssl
+command option should be added where for generating CodeSign extended key usage
+in X.509::
+
+        -addext "extendedKeyUsage=codeSigning"
+
 The full pathname for the resulting kernel_key.pem file can then be specified
 in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
 be used instead of an autogenerated keypair.
-- 
2.16.4

