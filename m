Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4332FE86
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 04:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCGDOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 22:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCGDOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 22:14:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B1C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 19:14:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q25so13535973lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 19:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6TB9PYEq3zeYLZKg5D+xCq8Y8gZgxb5+A3yPQ8nEc80=;
        b=Oi0z0SklDqrXcqlHBRHFrkXflYidmA96ce3L8SnewtmlNvJg/wASaoAA9B+EagEKXS
         5RlkBpc6HdUMSo5tB8SslAPx/Li9Q2LZFyAVHrSanS3nCqzbGkBes206RRB+px0VbD0e
         2bWc9ZyZlPjWupQw8vCUjT+0IbbD9iG5Tm2egHzQlifVITQbeUGenUGXgqpoOU9yCbdK
         3IiriSqrl/1Tc5GUDEX9EqQlp7sNKM6FGzbS5yCzxABnhOs+6YhKKGgzPEnZzyxXJKN3
         gItKg3zhfDFbVoVbOd9r+4YyuLYl9h1g26hcVFmI8dajpFYPPNhu5vF50bx+Rye4dJ0N
         pFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6TB9PYEq3zeYLZKg5D+xCq8Y8gZgxb5+A3yPQ8nEc80=;
        b=IQ8Grw22cl9ystPLmMslVeZ9xB4YvxkZxH1x2dkPtrp/vNAMiat4vUO3AIuosVAogO
         36gCAink2LN6aconPn0rsCck5GUGc0ePomq43AEs7x/6v7cuPaNhMR/UrfbMMOwEswiu
         mO3Yf3o1KRfbqUYn1IuOp9myb/virMzTQKrYdVyMOEWosJ0kAF+sPi7wZU3qTg6KfjMo
         3vrGLO+ldhtkuPaZGa42Zjl4GNa3m+0iT+OH1w8UqiL0Z7yxd9QSqZ6bb7K4DZQBciPU
         eG0HEr3Unr0A086V4ZY9LhZwAoQyWbNWh4h1Wzv1dYjiZKTixE3iaOOOFLKD6hh4WyDP
         39rw==
X-Gm-Message-State: AOAM531k3j+/ctwA7FinHnBuYWkT4cXyzjv2R1LbITFzi8CfixLFORBl
        P6cDa+QzEBcap+M6c/pLC3hbgg==
X-Google-Smtp-Source: ABdhPJwshrSBMjXUj3KQqRSF3VJ1Pfnh6bzsJj1UEisjKErvLIovUsoRaMDy2gFLfKgxvg8y3fAGXg==
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr10074997lfu.112.1615086848587;
        Sat, 06 Mar 2021 19:14:08 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.gmail.com with ESMTPSA id u16sm847582lff.169.2021.03.06.19.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 19:14:07 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/2] sun8i: r40: second ethernet support
Date:   Sun,  7 Mar 2021 06:13:50 +0300
Message-Id: <20210307031353.12643-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series adds support for two Ethernet ports on Allwinner R40.

R40 (aka V40,A40i,T3) has two different Ethernet IPs called EMAC and GMAC.
EMAC only support 10/100 Mbit in MII mode, while GMAC support both 10/100
(MII) and 10/100/1000 (RGMII).

In contrast to A10/A20 where GMAC and EMAC share the same pins making EMAC
somewhat pointless, on R40 EMAC can be routed to port H.
Both EMAC (on port H) and GMAC (on port A) can be then enabled at the same 
time, allowing for two ethernet ports.


Evgeny Boger (2):
  net: allwinner: reset control support
  dts: r40: add second ethernet support

 arch/arm/boot/dts/sun8i-r40.dtsi            | 53 +++++++++++++++++++++
 drivers/net/ethernet/allwinner/sun4i-emac.c | 21 +++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

-- 
2.17.1

