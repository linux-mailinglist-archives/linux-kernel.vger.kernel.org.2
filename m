Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11733F834B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhHZHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbhHZHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:46:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:45:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q13-20020a25820d000000b0059a84a55d89so2220625ybk.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wKFLqTVWaVrcQULKv1jqscU7IEOt0JC1OsA098B/mg8=;
        b=MgrRFJDm1nANvlgHSds/Pe4ZKKgMbmjPSzIetJqnyx7l4IeGw8CA8DOJ1MkwJ8Q1fr
         rE471tV2WG8jVbXtNw/o04Ax9QjwrccP2Fx1QJGGRniwORpBUYKnm0DYKNaM7Pv0rgEu
         BIQ4qLSmEknUPOFvBYuEixlESUUhGJTgXWLMmBh++7p036Y8qDdClF1Y/q5y/94SHgfX
         0xcEEN3qr0fgB2SI/iWRtkxX1ViId6077Ue1NyGKx+RkfhRI+J1Llh/dJBzoYLaKjUy5
         BFsRmQW+ev1BGTyj8BOxilty2S1Vz1mB/WDJjsct4nEQrrTCTYJquK/sb7ve2o0WBa0s
         sbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wKFLqTVWaVrcQULKv1jqscU7IEOt0JC1OsA098B/mg8=;
        b=k5vIxVsMlmPNv32MjBDihulpIVqAh5P19ssyaLtkTOTTLfNmsrjn+l6j/sRHV48dBa
         1zbgAiu7AhNZ5FYdwT//BFiDEeDOrMY0QV3DTsH636V0HX+8ACyiG2opyh4Dz3vsWp4V
         QXLK793m443CHyD7BcxZhwfPta+PCZ/gb3BOPUV9uh5sIIhAYh/Lrkp5dve6WM0tYT1m
         j+VOhY+jy/rY6H1KlAvqBiWQLzamVoBk1CFt8lijLu5dGRbe0ZXQA+dC2tBpdp2ciNTR
         jg6chnRf9dyjaiyb6WCnptrl1A5hm6n2oY5EP4Zpb5rW640yGopmVLHEWalVICQM1dwH
         TCBw==
X-Gm-Message-State: AOAM530G/iM/usX6DkddunKo4bZMsiLlfaWpZzOkbRiJmcWEatxpxCyP
        eCqBIb4PHgMgzYnZlwKmzaqrQdpQAsgF1N0=
X-Google-Smtp-Source: ABdhPJxz+g0Ic2ZhjBouHVwCw2zCtQ4XGrAuR6D8xhyLLvtQM7hmYzuuUc4xpmTTTvSNqfkXQX93y+AA1vZL1lg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:5b7b:56e7:63bf:9b3c])
 (user=saravanak job=sendgmr) by 2002:a25:1056:: with SMTP id
 83mr3551029ybq.52.1629963929742; Thu, 26 Aug 2021 00:45:29 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:45:23 -0700
Message-Id: <20210826074526.825517-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v1 0/2] Fix rtl8366rb issues with fw_devlink=on
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I consider Patch 2/2 to be a temporary fix that restores functionality
while a proper fix of the driver is figured out.

Alvin,

Can you test this out? Also, sorry to drop the accents in your name.
git-send-email was being weird about it.

Thanks,
Saravana
Cc: Alvin Sipraga <ALSI@bang-olufsen.dk>

Saravana Kannan (2):
  driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
  net: dsa: rtl8366rb: Quick fix to work with fw_devlink=on

 drivers/base/core.c                | 22 ++++++++++++++++++++++
 drivers/net/dsa/realtek-smi-core.c |  7 +++++++
 include/linux/fwnode.h             |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.33.0.rc2.250.ged5fa647cd-goog

