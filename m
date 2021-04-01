Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64439351E61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhDASkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239656AbhDASQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35C7B61179;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=ejZm762Qzd+UdOvVPRBKVDY7EbQAoeesNbw8pESQu0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuQI7ZcKtC1UANGXo7guPLOAwBDFqYn/Y6Nlz6nhUBUZwtzh8PKh1fmTsCka2GGdU
         aGLvf7Ag9uLj4yC67KxJXLpEyyJLtJbCuS15JyZTeg6EM6SrbyD3Z+290dtD18y4ik
         L7C9ZkdsB40RWUPRNqSwj8v4jBCyJNnj2AswQDb/tP0mCLZTODMpdZXO7hokeGeRsc
         +DWnvPV3ZCtY3RxEOwqQGqCJau50aRzMBaAM9DZRTPUgdOFWQ6yduIxG0h3i1j1JsF
         vfAPrhpwtUS4VsKYhfOEEJKoVofUQH+a1MVD5Vt2Gv+97zOPSAglTZ8cv6doAhPq1h
         iCLXAhNON3afg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3B-7J; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 20/32] MAINTAINERS: update snps,dw-axi-dmac.yaml reference
Date:   Thu,  1 Apr 2021 14:17:40 +0200
Message-Id: <ff7b363632716c150f6e1e2a99a31f3ac1bf6795.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
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
index d6708b3fdbd9..6b0a6f251e6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17491,7 +17491,7 @@ F:	drivers/spi/spi-dw*
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
+F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
 F:	drivers/dma/dw-axi-dmac/
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
-- 
2.30.2

