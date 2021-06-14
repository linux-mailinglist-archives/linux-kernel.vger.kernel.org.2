Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15F23A6598
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhFNLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbhFNL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:29:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE09C0611FB;
        Mon, 14 Jun 2021 04:24:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso12571998wmj.2;
        Mon, 14 Jun 2021 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6O1/p+TVyjn69g2HY/w7f3if8GXgF0APoHiuEoQe760=;
        b=BPuVNBP1Uvg7mhVvvK/ofXmX9NsORFXeJZJ5vpCNymBPW47LeglTWGpYc0cINwdQJ2
         /LhckxOpppW9cObo4ME1buGzwxvlx8ahGqLl/oxgY8HjEU/tfsuPrewVHNFXkug8GYxY
         ditvCdvJaFXbJXUNXawRpkTz771QtebK0BTw2pWBAM3qAkvyZ+C9/onA/gFWQIg5n8SW
         54ZQq1EWLiZg4rHnYCfXFwgXbjTPvsdNtS577Y1da5Kor0aQ/zj/aduC2E5JHWmhrsh6
         sKuqnmCP509sKWBYOIiNa0yKpFdwrQRwmzfL1UP1yhUGbjBSnpmbR2ZgJiXsHOkkW52W
         +TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6O1/p+TVyjn69g2HY/w7f3if8GXgF0APoHiuEoQe760=;
        b=JL/2glPR1Jrh8m8y28UvDzKOBamdDUIilFERpASjiO/AUY8nk6C5PGexkP9Ew7fRvs
         9boqklUDBgZ2vcvl6MxLDsZa3/5ffjuNd1TWw1ms7F8mlSe5dDw6WIM2fcnvneQIC663
         eIxjqUjzkNujlEw3PSxETYEVS5dvywdH/y9OjvOlHQjyfk02/pN5SxmTjL2miUHPUMOQ
         9OdZr34Mh9ndDxRLTWgoebxOIVqVBHDSk6KSgFU35wYt62pilAj5SB7Ea8ZmyLHlL12E
         m+/DwxPArsEsH+ehUClzbIaxqc37eZyPe9XxSvoc/DhJOW0tBjjE+HPtsAeSLJramiwY
         mkVA==
X-Gm-Message-State: AOAM532fqKb/aNQV5/0Df/ZnXpjJ9Y9uNSPe3QLcvdRMZIrqj8h04hF9
        tusoJJm/dtetM+63gzuO9K8=
X-Google-Smtp-Source: ABdhPJzLVH6N6pJbPducNwruu6XrCWiAVxV8CzXf8dkf6Rut4wtw6jDIpeVJdDdI2u2nro7Vf60dRA==
X-Received: by 2002:a1c:2202:: with SMTP id i2mr31669917wmi.72.1623669846417;
        Mon, 14 Jun 2021 04:24:06 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d62:e800:a8e7:80e:6e34:237d])
        by smtp.gmail.com with ESMTPSA id w13sm17269485wrc.31.2021.06.14.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:24:06 -0700 (PDT)
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
Subject: [PATCH v2 1/3] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
Date:   Mon, 14 Jun 2021 13:23:47 +0200
Message-Id: <20210614112349.26108-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
References: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
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

Fixes: 836863a08c99 ("MAINTAINERS: Add information for Toshiba Visconti ARM SoCs")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6cdd550cd3a..5df664744cd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2684,7 +2684,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
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

