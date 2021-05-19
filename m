Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CB388EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353619AbhESNYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353607AbhESNY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:24:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B47AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:23:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y32so9425520pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ovai3a0JnkLM5FPEScO4kg8zGFTOg/1nchKtueXaWHE=;
        b=H8UKa4OGk2nXnJlhwb1FcuImIe0jiq/Jlq1TPGr+1lgTEQ+fnE6dpEqPtAIcT2DIqF
         yhSlcKl3htU9/L0rrdQil+La/a9PH+06PNYy1dhAu14HuuGjgeh+2y0zZ5ROEG4BiuGS
         Gpna7xed6+xqtJznsORdWZD0cy4o9mulnj8zQ4IU7Y2i7wGOqvyARaYrL8wbrD7jSd7i
         /39/hYouNfIfo213y5O9q65oayLISZ0Hi7FELwj0DMXMlj9NQsclEghvc2T7A6mD7evS
         k6gi4hAQLrom91+bPA7PwYspwiP0KFbcDv48dwAlbFEVnzZopBciNiuhicMmarU9l4xt
         +tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ovai3a0JnkLM5FPEScO4kg8zGFTOg/1nchKtueXaWHE=;
        b=VY2bqe90AWHT9X52K+qGKyAI7E5fG7R+Kya9JJzk5BIPB5QzD8lzJfJGsTqoxkH1cP
         r2XKqbcWrsVbwtG34u7WJfvk7WJSnC4XWFfdMlJ0okFt7pXlMpQ6nlNtKNMMxmFSCCia
         YfxiR62qgbuupxPp8jnQuSc58zcgV7av1HtLJDNi/ZKUvL0NTSkzcnLtNJc4ezK9WNZm
         cEy3HNbvslIwrtAHo1vPeIMo+7s/JBbPVr9WvR0bPr+m+1wRwW+il/R0iC2JnYv8q0Bi
         5v4lZVbOckslFbQn59EeWC4ilOdcKn9oR72Hm0NsRysaCN8O5Ma1V9nIS+ZhF2fk6CID
         G4RQ==
X-Gm-Message-State: AOAM532GpJWh7UpWlWXcuHeJjRn/polNgjh+f2OKMuNdXYvh7QpAfrIO
        JLhbcUcg7bijL+z4G2k+XGvZSA==
X-Google-Smtp-Source: ABdhPJzi4vMVoE/89uxc4gUpNsZXKqZSX3bzNWtym/DVb1XXZFYmvOTqwpp7BOcw+y/avPQh9acxUg==
X-Received: by 2002:aa7:8809:0:b029:2de:3b94:487e with SMTP id c9-20020aa788090000b02902de3b94487emr9118170pfo.33.1621430588910;
        Wed, 19 May 2021 06:23:08 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id g8sm4325576pju.6.2021.05.19.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 06:23:08 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
Date:   Wed, 19 May 2021 21:22:55 +0800
Message-Id: <20210519132255.1683863-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EINVAL if ramp_delay_table is NULL.
Also add WARN_ON since the driver code needs fix if this happened.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 0e16e31c968f..ad2237a95572 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -948,7 +948,7 @@ int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
 	int ret;
 	unsigned int sel;
 
-	if (!rdev->desc->n_ramp_values)
+	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
 		return -EINVAL;
 
 	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
-- 
2.25.1

