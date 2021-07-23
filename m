Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049E33D3376
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhGWD00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhGWD0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:26:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF18C061575;
        Thu, 22 Jul 2021 21:06:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mt6so488129pjb.1;
        Thu, 22 Jul 2021 21:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IILYi2BBED19uarLK77YF9MGNtXI5Hu+8bpBHATAL0I=;
        b=kXr7wvE1n7/TKCY9W0ROVKU8LnS+Q14q61PeYSiAkwkZvmRJeFrRuyI2AkNv+A9Nqy
         8xm5Eo/qWe1mk49oAvJk8NggYhPEfliRN4N65Bnt2b+ZV8Lqdq7cpXk5i9XQpZ0blmQ7
         9V/UJ7vBzQLiubZ17ZPkF4g7JiEpx02olOoW0uXusgWr0r6Otguvq+f8gTh4QafrBabD
         r2TnHHeQBg9ztK6H5LRCUiOTUg8vvFCVpViM68F1o2S6PkfaUov/DMAVNKAaSwocFksU
         Uhp4MfE+Kf9OE3GAzr5+vfDSLuoi5aCG4iq2sdQpXg8Y0Tu1MHvLPIWBg3HFTOYdRvs3
         DEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IILYi2BBED19uarLK77YF9MGNtXI5Hu+8bpBHATAL0I=;
        b=l+6SIL8hncIDoRsNngNdW/ZUEfWCqUiKEGOnScnOFAWJwd2yXPrExz4BSTi4dr55vv
         nrA4AImtPNqS7CpTqaBd3Wnp/nKd2KNwYpJDcHkHP7yQ0jMSvlDk4fVsJISBfqPbKNrP
         kfX7GWeC6V78unobENDo3XtMwNoYWq+thRIjNbGQFg1k8OVessinJjgolso1wmTQB5d5
         H/nkxXGGTGu/Kd49kR6bqtzoifhDhLoDaOabuyvwcPGt8OXE6LoSjYC7AQZ9SpWTo7zw
         FTxfOJX+NBlBXUOOgu/jKDAZxhuESl/a2a/WQEpbuxD7idWGqRaa6QayqYwrpCjDthvG
         K7VA==
X-Gm-Message-State: AOAM532oDtJanrJK1t8kSmyHhOXImzOxLXquMhR5jniTztTbd2RRAy30
        i5o20VwU0aYueoaE4xhksdU=
X-Google-Smtp-Source: ABdhPJzfAN4Dm2094Oc4AXpBDrI+S93x0ZGuxtrf0rg65AiTzxOdCaPAA6zHF0nhMV4hySjMhRpNjQ==
X-Received: by 2002:aa7:9115:0:b029:359:69db:bc89 with SMTP id 21-20020aa791150000b029035969dbbc89mr2809512pfh.32.1627013217619;
        Thu, 22 Jul 2021 21:06:57 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id p3sm35474910pgi.20.2021.07.22.21.06.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 21:06:57 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     laurent.pinchart@ideasonboard.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     noralf@tronnes.org, dianders@chromium.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v3 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341 dts binding
Date:   Fri, 23 Jul 2021 12:06:42 +0800
Message-Id: <1627013203-23099-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627013203-23099-1-git-send-email-dillon.minfei@gmail.com>
References: <1627013203-23099-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Since the compatible string defined from ilitek,ili9341.yaml is
"st,sf-tc240t-9370-t", "ilitek,ili9341"

so, append "ilitek,ili9341" to avoid the below dtbs_check warning.

arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
['st,sf-tc240t-9370-t'] is too short

Fixes: a726e2f000ec ("ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board")
Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v3:
- add Fixes tags.

 arch/arm/boot/dts/stm32f429-disco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 075ac57d0bf4..6435e099c632 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -192,7 +192,7 @@
 
 	display: display@1{
 		/* Connect panel-ilitek-9341 to ltdc */
-		compatible = "st,sf-tc240t-9370-t";
+		compatible = "st,sf-tc240t-9370-t", "ilitek,ili9341";
 		reg = <1>;
 		spi-3wire;
 		spi-max-frequency = <10000000>;
-- 
2.7.4

