Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1F340719C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhIJTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhIJTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:04:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7CC061574;
        Fri, 10 Sep 2021 12:03:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b6so3996518wrh.10;
        Fri, 10 Sep 2021 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSna1bEaXtn8m7SSEUg3SHS/YUvgM9x34Z5EWR+22QI=;
        b=qdMQkcOMFEYeenP2UwasQiTiy8VmD3c1HUKLM7J/cUCaTaFWDnvpt4zhxpntp5S2q7
         0sbagO37+h8fm9IeszfwDuMPGFYP/f7YRhVZIS2zsOjMikNBQd39+BSuuZFc62FsI0Dn
         wO8Pcx+LP+rxvioAT1jQtJq4btd9DAn4qplze1MFOxwUf8uDgvHPO5UlvGjZhWsM725w
         ZLktSyr++t066WlY7KH3O6xY27k36rJd7WYn7VOhSRkwbVt44lgv0utKk2wDnMu1LSrm
         AEe4A/sixVEl97WNl6K2fXVfSwa/mcAlhEm5EaA24K5Ec8K6ARViHgt8NXjAdkvxof4A
         DRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSna1bEaXtn8m7SSEUg3SHS/YUvgM9x34Z5EWR+22QI=;
        b=u70OFBEOdjpqhklHTjfiIHLVf46ylAfR1YKnNI2ngSqUKlq1tar5qUXzCzKoqTz+/6
         b9qT11fpXbatcqSr4k1EQcU91yDLgezAo605EeIvR0S0g5/LBXmw7DDipC7vl31N7i7a
         jbL7zg0NeAdXs65qCSeNkdm3eZl+goqYCyak5kN5Abl/g0iwdRfcXy22xN4uhUhozY7r
         rQPd90Wka+foxtlTknHE2xgWii1aIcWVn5UHNngFrpcqgcO+gRXGs5Kc1IaE9TZz8SUj
         pdBKqdjpqWj7LJiS4rOyZr62vHmb1PEWd8huqucFspqUSyeW6/P7o2R2PmyLUShG+WIB
         RiTA==
X-Gm-Message-State: AOAM530dfJqdmN+JOsJJgD7sWMyHAzzS5YFp/eGJOn+owyBR2qzG2aQx
        zz0iTPG0dbomKSLZxpTl1D1WESmVEQ0=
X-Google-Smtp-Source: ABdhPJz5rIXeHcTGNtG6rhjzryeNOoNfS/iDrkj3d5W/OlUnPzP2McfiAHb+seXjC26tv5NXeJ67Uw==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr11508236wrv.219.1631300623991;
        Fri, 10 Sep 2021 12:03:43 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id h18sm5547228wrb.33.2021.09.10.12.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:03:43 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: mstar: Mark timer with arm,cpu-registers-not-fw-configured
Date:   Fri, 10 Sep 2021 21:03:19 +0200
Message-Id: <20210910190322.27058-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910190322.27058-1-romain.perier@gmail.com>
References: <20210910190322.27058-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor u-boot does not configure the arch timer correctly on
MStar, let Linux do it.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 2273295e140f..982dba9d28eb 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -39,6 +39,7 @@ arch_timer {
 		 * u-boot is broken
 		 */
 		clock-frequency = <6000000>;
+		arm,cpu-registers-not-fw-configured;
 	};
 
 	pmu: pmu {
-- 
2.33.0

