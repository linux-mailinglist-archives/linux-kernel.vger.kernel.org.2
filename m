Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89703E0A13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhHDVny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHDVnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:43:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4AAC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:43:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id e11-20020a05620a208bb02903b854c43335so2868383qka.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Pb12EbU06/c4uVcHA6PnZi5HH8DX1Z5yrhOe7RMfqqs=;
        b=rVcP18G61i62cfcA5J1OwAZ5xcfbbwinKlYYRIG0v+c+YMvnKA1w6xawMCCJV5CS7p
         4p053u+v5L+Kra5xP+9qUWJ64eL0hrUP9YqUh8UVdOVoTVcSKpiA6EnC5JYyw/pMzOBC
         YkP1Rb8ve0dLLAe/aUSEHKQX8Mv7dYWy8WQmD0Kc+C5wQs9uIXPhEUaAMGyY2bGq+bXw
         pqTZgC5QcokVFPC6/oyGnhyouTwHsWY+GZgPeMxB6PMQg4E9SWkyGGl0zpUA6KX5HwdG
         5BJuw8uEeN1nfmdZ1fbP6qYK9JIS4HAIh1Eopsg2YotgR84XuazpdacrfSoRFT5DJL6s
         8ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Pb12EbU06/c4uVcHA6PnZi5HH8DX1Z5yrhOe7RMfqqs=;
        b=F4lA++u+B0rKKSq+jv5tfgQJnOL0AIDIzQ5S++O7jWS5XwCoPZGP/qxHbP9HL3J0RU
         15ohB9o/Im2cDDlO7AV/dWhmWD/4Jb/JqdJNxB3Yr2pJMUsrNyi+rQIUsydm1MUaT9Y/
         ZyncArAZhjE2Xs+2x5ZpB05rU3i/ejuYM6Nwg+ejqx22TIBTy5eLY8m2I891GZBy+gcT
         g+9ZEa04PJiVQWFrBf+F8MCq0ErOpcQidkxmX+AJOucZyFpgHq3XRpFsZY+AWPlbjthq
         oYDTP575LGsD/C/p3EvL7KVefhaf0x3DGu1XkxhZtVrCa0T0kpJrnqET2zqguV4y7ExA
         RAbw==
X-Gm-Message-State: AOAM532+QQYqS5hfswappV6O6SaoFbUYGBmWaBep6JMX/uxCMQKaM39w
        F0t+7VLIjpAolkvP+9Jbjr3pmDpiy1hlg04=
X-Google-Smtp-Source: ABdhPJzUCDviw5bxbZkssyN3i3ZDHllO0p7OWjzr8ahlGNY9GwvlB5r2sJCY3z0O2HCPTEmzAeDT2H2e23bk8q8=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ffe5:1245:526e:3189])
 (user=saravanak job=sendgmr) by 2002:a0c:f807:: with SMTP id
 r7mr1741921qvn.14.1628113418097; Wed, 04 Aug 2021 14:43:38 -0700 (PDT)
Date:   Wed,  4 Aug 2021 14:43:29 -0700
Message-Id: <20210804214333.927985-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v1 0/3] Clean up and fix error handling in mdio_mux_init()
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

This patch series was started due to -EPROBE_DEFER not being handled
correctly in mdio_mux_init() and causing issues [1]. While at it, I also
did some more error handling fixes and clean ups. The -EPROBE_DEFER fix is
the last patch.

Ideally, in the last patch we'd treat any error similar to -EPROBE_DEFER
but I'm not sure if it'll break any board/platforms where some child
mdiobus never successfully registers. If we treated all errors similar to
-EPROBE_DEFER, then none of the child mdiobus will work and that might be a
regression. If people are sure this is not a real case, then I can fix up
the last patch to always fail the entire mdio-mux init if any of the child
mdiobus registration fails.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
[1] - https://lore.kernel.org/lkml/CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com/#t

Saravana Kannan (3):
  net: mdio-mux: Delete unnecessary devm_kfree
  net: mdio-mux: Don't ignore memory allocation errors
  net: mdio-mux: Handle -EPROBE_DEFER correctly

 drivers/net/mdio/mdio-mux.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

