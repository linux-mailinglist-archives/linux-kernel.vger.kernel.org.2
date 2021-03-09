Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2C331C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 02:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCIBWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 20:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCIBWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 20:22:13 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2CBC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 17:22:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m11so18522855lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 17:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=u72o1/hVsLzd4qHsvaFn3xtZxvDhEZWMFBnIIAXY3PE=;
        b=KAYnSojp13AUBi8npUZKXjWi3sakeQk4nSGke+MRxXW9yU4r7g5sZwgCgMb57esmt+
         y65/hK+vlDiPyQwsLuSNAfYfTW1nm7mDcnB+rW4voTl79f4uNKboBLcnzjpyNuptlec7
         90gm7x5WrqAbUj5U9wJaM78WtBWHDX1OJUV7pp8Mo/X16ny1liHgqgxov9E9UjgPiIzP
         9cZJdUR66DPmTsrczS/yRpfNphberQZyN3snXUpTTjmo96jW+Du6Ju2MoGI6VfGqdveu
         amJQsDo+Ar08IlCPO545NRRfhUmwANell1NXKZBI06ZoJGowKBKv84QeGqtiPjNI2e2e
         sr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u72o1/hVsLzd4qHsvaFn3xtZxvDhEZWMFBnIIAXY3PE=;
        b=McCe5eRNHDK+V0J6VHb5oF7ftskEe+6Sxy4HuhJ4iU2ng0AZ4FWNi4se7w95MV4oJO
         lzHvZmmJDyo/xOMUYtQdnzrJu3r8+b4gCB7S0KW2z+APzTz+XRNel0jGXWr9sRsIfjhP
         H62xuD8SIRwZdlI5/+BypG1Ntu7OmE5chyuoZRsCjucEUfZwsZiDM1tJYNJPW4vP/KCL
         tC4cx9eUQAgakYBMbbKiTWvE6QMbUZZ5ila+y9ifqWT++jUBXTkgSPejqtu1oe2Kk93w
         Ci6etxUlqz8/mkZMGnbq+8caqhV+yAKwQ9qLLOqVgPV+ELyQnp9MYzr3xf5pU6q29L1E
         Wpkg==
X-Gm-Message-State: AOAM530YdPIyNTYcl4SCmgfNKGNav2mmTJC16HhU+Y0W3Pq1UTnrU6Mn
        5w2sM+XSBt2GULYEB0t/y+0nVA==
X-Google-Smtp-Source: ABdhPJy2BXo+Pt/hZX3NuUDcSGuVoIYkjZKlJOv2K14Kcco8BLlu2vrSOzG5LpPQBMwXtVPvvE9BKA==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr15201430ljg.357.1615252920919;
        Mon, 08 Mar 2021 17:22:00 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.gmail.com with ESMTPSA id o11sm1538395lfu.157.2021.03.08.17.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 17:22:00 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] sun8i: r40: second ethernet support
Date:   Tue,  9 Mar 2021 04:21:14 +0300
Message-Id: <20210309012116.2944-1-boger@wirenboard.com>
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

Tested on custom A40i board with two IP101GRI PHYs in MII mode.

Changes in v2:
 - EMAC reset is no longer optional on R40
 - Add a new DT compatible string for R40 EMAC
 - Deassert reset line before enabling the clock
 - minor fixes: formatting, DT node order, leftover pinctrl props


Evgeny Boger (2):
  net: allwinner: reset control support
  dts: r40: add second ethernet support

 .../net/allwinner,sun4i-a10-emac.yaml         | 11 +++-
 arch/arm/boot/dts/sun8i-r40.dtsi              | 59 +++++++++++++++++
 drivers/net/ethernet/allwinner/sun4i-emac.c   | 65 +++++++++++++++++--
 3 files changed, 129 insertions(+), 6 deletions(-)

-- 
2.17.1

