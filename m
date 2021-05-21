Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B138C0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbhEUHcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhEUHcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:32:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A59C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:30:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kr9so2456452pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1pQHNInEJ2t9IMrJL3dGH2znJRf89XnI7Xv2706QSc=;
        b=1Vn6iajOgijz4OYdttKQdObyD/kNSmykKLESaushULk3o5tzWdomPCnEa6k9mGGblQ
         Dl6XpAS/IFWnum3sltTKFiMDvNRwwl7cN5BTmnfD+YQsdSrgFdOQAuf4A/CXT8La6WW6
         Mej1iWNwuh9syEKAIwViBx2nZD3mErrzjyMpy2cn3z5goDj5UVR7dzpt2m1o9+AIi1lP
         5/3Xy6/5IvEuo6hAxrs9w1TXKdmKmmG/gsVcIzsSamrl239+NmuDKE1pg4790mYEuJ5t
         zVeauOmHWaKZQ77aJbkrfeArRk7dW6N9A4S1gU1M7ZRjgk2e6JfSSBzxHth4tdLoRC53
         n4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1pQHNInEJ2t9IMrJL3dGH2znJRf89XnI7Xv2706QSc=;
        b=cDF+BFAv+xu1mTSfidDwBtOl34Nnj38ddzcPHE3P5vPaC55svqOrQVMVaqDkiZR41P
         UHNhmRL26JkoG/hm4RTf3DsAllrTpSObVZabuXH2DR6v8yWo9YcdaZC4NsaalSlJ/eNl
         Mo0TcOw3ilpGJPLIcMMGUGXF53VsIMQw2+gv6IAgduEMewqrON1C6Ph5mJF811DwacUZ
         b1WYYeE+D178bQ/v0mIdzLGQOrw+ICH16LxtPCr/BX1tkR1YBemoJuzx9O6/Y7ACI8Rj
         KxXKK6Cf2SlAFWZje6vzzGey8WKe7Jyt8QTekchZ1tZB8FDHyMY1YzAwJ8+e4HjiF77v
         P3oA==
X-Gm-Message-State: AOAM531Lzmd4eqvzFxIqD2iiejgnqCZmVvn8HshGbKO0VohCOTdsCCV9
        hyXM/vhYh1nt0YxkH5ol/Fdd4Q==
X-Google-Smtp-Source: ABdhPJy05Lnr9/bhYwmHWytqKBYJ+td2XlP0lUUQgrpnna8J0dBa+F93xrSxUVqf+/nBiGKTs11R5g==
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr9366875pjb.26.1621582254317;
        Fri, 21 May 2021 00:30:54 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id i8sm3436516pjs.54.2021.05.21.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:30:53 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: scmi: Fix off-by-one for linear regulators .n_voltages setting
Date:   Fri, 21 May 2021 15:30:20 +0800
Message-Id: <20210521073020.1944981-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For linear regulators, the .n_voltages is (max_uv - min_uv) / uv_step + 1.

Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/scmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index bbadf72b94e8..1f02f60ad136 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -173,7 +173,7 @@ scmi_config_linear_regulator_mappings(struct scmi_regulator *sreg,
 		sreg->desc.uV_step =
 			vinfo->levels_uv[SCMI_VOLTAGE_SEGMENT_STEP];
 		sreg->desc.linear_min_sel = 0;
-		sreg->desc.n_voltages = delta_uV / sreg->desc.uV_step;
+		sreg->desc.n_voltages = (delta_uV / sreg->desc.uV_step) + 1;
 		sreg->desc.ops = &scmi_reg_linear_ops;
 	}
 
-- 
2.25.1

