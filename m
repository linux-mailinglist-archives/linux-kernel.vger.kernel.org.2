Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2B39C539
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFECt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:49:26 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38544 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:49:25 -0400
Received: by mail-pf1-f180.google.com with SMTP id z26so8767963pfj.5;
        Fri, 04 Jun 2021 19:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YWDGtwFEazMTgKTgnhtKVsR9Lwj2c+5ANH5SB580b0=;
        b=JXCnaLKYrC45wiA7LB39WHEfpRZXjDA0VpM+dOMOnd/UbXTZ2ThVmKrwvZXaXAlxy7
         0AOZyTQpFj7B8zCJvmI2qfoFti/D86Va8pPqozHS9Q6Zg7drJb3L8hjjnJ0giJMM41sX
         8Kouc4DxrbDtvVAyXa2Ks8x0BV3QofsYEqaa3cByHnu4qnjdHBLtVkObQ4tC6CDhAYUI
         OMXvV3v2MiFin1OeAJZkAwa6a+exMhh4WzpXo2DzjmNdtVaIgr2VUW4uwaTnQ6tFjMnI
         mm5Iu1bbyCnwgSfIhpzdmUqp6EcI0MKW+6WQX+5CMVoV4rqGXa0onAxh+ad17F0iMVUG
         4+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YWDGtwFEazMTgKTgnhtKVsR9Lwj2c+5ANH5SB580b0=;
        b=aPRuFwa8qgB4QmlJCMMDuWaV+OebIcsCuzhBH/23ophvlczuRPJ5LgySMjDRbkRonR
         hLKe2MdUUYOAib5MX3aBJFxhuCBzjgB6B/hXvt0+Alu/PAEkvS99hxlT2BJZKVmxxlxG
         BpKbndij+G9FPwixvacN4T7LpNCgM8rhwGMO8ipX1uLTzVhcxK3qYfJXYgoLIEBIUqJk
         mGVVNHf7phNSpopSlBPKW2BoA7kqAqaUrADdHzEU3Kp/l1skTEnTpH4dT4MbrgfQuz0g
         R2pM5pYd0Bpyu2UWTqDtOgQejNDvlpB/i8Ak5bdcrh42lHrAufnKccntF5hD9j+8Uxri
         Fm8Q==
X-Gm-Message-State: AOAM530Vg3xpMGu0QlrFRfutUIaETtCl90xT/sSXkEhQsCMwYwwf7oBh
        Vf19DqfjNMHZH9BccQ1PiKI=
X-Google-Smtp-Source: ABdhPJwWI/5SZk7uOlDPOvSEihuZWVfO0MvMDfknx9zKdidVhPd5fqgYL0Lq63fbS7T5lAIsp1hXng==
X-Received: by 2002:a05:6a00:810:b029:2ec:3b54:6a89 with SMTP id m16-20020a056a000810b02902ec3b546a89mr7597353pfk.0.1622861186493;
        Fri, 04 Jun 2021 19:46:26 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id q21sm2864612pfn.81.2021.06.04.19.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:46:26 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim1: update serial aliases
Date:   Sat,  5 Jun 2021 10:46:17 +0800
Message-Id: <20210605024617.409677-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Update serial aliases for Khadas VIM1.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 60feac0179c0..f116a9d91633 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -27,7 +27,11 @@ button-function {
 	};
 
 	aliases {
-		serial2 = &uart_AO_B;
+		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+		serial4 = &uart_AO_B;
 		ethernet0 = &ethmac;
 	};
 
-- 
2.25.1

