Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184FE3D998E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhG1XiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhG1XiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:38:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AADC061757;
        Wed, 28 Jul 2021 16:38:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so4679824plh.7;
        Wed, 28 Jul 2021 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFHHs7fv3jc5YudTzgw5MtexrsriZl7knh1DB5cRAes=;
        b=L3XkxYlsyD9aFePA5FTxjxIxslqcS0nAZPewYHSE3yXv3njr4Q0WGYVoFzfoLjnIdy
         JzD6jWxJ9mVOn7G2drqpJdBgy1QDVkwOTO6dcs6l7Yk1FZYgR9qTm0d5KziCoTdBeyXE
         yDtM+lkOOKxKPzMR3etzoHJgcXjPuQrr9N3YvZpUBUo/vMV7x4Uc+XyzznJqiV/xU23p
         Ke+nVhfGmDxMjgDriBvBRsngyPW2PTzu8CnyzfSBwVXKZPwbad55gzWPd1YU+G2pqiYS
         sX0hKtjuHfAbpMwzEgLX6dNi48Qb5hKLhaokkNids73NJsKzKZ4906qI9Ot6ZFHBC2JH
         v2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFHHs7fv3jc5YudTzgw5MtexrsriZl7knh1DB5cRAes=;
        b=f4TSVZkoUL+LFii8OJnpiPS/sRXAPVg6V5vN95IMNZRNdw/4qvieIGR+JOnYIIltMn
         9wFCIo0hJHuoN2YnWsN4alz5XyIqbnuPdarMhK7rFW9Rp+licYD7rZwbiW7rU6eOY02U
         J2MMYvhM87JhmHTCbn1nwTDVBZ8CXGsQKJGyqEKKtqakKeV4lcC4TrUIQXdv5iIyo28I
         7fXtKizmUbccXm3SeJ0a46mhh6Gb/0mNpKPpupbW0wNgKuKrLQ4S+r+XbK1i6VH0i9/K
         913+dQeQgaIN6HqcPYRBr9tKwdmC2lO/N08CKW5gLp9TUtRC/hmXoOecdXiaaoka18DK
         Q9Dw==
X-Gm-Message-State: AOAM5308uus4XApWFL2J3fgKB9kdwFrLXUIaUSCloP7vX+x+Lc8b5ALd
        mdb8DxWUTShLTtZKy8K7UPs=
X-Google-Smtp-Source: ABdhPJzMdHRqs88mpqu1mG+TTxmvFqc63yR50LFdh3E0MRQmKTa48ri7hpO06GmpQSA3zkuvyc6lOg==
X-Received: by 2002:a17:902:7884:b029:12a:efa7:18d8 with SMTP id q4-20020a1709027884b029012aefa718d8mr1997882pll.85.1627515488270;
        Wed, 28 Jul 2021 16:38:08 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id k37sm1038671pgm.84.2021.07.28.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:38:07 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/6] ARM: dts: aspeed: wedge400: Use common flash layout
Date:   Wed, 28 Jul 2021 16:37:51 -0700
Message-Id: <20210728233755.17963-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210728233755.17963-1-rentao.bupt@gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Simplify wedge400 flash layout by using the common layout defined in
"facebook-bmc-flash-layout-128.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts | 48 +------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index 63a3dd548f30..a901c8be49b9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -91,53 +91,7 @@
  * Both firmware flashes are 128MB on Wedge400 BMC.
  */
 &fmc_flash0 {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/*
-		 * u-boot partition: 384KB.
-		 */
-		u-boot@0 {
-			reg = <0x0 0x60000>;
-			label = "u-boot";
-		};
-
-		/*
-		 * u-boot environment variables: 128KB.
-		 */
-		u-boot-env@60000 {
-			reg = <0x60000 0x20000>;
-			label = "env";
-		};
-
-		/*
-		 * FIT image: 123.5 MB.
-		 */
-		fit@80000 {
-			reg = <0x80000 0x7b80000>;
-			label = "fit";
-		};
-
-		/*
-		 * "data0" partition (4MB) is reserved for persistent
-		 * data store.
-		 */
-		data0@7c00000 {
-			reg = <0x7c00000 0x400000>;
-			label = "data0";
-		};
-
-		/*
-		 * "flash0" partition (covering the entire flash) is
-		 * explicitly created to avoid breaking legacy applications.
-		 */
-		flash0@0 {
-			reg = <0x0 0x8000000>;
-			label = "flash0";
-		};
-	};
+#include "facebook-bmc-flash-layout-128.dtsi"
 };
 
 &fmc_flash1 {
-- 
2.17.1

