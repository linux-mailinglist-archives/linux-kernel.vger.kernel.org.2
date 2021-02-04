Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA97B30F1D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhBDLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhBDLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3204CC061224
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so2640717wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxGJzZpz6qA+xiFT2fhj08K+AKiamZQBAjKu1cuB41g=;
        b=jyzJD24RWHuFc5gDwgp323TJgiD6YaBqxMG6JkMwvjTxcEH7LlCcpHG82W+8onqbfD
         IAfOefk8CiqkWG36lQ28CVBCphq/KgkKuepfBF0mbuniWh5ZtkKIbyo+prC9vXxRF2eb
         fFtE0vGQ/sNuTSjxnXD8iI5P6qI7On5v1kbxDeS2yUQ1G5T5G1rrl2SI694sSjiuhbrz
         LgxPl/W8gdORHLo+1GHLho7+XoF9aRSOax5OeXK9lyNMoP37DsfhkerUXNewLL8qtm4z
         i7JGhPPFCuPiavkerDwp4Cs1LhpGQzAQVKjx2gOF7SDXB5Ph0TtQA136NQ6vnyj2KD0D
         Ll4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxGJzZpz6qA+xiFT2fhj08K+AKiamZQBAjKu1cuB41g=;
        b=cUIwLmAIagSM2ur1woRoqTLixcDXHLsKshG/P1NMd0K2cnPDYeNeaoHhO+WI2G6M7H
         /qD+zCAPqwW3qX2fQCh2tiM09vIfBfCWB8Wa6s2rqSUC/S7IleWdKpIFzPUcUFItEqK2
         M0iZ8wW/Eeh3eQj2ghMy+VPGENVwiNkH+JURMwx18CRKcLHTDkCTzQcXJelzI0JEEgup
         qAmELQmUinFjoAuvLeh2yBAVyWhsm/JookpukdiVW77yQnu2r/dNsd5sHhXgCs5wnlpG
         M8x6NlTNoHZtZajPeWfUJSFrpUrziq7wEPKdErh5ml5K55Euwi3hNvjugkV8gusWNrfh
         MqKw==
X-Gm-Message-State: AOAM5305NsQd3LVuMh3awdaHpkys9AKUaQ53lvV1bWALUW7ppZW4gfNK
        HlGrm9BhKhXgE7IqelXMgIZpwKEIOQgTFA==
X-Google-Smtp-Source: ABdhPJwd9xdvyO+0bCKJVzM+EKxnNtd4uas/Onrew1JvEjI4x3rojBBg47BW4DbMHR4XwYf9F06qlg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr3911278wmb.116.1612437020990;
        Thu, 04 Feb 2021 03:10:20 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 15/20] crypto: caam: caamalg_qi2: Supply a couple of 'fallback' related descriptions
Date:   Thu,  4 Feb 2021 11:09:55 +0000
Message-Id: <20210204111000.2800436-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/caam/caamalg_qi2.c:87: warning: Function parameter or member 'xts_key_fallback' not described in 'caam_ctx'
 drivers/crypto/caam/caamalg_qi2.c:87: warning: Function parameter or member 'fallback' not described in 'caam_ctx'

Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index a780e627838ae..22e45c5bf2023 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -71,6 +71,8 @@ struct caam_skcipher_alg {
  * @adata: authentication algorithm details
  * @cdata: encryption algorithm details
  * @authsize: authentication tag (a.k.a. ICV / MAC) size
+ * @xts_key_fallback: whether to set the fallback key
+ * @fallback: the fallback key
  */
 struct caam_ctx {
 	struct caam_flc flc[NUM_OP];
-- 
2.25.1

