Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176134176DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbhIXOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346862AbhIXOgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:36:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 620826124C;
        Fri, 24 Sep 2021 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632494074;
        bh=5nmWlPOlf76cHRd196p/3LPh7R1/24UZcY5b7lynh58=;
        h=From:To:Cc:Subject:Date:From;
        b=L89icAv6wAo2oztLYcQ+5MtVtK91jufoul5J7WAxSZ+zcMFJ3xDO3A9bUCdtxdqrW
         P6kOSmA7zeov/3LYuG1J1BPnlSHmMFEl7YBobTgdsi/SAuAJ290w7f1scGpkRY1Lu0
         QNt/QDV1rHJLpkq5qDnlFQu1GVnBD4PooIlvQq7AtysCWWdt2IZ+f7NstOXgf6At6b
         3KsHi6WFN6BOsMtLnbKYYuvXu2kIC5tl/zblkLpc9MZPALa33GF4zlCqpJQTasjI3r
         PooA+5KDwhyDotgfQ95HBFvie4Z7xPt6mVCrjvcAEZVIecshe2MOcg5jgK5ofjVBSt
         Tz3WTH3JDGwWA==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] mfd: Ensure DT compatibles have SPI device IDs
Date:   Fri, 24 Sep 2021 15:33:44 +0100
Message-Id: <20210924143347.14721-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=778; h=from:subject; bh=5nmWlPOlf76cHRd196p/3LPh7R1/24UZcY5b7lynh58=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTeHHITpi0wZsnjOz3xw2qhSN/oCRGm5XzvAz/dL5 9LiWsk+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYU3hxwAKCRAk1otyXVSH0L+FB/ 91brDo1yHiSJEXe9DijVV+kBNQXtH+VqJffUf1cgcZOuVSoGikdv2FggWIhaLCaoYEikMqnXJzH6JN beEq9bhPIFb1VmJ36MdxVRd84W0Ep69Qe8J0yWwVBSxFLzxy00V+zlMDdvj6s7dIp/9tegJ3d2oGFI FTSAGC72FlcTWzVz5UfGVYyC9R3BJIkk0DBq3Xg3CSGHuv8llLhKakUB8eAP8YqKCqEt14uxc38IXQ DQJ9x1/+tLQcTkGZluOJiq/VnZ3/YvfmR0uuZcR/T/XV/bWvFfxX2JwzmYlR+Tnrg3+wMmhKlFDosx nznipfNUGCwt0gv/m/p/0xfhVGK0DN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so this series
adds SPI IDs where they aren't provided for a given modalias.

v2:
 - Drop the arizona patch since the code is apparently intentional and
   shouldn't autoload on SPI.

Mark Brown (3):
  mfd: altr_a10sr: Add SPI device ID table
  mfd: cpcap: Add SPI device ID table
  mfd: sprd: Add SPI device ID table

 drivers/mfd/altera-a10sr.c    | 8 ++++++++
 drivers/mfd/motorola-cpcap.c  | 8 ++++++++
 drivers/mfd/sprd-sc27xx-spi.c | 7 +++++++
 3 files changed, 23 insertions(+)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.20.1

