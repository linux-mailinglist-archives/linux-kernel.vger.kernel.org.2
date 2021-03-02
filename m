Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699FB329FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574830AbhCBDu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhCAVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:40:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77ADC0611BD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:34:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b15so468729pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyPAO3qmMJAESm8Q6YxtAhXPNRAsDpKjNqUjjoQ6MmU=;
        b=QVJ28EEEc4ubhX5nd9gy0c2IeOOM6QCTbe9TTcN2x9EBDTP5X57tnB4w3+V7zdJ2hA
         DWITea67umHcFIwjZ6q9wD8FJYgb0goqv2Sh771OFXriEVqvsbYOeMssfMmI9T2C2MRG
         CdhiIDnOEdwr/8E6lb7X3SP3202ZsjLjc/ACI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyPAO3qmMJAESm8Q6YxtAhXPNRAsDpKjNqUjjoQ6MmU=;
        b=YX4aYnGqkJ0g2Ypnv8+zl6MLfYaR2K8m00snZVD5YLm+jtJ4DcYXAqS5MdPy0xNoN5
         JzE7hFYACsgCRC/jjcap6lalQnto36+zHUQvlObjXDUAKSrVaTtCvP7CnelZs/Cbywud
         FmzdqnG7SEFVd41kklBOuU95xj2Sl1BCdYhW6iRPZOB/1Bdvgx4IVbyeiBi6R1NIKRCd
         ZieQKUNdpLaj0Wu6REHZWh0WpqM9cry1+ek8Rsf+Gv4yvhxgEDR293BHFUyrvjOc6eUN
         yrQftnmMqCwU0qrxxKYw7RTEfcbEOTLBIKhGZIhyM9rvBtGgjjbDcXdaAMeynBAdoWR3
         2MDQ==
X-Gm-Message-State: AOAM533YiQhiEG2RyOEiBk6JN/+AwiXvk7/brnGo6quPbeHfUKeP0AVD
        K68iP9Z6EfK84OVPVSXuE0iHHQ==
X-Google-Smtp-Source: ABdhPJy4it4H97/a0MqzRlYyd0xzUpzOVUf71Eh/7BCWWK6oClGXkPLFdKj/+oqITEv+3cdAOHekfg==
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr851107pjb.137.1614634497557;
        Mon, 01 Mar 2021 13:34:57 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c086:5f6:85dd:98c8])
        by smtp.gmail.com with ESMTPSA id f13sm790366pjj.1.2021.03.01.13.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:34:57 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] arm64: dts: qcom: sc7180: Remove clock for bluetooth on Trogdor
Date:   Mon,  1 Mar 2021 13:34:32 -0800
Message-Id: <20210301133318.v2.8.I80c268f163e6d49a70af1238be442b5de400c579@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301213437.4165775-1-dianders@chromium.org>
References: <20210301213437.4165775-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>

Removed voting for RPMH_RF_CLK2 which is not required as it is
getting managed by BT SoC through SW_CTRL line.

Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index c44be536b288..aa0efc42d5ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -835,7 +835,6 @@ bluetooth: bluetooth {
 		vddrf-supply = <&pp1300_l2c>;
 		vddch0-supply = <&pp3300_l10c>;
 		max-speed = <3200000>;
-		clocks = <&rpmhcc RPMH_RF_CLK2>;
 	};
 };
 
-- 
2.30.1.766.gb4fecdf3b7-goog

