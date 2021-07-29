Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362CA3DA159
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhG2KlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:41:20 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47846
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236436AbhG2Kkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:47 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E87EA3F231
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555243;
        bh=vQB6RRzmQQRlWh6S5blKR75hWps+lidsZcEbJz9OF3k=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nml0jDSXVy3lXLhxTJ8QN4KV0wYeNSWSr68dcZw6YBXHAj3kOn5Wdr7b2OBtWDLhZ
         4CmrfjLIEmWIF0CDcXcU2pqGh87u0rIhe9+fDPv0J5OUdZNra7JuYnr0+FFqHHK2Yn
         l4Z6sZp3SvVsi5BYE0/GPZQjjriuj2nY+zETK8CNo0GlqEx1uBfwAT1MhH3899+cyQ
         fnqJs5qMwxPnj0tVkXnSqAADuzI/aTemgJaJJkK+utVvbUT46CPwEQIooZNGe6LgF0
         7mfdfd5stXg/O5HnVDsmz0q51+j1sXhjV7qVE7wgMl3Lfmvg1uogOVwW94LiEsE5tQ
         yOEMgSm/rfMhQ==
Received: by mail-ej1-f72.google.com with SMTP id gg1-20020a170906e281b029053d0856c4cdso1825275ejb.15
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQB6RRzmQQRlWh6S5blKR75hWps+lidsZcEbJz9OF3k=;
        b=Q+4tixXNm9sWtzEvdq9vH0LGamru0XRBzeZJ+I+2rYdRLG0r9KnC02v6mP2OEIp7U/
         POiES2si3dl2Zxu40iGSysu9RXuO5onvz8tdyRxQsFrFhOJbrEOfRg/S/61/jKEdKFkX
         IjK74CE+7CKL7X92Aw6S0RYeXZJXrPzUm8A+aV4U9Xb90g1N+Onm3NEcF7jyD7Jkr59/
         JWR9FgccNDGzbO0fNQ1g/uepHR3c3hPj6adhXibWgI1KyIOYmlqHSZCRLJHT5oH0vzFf
         JZ/5DMaZP7/GSfqv3wHo/9rE4DSa8HoLHgTX4zqrsTarkaVeatAUFP8OMpFWK2Xv5/hW
         p8rg==
X-Gm-Message-State: AOAM533IaoPNCoX9XSkhvBO5Il+Z9vVTRRNHj7n91ucpUem2r8btTk8r
        WE10qX+sXxttDtzee5d0GIssvgvwWD3IJPeZCYZdCjf/rKnumUY5y4JJ9kqdINSSZ7MwpmaTFKk
        mx9eZdiXiHsLD2YTiyYqWLenG9RJY1hR3SeRAlXTVZw==
X-Received: by 2002:a50:da0e:: with SMTP id z14mr5301145edj.73.1627555243689;
        Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwijoO/q/+k8GRTBBEBcEUFMonWljYAnQQgqcZHQasMq3+MlfMPzmN1xs3UX4P2zxHnMrP0CQ==
X-Received: by 2002:a50:da0e:: with SMTP id z14mr5301127edj.73.1627555243524;
        Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 08/12] nfc: fdp: use unsigned int as loop iterator
Date:   Thu, 29 Jul 2021 12:40:18 +0200
Message-Id: <20210729104022.47761-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop iterators are simple integers, no point to optimize the size and
use u8.  It only raises the question whether the variable is used in
some other context.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/fdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index 650a140bea46..3f5fba922c4d 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -611,7 +611,8 @@ static int fdp_nci_core_get_config_rsp_packet(struct nci_dev *ndev,
 	struct fdp_nci_info *info = nci_get_drvdata(ndev);
 	struct device *dev = &info->phy->i2c_dev->dev;
 	struct nci_core_get_config_rsp *rsp = (void *) skb->data;
-	u8 i, *p;
+	unsigned int i;
+	u8 *p;
 
 	if (rsp->status == NCI_STATUS_OK) {
 
-- 
2.27.0

