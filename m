Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9A374960
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhEEU15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhEEU1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:26:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so1838861wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqRopQ6j7EZnfvlaFLYECgDSQLjyHwxQifGupas3xpc=;
        b=IBzjfiGOwr7Vh+9cvh0LuRB/HoU+/qiYi+BJe/wg4GgeuPXzdJoBXQ9ZdU+VM+6tsS
         m07ZhkvuSB/sYXBiGPbS9uiAz+21sog+VlBNX0pPQf3+b7U1iEVBKGM0FHPxdgwjI6oT
         HOsoj6aTaHdObd/TQELspiShcFTC6uuStMg2yjcXzdu6jnYtR4cKzssOxrXpJgoRHa8T
         dAqI2YampChMPN3sqaZ3osAL94v9YgZ1jFE7XAYySfnH+MYzxyxZ+7AOJWA/Lw23Nu9o
         nrgPMx5Kpc+OpgOd9+qN2YzGYYEphZHpXVaVW6jZaQGsoqVgscgDKJf1IedgviTysoAs
         Oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqRopQ6j7EZnfvlaFLYECgDSQLjyHwxQifGupas3xpc=;
        b=Ff3mCixieEdrC+52E+Qu5IHoi1M7wbg5o9RdBmuW8HwBH1xYLGvoMkOVv/mvgRO9ci
         F8ymASBtkAabRQT22lBp49lXylzM+Mkwq7asH6bI6fHxCVjCGSLHc5sFhmZEKJqmPSFN
         /blYSvLcXr3s3z8IVb+QnVI2App5h6hLNqHQXU23ZmzKoISiFpJfbn9yge++q1b05gnx
         w0wnDDZqRUat/QVxVf+kaWctp/bGDtmHQ4KAptkv1MHWQJv1DoSRROyc3yXJz3EqfrNV
         u0xux6j7RNyEh95tbtoG/zd5UDwRlZ3SEb01jPyNQoNIuMyAPoe8h2hteCCIsK3Cuszl
         nNTQ==
X-Gm-Message-State: AOAM532eDSuuSG7deoInPM8YAoAwLKla6WjP84KllCqtr7mFugjGoDFL
        vv+sk7S/pYRMSOGZWJ52wVXZGw==
X-Google-Smtp-Source: ABdhPJxHe5r2fcydaLYlL9LtVPJpAD710+mO6YJtzdc3PMfnyVf43O+5uE0C+fz1Z7JzTrmgPYxArg==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr534437wmc.186.1620246394181;
        Wed, 05 May 2021 13:26:34 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a15sm497245wrr.53.2021.05.05.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 13:26:33 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chohnstaedt@innominate.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 11/11] MAINTAINERS: add myself as maintainer of ixp4xx_crypto
Date:   Wed,  5 May 2021 20:26:18 +0000
Message-Id: <20210505202618.2663889-12-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
References: <20210505202618.2663889-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No maintainer exists for ixp4xx_crypto, since I have access to a board
with it, I propose to maintain it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 351617dd019e..b8b8618ecb41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9254,6 +9254,12 @@ F:	Documentation/admin-guide/media/ipu3_rcb.svg
 F:	Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst
 F:	drivers/staging/media/ipu3/
 
+INTEL IXP4XX CRYPTO SUPPORT
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/ixp4xx_crypto.c
+
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
-- 
2.26.3

