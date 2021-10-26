Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBA043B41B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhJZObx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhJZObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0BAC061348;
        Tue, 26 Oct 2021 07:29:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z14so18455511wrg.6;
        Tue, 26 Oct 2021 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTHTKv0ib78Ayj42luUwQqMCqoRPJ2rhfbbW9RwVRHg=;
        b=iB4DdmYJ6LcP81e2Zesa+lAjpvo1b9FjRZH9Xji/eL5W6OgfNMqSGKkZVyaes0fuE9
         FrZz60T8hSuXq9KfV1BFn2cJe4TRnG9GdarIdGLJyQOOkW2459gg+oILmbb6QJr4gK/o
         fmHamT7ZpnUVe5x/9eBayiEgGzQ9WJ+vuXV0bp26tpgde4XEMSShm+84cO5tGvBW0Vbx
         p5M9UeCcWyLLAhKEC7E5WLmKjWV/fJaRRhhzH9WV/PGzvZTnL9sehVPNdmwbPQ+yvuEH
         yGcwnlB92Mm9U24jLBmE5CR+NFKYYUifqn3ng5ghVV8zOqrPZ5hskGAOVunkHIH3BobV
         XYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTHTKv0ib78Ayj42luUwQqMCqoRPJ2rhfbbW9RwVRHg=;
        b=JAJQn6+i2JsGQ6loPSa/8xMCguF9UaWWKpC4DXSyhn39D69r//Ryw1Fg3988IWdgW9
         DvvNrfDS7yZINwIoNNx0Uu+1o+S6uHEsGLu+4oVv5vgrIxfOVNhC5ByKUcn5YX06wPIe
         yLEUkvNNvzdZOz+RSeB/d0IdfwhwEqVbzxLLmgDFOd+eSrmf5ovL56kF3ZO3w/SjUO/d
         PTTvNnEMe6E9NvFwkUJy4J9HLlMm/OKpEgClW/WHkbB0cDA4QapBpNEnz47NltnvQ1XJ
         iwFooVDJBgaqZDPMXABLMOVT5qC6ZfvDo5mbprBJXc+6tsZhFJky4LfpEppHseFaXZ5a
         feDg==
X-Gm-Message-State: AOAM530G2CwrYmt+EBjZVKEuMKFUccLYVH+pcr7PcXr5q5DTWsMLhfbp
        wsinMgy34lUkXg0NDIRmj1Hrkescdw0=
X-Google-Smtp-Source: ABdhPJzPk8BM5q1GA+8CxOHoGv4pb9xy+16wGt82SPBa3b1Xf73SN/PhPLJbO5z4uMrjdnpeBGmWXQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr32486316wrd.380.1635258558582;
        Tue, 26 Oct 2021 07:29:18 -0700 (PDT)
Received: from localhost.localdomain (i5C74E3E5.versanet.de. [92.116.227.229])
        by smtp.gmail.com with ESMTPSA id f18sm18745717wrg.3.2021.10.26.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:29:18 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 1/4] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
Date:   Tue, 26 Oct 2021 16:18:59 +0200
Message-Id: <20211026141902.4865-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
References: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80bcd0b0157b..1df6f98055bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2763,7 +2763,7 @@ F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
 F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
-F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
-- 
2.26.2

