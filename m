Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF130F1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhBDLLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhBDLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB928C061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u14so3030687wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UuJJvnBY1RT5AmJ5CEhkK6udrJuyZm280OjEkcYs/fQ=;
        b=HCGu7dsDqG4pkWy8ockT5UO+pq22sAnePsOuQg+uVYtRaK/OQphQlcxTjFJIKCHuir
         SpaoujMIk8FfAnv860dMGKAMiz0SMmR2yvVwDsC2bDsUxkESYR3eHXOdw5nZ0imM/tqA
         7CRrZkRe0JtqTUdogu7T5Rv0Xq1l+VGdsQ/oc4EuB+y3/wUbyZtxGwDrBRj8R6hzcWs2
         BAa0cQt4IQpXG4rs7bdLaZqfVrp2l5TdHxqHkDRd7enoxlJgCDUh+PKWyAdZs186elSe
         yPaRNmsEb4r9Ihw3d6B9HW3+COwQVnGBWPb3eA+bXfKhYyLhDXGCWnTuhjxNnY8JUmlE
         w5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UuJJvnBY1RT5AmJ5CEhkK6udrJuyZm280OjEkcYs/fQ=;
        b=RS0YEUJk1N7aFt9rkxHBKBPqI1PtuxmVUFIlxBi/TIs+FhYH6I7bVund5qB/sF1FJO
         Lv4aijhjTv3r21ciLamFN5ULSlUSlnjJFP1ZvnDw/BOhpZjG+3EyYM0aHxpHfI0WHA2L
         UQvkmaPFxKHTzyeWsy65IyN106U7F1p80RwzMJS95ATu6FG+fAXGyeTi+1pC2GT95NZp
         o7izQ0pajNkO6IhsRvTPLgKwkwC9EpveM9Ff3SK/MeUQ3cyx/Dh5Gfjq0hy1kDK+fT8v
         dEKj7z5GsY/sDEzt4bciD3qGEvNIgpdEs3uGNTTRt1xIwqaYQG2IW3Fk8LUUm228IeG5
         nHxg==
X-Gm-Message-State: AOAM5313KmLpbxWA7+dHj2/Q6GFbLFKjUeRHpD0UA7Hhh8STz96uAIqF
        qnQU79XcI9UbvO4lAcWjDZXx5Q==
X-Google-Smtp-Source: ABdhPJySJSWFjuE4JIiwrvf+jyaIlEDIGGf7ANwv7vOVJ9x5/EdqbI4lkAi16yQIPc4Drn88FhZFhQ==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr8537957wrx.81.1612437008481;
        Thu, 04 Feb 2021 03:10:08 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shujuan Chen <shujuan.chen@stericsson.com>,
        Joakim Bech <joakim.xx.bech@stericsson.com>,
        Berne Hebark <berne.herbark@stericsson.com>,
        Niklas Hernaeus <niklas.hernaeus@stericsson.com>,
        Andreas Westin <andreas.westin@stericsson.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 04/20] crypto: ux500: hash: hash_core: Fix worthy kernel-doc headers and remove others
Date:   Thu,  4 Feb 2021 11:09:44 +0000
Message-Id: <20210204111000.2800436-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ones remove here not only fail to conform to kernel-doc, but also
provide no value, so let's remove them completely in this case.

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/ux500/hash/hash_core.c:368: warning: Function parameter or member 'ctx' not described in 'hash_get_device_data'
 drivers/crypto/ux500/hash/hash_core.c:368: warning: Excess function parameter 'hash_ctx' description in 'hash_get_device_data'
 drivers/crypto/ux500/hash/hash_core.c:551: warning: expecting prototype for hash_init(). Prototype was for ux500_hash_init() instead
 drivers/crypto/ux500/hash/hash_core.c:592: warning: Function parameter or member 'length' not described in 'hash_processblock'
 drivers/crypto/ux500/hash/hash_core.c:1302: warning: expecting prototype for hash_update(). Prototype was for ahash_update() instead
 drivers/crypto/ux500/hash/hash_core.c:1322: warning: expecting prototype for hash_final(). Prototype was for ahash_final() instead
 drivers/crypto/ux500/hash/hash_core.c:1622: warning: Function parameter or member 'device_data' not described in 'ahash_algs_register_all'
 drivers/crypto/ux500/hash/hash_core.c:1622: warning: expecting prototype for hash_algs_register_all(). Prototype was for ahash_algs_register_all() instead
 drivers/crypto/ux500/hash/hash_core.c:1647: warning: Function parameter or member 'device_data' not described in 'ahash_algs_unregister_all'
 drivers/crypto/ux500/hash/hash_core.c:1647: warning: expecting prototype for hash_algs_unregister_all(). Prototype was for ahash_algs_unregister_all() instead

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Shujuan Chen <shujuan.chen@stericsson.com>
Cc: Joakim Bech <joakim.xx.bech@stericsson.com>
Cc: Berne Hebark <berne.herbark@stericsson.com>
Cc: Niklas Hernaeus <niklas.hernaeus@stericsson.com>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/hash/hash_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index da284b0ea1b26..bcaf6ba3e9235 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -356,7 +356,7 @@ static int hash_enable_power(struct hash_device_data *device_data,
 
 /**
  * hash_get_device_data - Checks for an available hash device and return it.
- * @hash_ctx:		Structure for the hash context.
+ * @ctx:		Structure for the hash context.
  * @device_data:	Structure for the hash device.
  *
  * This function check for an available hash device and return it to
@@ -542,7 +542,7 @@ static bool hash_dma_valid_data(struct scatterlist *sg, int datasize)
 }
 
 /**
- * hash_init - Common hash init function for SHA1/SHA2 (SHA256).
+ * ux500_hash_init - Common hash init function for SHA1/SHA2 (SHA256).
  * @req: The hash request for the job.
  *
  * Initialize structures.
@@ -585,6 +585,7 @@ static int ux500_hash_init(struct ahash_request *req)
  * @device_data:	Structure for the hash device.
  * @message:		Block (512 bits) of message to be written to
  *			the HASH hardware.
+ * @length:		Message length
  *
  */
 static void hash_processblock(struct hash_device_data *device_data,
@@ -1295,7 +1296,7 @@ void hash_get_digest(struct hash_device_data *device_data,
 }
 
 /**
- * hash_update - The hash update function for SHA1/SHA2 (SHA256).
+ * ahash_update - The hash update function for SHA1/SHA2 (SHA256).
  * @req: The hash request for the job.
  */
 static int ahash_update(struct ahash_request *req)
@@ -1315,7 +1316,7 @@ static int ahash_update(struct ahash_request *req)
 }
 
 /**
- * hash_final - The hash final function for SHA1/SHA2 (SHA256).
+ * ahash_final - The hash final function for SHA1/SHA2 (SHA256).
  * @req:	The hash request for the job.
  */
 static int ahash_final(struct ahash_request *req)
@@ -1615,9 +1616,6 @@ static struct hash_algo_template hash_algs[] = {
 	}
 };
 
-/**
- * hash_algs_register_all -
- */
 static int ahash_algs_register_all(struct hash_device_data *device_data)
 {
 	int ret;
@@ -1640,9 +1638,6 @@ static int ahash_algs_register_all(struct hash_device_data *device_data)
 	return ret;
 }
 
-/**
- * hash_algs_unregister_all -
- */
 static void ahash_algs_unregister_all(struct hash_device_data *device_data)
 {
 	int i;
-- 
2.25.1

