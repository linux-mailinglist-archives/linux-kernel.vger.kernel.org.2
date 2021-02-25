Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957583255A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhBYSgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBYSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:34:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F78C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:33:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r5so4157426pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9poB+9UvCsAftg2exikJeHln2VIb8dM063unlt1wkfI=;
        b=mgZP43UgZp7Mv0362cfeFUR5EQ0biY1rWtCq3oMV4iu1myOvda/j6Zbz8ZgNMcThKU
         ZWjYx3ZhoRe4osSFp8i2uB5uT4+LfyP/BK58E1HyYvujCwxZUQJ/h7Nor2yjqqmdGuCy
         VDkBLwXJPEjBluNdHGznEf8f+Mi5PapPxp9GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9poB+9UvCsAftg2exikJeHln2VIb8dM063unlt1wkfI=;
        b=DypC8ktR6oo+0BLEDM4+i/tr2tqsItf82njkdGczLbOm+5Lr8gDNc1lFquHf2Z0tHT
         RJlkjdOMmpc3pkPElrg2lZIVi/qdENdh+5m0pQODFvuOwSCMeB6l7ff/l+S6NC3EL0Pq
         xNTCSTp0WwNkowDuxPyeaRvV+ok0spjd7+q/6o0j3GnXpA+OFG7TvzOyDo+0NvX2c+aQ
         X3UYwP3/XaE6PJigIfIv5WF0SneBRA8HNwkO3fKaQA4KfctRiBoMctac/0JqJwpgcRfd
         ZnXaD+4+Uz5s1crfDfeJBkld0d+s9vSY0xQFOVbmiOd6dJsrpO7LlO6EAc0+LgK8UShE
         eacw==
X-Gm-Message-State: AOAM531jdtsQ2P/EyZBQ+3F6WTlYrAoAZEvG0P7b8qmM2EoSdpwkIq1b
        XdoSAh8RAdeS8E5BojcOetAEZg==
X-Google-Smtp-Source: ABdhPJyKnckjWKnAALD0HFPKl0cdT7zoyJqux+UOTjzVjpLDhGZx1TCNA98yXyiYzkPn+k1PgTJYjg==
X-Received: by 2002:a65:4584:: with SMTP id o4mr4088843pgq.266.1614278025406;
        Thu, 25 Feb 2021 10:33:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id l22sm6567782pjy.6.2021.02.25.10.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 10:33:45 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/4] arm64: dts: qcom: sc7180: trogdor: Add label to charger thermal zone
Date:   Thu, 25 Feb 2021 10:33:34 -0800
Message-Id: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some revisions of trogdor boards use a thermistor for the charger
temperature which currently isn't supported by the PM6150 ADC
driver. This results in bogus temperature readings. Add a label
to the charger thermal zone to facilitate disabling of the thermal
zone on affected boards.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- only add a label to the thermal zone
- updated subject and commit message

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 07c8b2c926c0..bda983da4eaf 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -15,7 +15,7 @@
 
 / {
 	thermal-zones {
-		charger-thermal {
+		charger_thermal: charger-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 
-- 
2.30.0.617.g56c4b15f3c-goog

