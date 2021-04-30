Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05136F69B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhD3Hqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhD3Hpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01393C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so103870064ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvsMkKSxObWfrYf5zpIINvfbNjNueuFKMoVjdC9Jfxw=;
        b=DuzBgLs5cGQZTE4Dl/XtabEQpmtO3joUrauIPr26mHsnu8kUSORJlCQ++E7JoNfbrB
         nY1KAybj0Rtun9GzT87GQBRS/3tClTqztNlWeYo1Y2crdk5AB+AAHi0uVmIlFZwkvmKU
         qD4KSbT8DulncPobTqMAqajpH5RI4/Dc/UmvHYQ4k0kHve2MvU2Dv+pUeFK5tnsGmAyD
         h19aH1zKJp7N+bi2Tn91hTOk7xzPS8i858ZCtkReD9fYwB9cy2b0RsVW4G6EAVUdn/Ni
         tEM7McvsBfWu3+hLxf7fkoDlNYmhEAm0IeE5WjEPOA/i+N3LXHLcNxZselgVO+aFyHKu
         Jy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvsMkKSxObWfrYf5zpIINvfbNjNueuFKMoVjdC9Jfxw=;
        b=qdOAKQwmkTc1HornoN/luasuU1dPudETItvZoB3CUeLM98C9uTHjppnuVn/E8r6TwH
         7tzDOTQ8LHKkizGZCZkZgpUU9DuX26TWTbnakqd4AuE+qyM/207UkvA8tiZLjC/lArEF
         YMbBe6AdOWhxq04BKvkKvhnsmD5oJAmPS1XIDpn4uJRmt8rcxSkjvwke01T5qnDqa4NB
         6rGHiK6i+L99itJJ304McNhKRvtIM+siAvqIn0GHCzStzCrFE7o1bRcjjArYzaBzuCoS
         ESLNlToBS4MuZjVGfz3HcO8yAWAcHFilsRhCtilHh2U61FWScjO2sOXmEO/B+9YTi4wA
         EVZw==
X-Gm-Message-State: AOAM531uMDStkw7gh4kWx8oSpjfhrnPgTZkHlK3eUNSc8h9wikstWami
        iOi/0xKLEzwsShKTRI7Yl1RrQ/Tv3z0Mog==
X-Google-Smtp-Source: ABdhPJx6s5BZSN9tvdPsVivNeTZHPANGYYplPmd2dOl28aYX9jwtDoltYj5UWNKE8Bwy0+FB38S/EQ==
X-Received: by 2002:a17:906:7118:: with SMTP id x24mr2791240ejj.127.1619768691609;
        Fri, 30 Apr 2021 00:44:51 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id q16sm657977edv.61.2021.04.30.00.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 28/43] staging: rtl8723bs: remove empty #ifdef block
Date:   Fri, 30 Apr 2021 09:43:46 +0200
Message-Id: <88902ad8cc2747792840a6f17db428a185a27f23.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty #ifdef block.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 9c9ad29870e2..f2793d5d9a30 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -112,11 +112,6 @@ extern u32 		GLBtcDbgType[];
 #define CL_SPRINTF	snprintf
 #define CL_PRINTF	DCMD_Printf
 
-/*  The following is for dbgview print */
-#if DBG
-#else
-#endif
-
 struct btc_board_info {
 	/*  The following is some board information */
 	u8 btChipType;
-- 
2.20.1

