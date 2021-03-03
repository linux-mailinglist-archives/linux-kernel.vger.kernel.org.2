Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6D32BEE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386108AbhCCRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhCCOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:37:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2DCC061226
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:35:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w11so23901615wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZrsJeCHjZzLqDs78jg58TD58YS3CDAKgLNjuHszhbU=;
        b=fsK4tgYSmAtd236Nx4kix67WOEAP8Vq1qYBvdI4sTw930KBO3MiQI2ZR+ZTYrg+mU8
         dqt/ute+MemtwlFyuFQVWKSaBE6FjUvnphQhfN/3dK1UzoWjkXahHEMDbY4hSDh1GtV5
         tOl+B9q6QxeYaIs9DHZiN2Qt3TXmRAnhx1eHx9Q+8GKbEGkNipFHDsbnhtUiae8nwMIr
         J9f+PFqquA4pjI/2wN9MtoOvNZrQUPUQBJRxvKqnX3BTLf5sQNcFHmglHEdK9bMyAOEk
         xFxeoKk/xAlRgU9d7E8Ebd+OwV5os2DR1yalbq0EF4LGnC6LQ7Az/Uaol1uzJs+Tguj8
         VmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZrsJeCHjZzLqDs78jg58TD58YS3CDAKgLNjuHszhbU=;
        b=AFjqtPzenH54SdLGJctVYoXHkNCxezl8RcmDE9Cal7u87XFzVK7oBs/Fjv2RVaGfPu
         2N1FzgRnhK5qnCte0qcF3epKFX5X+soONWG6F4HyPM/QIJe5SFW+LOSE1ikaI3453+q9
         lnP5QEQdIzQSrPe1NnGrSo2D5KkcFSnP7ogXiVdjB+crEqUK18Lg33uCJTOo+nXi8Uix
         EH6yaCBlO0SAqJ7xBvlrH7wj4zJjKRhAGOfJI2N8l29hDAVLJO3dcVpSdi6NA48u9cpP
         GcdFczLw19gcSE8oVETfPTaaOywVOAWKVGT28WGKYNwvAFk1G/0RBEuvvk+AhUFYmDhW
         /nGw==
X-Gm-Message-State: AOAM533E4QB2RIKOM+w+tWfIhb6+QU+c+JjvX3Uayo5ED/+l4jsVVnUw
        tXIiaV6cA50nWuf2ngCXTfh42A==
X-Google-Smtp-Source: ABdhPJwez2D078AUg52DRyoL9Z4FSzWaAcFlY+EilZQ4R/0d3XV7eiwmgAmaClxmAuOh1aJQF9VHHA==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr26709243wro.79.1614782098770;
        Wed, 03 Mar 2021 06:34:58 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f16sm31475923wrt.21.2021.03.03.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:34:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Manoj Malviya <manojmalviya@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Jitendra Lulla <jlulla@chelsio.com>,
        M R Gowda <yeshaswi@chelsio.com>,
        Harsh Jain <harsh@chelsio.com>, linux-crypto@vger.kernel.org
Subject: [PATCH 03/10] crypto: chelsio: chcr_core: Fix some kernel-doc issues
Date:   Wed,  3 Mar 2021 14:34:42 +0000
Message-Id: <20210303143449.3170813-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303143449.3170813-1-lee.jones@linaro.org>
References: <20210303143449.3170813-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/chelsio/chcr_core.c:2: warning: wrong kernel-doc identifier on line:
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Function parameter or member 'wrparam' not described in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'req' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'ctx' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'qid' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:806: warning: Excess function parameter 'op_type' description in 'create_cipher_wr'
 drivers/crypto/chelsio/chcr_algo.c:1566: warning: Function parameter or member 'req' not described in 'create_hash_wr'
 drivers/crypto/chelsio/chcr_algo.c:1566: warning: Function parameter or member 'param' not described in 'create_hash_wr'

Cc: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Cc: Rohit Maheshwari <rohitm@chelsio.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Manoj Malviya <manojmalviya@chelsio.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>
Cc: Jitendra Lulla <jlulla@chelsio.com>
Cc: M R Gowda <yeshaswi@chelsio.com>
Cc: Harsh Jain <harsh@chelsio.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/chelsio/chcr_algo.c | 8 +++-----
 drivers/crypto/chelsio/chcr_core.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index f5a336634daa6..f77d3fd962bf8 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -797,10 +797,7 @@ static inline void create_wreq(struct chcr_context *ctx,
 
 /**
  *	create_cipher_wr - form the WR for cipher operations
- *	@req: cipher req.
- *	@ctx: crypto driver context of the request.
- *	@qid: ingress qid where response of this WR should be received.
- *	@op_type:	encryption or decryption
+ *	@wrparam: Container for create_cipher_wr()'s parameters
  */
 static struct sk_buff *create_cipher_wr(struct cipher_wr_param *wrparam)
 {
@@ -1559,7 +1556,8 @@ static inline void chcr_free_shash(struct crypto_shash *base_hash)
 
 /**
  *	create_hash_wr - Create hash work request
- *	@req - Cipher req base
+ *	@req: Cipher req base
+ *	@param: Container for create_hash_wr()'s parameters
  */
 static struct sk_buff *create_hash_wr(struct ahash_request *req,
 				      struct hash_wr_param *param)
diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index f91f9d762a45e..f03ef4a23f96d 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -1,4 +1,4 @@
-/**
+/*
  * This file is part of the Chelsio T4/T5/T6 Ethernet driver for Linux.
  *
  * Copyright (C) 2011-2016 Chelsio Communications.  All rights reserved.
-- 
2.27.0

