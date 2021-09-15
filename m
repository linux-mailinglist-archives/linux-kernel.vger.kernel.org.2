Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B9240C517
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhIOMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:21:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58728 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhIOMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:21:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FCJcAu091558;
        Wed, 15 Sep 2021 07:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631708378;
        bh=kX94pddVeiqk451vWyTIQ+YtT8djrWa9lv4p4TwY5qQ=;
        h=From:To:CC:Subject:Date;
        b=MxZQYQFf/MB1AovsIdbjRL/UXPFRc/aL9m8aKsI4CI8Xe3K6MQ8OfpNzv9AquaqUh
         dG1L4uAnbd7zqwzHvNSJc0igeJ2BVzhDSn3zqoVVGzSOHRzDzIicMKZnU0AsWyaBq6
         4pycmjRg4noE02DmHrfmL7lO3qlPqp23Ys0A3KsA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FCJcsO089479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:19:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 07:19:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 07:19:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FCJb9u102921;
        Wed, 15 Sep 2021 07:19:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: k3-j721e/j7200: Introduce EVM compatible
Date:   Wed, 15 Sep 2021 07:19:34 -0500
Message-ID: <20210915121937.27702-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is prep work for potentially introducing new platforms for
j721e/j7200 and brings these evms on par with AM65 and AM64 usage
models as well for consistency.

Nishanth Menon (3):
  dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
  arm64: dts: ti: k3-j721e-common-proc-board: Add j721e-evm compatible
  arm64: dts: ti: k3-j7200-common-proc-board: Add j7200-evm compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml      | 4 ++++
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 3 +++
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 3 +++
 3 files changed, 10 insertions(+)

-- 
2.32.0

