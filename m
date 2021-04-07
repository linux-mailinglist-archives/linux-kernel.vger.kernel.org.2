Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C92356686
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhDGIVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237894AbhDGIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 429FC6139E;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=wQ3lAJ0NwM/z+yF01co43glK2InsyB10tr190DEbq5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKvU+6+2Hru9H5UKB5gHeTeA1MhX6XoWwjK96MBvC37PG7BUNfMe9epy8qsNY7uxW
         YcGkNjRNam/YUChlO4SYCf8m2SC3lF8NQgKG2+5LUz0Eq8oXPq+z3YklGpCp//lbuV
         nmPGeX/pja6WhQwk/e3m99Gf3RETJmIypI+nSu6IKv8+GTRNSrTobmYESDxK1Tq5hb
         NviDrhDiTHjtXbrAuQSt52BC4a/YMKYBvlY0gj9NP9pog9IRg46fTsBuAg5H0Y1fqQ
         9EIwYa1q93rRKvPj7Yvsk91AcHHS4Owjl+0H0xlKYwCrawgec+f2Dfdh4fTWmGiwvC
         9/GnVVeqIhhNg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2A-9k; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ionut-robert Aron <ionut-robert.aron@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/19] MAINTAINERS: update fsl,dpaa2-console.yaml reference
Date:   Wed,  7 Apr 2021 10:20:42 +0200
Message-Id: <4f860edc299b7addc1d4c234263b7bbdea9d32e4.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 616fde2dd60f ("dt-bindings: misc: convert fsl,dpaa2-console from txt to YAML")
renamed: Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
to: Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml.

Update its cross-reference accordingly.

Fixes: 616fde2dd60f ("dt-bindings: misc: convert fsl,dpaa2-console from txt to YAML")
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16a9c89755f1..02e29e4461a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7211,7 +7211,7 @@ M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
+F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
-- 
2.30.2

