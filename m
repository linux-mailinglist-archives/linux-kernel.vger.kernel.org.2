Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5990933C132
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhCOQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhCOQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:05:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41456C06174A;
        Mon, 15 Mar 2021 09:05:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jt13so67217334ejb.0;
        Mon, 15 Mar 2021 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i6iH0dqju6YE2XWm/tL7nUEjuS9YnWN/4ymNfM4ljv0=;
        b=iEnEtOiqFh4HB4CprnHrRRpU3B+BXDAiyjzFoSIxyv3NMJXNMhqNhUiXpFQFabPIgf
         vkil5jxKvNSeRSk2k53K8wGSADVcZhFh9erKPDHKNz0bk8IFgBGx/QRd29w0okXlDXTR
         pm4V3QuGbwO5U7hg0yT52JHlDN2EL+BxJIrSnXsuY3UhRn8Uza0eqsG7j8py9Rs8mNl8
         JlNbvL7XR5bKjGlggpkud1v2TNlkC+XTwLq7Ui3FLtdzJSHg2MiC/exfaR5p2urOXMT4
         78mwk+Onu8a0748tSWvyP5b+Khhxxn7Eh13SEFj0ZzsVbpZGbVMenlYoRwrXuMzki56W
         pZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i6iH0dqju6YE2XWm/tL7nUEjuS9YnWN/4ymNfM4ljv0=;
        b=t5m/MXc4ofqIV8Dru0M7SvJRn+CIiASz1myDtR8h5zfn34Sq/EABVEYtjy5ur5r81x
         Olpih4tkNbsTd62rsAUxC68/rZDd28sRj7424PWb89CLTWxOrqlQxLS7r/9vwK1M1puB
         cekYCIPf0knFouEL9K+YvB86GZC5KcodDGFFNIqF9Q0OtKlTuNyyu2IgvcPa0rmyB7dW
         Znzsx6+bue8yHwQ4ZEdCT4BZ8gr/He0Wusv0o+EoHXSzNtP+Vu4TtlqeSQIKaW/jXxbv
         Dh5Qqqx79kipj3EI8zEfOE9EV8aFwDH/muSHsD0WpCIWhEgHKg07zMEctJgCPqbQSa78
         4cOA==
X-Gm-Message-State: AOAM530bR+iIU0VpLcptVlCfxeANCelaYejfTPY4a78V0F6PvTNEJxFi
        858dpAof0cZtBr9QpVWcSKI=
X-Google-Smtp-Source: ABdhPJyUX64UUMfmeECILiXmkIaCTx8bVlGcsoSes3NyOqtVeHYBt+RiqwAJ1UkW12gedHEHUuqyhA==
X-Received: by 2002:a17:906:ada:: with SMTP id z26mr24553574ejf.438.1615824306973;
        Mon, 15 Mar 2021 09:05:06 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d28:c000:5c39:c910:15c8:a935])
        by smtp.gmail.com with ESMTPSA id z17sm7748510eju.27.2021.03.15.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:05:06 -0700 (PDT)
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
Subject: [PATCH 2/5] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
Date:   Mon, 15 Mar 2021 17:04:48 +0100
Message-Id: <20210315160451.7469-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
References: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
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
index 251e205b5444..89404ca760b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2621,7 +2621,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
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

