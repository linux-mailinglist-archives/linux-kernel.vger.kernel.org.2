Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5C33907C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhCLO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhCLO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A9DE64FF3;
        Fri, 12 Mar 2021 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560969;
        bh=Ywd2fbIlwdEKuoislyKBKy60FlzB2Pp3hQxuP2yVuMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaDs2NOneOopLzjjXKp+V7QkdvG+dKYTsqW2+f6U4FrswBtMZ/Fs6EMTWOwIh9RLN
         KB09cZ+LOOee+GnsafGTvSdMZ6iJFs6TMGRF7tguuwPZ4AKW9j3ERIXF2VbsnkCKut
         jqclKst7d4ITY/+wIhrhmA1eJIGthFDH46ztVXlq6GqnEwBU2Fi/WFFujtmKzcN/BQ
         sJ6+1ykH7jrtAg1KaZqHEPpt5tLtGUGl+8X/ES/bgmweOQ7GIXJUfXAjjHjdcLzEBQ
         t+p6C7D45BgL5d7e1p1EThv+GQlR1erqkJC1TEsprZYGztHA0cfsrP3LGkIrxeylkz
         VpOw3RoKFLeZA==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 3/7] mfd: mt6397: Drop of_compatible for regulator
Date:   Fri, 12 Mar 2021 15:55:41 +0100
Message-Id: <20210312145545.26050-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

For regulators a compatible string is superfluous. Drop the string.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/mfd/mt6397-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 7518d74c3b4c3..13037f4bc54e7 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -67,7 +67,6 @@ static const struct mfd_cell mt6323_devs[] = {
 		.of_compatible = "mediatek,mt6323-rtc",
 	}, {
 		.name = "mt6323-regulator",
-		.of_compatible = "mediatek,mt6323-regulator"
 	}, {
 		.name = "mt6323-led",
 		.of_compatible = "mediatek,mt6323-led"
@@ -87,7 +86,6 @@ static const struct mfd_cell mt6323_devs[] = {
 static const struct mfd_cell mt6358_devs[] = {
 	{
 		.name = "mt6358-regulator",
-		.of_compatible = "mediatek,mt6358-regulator"
 	}, {
 		.name = "mt6358-rtc",
 		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
@@ -107,7 +105,6 @@ static const struct mfd_cell mt6397_devs[] = {
 		.of_compatible = "mediatek,mt6397-rtc",
 	}, {
 		.name = "mt6397-regulator",
-		.of_compatible = "mediatek,mt6397-regulator",
 	}, {
 		.name = "mt6397-codec",
 		.of_compatible = "mediatek,mt6397-codec",
-- 
2.30.1

