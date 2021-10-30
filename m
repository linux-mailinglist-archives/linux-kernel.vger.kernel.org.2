Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F29440704
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhJ3C7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 22:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhJ3C7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 22:59:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 19:57:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so8614371pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 19:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhCHvaKbTCMh07wP4MgsfXhejEg0lMRt+cVvfPVOPP0=;
        b=cf6UOmqfTKKO6qIEeeizkq6GiA6CTT4PK4/+0doIF977/32qb1DWKD15jTkcvHDRTi
         WORJkKTU+R0BfyrAHXufn1A11bEGqdBe4uwFzlIxgFAb5DW0/Otbp2qKxSiYwwiftPuS
         63gyS5hqLAQq9vv3KWrpIL4atYCbYtkeiILfK/ty1Vq0PL/I74sfDPtnWc2aY8MHt78F
         aLf2sx1HFyqudaSrk8FpAXaOImCZ9kYNWyEm4ZJ2t314/Sk7qTPc/I7qrC+ECcnoQE8T
         oHgP5YYHBmuFqc6WAl8FiJ2bvdqk4wpnJMzSjBGf/TLkNyx7l5GSd8KV8UmoFyn+gTrC
         CFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhCHvaKbTCMh07wP4MgsfXhejEg0lMRt+cVvfPVOPP0=;
        b=bVg1cnYnqFc8B8vc/DZ0vOQYbrTAOwUkOrOSgfQCD/Ci2+z0tafyPY49ORL3mE1uJU
         UVHrYrf6lK9BSjZ9NBsEt0muscGXOyosYAnU3Qi8QNce4PYyurhCDOrL7K10jqrsWxKF
         8+0KpD87z29ryTysAiU+kGCIOyBkaZz7i8qsVX8E67Oie+PM9KGbnLBZdS//NL0LgN+v
         4B321P4TpF+SYMpynp8WiR64DfIkloH2QpYW+3Brle48zudbfw9l+lwO5GS9Qv2k3GFA
         Re1UMzf9W+84/CRZDiKFnmfMO6ktmZic3zKPjTMDqlaoTHgJO7z8BRab37oEuyrr4mLj
         CfdA==
X-Gm-Message-State: AOAM531Y8IudQhL0IIn8aYU/jmEuXvlNzdef651uhy6k6OCpkE+/RTq4
        rpc7ydFwaZOqBBeB6GuN4MI=
X-Google-Smtp-Source: ABdhPJzVDCuT6hBMcz1G+6pdzp/m3Wi5Augz7HXZRKSvoCyrpsO6iethyvkOPBBMc3qwi052Lf7q8g==
X-Received: by 2002:a17:90a:ff81:: with SMTP id hf1mr14206632pjb.157.1635562645271;
        Fri, 29 Oct 2021 19:57:25 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id mr2sm6097749pjb.25.2021.10.29.19.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 19:57:24 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable Broadcom STB USB drivers
Date:   Fri, 29 Oct 2021 19:57:14 -0700
Message-Id: <20211030025715.13296-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_PHY_USB_BRCM (USB PHY driver) and CONFIG_USB_BRCMSTB which
allows us to enable the Broadcom STB USB drivers (OHCI, EHCI and XHCI).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 33572998dbbe..ae891e3e6a1a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -287,6 +287,7 @@ CONFIG_MICREL_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_USB_BRCMSTB=m
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_RTL8152=m
 CONFIG_USB_LAN78XX=m
@@ -1105,6 +1106,7 @@ CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_BERLIN_USB=y
+CONFIG_PHY_BRCM_USB=m
 CONFIG_PHY_MMP3_USB=m
 CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_QCOM_APQ8064_SATA=m
-- 
2.25.1

