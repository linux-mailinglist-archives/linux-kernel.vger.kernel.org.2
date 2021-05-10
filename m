Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BF3379135
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhEJOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:46:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36272 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343800AbhEJOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:44:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDhI058741;
        Mon, 10 May 2021 09:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620657793;
        bh=J/dyqansxN5JKHd75Nozq5aC4QIjOnuXKswbpvsBbB4=;
        h=From:To:CC:Subject:Date;
        b=BhEk+Ay+3Z5NqXKtg2QaYthZjP0BKLKpHR7P1RlAnsLDeEZnHPxBajTpJifVSl2l5
         PLU4qzGtEfceZ5lKsGsdhbeVarFtBD5QTlxk0FjznbIKIP0F7lD+uZfnt8FsHQiUaJ
         njuTBv/WSw0xsrENPeklWLGBZMqYjlsOVhQKtWSI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEhDcg117450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:43:13 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:43:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:43:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhCmj126632;
        Mon, 10 May 2021 09:43:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] ARM: dts: keystone: k2g: Update dts node for yaml
Date:   Mon, 10 May 2021 09:43:08 -0500
Message-ID: <20210510144312.986-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series of patches to cleanup the dts for k2g to sync the dts
with yaml fixups (information provided per patch)


Basic tests performed on k2g-evm. Series has been based on v5.13-rc1 -
will be good to get it in the 5.13 window if possible.

Nishanth Menon (4):
  ARM: dts: keystone: k2g: Rename message-manager node
  ARM: dts: keystone: k2g: Rename the TI-SCI node
  ARM: dts: keystone: k2g: Rename the TI-SCI clocks node name
  ARM: dts: keystone: k2g-evm: Move audio oscillator assigned clock to
    mcasp

 arch/arm/boot/dts/keystone-k2g-evm.dts | 11 +++--------
 arch/arm/boot/dts/keystone-k2g.dtsi    |  6 +++---
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.31.0

