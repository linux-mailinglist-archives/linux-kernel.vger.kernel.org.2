Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA034D49C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhC2QNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhC2QNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:13:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AEEC061756;
        Mon, 29 Mar 2021 09:13:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso6964263wmi.0;
        Mon, 29 Mar 2021 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZUjAxwgBomEWDOBGCx7CFg3YXNAPChJPs3ok09Sv8I=;
        b=dGlhqkUAbofYPup/KNOVG6vo988vw+dJfr8f1F31H2UB7hmOatj7nEMWs1MYRtR1/W
         5pLk9Fa3cu89LVVswDh3OmHCEtuTd7U9YnGBv8GTQlHoBmqcCRhT2AIeZxOwRxcn2dCP
         LaHRhqlNj9Voixnc0H+f9TYIQqx0psi6BSjj/KbigaS2FQG7+LPFgic8Y4rIqH+W9mWf
         veItZTUKn91UnUMJyReNxIJtw4+hT/xk9/EG+czABBQhyg7hE7igNfNALl5UWhsxieAM
         VINNBKUxgLZoQXPytnwMjdmQqNi+L+5/jHm4+/wBamnpTm6bsn+qRyB5C++KwctSeWpD
         2IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wZUjAxwgBomEWDOBGCx7CFg3YXNAPChJPs3ok09Sv8I=;
        b=jnqUD4T46Iq8bexDsyrgJtOM5WbqEyVsDjAo3p30C/P/eTQI1HNqTyFj4PYg4VQ/dT
         uK5Y/LDpBCborcMj1cV3iSKLiRxDmDMEyTPq3eVXc5Hle8MHufeynhyozzkXX02KBHQl
         nE3QhrrKUqQghuv+aTbDQEUL2NBexge0oMC7C4MVsoR9Mdcw2Q30jVUfLvMhH293Wx9Y
         kjQ7Ru3feePOGHQ9Fvucjf6gF2jemLK5cxi0GF02XMc0HtdrM9yFNRInHzwmhPE+JIWe
         K9QmkuscLmreOxFMKjUHFlXez8gOl+IQy182diO9z7bGSn2I6J85GJOUkB/3wmkOzmf1
         xb9A==
X-Gm-Message-State: AOAM533JAsEw32osKq5VhaRlFfInyz31EfJXxjeATB1qRHKGf1oZPjUq
        gF0S+yiFwtJuKFQYd/+F+wINffwpJrA=
X-Google-Smtp-Source: ABdhPJzrHTwy3Nqnk+UDvJ7lpqMzVeSoBd13Q/dafjA/wrf27/w8YNOZfulDXqbsIVc67HnSr/rwsg==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr24994430wmg.26.1617034384884;
        Mon, 29 Mar 2021 09:13:04 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a6sm28570964wmm.0.2021.03.29.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:13:04 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Hyeonki Hong <hhk7734@gmail.com>
Subject: [PATCH 2/3] arm64: dts: meson: add saradc node to ODROID N2/N2+
Date:   Mon, 29 Mar 2021 16:12:55 +0000
Message-Id: <20210329161256.31171-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329161256.31171-1-christianshewitt@gmail.com>
References: <20210329161256.31171-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeonki Hong <hhk7734@gmail.com>

Add the meson saradc node to the ODROID N2/N2+ common dtsi.

Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 2f8d574c30c0..139c12cf9f66 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -508,6 +508,10 @@
 	status = "okay";
 };
 
+&saradc {
+	status = "okay";
+};
+
 /* SD card */
 &sd_emmc_b {
 	status = "okay";
-- 
2.17.1

