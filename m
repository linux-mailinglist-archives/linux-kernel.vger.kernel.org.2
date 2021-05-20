Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4A38B69E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbhETTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbhETTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C97C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so5829522wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjcCUXPequaERL0iWKMvvnJNHWoIV+jPVNxaSD9GFTU=;
        b=j+O1Mtk9M4NGgVt+3NsfiQd7A1ZWIT1Kke3k9FKKFxQ+RvhWemwcuBOP5fYr9xUV6d
         zVKuYUb6BJI/c93srLW6aahf54kj1sLFTE9oG7KgsxWQnQ+rolnTuGUQ6eMwmdLYrfX1
         2HPgW3G3oRZUBe6AaKUsDwWch8gN3LBplctpv2Y9sGorHbhT3xxAXngG8jjkGwyt+6oz
         NTic7vEgZmDoMCC8dk0xJL17T/AcTA5vcHBBV/RZ8Jg191WCm5XGS/Zftm3ZiA8UOJIs
         iMHynJolI0QrcQGJBnNx4wEXycSwRzPvMC8+fMUG03wUoQaz8CsiguONaYCUZfmDUdos
         qBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjcCUXPequaERL0iWKMvvnJNHWoIV+jPVNxaSD9GFTU=;
        b=hHnCIicM87sD5y1fxMhCJvaju4STq4rZmPWypZeA1hTNNrPs7+60iVjQACXpfBm3Bp
         F4zKCFOwFS+hVviEPhzPQDCHODD0Mv2dj2dYvj5hIzDkRVa7I5W+2BxfAkEIW5+50vEA
         d18GvYgI9P4hYLrynyFT4aQp2za4ZCEBKMbBvT2Ym92pygKefNrZzJFlvrZbRpw9wMaX
         R3hy4O7G6vw7/ItD1BFZyDHk6R/2nXsLZN5jVtia9XGUSvuzppSBkoSCjrnsrkIFaMBZ
         gasJYbVwbMsa+x5+CfAvAMChU7H1Ws5JJkehDLsJgpRvErWYn1Eba6Qqy18lVVDmndtR
         KUpw==
X-Gm-Message-State: AOAM5306yFylPp0xqzRTCO8mZvQQ4I/Eumw4HYQU/WeJWhBf7E/lrxxb
        HD3Qb/owqCAO1Ojzd6zgJke9zA==
X-Google-Smtp-Source: ABdhPJw3QdxXdYb3YGeZ5nDe9KaL5FXMJWT8YGtBx3+uAxOifUAnuBCO5ExKWVHYpmm8HLWWMKfmvA==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr5513989wma.42.1621537285341;
        Thu, 20 May 2021 12:01:25 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cedric Madianga <cedric.madianga@gmail.com>,
        linux-i2c@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/16] i2c: busses: i2c-stm32f4: Remove incorrectly placed ' ' from function name
Date:   Thu, 20 May 2021 20:01:03 +0100
Message-Id: <20210520190105.3772683-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-stm32f4.c:321: warning: expecting prototype for stm32f4_i2c_write_ byte()(). Prototype was for stm32f4_i2c_write_byte() instead

Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cedric Madianga <cedric.madianga@gmail.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-stm32f4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index 4933fc8ce3fd1..eebce7ecef25b 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -313,7 +313,7 @@ static int stm32f4_i2c_wait_free_bus(struct stm32f4_i2c_dev *i2c_dev)
 }
 
 /**
- * stm32f4_i2c_write_ byte() - Write a byte in the data register
+ * stm32f4_i2c_write_byte() - Write a byte in the data register
  * @i2c_dev: Controller's private data
  * @byte: Data to write in the register
  */
-- 
2.31.1

