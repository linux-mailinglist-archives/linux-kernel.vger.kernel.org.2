Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9F377F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhEJJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEJJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:27:41 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:26:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c21so12870072pgg.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuM2qFwJUXSo3sJ0uUDN99Vl7wLqkoUYd3aEZh6X+Fg=;
        b=ZFPLINz9K5Y2ICiDxQuHLQZPjY+KDhrgcDQITj7nAsKoaCeUvw7yepmVPyZy+zjzlA
         tnDIxC2wl08YncNdYK9+9uhlsZd4ofUuztqW3IXvTESANrefMFhUs+gTrQOwVkXw+d+p
         3VwZsmhkIj+KlQfez3qd9328zjCOtjaoJImWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuM2qFwJUXSo3sJ0uUDN99Vl7wLqkoUYd3aEZh6X+Fg=;
        b=T5UL4QvtofzUuYbc9e2jIEHqrttaDf1gh1CLUUp0A4fz21O/oHdC4nUqK5zYw/eRvp
         snWu7PG+AqLoSdcvZpgUDpyJDaImhwtRJAjJ3rtW2aDuTLPZLvk+aTcQxQD6ueyvFeaa
         4M8D1RU7cbk8ZI0J9uR37vdtDjR+2aPOV2+72I4XetT+rCAfYFub9bPqrHfntsXdWzK1
         dSpz8gYwYKr1hqp/oSfnwD9l6M8VaGHrrMthy7rTkq5gebQW74rnoEx2hw1jqsLVEO4S
         UmmyBKapPHtXMbjicZGCnnEr3sq91phyUdEn0wi4CWw4XOS7RmTt3RCj1VbskJmSO5Q6
         zHSA==
X-Gm-Message-State: AOAM533c9zh7riTmJVFaQ3p9RjSMoRGchOj1X71XXgpl/8dZHKdCggB8
        rCoQNs9Q0gfe/QMtb2Rb3PPdkQ==
X-Google-Smtp-Source: ABdhPJyjbHbTp9INK0YHJwsBYB1iYZU0TdNo61ldaxVdgeUWxk/SS1fexDBLZF8U1jD9dWDvis5I3g==
X-Received: by 2002:a63:f90d:: with SMTP id h13mr24293046pgi.18.1620638795597;
        Mon, 10 May 2021 02:26:35 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:179a:d92b:9be:4135])
        by smtp.gmail.com with ESMTPSA id a16sm10671391pfc.37.2021.05.10.02.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 02:26:35 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hsinyi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mt8183: add cbas node under cros_ec
Date:   Mon, 10 May 2021 17:26:31 +0800
Message-Id: <20210510092631.3141204-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'cbas' device node for supporting table mode switch in
kukui devices.

Kukui platforms with detacheable base have an additional input
device under cros-ec, which reports SW_TABLET_MODE regarding
its base state (e.g. base flipped or detached).

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..40030ed48854 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -816,6 +816,10 @@ usbc_extcon: extcon0 {
 			compatible = "google,extcon-usbc-cros-ec";
 			google,usb-port-id = <0>;
 		};
+
+		base_detection: cbas {
+			compatible = "google,cros-cbas";
+		};
 	};
 };
 
-- 
2.31.1.607.g51e8a6a459-goog

