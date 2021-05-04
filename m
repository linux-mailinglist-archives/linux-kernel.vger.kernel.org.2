Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59D3729A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhEDLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhEDLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:49:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B89C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 04:48:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zg3so12672228ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZKw17Y6Eu5a8sxvLIrFLfxkEizM6QV3DVVZZEdS/rU=;
        b=OnYC6S9iWXIxsdpdyW/QtLTRf8feHepvehG7VkmZuTC6eS1nil38GiXi3UczBI7+0M
         4lIxDqssnU71JyOcDpAY3eTLulPMVM0npYc50EkL3JLfp0oPsB8vk1U/XRW3uq9jw5XH
         8WGFkRUzSRH1GK0o1K2HKRTZjVpy7dqqZboGZE7f+6EIlYBauxxWWlK4KT259RNoUCtQ
         MTH7OM7BHJDeJTWhUixHGR228F+38wAN6pWz1u981wm/CMnuZLa299IoYBi89j6pOX0r
         cnEa+jQZ8wotpBBjUTDc/gVE9FZrBWMeT7jTsGk2Rb6ke7Y+fSq4VlrGX17eMbYRTvcs
         7A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZKw17Y6Eu5a8sxvLIrFLfxkEizM6QV3DVVZZEdS/rU=;
        b=PRj2tkMmKgLruXTPoeSAXQ9CrFsOgYFQkkp5ezWXzNSX5fKrZ0tgJ8JCBLI09XVzIW
         CJ9qNccmM5NgnHJxSn0ol61XMrustjXqZZlcm3S7G1rII1zwV+A57jQxHw77t8O17s3g
         vTu2S+tFwYBMVB+A3lTZQvCko/QbhMZoAtVFA/9iuzPJeTYkomzatbtZ4QzysQ/QXYbt
         moHoJKpt27t8rZgpom0csg/Lt5+OhWZuEnYSDX5a9soXnjYKe/hJGYbMDffeJ90/YXVy
         lTiL8b9qxeXdjRS6kUp3TmuPH3y268rd0Lm6nG0HM8SKZKnrkxne/K5j03slqfXKiL7M
         gFlQ==
X-Gm-Message-State: AOAM533WIlG+IjYNGbX0sH8+h59u9GKBJKBBpTwNpUicgwYcbnxQwPJI
        FdeEUjoJrMS7ulR70UNxpBe1Kg==
X-Google-Smtp-Source: ABdhPJw5prlTKIg+b6kYNCxo5TticYdFBD5NzEUsHC2CbZNk36nyuhybvkttL6kuw7I2tbtcygq75A==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr21420087ejj.366.1620128912296;
        Tue, 04 May 2021 04:48:32 -0700 (PDT)
Received: from localhost.localdomain (dh207-98-12.xnet.hr. [88.207.98.12])
        by smtp.googlemail.com with ESMTPSA id t22sm14149944edw.29.2021.05.04.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:48:31 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] soc: qcom: socinfo: Add remaining IPQ6018 family ID-s
Date:   Tue,  4 May 2021 13:48:26 +0200
Message-Id: <20210504114826.64376-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID for IPQ6018 was previously added, but ID-s for rest of the
family are missing.
So, lets add those based on downstream driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/soc/qcom/socinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index f6cfb79338f0..28bbc7a9227e 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -255,6 +255,9 @@ static const struct soc_id soc_id[] = {
 	{ 351, "SDA450" },
 	{ 356, "SM8250" },
 	{ 402, "IPQ6018" },
+	{ 403, "IPQ6028" },
+	{ 421, "IPQ6000" },
+	{ 422, "IPQ6010" },
 	{ 425, "SC7180" },
 	{ 455, "QRB5165" },
 };
-- 
2.31.1

