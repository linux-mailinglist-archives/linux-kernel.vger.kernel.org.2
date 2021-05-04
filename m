Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3841B372AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhEDNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhEDNN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:13:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C591C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 06:13:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y7so13060096ejj.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 06:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXRitWWRRFW0ojzwHJ4zpfVrafyqDHpLGDB/FMLEkjA=;
        b=uR0rWgEn3vx0xKzg6fFNSUPJ0iGTGOgJl/mJVjwfvk60++XDgNCqyk2E9AZxzMwo5Q
         HBBrWYoU6dYFcGAa9PIDkdld3NPhj8oBfUYEC0JvohnJPC6mORDtvXY40W0TU+r531oG
         vGb8lgxmqy5PXle8hbYzEc8SnjzNCLX6aHqYZbSMQzorFsfj8KAcXYlGhxYd+NOrIPOc
         hN/E60UlayDR+7684/DO2F/oEftIPDgnWggJQHTN4D/aFnhN8qScFrntYIhA7HXnXvHA
         tY+uMNYu00iO2o8pAMoSfvqrICj9f5ZV6OF8Y2Q5zgVO2hTdT0D+fo+O31Hp/m2pAFCh
         yg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXRitWWRRFW0ojzwHJ4zpfVrafyqDHpLGDB/FMLEkjA=;
        b=YaDpTkNkPAkiZq6LSIHfYy699zi2SRBfIRdXQclqkoQSDT1j/2ZhurkG2hmqWzM3qk
         a04ftoSf5vuXrUcGj3WtUewcXgPvtFq6RQ2v7TlFNpmgsAfGzgH/SLHYDSAp+VNZ8796
         +64/3gytsL54LTB6gbYBP6t1efbBgBz6wgO5KmHjZ9F/e5eLnQTIm/a7aSvxbubL1N2G
         cFmFzOU7VLDCxCtVm7Jg4ccauRKAMgpPiL9ftim8QGRlAIlR9b6Jdv4DMyt4w0uumZrz
         pvot9SIkGBrQGCZ7QbhYHfU2tXBPJa5oLmyA3/h7IM2DwMx2OYi3HexFlayeSHYhJzFv
         AvpA==
X-Gm-Message-State: AOAM532qs1z0XZt740+WMZgNqDj6aDpNr4NNrPodc+IjR57++dV3dQSC
        JxM8KozYkAv5e2An9qdFJjkdf+N5i8nggg==
X-Google-Smtp-Source: ABdhPJxkA8SUpPHLjcdS/lCMfwtVNold+sp1LgodeWf+E1FxlTBZSP/JzRRB7mN/pSK9NodJ2PuMCQ==
X-Received: by 2002:a17:906:9a02:: with SMTP id ai2mr22336260ejc.279.1620133980948;
        Tue, 04 May 2021 06:13:00 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id ga28sm1237444ejc.20.2021.05.04.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 06:13:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: align argument position in a new line
Date:   Tue,  4 May 2021 15:12:55 +0200
Message-Id: <f195bc7d72c122e5e16b3857cf99ae1f84734915.1620133620.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620133620.git.fabioaiuto83@gmail.com>
References: <cover.1620133620.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

align function arguments position on a new line to
open parentheses.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index e4f3049ac351..0cb603aa4ee6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -2056,7 +2056,7 @@ static void aes_encrypt_deinit(void *ctx)
  * (SP) 800-38B.
  */
 static int omac1_aes_128_vector(u8 *key, size_t num_elem,
-							 u8 *addr[], size_t *len, u8 *mac)
+				u8 *addr[], size_t *len, u8 *mac)
 {
 	void *ctx;
 	u8 cbc[AES_BLOCK_SIZE], pad[AES_BLOCK_SIZE];
-- 
2.20.1

