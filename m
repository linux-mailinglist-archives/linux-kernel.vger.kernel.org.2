Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09AD3CF0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbhGTAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378473AbhGSXtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:49:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B41C061574;
        Mon, 19 Jul 2021 17:27:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b12so10594831plh.10;
        Mon, 19 Jul 2021 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3paEF6uTPtJuVzcwEbmMICexqBa0ixV58zFe59FrapY=;
        b=ktfbQ//Eqk+xDPMBGC1lTN2dtljdcf913wD8dC1G5WKjaoXy7LOb98VnRAAatZoOK6
         39evXxJhZb+WrBgC9zww25iuAy0k6XgY5Q8e2msG844n2c3eEuEXS/bIR/S1vUbFj4st
         kmmMrXedAdfoBk3LO/uBh7dw8I48PI/XXE4V+xCPa4qBV8hqRQXI6L1O2ddTdmJYuSQw
         NQ9ULnb6qseP4jkZjIAWzGYxw/Mv90VnKOm2bJ/oQka4GDmDLobqFJ5p5WElTvKleBba
         hjuJMIDNnDK1wk5rye8fmmCXCMZAcQJzDO7d3mzIwoBv+cwk7aStIzPxD1+ZAqCTduO5
         hfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3paEF6uTPtJuVzcwEbmMICexqBa0ixV58zFe59FrapY=;
        b=EvAnsaw1NnBkA08Dm2hka4v1IdfMg1tWJZ5P6UQhWItw7/D/rkHav4zFZ5NaCjlj0r
         2KOZGqFcW+okTk7Xn9HhG4F1w15RJxroM/rxvjpub/aB9pBE8+sIch9xqbE6nuDSEGvm
         PIdOiTt2S7O+nGWNwls9FWhYigQH40sTGWh4c6S1FeCSbXZjda1Hqeum5ItPgKnNDITS
         co6Lz9tcxm/bHH1bzpRSh9VCj4bB0OqkJ/oeGDb88uRxkV+wdNWucawikzQjhxN013XP
         96e4ss3ICY1TkvMVFm9FdKZgzN+M2QS+P1jEzz0t3bE6ywOleHy2mVGB++qQi4kOZr+g
         i/yA==
X-Gm-Message-State: AOAM530JPUmiHknTzEbAZp6tFTeeJO62G6uqdfcDV33cOvxSOOX/2UVS
        E6Q6fWIGqrUBDZf47SCNFvI=
X-Google-Smtp-Source: ABdhPJwjzsszQsBR/i6spF9ryPzXGmISj7B/mjK51ISfM0a2Zus/cLUb79kBXN2eQdHys5ZDUgXwqg==
X-Received: by 2002:a17:903:1c1:b029:12b:1eef:fedc with SMTP id e1-20020a17090301c1b029012b1eeffedcmr21371916plh.17.1626740836970;
        Mon, 19 Jul 2021 17:27:16 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x7sm11941831pfu.158.2021.07.19.17.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 17:27:16 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: minipack: Update flash partition table
Date:   Mon, 19 Jul 2021 17:27:04 -0700
Message-Id: <20210720002704.7390-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Update firmware flash "data0" partition size from 4MB to 8MB for larger
persistent storage on minipack BMC.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
index 9eb23e874f19..230d16cd9967 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
@@ -265,19 +265,19 @@
 		};
 
 		/*
-		 * FIT image: 59.5 MB.
+		 * FIT image: 55.5 MB.
 		 */
 		fit@80000 {
-			reg = <0x80000 0x3b80000>;
+			reg = <0x80000 0x3780000>;
 			label = "fit";
 		};
 
 		/*
-		 * "data0" partition (4MB) is reserved for persistent
+		 * "data0" partition (8MB) is reserved for persistent
 		 * data store.
 		 */
 		data0@3800000 {
-			reg = <0x3c00000 0x400000>;
+			reg = <0x3800000 0x800000>;
 			label = "data0";
 		};
 
-- 
2.17.1

