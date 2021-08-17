Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE03EF170
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhHQSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhHQSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:09:27 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B589C0613A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:08:53 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w19-20020ac87e930000b029025a2609eb04so11503975qtj.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D43/Ik0ZmeC2KyL3MoNeHEy/ITGcx5BeAMWxIqGpsKc=;
        b=KEZdX/0iZbepsW68H82kx3/2by5MhIJd17wC2teBdmixZjuUy/hsk6bvqa5UaB8RzR
         YcIt1kFEwpuR8dVnqRTsKYegEEgWzBDxQqB3udzDl3A6DpxZcuHzOCMRDeaJWPt98Hc3
         x2v9gLSab7WqUENthjjzD7JH9n6Maqhl5QItfOltkmZq4mI4HRl94FyyNiZHHy3yHsvD
         JpCq/jjvnlBjLX+dSeAWvhcIeN9AA9RtUFYsAwvKQ62CPvddEuXOttgKEnnVMao6MCSo
         wY0GewoxzsqKB7hR/c5Zzxp5iOit4kBWDxJrxfgZNlEwjaheiTA4tgDyBDVRQ4vAKGPl
         xyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D43/Ik0ZmeC2KyL3MoNeHEy/ITGcx5BeAMWxIqGpsKc=;
        b=qr4nAfDRitRuXEd+JmLbmjqG9OmxZLngU1haVUe+kDEQOw+5r8inXExBGGZR1dL9vp
         sv6vbZh1kPonESwub3SDgWqhmHzNFaXwacFpIMhYrZUN4HIdxFlsLwF/LZxwwNigTs0v
         7tKb5mkPQ3MxEdBX98A6lQkSFU3Vhjuqndt6bRWQ8OscsqytF/jtrL4rcFxDNrpRVrXt
         +wp9d14SSRCx1EWl9rlohAIlgwjaZFaGcpDEeDw0aq+xm9Mrwva+oZF1WeVlT/w59wmV
         AsiChVsTfGug3/xM86Kuc5EmE4u4TBplW7mr3/ZiNePh59q3YQXuZ8p/dicyGUGjj/K1
         zmiQ==
X-Gm-Message-State: AOAM532vAeNGfMfthcFKUGP+luwfsVxA1pH4OBzSs249EBoVrarWzVLO
        KTzlZeJT6V2ueVQncac1XAKx9Fwq9XuIRAQ=
X-Google-Smtp-Source: ABdhPJzxK4tKOsKXmKq5tOjL/M2oVEZjC183UfLFYmDlQrxG7xgiGY7cFJGcvVq3rDvg/gLR8gKYI7rNVpCjnFY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7750:a56d:5272:72cb])
 (user=saravanak job=sendgmr) by 2002:a05:6214:923:: with SMTP id
 dk3mr4650090qvb.38.1629223732811; Tue, 17 Aug 2021 11:08:52 -0700 (PDT)
Date:   Tue, 17 Aug 2021 11:08:41 -0700
In-Reply-To: <20210817180841.3210484-1-saravanak@google.com>
Message-Id: <20210817180841.3210484-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210817180841.3210484-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH net v2 3/3] net: mdio-mux: Handle -EPROBE_DEFER correctly
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

When registering mdiobus children, if we get an -EPROBE_DEFER, we shouldn't
ignore it and continue registering the rest of the mdiobus children. This
would permanently prevent the deferring child mdiobus from working instead
of reattempting it in the future. So, if a child mdiobus needs to be
reattempted in the future, defer the entire mdio-mux initialization.

This fixes the issue where PHYs sitting under the mdio-mux aren't
initialized correctly if the PHY's interrupt controller is not yet ready
when the mdio-mux is being probed. Additional context in the link below.

Link: https://lore.kernel.org/lkml/CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com/#t
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/net/mdio/mdio-mux.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index 13035e2685c4..ebd001f0eece 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -175,11 +175,15 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus->write = mdio_mux_write;
 		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
 		if (r) {
+			mdiobus_free(cb->mii_bus);
+			if (r == -EPROBE_DEFER) {
+				ret_val = r;
+				goto err_loop;
+			}
+			devm_kfree(dev, cb);
 			dev_err(dev,
 				"Error: Failed to register MDIO bus for child %pOF\n",
 				child_bus_node);
-			mdiobus_free(cb->mii_bus);
-			devm_kfree(dev, cb);
 		} else {
 			cb->next = pb->children;
 			pb->children = cb;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

