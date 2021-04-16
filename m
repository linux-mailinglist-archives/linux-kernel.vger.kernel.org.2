Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC203622DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbhDPOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244232AbhDPOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r9so42483535ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61oKXxvl+24t+oBgcuj4NfG+vBqO/3mKOMoXwskYVGU=;
        b=X4BXqdfG23NXa84B1Vlw8fBJx1H23dD737fq31AW5KzaRwv5QkDL16paKDhgU1wF8W
         GOL7iCorZFDYIS0EemuA5lDQa4FHfNL/wr/A1E0/ig2HuqDN7oxizMG/QdnscB4oBsDP
         5WIgMUlhpojZQs9TK06RF1Nrwj9zyQTJbO8BI0VWmYwcphGIQsks2Bps/emwiy+CH/Wk
         o67Nj1MfKAlRF3jncWbu3AUTyN36ebEjkndRCtA6nkAWNOFo5+SKbfsQIh4rpmjt6Dow
         F6NMyDFABd2NhOpbIqURgxg4QjDROUlAYJxrkg3GXO/KZ9XSpWXilAKay+z0Aj7Zc9lU
         0d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61oKXxvl+24t+oBgcuj4NfG+vBqO/3mKOMoXwskYVGU=;
        b=T5JT44TUEDVA78w+ze6Qe106XWErGGVgjkjnKiZoGJmEbFEAubDch/jh2GPzu3s6YY
         bpEx2+U0mtHmgg5uThXFoiyC8+ujri6BmoQ5fS+I/aRNZyIiVnOzi170mNTJ67PM1j8c
         v9+RVz6/L4ueIaZTEYBvp/jHYC7Ybc8tNKYb9op7XO+7e6KZA4lsoozXUKTGxjvxWhBd
         UBZs2FJn52r7xFENJz/uBd5abR3XVmY6ZRImEB7p9yW/XWcvvHwnmswYXwo8LO8Ktwqj
         bU4TobdrsoyhsT0GJ4x27hXL6HTAI2Q18tSMXOdb1TS8tFSKrPHq46nQjbLgZbByXAcG
         G7vg==
X-Gm-Message-State: AOAM532U/2iZ2z2b2lRpT2Pqbu8A4bFfwthObpIhQ8rEoy2Vff/tva/e
        9llxo8sx+RE/g3vmN1w2BZSlcQ==
X-Google-Smtp-Source: ABdhPJxfs0dO3k/tSuzZR0zH09FpnzlHYRFLRl3kEj7fOswxtkCOFLd/lE/Wsujn8Z016ric4zI1mQ==
X-Received: by 2002:a17:906:9bd3:: with SMTP id de19mr8318214ejc.329.1618583868141;
        Fri, 16 Apr 2021 07:37:48 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH 17/40] gpu: host1x: bus: Remove superfluous param description 'key'
Date:   Fri, 16 Apr 2021 15:37:02 +0100
Message-Id: <20210416143725.2769053-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/host1x/bus.c:774: warning: Excess function parameter 'key' description in '__host1x_client_register'

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/host1x/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 218e3718fd68c..e293b68acc348 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -761,7 +761,6 @@ EXPORT_SYMBOL(host1x_client_exit);
 /**
  * __host1x_client_register() - register a host1x client
  * @client: host1x client
- * @key: lock class key for the client-specific mutex
  *
  * Registers a host1x client with each host1x controller instance. Note that
  * each client will only match their parent host1x controller and will only be
-- 
2.27.0

