Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8D3D09F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhGUHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhGUHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:01:07 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F0C061574;
        Wed, 21 Jul 2021 00:41:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k20so1085131pgg.7;
        Wed, 21 Jul 2021 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+x+f7PVXVcjHLEa5oy45MfmPR9ugBPOg1ZaiimxyB3U=;
        b=jKVLhLjvLVl7Wec2cQKnTeigp+0iVu7nuEaJ3MBEjV0ohly6Ehi639hu0Qzu7aIPX8
         W79uGjJptJZvaf0LJitfBFQ4RnohYxegnaJF/NzoG9Y/1UNyv9/5Xrt1CZ27UsnQgZUN
         mSHLOtDCUqR4gofeY6zRttrvLlhbyMrDd03QrDmOE//F3MAjiHmMxBkmwnUHdM3ieHXi
         31szerUxwpEAPWRlIWcbcWBwJygCfuuJmiKvDO7yXbaLdqIPqOr2XTdwpZNivaMyoBvV
         IVuSS3Sfa0UEyTycIjqQOimgcjHbbC9jJp5LJrN775RLr9u3CCSXCneF+lAJM14miNHp
         DGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+x+f7PVXVcjHLEa5oy45MfmPR9ugBPOg1ZaiimxyB3U=;
        b=Up7WtRBbvuJ5s6n/nEUxlY7JR8wA2Sd+eCpF1Ag4DgFLuth5JEfgFQg+rbveKGph45
         7tAmVbU+esDJJJwkozOT93mi/HSKaZl77SJqT8jBuVyBUdUmirHjve8p/e4Sivyx+BOA
         mxr16PRX6bbko7YcetX6gD9d4aggnrmjQQjJdULDMQIXOcYV42LxN9gtqqY0hLgotYLg
         u3siOaqkq8suEhD02qMYT0nOheF+7jnoL2PcIrd5r8hFAA65hrtDLOnFRrWH0kXMNIUG
         vRPYaabz+oA1OlCuBUO8HxGuer44V9vBUviq4o0qUflQEZsT+hVNAmuRje7AoNY1ltD1
         p0Hw==
X-Gm-Message-State: AOAM5332AlOj+FkSkKLJzVbJDo1yWM64qTmyU+ySDIryss2smqDnjYJs
        +x4yOtdxb6e15wNurlNUwcw=
X-Google-Smtp-Source: ABdhPJwm/gorGk3PKzcSSUiK20jrDXjD35yudvyAPAcVMS7CyY9Wf44Ly7TLgQ6i2zj1IskD7/4ubA==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr34409484pgb.127.1626853303934;
        Wed, 21 Jul 2021 00:41:43 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i8sm4841867pjh.36.2021.07.21.00.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 00:41:42 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     noralf@tronnes.org, dianders@chromium.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v2 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341 dts binding
Date:   Wed, 21 Jul 2021 15:41:27 +0800
Message-Id: <1626853288-31223-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Since the compatible string defined from ilitek,ili9341.yaml is
"st,sf-tc240t-9370-t", "ilitek,ili9341"

so, append "ilitek,ili9341" to avoid below dtbs_check warning.

arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
['st,sf-tc240t-9370-t'] is too short

Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
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

