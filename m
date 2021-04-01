Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEF351E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhDASlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236986AbhDASSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A41D4610F7;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=iqEkzOwfz35mssL71H++7gGTRC+bi3L+mvzkZz9ceyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlxb/2DC/BLzpzjxnwk9uwYPsGo3eRl4yUxy/aYWMI6M26Q+gxOwPH5rdaRFhc9Pb
         yMvOjiAfjIHnOUTzvYB0RNxUObBvQ7Lltc8iq3N4G0ZpZhjm92TZDt83BSXr1tmhae
         bm1eWhbtr1jKDI7wG9LQqb6axjoYoxkEqCpdFW3//nGcjN+tzI10NrWBcKAbcrgm6m
         uEIfxySMaE6A+BLVGbWFGjMdhmC5h8riuLE46Q6AxZ/mY4po1ny58SoYCth2PSckfy
         2s8pI6zLI72fzqUu+NlWK96JKOTPorKz5i+Yg+RLPszfzj7u+GWDsPCE6SfXp6ddLm
         DH3Qsug0CgrzQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2S-KF; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ionut-robert Aron <ionut-robert.aron@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/32] MAINTAINERS: update fsl,dpaa2-console.yaml reference
Date:   Thu,  1 Apr 2021 14:17:24 +0200
Message-Id: <188e930100ecb7d4bd476681f3cc29fa536bdcde.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
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
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53c66a6908b7..de9637196526 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7274,7 +7274,7 @@ M:	Li Yang <leoyang.li@nxp.com>
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

