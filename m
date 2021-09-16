Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357A440E5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbhIPRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:15:02 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54308
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345109AbhIPRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:28 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 68B1D40297
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811931;
        bh=LNYgyUdmOLuXkjD9g2BDNjy4wJVnJNKR41YhWEm7EZw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=YmLGLmSyWzQVyehHmg+s+kW7r1UPUVn1muJE3vznlcEt9ZsB7Bu/YM8uazw6+ZW2b
         NTdnMOquYCsTujRh7KE+DHKAAwK83KU2f5B1k79yDDNGgy2CE5vEeQvUt8nTFNQ1la
         GFLT5kyUQsxP0B/G9y4haKs7p5GkOTWHUQLLkd55c+n3j4qZnyXu6q9WfD76KOWFgJ
         y6SNK6/G3aBVIsrmTGy0RL53yEkarBY2x0q61Y599g6zQoFX3Kefds3kc5sySCXlzB
         rePOyYp6NebuLD8Q/5fhVbxSXk1+lLgM+wB0cU/0EtwWFipgpj+26NLA6OKwUwCFvN
         LsFU7GHP5BTBA==
Received: by mail-wm1-f72.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso1377254wml.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNYgyUdmOLuXkjD9g2BDNjy4wJVnJNKR41YhWEm7EZw=;
        b=bbhy/F77yNfqAhPfAcHS5X/t0fEz70eIWmrAVXsLA0hOkB9QD3Upe0UZvL+W8WD4VH
         PmSIR4KsV0gA2c8xG5aiYXCW/IkEbYwIatELsRr8SgO6bVfDQSHufrIddH0TDFfk7CjN
         pSi9LnDOUgIS5ulNSvXIoYTtDsyLVaQAAJou9+i4kfZpLtVqtox9OInVz72SdAr+0R/g
         907NA4czsZPOPH7qaAxnwRnCosa0vCgLYgSpV1taaQ1yPwdYiL5s/tieOkpObzsJHTZL
         iMSHppqBHymxNAHX6qy29fJH0Mgfy0p61GCC0z87uSpXCF7OlEipfeZ7jiHyP7r0Hkxq
         kMTw==
X-Gm-Message-State: AOAM530xHeWr/p0MXo5qwmZPfjlzSudCKrqQSbZrYNMhdQ69uUKQFPDh
        PhAOTjm9eLN6gV2CKkPzeXtr0W200K1mNtyI6n2LWuxveLo9DIwVLoToh7RwXc6MjfEce0/+Uyn
        YbFQ9PynCT7KxgSErXdyFbdlTgSqAc7PfVKTLAkp5VA==
X-Received: by 2002:adf:b319:: with SMTP id j25mr7420836wrd.256.1631811930876;
        Thu, 16 Sep 2021 10:05:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuWdr3LHYQAlkhUF2LhdnvbqjpaHH/IYbTuQZ8JReG2xn2D6IRAY1c2YETkzuaX7analAfAw==
X-Received: by 2002:adf:b319:: with SMTP id j25mr7420800wrd.256.1631811930645;
        Thu, 16 Sep 2021 10:05:30 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id u13sm4153069wrt.41.2021.09.16.10.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
Date:   Thu, 16 Sep 2021 19:05:28 +0200
Message-Id: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brcm,bcm4330-bt is already on the list.

Fixes: 81534d4835de ("Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/bluetooth/hci_bcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ef54afa29357..7852abf15ddf 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1508,7 +1508,6 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm4334-bt" },
 	{ .compatible = "brcm,bcm4345c5" },
-	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
-- 
2.30.2

