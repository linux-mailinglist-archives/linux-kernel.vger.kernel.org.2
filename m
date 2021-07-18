Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9157C3CC731
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 03:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhGRByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 21:54:16 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38593 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhGRByN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 21:54:13 -0400
Received: by mail-pf1-f180.google.com with SMTP id i14so882964pfd.5;
        Sat, 17 Jul 2021 18:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o06ssx91GTtHRONE1cdsYw3UDhFvrKEaTUOFNaT/QnA=;
        b=gN4W9lkxYpHeSi93GHkQYPeoisYknxjGuGzbqi7HcPK+LgeEtb04xNLoRo36N7jBfE
         0kgZ3h8V+AdzUd4tKEpR4pnJi4oLMcFor0NtPVc2KN/TEw/AOmioOiOTiHV54xy1JKu6
         bZ6LM0ztAd3143KuJ1BEglNB2RLbA9xNoM1SYXsv6uozMivyydvkCjPgd3JdgV1MppU2
         A3MgJJTP4x4gdx29+0E3Z10njZiiLi+3//bnRO3OZxpOykw+zSB4LfemQxIYqRVgUjcG
         tj08wDyTFdK8MRANfwaj8AlrxDUB8bL0bRJMlA8Ud/MxXxvMV3ETbcNk1LQicmANl2ZS
         G1Cw==
X-Gm-Message-State: AOAM531B4fEJfNJN4xWlFunioDzjnpQyb4wxEEHNlcJTYnOUUVBe/GPk
        6qT5UNDjuSB8irg2gbgyUO7dzfeWUcA=
X-Google-Smtp-Source: ABdhPJx+Wq3Cgu2wXGZbZqBol0/gKpzouK1wZzqlU9X7BSowIeBzurDfahVwBp33k8QhYJI8rivuvA==
X-Received: by 2002:aa7:8ec5:0:b029:33b:7b34:9cba with SMTP id b5-20020aa78ec50000b029033b7b349cbamr5701256pfr.35.1626573075239;
        Sat, 17 Jul 2021 18:51:15 -0700 (PDT)
Received: from localhost ([24.4.24.239])
        by smtp.gmail.com with ESMTPSA id 78sm6294440pfw.189.2021.07.17.18.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 18:51:14 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, moritzf@google.com,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        Moritz Fischer <mdf@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/2] usb: xhci-renesas: Minor coding style cleanup
Date:   Sat, 17 Jul 2021 18:51:10 -0700
Message-Id: <20210718015111.389719-2-mdf@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210718015111.389719-1-mdf@kernel.org>
References: <20210718015111.389719-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change an explicit err == 0 to !err. No functional change.

Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/usb/host/xhci-pci-renesas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 1da647961c25..327f6a6d5672 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -595,7 +595,7 @@ int renesas_xhci_check_request_fw(struct pci_dev *pdev,
 
 	err = renesas_fw_check_running(pdev);
 	/* Continue ahead, if the firmware is already running. */
-	if (err == 0)
+	if (!err)
 		return 0;
 
 	if (err != 1)
-- 
2.32.0

