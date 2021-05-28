Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516C3393F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhE1JJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhE1JI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA91C061351
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h3so1692876wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSfiWENpoM0SVqY08Fc1sBXBHZUZoCh156k1W1PW9W0=;
        b=UEuBzkedHEMrTHy5u8204Bozcy2vdO7A2pfhZryB8XNJYAKtfW/LvR3Y4Ytcl1MK75
         QTmIJsDrylbrnd58ZY2lYweT4H+qzBD83bEPkIudrOitPmG9m2ejS5nqtxTYptFJYWp+
         zVXxR7IgOQ7J9DViQQoUTUJ+iQqH7wU67WS+RdVPS/KLb9eKX3FLklqC+wD5wUeckG3e
         zyZhM7jvN9xT6Ry4S/Mjybe03xW+sozSBgnfTsBQNRz7liILeaE//+Dn6snL8gMPX2th
         UEcBNROeLD0nNAP0VVmQEiGI9q6bzL2VlduVI6JhiIb6RrmcdK/oeui66yqWfh9WX8vV
         iU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSfiWENpoM0SVqY08Fc1sBXBHZUZoCh156k1W1PW9W0=;
        b=NWHnTx9sUGIHbj0L294ScZyDh+1jrO4hZSlzBuP1QN3V66L3VDbfs9LEo7CwDiwRDI
         ZA4YaQlqifF7LHN3hqp/o9xFJEYDKdwxcMWjse1lHE2r4EJ2+keFEfVisiwlMNdi/nxq
         8tSPVhvJHBhuIa3NOrSciYYKoSHc1dS0V2tc5fLPoPqKaUdfkynobSteUZzQWgK/42yg
         lotnV83aWYjrRGlhkNlRtMUkGcCF+TnILzULSKAJC+0R+n+lzsb/2o3MrtZ4EL4ye/rv
         EdV3be5eSkF8PUCRL1R+Rnf1G4a7PGunXbpF80T0BPCOrtBOmg7vARzST8CeItko02X+
         A60Q==
X-Gm-Message-State: AOAM531rsGDejqBks1lbxjMb1N4BE830zpBLmiCibqxkNp7z/I71z167
        kfM5vNT2ouozey8uzIWcKO3BmA==
X-Google-Smtp-Source: ABdhPJynURgTSqGp3nPp38Jlf+d7Bcv27IHY7P1bQdoAoKiPF74mikzq52auixb4D6gvAgAEsmlC1g==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr7369609wmn.94.1622192804096;
        Fri, 28 May 2021 02:06:44 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: [PATCH 12/15] leds: leds-mlxreg: Fix incorrect documentation of struct member 'led_cdev' and 'led_cdev_name'
Date:   Fri, 28 May 2021 10:06:26 +0100
Message-Id: <20210528090629.1800173-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-mlxreg.c:42: warning: Function parameter or member 'led_cdev' not described in 'mlxreg_led_data'
 drivers/leds/leds-mlxreg.c:42: warning: Function parameter or member 'led_cdev_name' not described in 'mlxreg_led_data'

Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-mlxreg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index 82aea1cd0c125..b7855c93bd725 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -28,10 +28,11 @@
  * struct mlxreg_led_data - led control data:
  *
  * @data: led configuration data;
- * @led_classdev: led class data;
+ * @led_cdev: led class data;
  * @base_color: base led color (other colors have constant offset from base);
  * @led_data: led data;
  * @data_parent: pointer to private device control data of parent;
+ * @led_cdev_name: class device name
  */
 struct mlxreg_led_data {
 	struct mlxreg_core_data *data;
-- 
2.31.1

