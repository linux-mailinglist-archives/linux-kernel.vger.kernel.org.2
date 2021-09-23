Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340D0416629
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbhIWTtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242885AbhIWTtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A23FF60F6F;
        Thu, 23 Sep 2021 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632426460;
        bh=ZzvVNd7jPA8uiP5Rg0l2L5ajWOXBgNof+eHF7UesUfs=;
        h=From:To:Cc:Subject:Date:From;
        b=MctM9Tchq+0z2AN87ZxoRJl32obZ2S2o+i5Ie4aeDlpDDNKFCc3ZG7rLkJjhUjIht
         Eumkf2gpOKNCCgts/91ptfqYFGjWle9MVqc6Dcd6oeLf4TCZRjTvkYxrPJo9IboeTA
         yd4eqDa2FzZoL8NFXSVLDbkDmTphOozcYxChQ/6k/v8eSzSNvbDj2FpfS6SHu9HwPj
         CDl4tQrbfDLz/X5/2MVwun+xCcdpg3L6nC+KRqWwYnhQJLsiKJtggs89FZjJc5H7nt
         /VCncXNr+OYUcf7+dbwv9vV1HrwAPiQ0GGhNHmq7p2wnG7OWeHOQfKEKZ5xL5UYPtm
         hBF5NBa0SHoOw==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/4] mfd: Ensure DT compatibles have SPI device IDs
Date:   Thu, 23 Sep 2021 20:46:41 +0100
Message-Id: <20210923194645.53046-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; h=from:subject; bh=ZzvVNd7jPA8uiP5Rg0l2L5ajWOXBgNof+eHF7UesUfs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTNmgEGyPD+NwBpff6ojuOxCKtZG8T9Cj02wS6iT9 gDEuksqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzZoAAKCRAk1otyXVSH0N/iB/ 9h2g1qAfnZl2Y6hhcT7x02MJtWM7TCeTSd8+WnbF0PBeo2c0kj2SGQP5mEX26vZ9KTpDF0B5VEAppG VkmN0fCrnmZ98WMYj4/eplyGu46PJgwgY+ijWm1W8qVZ7b/14ZhGf/PlABflt9cbgNpTqkwXlFMRod fzhgyAidYemlqbkhj6BAUbgHc7jW19LTwtwJkNY4RdW5a56K3fhcLnltxjt/x4Va4xsKry7r4INPJh P8/TwnzrW+00hXfApU8ThJzu3GrynFs5t+OseLewOhJiQ8eHa/M3JE1eihUcKXNzb7HaCTBDCS/8/u MKc4em0i1LKbVt2P+QQ0aPgO0zsodX
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so this series
adds SPI IDs where they aren't provided for a given modalias.

Mark Brown (4):
  mfd: altr_a10sr: Add SPI device ID table
  mfd: arizona: Add missing entries SPI to device ID table
  mfd: cpcap: Add SPI device ID table
  mfd: sprd: Add SPI device ID table

 drivers/mfd/altera-a10sr.c    | 8 ++++++++
 drivers/mfd/arizona-spi.c     | 3 +++
 drivers/mfd/motorola-cpcap.c  | 8 ++++++++
 drivers/mfd/sprd-sc27xx-spi.c | 7 +++++++
 4 files changed, 26 insertions(+)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.20.1

