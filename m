Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567943AF065
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhFUQs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233080AbhFUQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:42:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C21ED613FD;
        Mon, 21 Jun 2021 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624293076;
        bh=UkDxa+fl9rFOLo1Io0faeV/fqWbjlXYKuHxxv5ocWTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9uPjHs9cXK3PEoIbJWjQZpFGmzlPGUJZG+rrSQxRQiRdztsfwPotrqgj7ylkDf+0
         2ISCaGz8puZsRzJ9QAIsj7Gs1ccK/mQV4YkVQlhhar3jYJkfEa3caQ0JdiWTl+Kxri
         izfYRFNrPBeWdpPZs+pAW5OLTvHnLNFis5KHA0gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 088/178] regulator: cros-ec: Fix error code in dev_err message
Date:   Mon, 21 Jun 2021 18:15:02 +0200
Message-Id: <20210621154925.674280513@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621154921.212599475@linuxfoundation.org>
References: <20210621154921.212599475@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 3d681804efcb6e5d8089a433402e19179347d7ae ]

Show proper error code instead of 0.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20210512075824.620580-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/cros-ec-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index eb3fc1db4edc..c4754f3cf233 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -225,8 +225,9 @@ static int cros_ec_regulator_probe(struct platform_device *pdev)
 
 	drvdata->dev = devm_regulator_register(dev, &drvdata->desc, &cfg);
 	if (IS_ERR(drvdata->dev)) {
+		ret = PTR_ERR(drvdata->dev);
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
-		return PTR_ERR(drvdata->dev);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, drvdata);
-- 
2.30.2



