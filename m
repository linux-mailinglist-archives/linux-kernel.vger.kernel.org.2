Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD433AFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhCOKQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhCOKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:16:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:16:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l11so8368876wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qEcvd79epFvjAlVRoO+1lYJ1AOd3z/2fMLyzMbtlsW0=;
        b=WiR3wWlmCPIN1yifpERq1yzS5j8cZfvVufWe6O6iasibSjtFu8IBSYSw9kqkkEkkxT
         CZgfdihOpxX5+p+LrH03RXH8slyo/CYLJBxQDIetKcX9DppSepBYgWYNJ60Fo+JjloGB
         B0n67MRmFbhNaGRArGzB8JWQ28lS8JYMPZJumxHBOJJ8btV/WDT53E1Rdb76m/HEtGJ8
         GKFxhBPsG3iC7MUBKEnXV/98Mn4KcFMBIPcjjqVG1JirGZJtSht5lYIQrZWNq5tZzI/E
         B1GP6/u0THhZwN6FSL42CkuZCnm2CKxtSnXjbpnmTIu4JuoUjdobQjEButKabb4H5U1X
         Kv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qEcvd79epFvjAlVRoO+1lYJ1AOd3z/2fMLyzMbtlsW0=;
        b=DmCnTMZF1YvQ4JXvuoXT61J6MzcyRSoUzRpWoPVLSA5wBrX3ZJLUYO9vPAASYSaC2/
         3eNk2xTlOIhFdWM0dEDpEIUmyNAk8JxDDfriDBM6g4N1sjA8dpWrQ8ywIZjOstJUC5J9
         zEI9aG23agNaextwe46kqbUwJCJoDmqu8S1j6WqpyJ/mIBHISB24b8V+AdH6SzP8ui+i
         AsR5fDOlesEtyQGComvSzGhgFWYhi0XiMkVPZ7Gns4I5fjiE/wyRox80jikYuVw8VjJ9
         N8oIVLB3Xn4gtOC6OhOc4iib22grNNuSem8FrrvYNrpecQdtiZcby28vIMiEl3tC9jQy
         71cg==
X-Gm-Message-State: AOAM530TvTs+CzvImegRSdJbxd4/kPRkL6vruT65f748A4j1O4q9Igc+
        V6IuXnw022miFAmgfeDJaCI=
X-Google-Smtp-Source: ABdhPJxBRWGOkhDzJBNtIPxZ4G8Z3SOfLXdFXysQMhlzGyqcXLqrLK+t8nMGcts3vZtT9VQvLVYRCQ==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr26438383wrr.49.1615803395167;
        Mon, 15 Mar 2021 03:16:35 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id s3sm11280842wmd.21.2021.03.15.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:16:34 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:16:27 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_EXT_CLK
Message-ID: <e50627bb53a8c2d3fcb03a95d8d490e98beff03a.1615801722.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_EXT_CLK

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a64274fa9907..d0e5b482f382 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -53,20 +53,6 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
 
 
 	/*  all of these MUST be configured before power on */
-#ifdef CONFIG_EXT_CLK
-	/*  Use external crystal(XTAL) */
-	value8 = rtw_read8(padapter, REG_PAD_CTRL1_8723B + 2);
-	value8 |=  BIT(7);
-	rtw_write8(padapter, REG_PAD_CTRL1_8723B + 2, value8);
-
-	/*  CLK_REQ High active or Low Active */
-	/*  Request GPIO polarity: */
-	/*  0: low active */
-	/*  1: high active */
-	value8 = rtw_read8(padapter, REG_MULTI_FUNC_CTRL + 1);
-	value8 |= BIT(5);
-	rtw_write8(padapter, REG_MULTI_FUNC_CTRL + 1, value8);
-#endif /*  CONFIG_EXT_CLK */
 
 	/*  only cmd52 can be used before power on(card enable) */
 	ret = CardEnable(padapter);
-- 
2.20.1

