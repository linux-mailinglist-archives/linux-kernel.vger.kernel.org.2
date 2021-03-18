Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0383A3405ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhCRMpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhCRMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3262462wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMTahAsaElMxqi8eZGk2JR1LgFKDb6Ye/mNpDFgFc8o=;
        b=dvpUi70deEjAO/2KnUGPQa0XxK3Y2FGyWvK8WilSPi5yM7x/GlW/mmywfd0OuvFXsO
         w6lhV+d8yzST2Zg9qCt55bDyrDOBVmv6AHYEOr8K5hdCWTHz8iJG7+mxg/p5ffvqiVfP
         x6Pm3TTB+MVoJLj/cI6sNyfjnzaBEWo3tSmdpO7rTketyLx1nolyDmibGPoJTmGHI6kG
         7gvqDNcNKuCMvX9QvMZp972j+gpvWSjK8TEy5GaCdJk1S8Xi9rjFo1EqB8vQy10zPGtS
         UfgSE/gkIOUPiYE1Hi+pbdsENjj5b8vMpXZTGfTIw78mDjnOsXKTVMVp0eB7UbzJxJLM
         ABeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMTahAsaElMxqi8eZGk2JR1LgFKDb6Ye/mNpDFgFc8o=;
        b=hILPMa6/YyhG0hU71X10psxU03j2BV2esCpUh40xTU/XmSjFLghZQmKoSe/kJHGJL9
         4dDpDJDdDzG2ep24ZckP2PsgpL+lgUfpKuAdhi3DIJmUp1GObULz43Y362tPIQ5kDLn4
         /L3G2rmUvc38hZkulpLIlTkduV4ZTO6hRLKdw7DvxSweRonL/1cj56gnox+2j0NaAjqO
         kof16mB4RbQ8qjI889ZMGDksshRnTz4U1W+jAV9cEMnURirg+3G/lrWwNTNQFiEGyYyf
         GBM+Gp/Cre9dhBC6FGfX0DIRbryavsVBeCcfU0t/YSGw/hwcdpKEtvl3dZddM2jF9i1n
         UOug==
X-Gm-Message-State: AOAM532pAwX0P08EwP7Rq4nNWOH8u//auTqhQF3AfXOlpdUCERIeAtKE
        a+RtW1qmbXr7IDSFhvG3I+gb3Q==
X-Google-Smtp-Source: ABdhPJzQx6Slpl2jsjhrwVq5uOSUJdpe2/Tb4K7eDbq/y5pEeET6/wucfCz6Y0rTCocip+3mo9Z6mg==
X-Received: by 2002:a1c:bc56:: with SMTP id m83mr3548402wmf.174.1616071477165;
        Thu, 18 Mar 2021 05:44:37 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id q15sm2813900wrx.56.2021.03.18.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 07/10] crypto: caam: caampkc: Provide the name of the function and provide missing descriptions
Date:   Thu, 18 Mar 2021 12:44:19 +0000
Message-Id: <20210318124422.3200180-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318124422.3200180-1-lee.jones@linaro.org>
References: <20210318124422.3200180-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/caam/caampkc.c:199: warning: expecting prototype for from a given scatterlist(). Prototype was for caam_rsa_count_leading_zeros() instead
 drivers/crypto/caam/caamalg_qi2.c:87: warning: Function parameter or member 'xts_key_fallback' not described in 'caam_ctx'
 drivers/crypto/caam/caamalg_qi2.c:87: warning: Function parameter or member 'fallback' not described in 'caam_ctx'

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 3 +++
 drivers/crypto/caam/caampkc.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index a780e627838ae..8b8ed77d8715d 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -71,6 +71,9 @@ struct caam_skcipher_alg {
  * @adata: authentication algorithm details
  * @cdata: encryption algorithm details
  * @authsize: authentication tag (a.k.a. ICV / MAC) size
+ * @xts_key_fallback: true if fallback tfm needs to be used due
+ *		      to unsupported xts key lengths
+ * @fallback: xts fallback tfm
  */
 struct caam_ctx {
 	struct caam_flc flc[NUM_OP];
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index dd5f101e43f83..e313233ec6de7 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -187,7 +187,8 @@ static void rsa_priv_f_done(struct device *dev, u32 *desc, u32 err,
 }
 
 /**
- * Count leading zeros, need it to strip, from a given scatterlist
+ * caam_rsa_count_leading_zeros - Count leading zeros, need it to strip,
+ *                                from a given scatterlist
  *
  * @sgl   : scatterlist to count zeros from
  * @nbytes: number of zeros, in bytes, to strip
-- 
2.27.0

