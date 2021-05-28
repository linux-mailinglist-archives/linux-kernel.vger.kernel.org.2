Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AB5393F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhE1JI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbhE1JIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c3so2521635wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLS0FB17HbpmmfumllhmqVSElRMK/rukxZufYJ+uM3w=;
        b=IqJBFrZK3QQeSM0UFkIbJaJKRS77W9bionIX5fp+IQ43LnTYpvKqSz3wW/gKYQ/Ptt
         SYcDqy0h4GTSLCN5CWR4LGpIYMRnyiXncFOG5yEdlJxur5zCrCIWMoOHUxMLnatYYYPH
         NVXioJ6ubPbLKVn+ZWVQdoY/Qp3l0sPtH6K8hfYj/DA36+x7+CE1RbZByV5PgV9qcFV7
         ZuXXmJap1RiDM57tpVQG7qJrfVUVcBRUuAGRhlGhOBytjp+XNSgV7XR9urEsr6RLxvsQ
         0uXdWSKxiZcZZa4GGJD4N1FM9DM+9XnnkXvcsQHbxHmZhmnop8rUMVpoGVuz5mcnRXy1
         wQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLS0FB17HbpmmfumllhmqVSElRMK/rukxZufYJ+uM3w=;
        b=gzR0SvsflUgs9f9w3KBvjwBVjVOCI+4v60AqvLHTB03jFtZYO2PZNO0/r+evKNCMLt
         LfI6DyncVXHfsgc0qnbOpSFl0BApmoc081ph2UMTK6gC3Pv9m3sF1Kagi7WG4slUfe/z
         1dnNzL1qUE/+/fC5ESPb5i9E6/rIF9OOZVAbDjqMUObcyN3ONFfYHicxzN3/MJDCoLcf
         Tb8qp9NpGOyOHya64KiACBmhYUKvzAMPdX0g4Sp0bJ2EMCSmYK2pvii7SZEmakemxw0Z
         o36bkY4CJscKq8KyNRpg31EO+2Kbb74ce6pNovnRpzjTdZyYWREyvKK63ak7FkL3yZRe
         ywOw==
X-Gm-Message-State: AOAM531ugwv5oDWgJ5ZiS0IA/e1QcmH/5c2oAhmleLP7kRXMk9499Er/
        aF29e/v2st0J7FIjKCAxnBr+ww==
X-Google-Smtp-Source: ABdhPJxLcM/oNoc34IsXQ0iquIcL36RQ/+WSPhZqHCGx6ZwumAqrVyoOVKB0Eru+WZ9zKK2nJHs04g==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr7561654wrm.46.1622192801276;
        Fri, 28 May 2021 02:06:41 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Kumar SAHU <shreshthakumar.sahu@stericsson.com>,
        Dan Murphy <D.Murphy@motorola.com>, linux-leds@vger.kernel.org
Subject: [PATCH 09/15] leds: leds-lm3530: Fix incorrect spelling of 'brightness'
Date:   Fri, 28 May 2021 10:06:23 +0100
Message-Id: <20210528090629.1800173-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-lm3530.c:113: warning: Function parameter or member 'brightness' not described in 'lm3530_data'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Kumar SAHU <shreshthakumar.sahu@stericsson.com>
Cc: Dan Murphy <D.Murphy@motorola.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-lm3530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lm3530.c b/drivers/leds/leds-lm3530.c
index 2db455efd4b17..e72393534b721 100644
--- a/drivers/leds/leds-lm3530.c
+++ b/drivers/leds/leds-lm3530.c
@@ -99,7 +99,7 @@ static struct lm3530_mode_map mode_map[] = {
  * @pdata: LM3530 platform data
  * @mode: mode of operation - manual, ALS, PWM
  * @regulator: regulator
- * @brighness: previous brightness value
+ * @brightness: previous brightness value
  * @enable: regulator is enabled
  */
 struct lm3530_data {
-- 
2.31.1

