Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43737451D11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349330AbhKPAYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:24:53 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:56113 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351874AbhKOUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:38:42 -0500
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A006720142;
        Mon, 15 Nov 2021 21:35:11 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v3 7/9] backlight: qcom-wled: Provide enabled_strings default for WLED 4 and 5
Date:   Mon, 15 Nov 2021 21:34:57 +0100
Message-Id: <20211115203459.1634079-8-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115203459.1634079-1-marijn.suijten@somainline.org>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only WLED 3 sets a sensible default that allows operating this driver
with just qcom,num-strings in the DT; WLED 4 and 5 require
qcom,enabled-strings to be provided otherwise enabled_strings remains
zero-initialized, resulting in every string-specific register write
(currently only the setup and config functions, brightness follows in a
future patch) to only configure the zero'th string multiple times.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/qcom-wled.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 5c5df5a3deab..f975c1f6398b 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1079,6 +1079,7 @@ static const struct wled_config wled4_config_defaults = {
 	.cabc = false,
 	.external_pfet = false,
 	.auto_detection_enabled = false,
+	.enabled_strings = {0, 1, 2, 3},
 };
 
 static int wled5_setup(struct wled *wled)
@@ -1192,6 +1193,7 @@ static const struct wled_config wled5_config_defaults = {
 	.cabc = false,
 	.external_pfet = false,
 	.auto_detection_enabled = false,
+	.enabled_strings = {0, 1, 2, 3},
 };
 
 static const u32 wled3_boost_i_limit_values[] = {
-- 
2.33.1

