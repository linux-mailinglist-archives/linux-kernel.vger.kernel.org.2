Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2753F6DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhHYDiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbhHYDiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:38:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:37:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id n18so21781608pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQQEbVeVDT1YhEtDZWiPfSh9kXzQOU1nYSUeUxcQq+4=;
        b=PH1DNs9H1KsQ3Cg6OzNgT+fYFdlzjQeAFpdasNaEflS4E+oqB40xQSi87WX2LyJVzh
         ts1ixMeOmUEU2zwPVS7OIe/87CXbzSpQ2vqaD9ZG9SyRj9ZO1SoPpyV/jXC6qRlA/tRw
         w6UYu8MAafAEnbH17XKCqIpgYCqnv0k2JsUmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQQEbVeVDT1YhEtDZWiPfSh9kXzQOU1nYSUeUxcQq+4=;
        b=Wn4ETo53nj0hbFryq0qwoW1wNHDg6zTYoLNIWZprWNyvyykUdSnIsb6K4VgyRWAWXr
         jzbu7huunRZYsHVN8AcsAiG3pzwTUOmont+yauW2DbgtJNucwgBMKKIZV5DHG5E5DkTY
         wm/IuXJNLMJdyerunIIoclBrqQpSEnS19iyUOiynV4LLlzf/ZOMUXhoEYkPvUxYauLoO
         ftAKVKra08Wi2jKjJSizTLDuZxVQNm8tw6/NTm+A7uoFuMNxuxKf07ODopB0mhvAOJSy
         977CsrPn1UsmjiiIG+CIOn7ja42UZDHucpaF/AE9dOxKzhr1PIt5kdASQVyeH4AnkqTp
         hmVA==
X-Gm-Message-State: AOAM532H1yc6/m/9iXun8xYTzSFEthDNXzC99zJA4YVp3fnkgRBXq/Du
        2p81vO9chQTrO/aSu2qHxGwL0w==
X-Google-Smtp-Source: ABdhPJzBEIHR00TxsQDE8F/MS1LdIOVDWP+Q0gVkn8Sa5XgEZ+HdYSirC75ts5J3UjFkwT1laKhfLw==
X-Received: by 2002:a63:155d:: with SMTP id 29mr27256678pgv.118.1629862643687;
        Tue, 24 Aug 2021 20:37:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:629f:4b05:2c88:776d])
        by smtp.gmail.com with ESMTPSA id l10sm3902149pgn.22.2021.08.24.20.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:37:23 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] regulator: vctrl: Use locked regulator_get_voltage in probe path
Date:   Wed, 25 Aug 2021 11:37:03 +0800
Message-Id: <20210825033704.3307263-2-wenst@chromium.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
In-Reply-To: <20210825033704.3307263-1-wenst@chromium.org>
References: <20210825033704.3307263-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit e9153311491d ("regulator: vctrl-regulator: Avoid deadlock getting
and setting the voltage"), all calls to get/set the voltage of the
control regulator were switched to unlocked versions to avoid deadlocks.
However, the call in the probe path is done without regulator locks
held. In this case the locked version should be used.

Switch back to the locked regulator_get_voltage() in the probe path to
avoid any mishaps.

Fixes: e9153311491d ("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/vctrl-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index cbadb1c99679..93d33201ffe0 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -490,7 +490,8 @@ static int vctrl_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ctrl_uV = regulator_get_voltage_rdev(vctrl->ctrl_reg->rdev);
+		/* Use locked consumer API when not in regulator framework */
+		ctrl_uV = regulator_get_voltage(vctrl->ctrl_reg);
 		if (ctrl_uV < 0) {
 			dev_err(&pdev->dev, "failed to get control voltage\n");
 			return ctrl_uV;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

