Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE234AA10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhCZOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhCZOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B1CC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so5847179wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xh7i5Zt9zY8KA4+yMY4ctmVEgG+7w746xU8n69jbbEs=;
        b=fLcj8t4LYR6hRhlXGoJbtXpS9AeaTkfx75kb7h/IAQkN9bkwczcfHP3SpsfBobIXv2
         8Txb2yVtWky8UpSkBZnd4SoEHbYDnOY2ZHvtSLUfONx2PLo5jiUbNcBHM/Ultuq53wNb
         /qzmdvlfRUM5xz2gx0M0FVisLXL6vDI3xqDjXzFmJGiBveGl8FHa6Kb+X6sH8bcl1Xvz
         BHBuPt9HoZDMONgY+VJw1WH+rZAXuHkg2B1oWpQ3xbTdnelsjhi7F3oiZo9XHG/WVqLR
         +BWBn/NJa4iGkF42GxiYMq6RB7IUnmZA/vxVs4cdqP6x8CCXbkruUN1Tz3gz5+sAdepC
         6b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xh7i5Zt9zY8KA4+yMY4ctmVEgG+7w746xU8n69jbbEs=;
        b=YfyH/EECrWsXhR5DCIxFEMCpK2U6AhTh9S+CTO/hcK/MLzY3XJEo+PpUAKwzHBwkDz
         o/bvfSsvkdnOFaWUW46bRrANoE54J/DBuEXkPMEzrcAB5IYoBXNlmQGQcNLXp9CrR0Wg
         wlJ9Oavgz0tMLCv82Op2klUKJ/h1NboUCuAFt2CKzmOgVra6Jg49HZwSaIhfqzjRG29Q
         Ji09WDp3Ket8K4wgXsr0Wst/d6LBtijmPEdIJ9lqecjbi6i17eRHiewnoaRVYOUUVEEN
         fotYOfx0y3tIxHBZxEowsjyMyZI6gwpIJcSHBCbRqHsQqs3L/sdawU6qWEOUpcrEdXEn
         xIUg==
X-Gm-Message-State: AOAM530M4KZ0OTvZgKTU/NcKGvigg3HhzzPek415zSNmpuKBKTSeOuWj
        ccc2aK2g0jzWzlbVkGp3+ZN3Vg==
X-Google-Smtp-Source: ABdhPJwb/a/SRwF/DAAw8ogBKfBvlx8OkfX2V5/f/vRfPam9TRSF9EbP2sUYi4E/UDR4SJzevq431Q==
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr15168861wrm.389.1616769320924;
        Fri, 26 Mar 2021 07:35:20 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 19/25] HID: hid-uclogic-params: Ensure function names are present and correct in kernel-doc headers
Date:   Fri, 26 Mar 2021 14:34:52 +0000
Message-Id: <20210326143458.508959-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-uclogic-params.c:33: warning: expecting prototype for Convert a pen in(). Prototype was for uclogic_params_pen_inrange_to_str() instead
 drivers/hid/hid-uclogic-params.c:519: warning: wrong kernel-doc identifier on line:
 drivers/hid/hid-uclogic-params.c:706: warning: expecting prototype for uclogic_params_init(). Prototype was for uclogic_params_huion_init() instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-uclogic-params.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 6af25c38b9ccb..3d67b748a3b95 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -21,7 +21,8 @@
 #include <asm/unaligned.h>
 
 /**
- * Convert a pen in-range reporting type to a string.
+ * uclogic_params_pen_inrange_to_str() - Convert a pen in-range reporting type
+ *                                       to a string.
  *
  * @inrange:	The in-range reporting type to convert.
  *
@@ -516,7 +517,8 @@ void uclogic_params_cleanup(struct uclogic_params *params)
 }
 
 /**
- * Get a replacement report descriptor for a tablet's interface.
+ * uclogic_params_get_desc() - Get a replacement report descriptor for a
+ *                             tablet's interface.
  *
  * @params:	The parameters of a tablet interface to get report
  *		descriptor for. Cannot be NULL.
@@ -689,7 +691,7 @@ static void uclogic_params_init_with_pen_unused(struct uclogic_params *params)
 }
 
 /**
- * uclogic_params_init() - initialize a Huion tablet interface and discover
+ * uclogic_params_huion_init() - initialize a Huion tablet interface and discover
  * its parameters.
  *
  * @params:	Parameters to fill in (to be cleaned with
-- 
2.27.0

