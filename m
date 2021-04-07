Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72526356675
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbhDGIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237335AbhDGIVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4798F61246;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=Rfxsd1gJB9wN8MiDPb4ZjhB+fZI/Qc2ZbwxqA8pwT7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YL3mOOGYjs3nqsB7WzBZsarry/FtXZ/BQj9GYSkLmkB86EGXQ3p59njs7GOAul64g
         JObZyrb8vzQem7vY5TWpUbivvSkh8MjaCv+d52ebPvnuF4aP5hChaR3Y8KyowoaqmU
         sXfX04dIQwr9sv3XxN12HwUPHSrlRE2WFCvRqJbFGihXa+94gdBLWew/6csdvNbPxQ
         fLrBDv4Kqtq6qrtbJqrXwPYcGgP0qgttOqGnt+vFp91ZfAdvW8jNuaPx9STY235uup
         H9gDPTf8XSFLfGI3OXhDWU8Cr967urmyyNwfErH3HT3YpsiSiulNyBS+OJfBaHatRf
         TIrlvrfZmrj0w==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2E-CW; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/19] MAINTAINERS: update snps,dw-axi-dmac.yaml reference
Date:   Wed,  7 Apr 2021 10:20:44 +0200
Message-Id: <133179ca2d6597ced45da402d6d9324138f3ff39.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 8c70fb7e0a0a ("dt-bindings: dma: Add YAML schemas for dw-axi-dmac")
renamed: Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
to: Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml.

Update its cross-reference accordingly.

Fixes: 8c70fb7e0a0a ("dt-bindings: dma: Add YAML schemas for dw-axi-dmac")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 735d48d18a57..dbc123bde7dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17285,7 +17285,7 @@ F:	drivers/spi/spi-dw*
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
+F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
 F:	drivers/dma/dw-axi-dmac/
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
-- 
2.30.2

