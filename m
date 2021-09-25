Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC81C418453
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhIYUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:16:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45104 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhIYUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:16:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYHL106708;
        Sat, 25 Sep 2021 15:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632600874;
        bh=UHTxGOinvbShXHl3QZ3a/tr/5I/5/uQgQUpO/VY73jE=;
        h=From:To:CC:Subject:Date;
        b=o0NkDFGKgfSHhdLk+DmZWRYqO0O9EzIkmb7IgkzSnlzHEmO6UOal0nkddj21SF92W
         7xRO7SmYPxJv98fejn7+Xte3Oi7FJrJQQuc+UKzp/qNxFygm2I95kUK3+W9w943OFV
         CJJt0JUwW7DVrR9bNDAfQNFF1vc/PopfDcCSR9xU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18PKEYma130208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Sep 2021 15:14:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 25
 Sep 2021 15:14:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 25 Sep 2021 15:14:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYYi075483;
        Sat, 25 Sep 2021 15:14:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/4] arm64: dts: ti: k3-j721e/j7200: Introduce EVM compatible
Date:   Sat, 25 Sep 2021 15:14:26 -0500
Message-ID: <20210925201430.11678-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is prep work for potentially introducing new platforms for
j721e/j7200 and brings these evms on par with AM65 and AM64 usage
models as well for consistency.

Changes since v1:
* Modified the series so that backward compatibility is still maintained
* No more conflict or dependence with [1].
* Added consistency to am642/am654 platforms as well.

V1: https://lore.kernel.org/all/20210915121937.27702-1-nm@ti.com/

Jan: This series will probably conflict with [2] - I'd rather we did
this cleanup before we introduce new platform patches, lets see if a
rebase and repost may be needed.

Nishanth Menon (4):
  dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
  dt-bindings: arm: ti: am642/am654: Allow for SoC only compatibles
  arm64: dts: ti: k3-j721e-common-proc-board: Add j721e-evm compatible
  arm64: dts: ti: k3-j7200-common-proc-board: Add j7200-evm compatible

 .../devicetree/bindings/arm/ti/k3.yaml        | 35 +++++++++++++------
 .../dts/ti/k3-j7200-common-proc-board.dts     |  3 ++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  3 ++
 3 files changed, 30 insertions(+), 11 deletions(-)

[1] https://lore.kernel.org/all/6a6a0d3a-522c-d01c-d3b8-a13488d0c736@ti.com/
[2] https://lore.kernel.org/all/336ade4715b3d2f5f83c3ed8f3fa2989f5699578.1631708830.git.jan.kiszka@siemens.com/
-- 
2.32.0
