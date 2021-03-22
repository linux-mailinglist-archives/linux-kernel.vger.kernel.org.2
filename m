Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44FC345006
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCVTiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:38:24 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:19231 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhCVTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:37:56 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 0535D1A966AA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:37:55 +0100 (CET)
Received: from s645.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id E8D852E29DBA;
        Mon, 22 Mar 2021 20:37:54 +0100 (CET)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s645.loopia.se (Postfix) with ESMTP id DEAA91579F93;
        Mon, 22 Mar 2021 20:37:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s500.loopia.se ([172.22.191.6])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with LMTP id 9K6bvFuAO9Re; Mon, 22 Mar 2021 20:37:54 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.157
Received: from localhost.localdomain (h-155-4-131-157.NA.cust.bahnhof.se [155.4.131.157])
        (Authenticated sender: carl@hgsystem.se)
        by s500.loopia.se (Postfix) with ESMTPSA id 3941F1E32F06;
        Mon, 22 Mar 2021 20:37:54 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 1/2] dt-bindings: Add trivial device entry for TPS53676
Date:   Mon, 22 Mar 2021 20:37:33 +0100
Message-Id: <20210322193734.75127-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20210322193734.75127-1-erik.rosen@metormote.com>
References: <20210322193734.75127-1-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trivial device entry for TPS53676

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a327130d1faa..2e29c2a91966 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -288,6 +288,8 @@ properties:
           - ti,tmp103
             # Digital Temperature Sensor
           - ti,tmp275
+            # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
+          - ti,tps53676
             # TI Dual channel DCAP+ multiphase controller TPS53679
           - ti,tps53679
             # TI Dual channel DCAP+ multiphase controller TPS53688
-- 
2.20.1

