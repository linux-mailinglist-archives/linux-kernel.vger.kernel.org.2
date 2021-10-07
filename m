Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD840425A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbhJGSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbhJGSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:03:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8CC061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:01:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q193-20020a252aca000000b005ba63482993so377578ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r+cHeTTjO90PS0eai6zYLqlbbghwPCf4HX8fINZOrVo=;
        b=Tjg2WjHfqsfjG9mnJjznbqm0FF467Q9VNpX0aEArMWSepyKbuBHLNlmMbaDi7qGYhR
         F9Pic6KqWxOcXpUtvN52KN8qlZwlfSge+4y5rzEj5PEA3zLZZpqcSw7BUqWmjUs6QKU0
         GZG194aZ+ZW/Sq7DWmKCCLPhKu7zv0/EQj55JY3vCfGpMb8gYGwvuEaILnWiBg0mJoMU
         Ig8W2Dt1KZdj4HBYBef75fDxRtkEO55z6rsMJesDF8krBEt072ZNjR3yuEu6d9ruV7Zc
         YZ0V4993yXOALPAl6pZjDoQ+ErPzYZwueMTvehX/U2aYVarIzkhjmfo1tV4oxte3QiWU
         jhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r+cHeTTjO90PS0eai6zYLqlbbghwPCf4HX8fINZOrVo=;
        b=4xbsT5A+RNvz1exSuuTNG6lNp1iClMxpBG+lznkkHikiWKa7uwRylnZVKaheoy4BSE
         /S0mbtsKtm0XR7qMRX7E07eo4tzl5LsNkM4AINq9AcifFRho2XMTn5/52FKFJvyyp+Gd
         LCXWZb0agUjrhF2jxZ/TOK31yhIRg+ySIkRR86WhpJK/ea/Jn+wMfJqWFLsMUZnNO/Nq
         8rl7xB2Ux1c9Nj990IQukb6GB3N+CjlOe5IbbPxf5G/7G+xDUl6fKXyMJdbpPc2kXmFG
         dgJErF4wjLkaWID71LspfhWjlFa97S6/WOz/QZqQ8Nx0NCdnPISq5xBcghxNlCpXsc5w
         y0cg==
X-Gm-Message-State: AOAM530ia4Uy0OnHLWiTPHzwaPen6kRR4qAk3Bz7kKrJ5dAczUFCNzQB
        vNFyXCYjK+tvLetTzhIW19KhJyp558O25/s=
X-Google-Smtp-Source: ABdhPJzWbLRRvZtWkRt5K+FUZHphlko/RfXWxtqFNHXnvPylWZf8nOuluf3xvj1LHzqYLeg9YAbmfXwpj75quVo=
X-Received: from dimitry-linux.mtv.corp.google.com ([2620:15c:201:2:153:83c6:87f9:e276])
 (user=dimitrysh job=sendgmr) by 2002:a25:f803:: with SMTP id
 u3mr6344481ybd.386.1633629697804; Thu, 07 Oct 2021 11:01:37 -0700 (PDT)
Date:   Thu,  7 Oct 2021 11:01:30 -0700
Message-Id: <20211007180130.805401-1-dimitrysh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] arm64: dts: meson-sm1-odroid: add cec nodes
From:   Dmitry Shmidt <dimitrysh@google.com>
To:     narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CEC in same way it is done for other meson odroid devices

Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index fd0ad85c165b..7eed4849233d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -225,6 +225,20 @@ &arb {
 	status = "okay";
 };
 
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
 &clkc_audio {
 	status = "okay";
 };
-- 
2.33.0.882.g93a45727a2-goog

