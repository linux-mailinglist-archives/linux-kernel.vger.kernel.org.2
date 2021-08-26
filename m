Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD713F8EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhHZTlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbhHZTlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:41:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:40:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fz10so2954691pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OL7VNOIckGPb3nTQNYkFgRyfjBAqdWJtHBvoq3i1gTA=;
        b=XfKshZnxtsZUiDOMp3bMOOc2OZVSgGt28r5M+IgfIl7C2A/me3bc23+0fWAZu/MRRp
         CJenvN5L4VGyJq4FqryWlvctpG561G8Fdi1ZZq5ONK7XNjqfkIbA+M72qK6ZSOA6UOT/
         2hHLvRK/88BrqTFjLNc/ilvY+zdfaKlgFT5ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OL7VNOIckGPb3nTQNYkFgRyfjBAqdWJtHBvoq3i1gTA=;
        b=FSLeT7KDcIusVMPYBz8i4nhEwCEK1ZdU0RHj5Kyx54qbLqHHPCpi1E39P8sUf5EW7Q
         cwaS2hRWvGFamkGocWbuRMT9Huwdw5U8zypQ3NYvE+Fdd0ifwwB4s02IktKWEC7eOG9c
         WX6l8kmkfrbWcPM+oeYeGobE7a1VfzdXo2gNDSH12ij3EEjYmpAwtQu5gIj10d/4Hm8z
         xwMhRT9sEoQGZeh4k1V4e1y0iftzJvWKKeEDYZgOfGj1eOcCs5j3MQnrHZgp9h46+haU
         T48aJrEYWVex/PsAhPNWTzpG3EH6MnD4maQLjfoWBxVze+WwjTIp3fhsW77VbqXwo3Ja
         O7/g==
X-Gm-Message-State: AOAM5325zR4ZCfYtjsWQJ4jY50rRUuDGePyMcNsSXrkbndtPqNafAKNM
        vVVka0GDlGuBXuHqJyd6a5vRnLdmJ6DAypEI
X-Google-Smtp-Source: ABdhPJyi8k9j/pPOsmvIKcekS344fV89wbYnuw6Xq7IVfBWNCRisIxuCXwNRp99jRUKbEV1oP07dOg==
X-Received: by 2002:a17:90a:6ac2:: with SMTP id b2mr6279190pjm.36.1630006826558;
        Thu, 26 Aug 2021 12:40:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b65d:400d:1964:f64c])
        by smtp.gmail.com with UTF8SMTPSA id a11sm4324637pgj.75.2021.08.26.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:40:25 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: resolve supply voltage deferral silently
Date:   Thu, 26 Aug 2021 12:40:17 -0700
Message-Id: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Voltage-controlled regulators depend on their supply regulator for
retrieving their voltage, and so they might return -EPROBE_DEFER at this
stage. Our caller already attempts to resolve supplies and retry, so we
shouldn't be printing this error to logs.

Quiets log messages like this, on Rockchip RK3399 Gru/Kevin boards:

[    1.033057] ppvar_bigcpu: failed to get the current voltage: -EPROBE_DEFER
...
[    1.036735] ppvar_litcpu: failed to get the current voltage: -EPROBE_DEFER
...
[    1.040366] ppvar_gpu: failed to get the current voltage: -EPROBE_DEFER
...
[    1.044086] ppvar_centerlogic: failed to get the current voltage: -EPROBE_DEFER

Fixes: 21e39809fd7c ("regulator: vctrl: Avoid lockdep warning in enable/disable ops")
Cc: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/regulator/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca6caba8a191..85783fb3aadf 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1151,9 +1151,10 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 		}
 
 		if (current_uV < 0) {
-			rdev_err(rdev,
-				 "failed to get the current voltage: %pe\n",
-				 ERR_PTR(current_uV));
+			if (current_uV != -EPROBE_DEFER)
+				rdev_err(rdev,
+					 "failed to get the current voltage: %pe\n",
+					 ERR_PTR(current_uV));
 			return current_uV;
 		}
 
-- 
2.33.0.259.gc128427fd7-goog

