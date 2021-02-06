Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF36311CD6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBFLOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFLOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:14:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D09D64E5E;
        Sat,  6 Feb 2021 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612610030;
        bh=TkP9ZC6QFQ1gX7yjVfisqOotY4VCchxyp7FwY0Tl1gc=;
        h=From:To:Cc:Subject:Date:From;
        b=NrB9TV7N9mCzPM9mIC5b9pLL3wEMnwt+lJatfJoTzbCATu/GYGP4gh/JOj4hgkAxW
         2RhmBCeOh79lNXjQUSMze97K0PYemUN94tYl4Pncyz58tEzbKcw59n5GLDHHGGSyw3
         7fE2welF1XFhefSFN/yuCx6E2A0iGmIV2/KBJJ2gKOTT/2Vtb854WJgkqSTye6yG4d
         jRoMVLdp0+ao8SegRy1BimPEt9vCllOqVfoz7mwZ0W25PBulnGxzeR3Y/i0kexnhKN
         Md3RA4SRQY2ytojW45xxQQL+uHkvMaMsZo+BEywr0BWxP8qw+Qo4n0ROjUTl1v5f1P
         IHKdCmTGBtYQw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] memory: ti-emif-pm: Drop of_match_ptr from of_device_id table
Date:   Sat,  6 Feb 2021 12:13:43 +0100
Message-Id: <20210206111343.19273-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might be not relevant here).  This
fixes compile warning (!CONFIG_OF with clang):

    drivers/memory/ti-emif-pm.c:238:34: warning:
        unused variable 'ti_emif_of_match' [-Wunused-const-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/ti-emif-pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
index 6c747c1e98cb..179fec2da56d 100644
--- a/drivers/memory/ti-emif-pm.c
+++ b/drivers/memory/ti-emif-pm.c
@@ -340,7 +340,7 @@ static struct platform_driver ti_emif_driver = {
 	.remove = ti_emif_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.of_match_table = of_match_ptr(ti_emif_of_match),
+		.of_match_table = ti_emif_of_match,
 		.pm = &ti_emif_pm_ops,
 	},
 };
-- 
2.25.1

