Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC96C40AAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhINJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhINJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:28:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4356C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:27:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1960728wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bfv9mrhoCCh8u0D+lkls3XOLkYlFZSKbSMNA1jMqkE4=;
        b=P0ezE9qhfQ7YFuhO5o2QECi/f/dbGOGBXB+TO/T0hYa1m+Ql/DlKarEYdW/5O3TOTH
         cW54RAgvnTvUqFw67C78onjTPCu1bhmEPLrp5zufgaEkbjSBiSn7bc87IaxENdMiIz+3
         Yzg9YIUIv0Yr/MEvhpR30B1yG4bwzj7WBzKkRU3FCDl2CABwwgB2xL0iuVblIeorM0/i
         0UWWW3QYVAFNrknaal43z8LCumbNcimR/pCBL1HHkQRBkAlhCmyV4r0daxNFNB3cR5k3
         vUVNiQKODDkdy2c3fItBF68vVG0jVvuv9nKkS+l3WSKwoSYl2B7teU1fNbZmmQSX8YgW
         QedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bfv9mrhoCCh8u0D+lkls3XOLkYlFZSKbSMNA1jMqkE4=;
        b=DacLFwL/ZEOumM6scHbiaBNlytKNmm64S8ap1MujILX8Xs9akqMkz9IDfFrCt6Eez2
         58TreRHbZxeM08V3RA4Rbza4KId6mfmtpqATZdpn2Ip/j4FPLEdA6P2H0nedtPANwTtW
         sxSiB9cjGMUpAki07x/V8+iRQjfTJMv5ezuBd4DF3uSnY0tvVfzyJx0vKJIUhMo/t2nT
         Pz1lqPreemBa4Ae6JSF8v3844wCoreLxmwnGzLILOJqF6vyYBF0Y/bye99LzF4G7HmlZ
         dLYIrSE4oLzSYlWTlpx7q5anoCZFN0vDypCl56xwK0GXUAaA0tsfQtj4ajtQQdxGizVw
         cWbw==
X-Gm-Message-State: AOAM5311gJinBsiwnZoFFxk3zKqs6XLO75jz6B3jmL+MoEhTs6lCZf1i
        06X3uc3zMp/d9e3Cur4ltVs=
X-Google-Smtp-Source: ABdhPJy3weP4Jyqn57+GuhwJkx7GYziPCndmJZ3YD2KZvj7dUExJNkmb/COoWp+4u1vnPjgGwJyH3g==
X-Received: by 2002:a1c:20cf:: with SMTP id g198mr1014787wmg.143.1631611643356;
        Tue, 14 Sep 2021 02:27:23 -0700 (PDT)
Received: from monk.home (astrasbourg-652-1-178-243.w90-40.abo.wanadoo.fr. [90.40.105.243])
        by smtp.gmail.com with ESMTPSA id a3sm9734085wrt.28.2021.09.14.02.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:27:22 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
Cc:     paul@crapouillou.net,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] DRM/Panel : abt-y030xx067a yellow tint fix
Date:   Tue, 14 Sep 2021 11:27:16 +0200
Message-Id: <20210914092716.2370039-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous parameters caused an unbalanced yellow tint.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
index 2d8794d495d0..3d8a9ab47cae 100644
--- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
+++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
@@ -146,8 +146,8 @@ static const struct reg_sequence y030xx067a_init_sequence[] = {
 	{ 0x09, REG09_SUB_BRIGHT_R(0x20) },
 	{ 0x0a, REG0A_SUB_BRIGHT_B(0x20) },
 	{ 0x0b, REG0B_HD_FREERUN | REG0B_VD_FREERUN },
-	{ 0x0c, REG0C_CONTRAST_R(0x10) },
-	{ 0x0d, REG0D_CONTRAST_G(0x10) },
+	{ 0x0c, REG0C_CONTRAST_R(0x00) },
+	{ 0x0d, REG0D_CONTRAST_G(0x00) },
 	{ 0x0e, REG0E_CONTRAST_B(0x10) },
 	{ 0x0f, 0 },
 	{ 0x10, REG10_BRIGHT(0x7f) },
-- 
2.33.0

