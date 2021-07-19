Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390CB3CCBB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhGSAUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhGSAUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:20:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036AAC061762;
        Sun, 18 Jul 2021 17:17:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p17so8674811plf.12;
        Sun, 18 Jul 2021 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E1IaT57PqM3OxdaVHeeIsBbVs6K+CAA7tBM2PO+uVXc=;
        b=qi5842c9wgexH7nMKcHR9lMnIDvGqx8RaC9r5vuX1qTgthOVXY6Lfy/3izEF2MFvii
         +Na1zJgOVTD/STx3mYGRYJVEFnumtNB5KlfEzswwI5mMgq4Fs79t8v4oFhnd6w1/eafY
         3XjZJ3Qv3GsfXHXUcaTXdpd/BR4qTpAS+I79wHZoGrxs558u8/jtRmH5H5omJpD82dam
         aveObl+lB2cYtxuNDsolZZ8KMBhNW+Om/FJgfzyzAvGhwbyOZIMAMTYpap/KQ2JYm8Gp
         sdWc6W4X9o95K3BReg73+bpymik1mipXXjFmQjPiilSm9JYAQX8FE/sWLzcGDNSz4O/6
         G13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E1IaT57PqM3OxdaVHeeIsBbVs6K+CAA7tBM2PO+uVXc=;
        b=SsoAY4+NkQ+SUipipGWd+lRzB9Vs5WIGlIMRJEy1eV9veSz9EU/sWCjuiCLPQs7uYp
         qeJrQjynOclrfRaBv+APkGefuN7nUax1F+WvTmL9r7iSVqVkHXQFevLXxYu/XuSIVEoU
         900tpu5+7x/c5Z19V8gOMI8mEJ+E+EKqHgpd1Y/+tsvXonMBOkQ/uo1u2VkVqIHASvwe
         LWQDvWIL8lre3n37SBF4bekqX9Y1maDUvQUDuLNfb/nWIu7uYrA2j51LCcfM4m7tR9Ao
         6h+yqdRS8HSE5uI/JkdrqXs8RR2Vz0DKEkb0D0oiDR0qocyo03tj6F2mTuY53sMSJ/Xs
         Xakw==
X-Gm-Message-State: AOAM533uVIpZN5Kr8mADNUCwcd/NWUkJg+dGbz9D5OgoCWl2URcghxMq
        BISkS5To3OeH/v0TSXRKvPM=
X-Google-Smtp-Source: ABdhPJxji3hKmRx2pHRZDVVI/50pg9imIvz4sULf1nzAhYLK7ZAK6pCSpUgK1OLvvIv+qpuhXSr6Cg==
X-Received: by 2002:a17:903:404d:b029:129:b048:528b with SMTP id n13-20020a170903404db0290129b048528bmr17314870pla.65.1626653860533;
        Sun, 18 Jul 2021 17:17:40 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x7sm1059847pfn.70.2021.07.18.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 17:17:40 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/4] ARM: dts: aspeed: galaxy100: Remove redundant ADC device
Date:   Sun, 18 Jul 2021 17:17:23 -0700
Message-Id: <20210719001724.6410-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Remove ADC device from galaxy100 device tree because the device is
already enabled in "ast2400-facebook-netbmc-common.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
index dcf213472749..60e875ac2461 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
@@ -51,7 +51,3 @@
 &vhub {
 	status = "okay";
 };
-
-&adc {
-	status = "okay";
-};
-- 
2.17.1

