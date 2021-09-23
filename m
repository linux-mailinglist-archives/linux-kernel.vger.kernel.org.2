Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD841662A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbhIWTtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243014AbhIWTtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:49:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA3461241;
        Thu, 23 Sep 2021 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426466;
        bh=8gAVjCQcuHU63cgpeZZly60YG8tX7zNgE8V1Gh2jQD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q53yAWW4lFysR/jJfzqhynbMb9bac2+VT1IzIn0xu06gXQhHGO16XR+MNpH5pIrQD
         Sc7UIdyldcbyBCC8to+fiex2kckIfbKWr/0kIZjEI0qnA9gEEv0AVtyxIm78rhUDUa
         9agmzpl70emH2jvuq8+R46tTV52F9MLUd5qA7lqex7uyOqSjkq/vIffFYXvpcUo2wL
         yYrA9Ts8+eJRUZbENppeqZl3SNu3HenQHHAz1hyqbTITZp25An9p+I8DXbpm8BFGYV
         yNVNZT2V2fcazCK3wXFxVtJCKd4M6lw1dEv/bTYdgi3X4cmYAQTwvvyKIg2U9ZSY1i
         X03rj8AlkwtGg==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com
Subject: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device ID table
Date:   Thu, 23 Sep 2021 20:46:43 +0100
Message-Id: <20210923194645.53046-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923194645.53046-1-broonie@kernel.org>
References: <20210923194645.53046-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; h=from:subject; bh=8gAVjCQcuHU63cgpeZZly60YG8tX7zNgE8V1Gh2jQD4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTNmi0oH3aR5Vv2igaUZFg72i+tDaL0JLJWplsMsO P43tur2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzZogAKCRAk1otyXVSH0AEiB/ 9kFcK4QIaRsKCWx6X+4wuG1sBn0slHjjDBRq/8nojB4h6oQyqN0GWUQP7TiT3+TUbRc7VTJkf9/Fla QpDMYaRHNPn6gAQZ3H7MTF7pimuw4Pu7lZT9DdHGrGDavkbjbuvRPuAcA+nKS6qy78B4F8g4ZEyvC0 4jX4B6zkSsQR7in7s0XvrzN+HTpaxWgdwEeRvWa1JpOfDNq3RkgAzAckkmnKsc31uQwvFyMqoYmtld BuXoPAvLTFLdmumx4ciRhkPv8UWtvq990V6K6ANOUM8vhaX9E5z6mvjScQpDnB07y5rrnU+ssOK9OI LmwZzdKfRVmVdBh6VSlRIPFcf0pPsa
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding SPI IDs for parts that
only have a compatible listed.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com
---
 drivers/mfd/arizona-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index aa1d6f94ae53..8b44af297b7c 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -216,9 +216,12 @@ static int arizona_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id arizona_spi_ids[] = {
+	{ "wm1814", WM1814 },
 	{ "wm5102", WM5102 },
 	{ "wm5110", WM5110 },
 	{ "wm8280", WM8280 },
+	{ "wm8997", WM8997 },
+	{ "wm8998", WM8998 },
 	{ "wm1831", WM1831 },
 	{ "cs47l24", CS47L24 },
 	{ },
-- 
2.20.1

