Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5283776FC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEIOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 10:33:13 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:45437 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhEIOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 10:33:12 -0400
Received: from grover.RMN.KIBA.LAB.jp (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 149EVSmU017769;
        Sun, 9 May 2021 23:31:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 149EVSmU017769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1620570688;
        bh=G3dhZI2nEP2lqV1Crk/J+8JZ6EDNlHY8x4P5T08t35A=;
        h=From:To:Cc:Subject:Date:From;
        b=edFxT94kKcgAscGEQryn+T5qC5Q1nElQ7G2rEZ7SU0PBzcE47xTIrpObphuL8OXRS
         hpRTDYOoXRYG5ZmegWYyAnFA/eY0mNiT0BM2NOASi29CgrVrqdEurZkdSstnVB1gqT
         SV1lC/8ewZgsEhHC47xCtz/r6BVzZWuZ05zTl8MMyU6K5UiVs+Jlyw+7VJkEdzrfyI
         Pmrn1/ollru0iw80vI2Xfb77jVnxsxfykWjhiotj/rijgEZKPdI1lnr9bbxvet5cKk
         yazmlEyPsIFqOHaOFKeOU1AMLo3T/09zcaaiSkiiRbbGrVh8oEtNqiBy/SVb32d3SR
         kRqwcB9/02vXQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: add arch/nds32/boot/.gitignore
Date:   Sun,  9 May 2021 23:31:24 +0900
Message-Id: <20210509143124.259483-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore arch/nds32/boot/Image.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nds32/boot/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/nds32/boot/.gitignore

diff --git a/arch/nds32/boot/.gitignore b/arch/nds32/boot/.gitignore
new file mode 100644
index 000000000000..9182a3a1ea0a
--- /dev/null
+++ b/arch/nds32/boot/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/Image
-- 
2.27.0

