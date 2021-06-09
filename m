Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5567E3A0A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhFID2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhFID2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:28:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F80C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 20:26:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h12so457393plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdYrW81rTRXOyPwwkBxz8oEi4fq6qdyXtGkz0juieDI=;
        b=oM5dWCghrtGmRy3vXH0k82IRuHsl9PMV9Y87AV1Zaz54x7HGdVWxu43tLv4fncOx0J
         xLZ2H3DhJKC69qT80S/baQirsqtrhIndxLA426DhYtYAxf6Mw1FHtoSedK8wbZGiucvj
         o9YaaLtkJFPA5CY8pD1jmQzI5pRtzS+CiRFVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdYrW81rTRXOyPwwkBxz8oEi4fq6qdyXtGkz0juieDI=;
        b=Ls1dMu6vvcW5gdMhsYxgzcLaoe8WjLDMB4mOaaWXxWhq39kleRV7XOszFiQYGMOzh+
         bedxxhxteqztPK3/8BvyK2HTDQQN1/SBtvR51E0fdXkdQsz9iVHmFet3bCB7E1yjqC/+
         esyEhnEeI/C8AfCocJ8wGJ4VR9O/nzF3Un/AC4NYBIMqEb6zElRXY7COLp3rH6+C3Ldj
         9IsU3AjvWydw3WaixY6MvWOLQzlrPxH+QWIiQlCRPdBB9EifPJ+QYMSrBfUWndx3cjjv
         9zLM4Cm7nKM+RuPuWnl8uFwU2l06vsjCOqblvlNbK1KgWcWJ1y0qk8RPteE4az9ViAWZ
         zCeg==
X-Gm-Message-State: AOAM530E+GCJNhUMkRJTgadf7qFH+MasiGX5nomPtQ7ytFKzy/FEx/dw
        sfPq3g7uAr8jiknURKN0k0YIpw==
X-Google-Smtp-Source: ABdhPJxU3TRagjuWEF2Gz3E1Ucyrx55ygzxfYieVj3D0ExyoJPKDqzOCd2hmUMkedHakii/hod69Hw==
X-Received: by 2002:a17:90a:a41:: with SMTP id o59mr8087029pjo.203.1623209177949;
        Tue, 08 Jun 2021 20:26:17 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:2585:de55:d6c4:950c])
        by smtp.gmail.com with ESMTPSA id 125sm11728635pfg.52.2021.06.08.20.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 20:26:17 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] arm64: dts: mt8183: add cbas node under cros_ec
Date:   Wed,  9 Jun 2021 11:25:54 +0800
Message-Id: <20210609032554.2443675-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'cbas' device node for supporting tablet mode switch in
kukui devices.

Kukui platforms with detacheable base have an additional input
device under cros-ec, which reports SW_TABLET_MODE regarding
its base state (e.g. base flipped or detached).

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

---
Resend this as a spin-off, other patches for dt-binding and
hid driver were applied.

Link: https://lore.kernel.org/r/20210514122051.266169-1-ikjn@chromium.org/
Link: https://lore.kernel.org/r/20210415032958.740233-1-ikjn@chromium.org/

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..1512605a438e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -816,6 +816,10 @@ usbc_extcon: extcon0 {
 			compatible = "google,extcon-usbc-cros-ec";
 			google,usb-port-id = <0>;
 		};
+
+		cbas {
+			compatible = "google,cros-cbas";
+		};
 	};
 };
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

