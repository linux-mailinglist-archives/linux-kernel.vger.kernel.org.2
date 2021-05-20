Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CB38AEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhETMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242924AbhETMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:47:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9DC0610E6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b7so8440927wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCVCX80G9lI3O3DeFSFdWNKU1XN0pA4zwW94RZh137s=;
        b=DnovUsZrtkLnNIXfVzFMlXamimyl3QsLUj3BLuCSCi6P7s2pHJS+wtg6wFZSPMIZOW
         tGW5MLIS4HlwPS8tJGwKr1EEyzO2bMzF22qUyq4is1106KZBOnEJBd7ctalV/p1DLtw8
         ZoGXfcO4Gekv9w1r+yR54P8TUa0cE7d2WjvX1kI3kAJ47GqSKBjjfApHBsq8i1b7ExT/
         XwYeotY/IxJhHASH1kEHUcYTKmsPcAo5dwvJJQPvLnl1Tsp8HqZGFdXhA+24El9G94A7
         i7MQVVLWkQQU7UqkYLD5T5Gx12kCsOu1BcdLb6WU7cMSWkn1hagvDWcnBEdDRiNFfyuk
         tk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCVCX80G9lI3O3DeFSFdWNKU1XN0pA4zwW94RZh137s=;
        b=JhJE0mZm0ryy2Z0yltGMRjQqEQcPXt+K9SZ9A+sjPFW2uGBtZGOT/PD77AcQzi2TK2
         CKQkWrufzJ4yyHxcV5eyTSlNiHNviGgM6jMkcWw13cbyo8YsBQt23gFfsrOxdHrvunm/
         QvK+Mt4l+2L6slEWHtHG82EXZ0Mc4MoG03XBeA/xKuFFGXF4YGDOO8ajU6P+Ag346SMK
         4kCQlr1Qz9TcKeZjUhQUYAfwH0YoolbksMJPOH4P394+Csl5Ne82UtNIlrUD9T1RSqJC
         bHokZ5JkYz2MaeI383i+XsOBry+fqGQUiP8AFmo/RCla/SuCxjcVK/II1nfIvfHTcDyg
         37rQ==
X-Gm-Message-State: AOAM530ypMPjmSweNKfuR/hihaQbCdh/ElG0GRdlnU1DKy78SHaGXJPh
        Sm16zVpm/mMSl2Dg36JI1tSVGiKpf+6Szw==
X-Google-Smtp-Source: ABdhPJxsxO3cMjQOIu2NzIsyrv2mZnjNOFpHFPCLkjEAhYlt/DnCg68LsHAQJE3vvWCRMk1OgPiD7g==
X-Received: by 2002:a05:600c:19c8:: with SMTP id u8mr3794890wmq.50.1621512503864;
        Thu, 20 May 2021 05:08:23 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r7sm2237170wmq.18.2021.05.20.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:08:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 1/7] mfd: wm831x-core: Fix incorrect function name wm831x_reg_unlock()
Date:   Thu, 20 May 2021 13:08:14 +0100
Message-Id: <20210520120820.3465562-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120820.3465562-1-lee.jones@linaro.org>
References: <20210520120820.3465562-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mfd/wm831x-core.c:121: warning: expecting prototype for wm831x_reg_unlock(). Prototype was for wm831x_reg_lock() instead

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm831x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index bcef08f58fb3f..c31809b17547e 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -109,7 +109,7 @@ static int wm831x_reg_locked(struct wm831x *wm831x, unsigned short reg)
 }
 
 /**
- * wm831x_reg_unlock: Unlock user keyed registers
+ * wm831x_reg_lock: Unlock user keyed registers
  *
  * The WM831x has a user key preventing writes to particularly
  * critical registers.  This function locks those registers,
-- 
2.31.1

