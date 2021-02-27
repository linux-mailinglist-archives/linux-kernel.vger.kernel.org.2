Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB562326F26
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhB0WXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhB0WXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:23:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73203C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:10 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id e7so19443299lft.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mksrx6ET/Hi3zXR5ldh0btRvfU1cL3yeWq6vtOUAmxQ=;
        b=R+p9IfoeRbrkWOMrjUbmqPZI2Gks/lZnqT3xU5U/JOiUgMbBpj3P5DA/p1TYEmIs9Z
         G8hT78Oj9nzgSG68YfnOjVRqs0AFo0xL30oVaQQVM7F3+TMvApD1Rhaybz2bcfkOfjnT
         oXpBb4fsxB5rUnxBPKf57QuHFS48k1E6dHhhNEjuJTjnAc59MU/Zlbzdd0KetAirSbpl
         XePT5V5jQgi8b/0n41hXwWNwzIi2fLjyEJPbz2WOM/EO3rEJHH3vOHqsGyqJRcRUdF2Z
         RoHasZSU6CLilx/cO217rLMY8FjoiwQhRReKrIIPsgLSy0BZKqo8wDqGhO89umUPQ71L
         CDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mksrx6ET/Hi3zXR5ldh0btRvfU1cL3yeWq6vtOUAmxQ=;
        b=GumdtCmRGbBP4oM543vdX4op1n9iyPWiFAc7ISePB3CiJQFLvWbs51IMtl/klIXZqN
         ZZulFa4SGqAUIrrZg8l8opsFhgSH7GGT/4gDT5jP46q3xUSa6UpLcYXyz4wmELjw9RWc
         zTQOhIz/5a39YS0DKaPhkwTLbVasLO1sgc1sDE9A3tpP6sZY1UU+r2l0aGJKGAcz2Y40
         1H0hV4Vw9+DS3M3G9dlcP5QyyGN70pOlGc5Na/GnLQVeqfhPNFJZSkuojPvCrECJMAnv
         0mLPPynf6rHpQptizYcRQrlBk0gcEz9N/oI94pd27+YKzqQcrE85yn3k3HZcy5v2RVkN
         Hhpw==
X-Gm-Message-State: AOAM5336FOvTjVAF6lM+frCJMRXyh3NayjF7lyEkRgKFcMUNN68dHr0t
        OGZLjI+33aC+PbuBTM3Z8GQ=
X-Google-Smtp-Source: ABdhPJwocTf3bMMm/ErWN5uaeWhJ9aOlcfwhnkZL/WKpZo9hZIsoaD+BKCZ0jP0QdTgGwRZ0a6FfVw==
X-Received: by 2002:a19:c74d:: with SMTP id x74mr4805280lff.223.1614464587761;
        Sat, 27 Feb 2021 14:23:07 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id 194sm765210lfd.116.2021.02.27.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:23:07 -0800 (PST)
Received: (nullmailer pid 581541 invoked by uid 1000);
        Sat, 27 Feb 2021 22:23:06 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 0/4] staging:rtl8712: avoid unnecessary definitions in wifi.h
Date:   Sun, 28 Feb 2021 01:22:33 +0300
Message-Id: <20210227222236.581490-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wifi.h contains unnecessary definitions. Some of them are not used
at all, some can be replaced with native definitions. 

Ivan Safonov (4):
  staging:rtl8712: replace get_(d|s)a with ieee80211_get_(D|S)A
  staging:rtl8712: remove unused definitions from wifi.h
  staging:rtl8712: use IEEE80211_FCTL_* kernel definitions
  staging:rtl8712: replace cap_* definitions with native kernel
    WLAN_CAPABILITY_*

 drivers/staging/rtl8712/ieee80211.c    |   6 +-
 drivers/staging/rtl8712/rtl871x_recv.c |   4 +-
 drivers/staging/rtl8712/wifi.h         | 178 +++----------------------
 3 files changed, 27 insertions(+), 161 deletions(-)

-- 
2.26.2

