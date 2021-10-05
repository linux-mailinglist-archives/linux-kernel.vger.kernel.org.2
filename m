Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3C422DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhJEQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhJEQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:20:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231A0C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:18:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m22so32914733wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrrCwF+kFDwdSmZPhicXDostoj2EDmJYm/81LXTAGoo=;
        b=YftOWF02yixWsn3Yl1W6mpcPerRe4dd8jeS9FCkxUkNWPrbhB/euRl6FScWNY/dGev
         o1JJ719GC73YAY0DqKgriMkB7oCVW04HMvef2cw3s+ypCFusqgY7AWtb+vfLdoZBXxqK
         qep+P/7D8LbXifiLFatuclXXsj0GDtk/Qa4f7imwP+sHDHhsNiw83v/enwZiWskToBgQ
         tbNxfkpILuapgxwU50MiqwddyJBjfdvY577c6oMmKtdEl6Dr3Vh1lQMqwdm5AOJmDlh7
         NPZLIQTYs+VdcEjUAENpR++AfgCGl5wL5TNIUlIBCH94TtQJAYV+G3FfuL7KTdCziWkG
         Pr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrrCwF+kFDwdSmZPhicXDostoj2EDmJYm/81LXTAGoo=;
        b=p09Ss3FMHn58frRhkTwEG43Qv9TiQ95GPIfSLIB9M8tvDQ6OE6lg9+3+67Rv6chVuC
         GQ8QMZv4o4OAu8dI6J+y1bZeiH7sYNBlatQlDBSt242/emXr7qrFvSEVT5tMr7mG+ZRp
         aM1Sq910TEuqPX4fQddlNwLtgcUcjsbdTrw1/YhcKfuD/ZR7Yj7zwNu/lAGvYZUrQEP4
         S8/xOnXmlYFdtOaSDqhyNrRTUSHbYGauaa+86KbdaSgjJ14WTJa64QA6voadK6gXsc0A
         RVZCUA6zE5JagqapjYSIscs5kJPNx6jb3aiHIPojB8/RYoWY7m9Y9eXtTCDSW5dRl4la
         s9iA==
X-Gm-Message-State: AOAM5321YV2eS5AQ12sUaXfWm1gdQITs+spEFGpbDohh4BAPomQzRv9t
        S9+vLXQ5wsuGuZgVArPiiayGKQ==
X-Google-Smtp-Source: ABdhPJxA8BzIyDtOmWl4mpjPd6cuGv3bvxOhIM2mTMdx+M2wrXsEa/gha5ZRsdZ/5E8C6F4x9bfw9A==
X-Received: by 2002:adf:f789:: with SMTP id q9mr22714087wrp.367.1633450718739;
        Tue, 05 Oct 2021 09:18:38 -0700 (PDT)
Received: from localhost.localdomain ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id x17sm18188856wrc.51.2021.10.05.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:18:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>
Subject: [PATCH 1/1] sign-file: Use OpenSSL provided define to compile out deprecated APIs
Date:   Tue,  5 Oct 2021 17:18:33 +0100
Message-Id: <20211005161833.1522737-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OpenSSL's ENGINE API is deprecated in OpenSSL v3.0.

Use OPENSSL_NO_ENGINE to disallow its use and fall back on the BIO API.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: keyrings@vger.kernel.org
Co-developed-by: Adam Langley <agl@google.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 scripts/sign-file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index fbd34b8e8f578..fa3fa59db6669 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -135,7 +135,9 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
 static EVP_PKEY *read_private_key(const char *private_key_name)
 {
 	EVP_PKEY *private_key;
+	BIO *b;
 
+#ifndef OPENSSL_NO_ENGINE
 	if (!strncmp(private_key_name, "pkcs11:", 7)) {
 		ENGINE *e;
 
@@ -153,17 +155,16 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 		private_key = ENGINE_load_private_key(e, private_key_name,
 						      NULL, NULL);
 		ERR(!private_key, "%s", private_key_name);
-	} else {
-		BIO *b;
-
-		b = BIO_new_file(private_key_name, "rb");
-		ERR(!b, "%s", private_key_name);
-		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
-						      NULL);
-		ERR(!private_key, "%s", private_key_name);
-		BIO_free(b);
+		return private_key;
 	}
+#endif
 
+	b = BIO_new_file(private_key_name, "rb");
+	ERR(!b, "%s", private_key_name);
+	private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
+					      NULL);
+	ERR(!private_key, "%s", private_key_name);
+	BIO_free(b);
 	return private_key;
 }
 
-- 
2.33.0.800.g4c38ced690-goog

