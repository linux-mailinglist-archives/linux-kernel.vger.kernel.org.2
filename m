Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776F235F9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350946AbhDNRaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbhDNRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:30:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A530C06138F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:29:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d8so10512201plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtcyLr97vt7tBtf+Evf5JrbdU0JuK+5BO0OeaqqfGII=;
        b=U3p66+Be9J9brLNZfLCAa72fmyHRhYkU2dLerndAukBzw9zqH+m1l2LBgLkyJu6/04
         s1uRRZ+UJIiAk+qKJDPUqbNlfS9edRSd1TqeoyJPJaOheuKDsALg4RevMCAL+aM1mJni
         RIbOhRQmnkWslS55DoyiBjiz4r02jbQvoJm18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtcyLr97vt7tBtf+Evf5JrbdU0JuK+5BO0OeaqqfGII=;
        b=fLmfwyNCC4XKGlTsDWwxNPAYKkiVwsfb2jobCqxV9lV5AYCAUuJnVvBlEg+UGt0m9N
         kw82wM2thKaVZYOFIsg4FNMVRk6sKC5CKG1rp6MsHsdK9v/B8VkgoR3+uTI51BgowmnN
         D9u735Ea2vTG7YJ0o1awgB9LYNncH0uIug5flnlZzyswz43HtLKNbTgIAE5Unst16MBw
         ZWCzGhcdfaBcydTShZ7jlS8MODpujuEx/Ik2jWtMkELw7992lwL3LLV7eQENp8BWjTVO
         xKL7ge5PS6h4HgUNC9/Y8yccqmRMxjEAiTfSOTyzWE8cun3EYsH6XFKMVGjDq+n4rj0i
         Rsqw==
X-Gm-Message-State: AOAM530x6oAYJzH2alN8Jz4Re1DJBZ/25/EXOPt4R5H7d+aqn31cAGF9
        PvkfolgTHbPVCKuDtJMZmAeHrg==
X-Google-Smtp-Source: ABdhPJwPcZosbX6F/FEtrRwct5NPpkw0jknr5o9f0r7xAc5sBoT3Dcx5C3arvvo3qFB/+caOXsY09g==
X-Received: by 2002:a17:90a:ce8d:: with SMTP id g13mr4686960pju.85.1618421374136;
        Wed, 14 Apr 2021 10:29:34 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:bae3:4af0:9792:1539])
        by smtp.gmail.com with ESMTPSA id e31sm63460pjk.4.2021.04.14.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:29:33 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-i2c@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v19 4/6] misc: eeprom: at24: check suspend status before disable regulator
Date:   Thu, 15 Apr 2021 01:29:14 +0800
Message-Id: <20210414172916.2689361-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414172916.2689361-1-hsinyi@chromium.org>
References: <20210414172916.2689361-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cd5676db0574 ("misc: eeprom: at24: support pm_runtime control") disables
regulator in runtime suspend. If runtime suspend is called before
regulator disable, it will results in regulator unbalanced disabling.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/misc/eeprom/at24.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 926408b41270..7a6f01ace78a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -763,7 +763,8 @@ static int at24_probe(struct i2c_client *client)
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
 		pm_runtime_disable(dev);
-		regulator_disable(at24->vcc_reg);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
 		return PTR_ERR(at24->nvmem);
 	}
 
@@ -774,7 +775,8 @@ static int at24_probe(struct i2c_client *client)
 	err = at24_read(at24, 0, &test_byte, 1);
 	if (err) {
 		pm_runtime_disable(dev);
-		regulator_disable(at24->vcc_reg);
+		if (!pm_runtime_status_suspended(dev))
+			regulator_disable(at24->vcc_reg);
 		return -ENODEV;
 	}
 
-- 
2.31.1.295.g9ea45b61b8-goog

