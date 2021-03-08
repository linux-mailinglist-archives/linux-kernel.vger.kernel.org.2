Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C230330F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCHNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:31:54 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239DAC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:31:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f5so8082851pjs.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ncmPR+Ul4hj/YevEkIcgWGYc6btFpweVo1v4X4ckn/w=;
        b=s3bAwjOaaVp63nrCFLpokW/AIOBoAXKXIUD+VkFsKXhOsvJvnN2MX5nNTolPwYaBDq
         wphZjSNYPtKEwn3z5oobkYYaRs9w5BVOTv7fmKTZC6/gu+MGWjAbvpPGV8QHH15ekVHt
         CEpg/0WhupzyWn4AKZG85ygECGbseVTYz3UwjsSwi7b03MN7C5Xe2ovXMCcbGy/Ykd32
         4WlXAJBgzmyHb9+5aSMsniS3rhqVohOeFNP6BbPhyskNiikIrV3nLaVWx2WNjoxAn9Dr
         D84WGJCk6sTsi7WICt5F6tCHr3zVViwGD+uNr2x+RpGIf84S1WVqVUY3TSWtBsJ34ZMy
         7J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ncmPR+Ul4hj/YevEkIcgWGYc6btFpweVo1v4X4ckn/w=;
        b=YEzyMGTNiRxSc6hFqf5qYMu25VxYbIQlji/jUrmh6pR+ilDby0lKlGTZZdZFOYp0V+
         /dJDEDjWvk6kZ8mMkmJyqKX4RYzUD39OmxJIbzh2AtVx1Evu4raTam9q8EgUJ29/6yLe
         Ai82VZu7PC9cFuyhj629c8dWe12SCOWmqC5SAFGKBrRwSt1UpGqe/IhM2taehNuYr3wS
         R1tYU+PubvYiRmgYa5NSBF+TpKt0ocI8s/VAYAfW6sAoEjOb6P+l0MVGsyQsM8Rwgzeb
         ihqFF8ToX9qoRYIKhM0C19sgWnUqwuTFZpzk5u5H5rO3+R1831sPfzLYLb7w2jRDkrJM
         Dc5w==
X-Gm-Message-State: AOAM533Al+cdAOmA5CqlrORNOOd2RV5ON+Ym8cP79JJOd7aCP38xf/LQ
        0SrjJ4BHfW0eigrhVqYvJZv6gGQG36c=
X-Google-Smtp-Source: ABdhPJwvlFzosiB9AUVEYirfgYxKLuuHfbO0Hrn7Eg9GmchJhm9FdQ1yPs738gLDE/LMYBXaa6N2wlLsamg=
Sender: "raychi via sendgmr" <raychi@raychi.tao.corp.google.com>
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:b0d0:d9f:e729:2209])
 (user=raychi job=sendgmr) by 2002:a62:2b0d:0:b029:1ed:55cc:25d9 with SMTP id
 r13-20020a622b0d0000b02901ed55cc25d9mr21893016pfr.54.1615210312591; Mon, 08
 Mar 2021 05:31:52 -0800 (PST)
Date:   Mon,  8 Mar 2021 21:31:46 +0800
Message-Id: <20210308133146.3168995-1-raychi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not enabled
From:   Ray Chi <raychi@google.com>
To:     sre@kernel.org, gregkh@linuxfoundation.org,
        naresh.kamboju@linaro.org
Cc:     kyletso@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_POWER_SUPPLY is not enabled.

The build error occurs in mips (cavium_octeon_defconfig).

mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_remove':
drivers/usb/dwc3/core.c:1657: undefined reference to `power_supply_put'
mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_properties':
drivers/usb/dwc3/core.c:1270: undefined reference to `power_supply_get_by_name'
mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_probe':
drivers/usb/dwc3/core.c:1632: undefined reference to `power_supply_put'

Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Ray Chi <raychi@google.com>
---
 include/linux/power_supply.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 81a55e974feb..6e776be5bfa0 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -381,8 +381,14 @@ struct power_supply_battery_info {
 extern struct atomic_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
+#if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern struct power_supply *power_supply_get_by_name(const char *name);
 extern void power_supply_put(struct power_supply *psy);
+#else
+static inline void power_supply_put(struct power_supply *psy) {}
+static inline struct power_supply *power_supply_get_by_name(const char *name)
+{ return NULL; }
+#endif
 #ifdef CONFIG_OF
 extern struct power_supply *power_supply_get_by_phandle(struct device_node *np,
 							const char *property);
-- 
2.30.1.766.gb4fecdf3b7-goog

