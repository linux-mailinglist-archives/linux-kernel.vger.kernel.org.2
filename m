Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7473EF16C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhHQSJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhHQSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:09:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A6C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:08:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c63-20020a25e5420000b0290580b26e708aso21106740ybh.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kSH45SZMveG0CaWqBoMxwQKpfpniEhXxIOVkDYEW2gs=;
        b=etBTrfpzbs3cCZzDaZKPfBXIEycjxSXscCauYc6AWlisF9NEhS8ywPiPwTY/Wtj71Z
         mlPHKTapnrEoFTaKGh1QJEXGlBuHZchvm/cDjtVpnGJlY4UPdFgBGeMIXvnyvEiB3hRL
         b+keVDqVAz4Li0cYWHnFXicwcp13C8RMgw9c7Tcbe4/22AeafI/xWgVcoT+x81IAqy13
         uwk6adK35YZVmXB7bbz+Wa2Vvk6+kFDIi1yFhCC3IuXeY0LOvtUlZL85J9SKxs8+juNa
         I/u7zRb3xSzn3J5LZUMJM8ZLRh6Bdl3tMCdepXJQ2NBrkquYBrm2rCvMJr/3nxAW6QMi
         AyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kSH45SZMveG0CaWqBoMxwQKpfpniEhXxIOVkDYEW2gs=;
        b=sijkFsclrHdjERpe6QU2CavKgBiO/iZWo+Tvv/927IkKd+kOB6OdlPg93IIU02F/7K
         ObkjQt/nnxqXJpkTW4aQTXp8+PNoxRkeDC8nYysEnXCg3zjx+TM9QXrCUggX+OsazxnM
         v5pMwEqv9Z4mOtk+sD6PW4Nd6YxF0gSxGAkILnXhokhlJxp9JteftOj0k2gKSrB4sHP7
         URJ3wtInIevau1Ysj24dQEjCTFnIGqvwYxIxpM+XukABqCPWYht1eAn34FSu4aqsaq9r
         Sh6DhR+2Yec2m+HlORclrj2T5Ka9+FVUdwEJG7Ji1JtG0oIxMcfF41QC+iomPTqof5yr
         3ksg==
X-Gm-Message-State: AOAM531FNZk8FAhM8ytA8J7QqvxWKrMeiidiInkJtwOSL5DblK3JwKcz
        rmfNa6/UNWywCfTjvn21Q8AP18BNRkpjm2c=
X-Google-Smtp-Source: ABdhPJx7kwc2yf1NBmOlwG/p8RdAt1gPoF/4QEpryZEEDFOG4+07JBD9gcC3N93m0NSyNthhw2Af3wW+rR1Ihgg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7750:a56d:5272:72cb])
 (user=saravanak job=sendgmr) by 2002:a25:b948:: with SMTP id
 s8mr5947207ybm.281.1629223727760; Tue, 17 Aug 2021 11:08:47 -0700 (PDT)
Date:   Tue, 17 Aug 2021 11:08:39 -0700
In-Reply-To: <20210817180841.3210484-1-saravanak@google.com>
Message-Id: <20210817180841.3210484-2-saravanak@google.com>
Mime-Version: 1.0
References: <20210817180841.3210484-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH net v2 1/3] net: mdio-mux: Delete unnecessary devm_kfree
From:   Saravana Kannan <saravanak@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole point of devm_* APIs is that you don't have to undo them if you
are returning an error that's going to get propagated out of a probe()
function. So delete unnecessary devm_kfree() call in the error return path.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/net/mdio/mdio-mux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index 110e4ee85785..5b37284f54d6 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -181,7 +181,6 @@ int mdio_mux_init(struct device *dev,
 	}
 
 	dev_err(dev, "Error: No acceptable child buses found\n");
-	devm_kfree(dev, pb);
 err_pb_kz:
 	put_device(&parent_bus->dev);
 err_parent_bus:
-- 
2.33.0.rc1.237.g0d66db33f3-goog

