Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919EB42E5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhJOA72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:59:28 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60552 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhJOA70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:59:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B8011A0977;
        Fri, 15 Oct 2021 02:57:20 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E888C1A095D;
        Fri, 15 Oct 2021 02:57:19 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2A46340A85;
        Thu, 14 Oct 2021 17:57:19 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 0/2] convert ifc binding to yaml and drop "simple-bus"
Date:   Thu, 14 Oct 2021 19:57:05 -0500
Message-Id: <20211015005707.1996-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ifc binding to yaml schema, in the mean while remove the
"simple-bus" compatible from the binding to make sure ifc device probes
before any of the child devices.  Update the driver accordingly.

DTS changes should be submitted after binding/driver changes are merged.

Changes in v2:
- Update endian property to type boolean
- Remove example subnodes that don't have yaml binding
- Spin DTS patches into a different series

Li Yang (2):
  dt-bindings: memory: fsl: convert ifc binding to yaml schema
  memory: fsl_ifc: populate child devices without relying on simple-bus

 .../memory-controllers/fsl/fsl,ifc.yaml       | 113 ++++++++++++++++++
 .../bindings/memory-controllers/fsl/ifc.txt   |  82 -------------
 drivers/memory/fsl_ifc.c                      |   7 ++
 3 files changed, 120 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt

-- 
2.25.1

