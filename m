Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658BC440705
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 04:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhJ3C76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 22:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhJ3C75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 22:59:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8FC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 19:57:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f8so7993043plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRZRUWkhWxUsoJi+TfDhQOO+QR6RREWrvwlDvSDfAp4=;
        b=lxcJ+cbNp11RJOx6wKzLlsjsUUS0H2Vma5AtlB/wNaxoD6ICA+CRiF0VZ19IHOpr6r
         fEDJQASoGp2n8CHc4lbZt7YjW6Tyd+giZzvh+o1A5cPlz9j1HX+f8e0mWjyq5/tQIMJM
         USkTEPp2yXHy8hogUGYqo8Lb+FRdIavxHfTYvsofvwOmNennVqmI2YgEqM/w1Hkw29cC
         sxgXl44ybL2R2YjoIOfNOZbOOnRi/XtvyAJgC7w+bMhTlqz/kVGzIkmC9u+mcfjVV4n/
         Y7MajMi0IYM99jY4Ibh4RLnpGq95Q/6NmJ/Aa9IMV6XN1TuYWjvqxqLQvzMXr4Ph43uC
         ZuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRZRUWkhWxUsoJi+TfDhQOO+QR6RREWrvwlDvSDfAp4=;
        b=7QrDEpIz+HCpfVS1SWxpn/UYEcWRSDhfBuOb7UHZzxDG/w4p+7KyoRgsGJCkxucI5P
         Jlxh8y6bdWsxfOti3vTroGmXu3IMKQQmaXrKAJOT3GT6qpN6Xy/1AWojbtWQkmHnlj7u
         cEFVVpftEhUcKOh9gFcYVn4HmqvNuq+yTAHzXSketXhLDv7/7CoV2Qw9ccGxul6TClw3
         DfFiZ2td2npW24DnVstpMaJXwHn6pB4NAaD4x4xJO5fX0bQINS2SZV2p2Kuh86wHg/VF
         KZoVlZ8jTz8vZhdIubuf0Y52cWLS7jtAMny/vMTSofbtixWAd0MSo/vXTvf0lZwDnRoz
         7QKg==
X-Gm-Message-State: AOAM533bzdt0wjqjdZ0/NmfefIMGbjZfeSrYmWDB1QRynjyGHWDOZooR
        KFo0MYWUo2GhCsGm5K/yW29dfki24WQ=
X-Google-Smtp-Source: ABdhPJzj+RwzbGkQOGcfWDt01KBz5Z3HOhJfycdGXK2OJEqMC4V8mJPZi3KBcsglFKLBxbjL0+g8Qw==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr15408997pjb.51.1635562647586;
        Fri, 29 Oct 2021 19:57:27 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id mr2sm6097749pjb.25.2021.10.29.19.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 19:57:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable BCM23550 and BCM53573
Date:   Fri, 29 Oct 2021 19:57:15 -0700
Message-Id: <20211030025715.13296-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211030025715.13296-1-f.fainelli@gmail.com>
References: <20211030025715.13296-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the BCM23550 and BCM53573 SoCs to have all of the ARM 32-bit SoCs
enabled.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ae891e3e6a1a..91f21725503a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -24,7 +24,9 @@ CONFIG_ARCH_BCM_NSP=y
 CONFIG_ARCH_BCM_5301X=y
 CONFIG_ARCH_BCM_281XX=y
 CONFIG_ARCH_BCM_21664=y
+CONFIG_ARCH_BCM_23550=y
 CONFIG_ARCH_BCM2835=y
+CONFIG_ARCH_BCM_53573=y
 CONFIG_ARCH_BCM_63XX=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
-- 
2.25.1

