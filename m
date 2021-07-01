Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1B03B8DEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhGAG5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbhGAG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:57:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84303C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:54:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j199so4601372pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaGoqmFP1tt0EpZeEpkj9x84y98y9BYCdG4DKqTdqyc=;
        b=jytw1fUdgseF6tkwK4vPEO6tMMLx7zUiWZECq+PuslI4xmtAklxm6BQi0CekZ+tkIT
         aqXLdrI5VN/Nc5msg6XIAk1fVxzUfAR+cKBijD9YUtszoyZNJz5//dHazXD96UAh9TOT
         CjyS7QVqbISwamkqJs9oz5XJJYFycLwO1/P+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BaGoqmFP1tt0EpZeEpkj9x84y98y9BYCdG4DKqTdqyc=;
        b=PELx0lSX9DILoeX8eVjcY3t8/5Kx+V/pQ34HKqQcKVsTyw6VcXPCUadTJbwNjd+M+P
         B/ii3oxjzRK96LcomO3revTDOLLprLTPQ+XHsdLjVkWUVq4jYO+MecMqWqdzthDbiZgC
         oftFL3t2/X4uiSMVovsmNgNltp1awqHTSeUdDYGiLuRYGDNfn39hg2UkRFs5yw9pyw5n
         EfOje0uXUsVhFU6tbIgGckETEigvsJNsIc7OPdi2PyuUcEUnavc18qBAfxB2j0d6Kkjl
         b+5oM5t98DPPLcfdgpgxuZBQG6tRMQEWZUKFNvJpDLx2GcLhwwZGqjJ/6PaeJXgR3znJ
         hMtQ==
X-Gm-Message-State: AOAM531GG69mKIhiIzJMVD9r80E/g/L4d8D+4J3QrKV1AdgdN6g+X0nF
        Hz8s5PXylj0+9SwtFRh+1qqq0w==
X-Google-Smtp-Source: ABdhPJzxV7zCV9lAR3c0Jc9juDg8NFET/Z+3XOOmtNN2U0pMXdlVQZ61Yd8/oRnIU39J8a/TT842Sg==
X-Received: by 2002:a05:6a00:2145:b029:30b:127:e0a3 with SMTP id o5-20020a056a002145b029030b0127e0a3mr25141688pfk.34.1625122484840;
        Wed, 30 Jun 2021 23:54:44 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a18a:185:21d0:d5d6])
        by smtp.gmail.com with ESMTPSA id l7sm24770126pgb.19.2021.06.30.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 23:54:44 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        zhiyong.tao@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: mediatek: Fix fallback behavior for bias_set_combo
Date:   Thu,  1 Jul 2021 14:54:39 +0800
Message-Id: <20210701065439.2527790-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pin doesn't support PUPD register, if it fails and fallbacks with
bias_set_combo case, it will call mtk_pinconf_bias_set_pupd_r1_r0() to
modify the PUPD pin again.

Since the general bias set are either PU/PD or PULLSEL/PULLEN, try
bias_set or bias_set_rev1 for this fallback case.

Fixes: 81bd1579b43e ("pinctrl: mediatek: Fix fallback call path")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 5b3b048725cc8..0cdff487836fa 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -926,9 +926,12 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 			if (err)
 				return err;
 		} else if (hw->soc->bias_set_combo) {
-			err = hw->soc->bias_set_combo(hw, desc, pullup, arg);
-			if (err)
-				return err;
+			err = mtk_pinconf_bias_set_rev1(hw, desc, pullup);
+			if (err) {
+				err = mtk_pinconf_bias_set(hw, desc, pullup);
+				if (err)
+					return err;
+			}
 		} else {
 			return -ENOTSUPP;
 		}
-- 
2.32.0.93.g670b81a890-goog

