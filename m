Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335A9363E76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhDSJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhDSJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:27:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3DC061760;
        Mon, 19 Apr 2021 02:26:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w23so36013039ejb.9;
        Mon, 19 Apr 2021 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qx4QfDafADgbcq+PO62rRQaT0rvAUY+eMro/BxtVFVI=;
        b=kvTQN4UzrE1XjMxmf0iUrM/WSEMi3i45r6ynjs9GhTUvrWNTI9610Hylxtp+srZ5mC
         0buEOZyizEilnoHplhqHZHH1j9u1FyGzXagV2orBOLWrqFp5O13kHawKS4OVy9Pr9wMQ
         OZfh9cwakY6rR4eB5GUKCd1nTNmsS4Sv515tdKxMCLNODP/NQLlM404z18JXu2VZ6P62
         tOmIbWDtyNhDf5KFLSH9LjNqxviMku1UjqOxmUBG0DVs+r2NGJhOMT3Am3wydmnzCTns
         M91Hh4rr/a0v3H9Snx+58VNGKSRKfSzmO0o1VCDJzR/f/UHnt4tDurPHDh/aA8PIod9q
         F99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qx4QfDafADgbcq+PO62rRQaT0rvAUY+eMro/BxtVFVI=;
        b=mXZMxNP/R/fy/l/mg9T+MbKJ2EjMTGZYNOKEch1docRxwCTSLCG/yYh4E8abToSUEX
         R94zpZk/UVhJ38zVT48R6mNgfJMhElUP5DgWssxO6mp+0TqJZjvmDobXSbnDuqyse9T7
         tN1cqyjDOyk6lq8Pv9J1IDqC20B2Bp65vBYDB+ydYLQ1TvdnENqHjNtBb8gOerh8zj/2
         hSEzGOdMOWn8I6VYwcg5BC+tQJp16+/XNztx1mDHmbwWQe8KcFaGBBEQFEERREzpDkdZ
         Lylh8hiCTf6g9rmBMzQKVGuZnPALBVuCydRLiaPmfccAzxDyp6EFynHcsYovCz0omwDO
         pXvA==
X-Gm-Message-State: AOAM530X0grP1YyZyGW8ckQzvIQElV8i7NO6DPVZ2fGlilPR1Y3kZ9JN
        P6TIaDik+nVTVvfHO1xIsxo=
X-Google-Smtp-Source: ABdhPJyT/3TKaQWvaQ6XQKPMcikA1eZP9Br3ZUeBk/mjVjvyXoeUkg7HV8dcGmyStBsluUxue195Hw==
X-Received: by 2002:a17:906:6818:: with SMTP id k24mr20694972ejr.245.1618824381593;
        Mon, 19 Apr 2021 02:26:21 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dc6:900:a414:a08d:9e82:6738])
        by smtp.gmail.com with ESMTPSA id bh14sm9943706ejb.104.2021.04.19.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:26:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/3] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
Date:   Mon, 19 Apr 2021 11:26:07 +0200
Message-Id: <20210419092609.3692-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
References: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM
SoCs") refers to the non-existing file toshiba,tmpv7700-pinctrl.yaml in
./Documentation/devicetree/bindings/pinctrl/. Commit 1825c1fe0057
("pinctrl: Add DT bindings for Toshiba Visconti TMPV7700 SoC") originating
from the same patch series however adds the file
toshiba,visconti-pinctrl.yaml in that directory instead.

So, refer to toshiba,visconti-pinctrl.yaml in the ARM/TOSHIBA VISCONTI
ARCHITECTURE section instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c54b8e4520d1..d31c8058b17f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2669,7 +2669,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
-F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
-- 
2.17.1

