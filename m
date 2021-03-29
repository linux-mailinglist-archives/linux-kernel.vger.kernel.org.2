Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA334C2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhC2FQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhC2FQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:30 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0ACC061574;
        Sun, 28 Mar 2021 22:16:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v70so11385427qkb.8;
        Sun, 28 Mar 2021 22:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5EV04eIiwEZ5nQKZ5z824e2ndM34fbaupYp7au9GOk=;
        b=JYjp9pgpwG6VnW6Coy7RK8cJ2xKSV9P0BP5zrAZDLSs18NPVCXMkTApunGkgx/vl8u
         EkvSHAy9QQkF/SxXrWS7cAnXzgeczSUEy4L6kKGwPs/Layd8ji44iWdOTtds2LpmkpDj
         a6U5miR9WzxBG2OLOTulR2bnCrGj4U5juxjQEGWJpNrIDJguvOEDt0Pe86tjLRPIwPLu
         wAGWYlqrWKIryTUlC+lZ7F++MpsJCFQdvlwZIjXdyfCB59n1SXFfKCcBRXUgU8r27wi0
         RfGwyAYzLnPYKl1w4YODOycAGYo9GxCsm1m6YouJIzZM/iB7ZRrn+ySKz2wB0uj+y7CI
         lVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5EV04eIiwEZ5nQKZ5z824e2ndM34fbaupYp7au9GOk=;
        b=gHJUjdFari1+pih++OFy4xD48hZql3RMm9ihdRvf3m9xyOS9AABJWlOCerZnfxAVu5
         bUTA18odrGcrQ17vrlu34o0OvwMImjAYsFkN8kUZkPQkjd0XgP/hiCV49vG9AYwP9DTR
         avtBUY5W9lmunnQ35BKCvKyHapS+HdVEQx3K9JZXkwoVKc81wA49T2aBWEYqVJVIetBR
         fjnjWGld2uuPTxKP6fcRTkCxGpaVr94qqdq+eCooKD8thGp3dKrRy3AI5iRneJE+dNIc
         Y7lVF+QIlfP2poD3I4L7UC3W3ISa/fBH/eik7TWRgQCda1c9kkF4EAvf1tC6azZ3tQbY
         sfyQ==
X-Gm-Message-State: AOAM5321i3IIuf5Ok1W2LfQNOax8KA/GZpZ8w2G2LAodxu2dvHmv52m6
        a+UwZ9ZqtHRmfnfYsxzpluo=
X-Google-Smtp-Source: ABdhPJz5OXalOkpdOsabrX9UVuVu2Vh/A01U8MYW34nnq0NtcNGXiUKr2tEbXqEji83Tu31UMm59/Q==
X-Received: by 2002:a37:a211:: with SMTP id l17mr24190468qke.195.1616994987898;
        Sun, 28 Mar 2021 22:16:27 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:27 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/23] security: core.rst: Fixed a spello
Date:   Mon, 29 Mar 2021 10:42:54 +0530
Message-Id: <cb6d3318559c7be6b56f7cf426bb69e7e085adf5.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/implemenation/implementation/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/security/keys/core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index b3ed5c581034..d66ad592c6cc 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -869,7 +869,7 @@ The keyctl syscall functions are:

 	 - ``char *hashname`` specifies the NUL terminated string identifying
 	   the hash used from the kernel crypto API and applied for the KDF
-	   operation. The KDF implemenation complies with SP800-56A as well
+	   operation. The KDF implementation complies with SP800-56A as well
 	   as with SP800-108 (the counter KDF).

 	 - ``char *otherinfo`` specifies the OtherInfo data as documented in
--
2.26.3

