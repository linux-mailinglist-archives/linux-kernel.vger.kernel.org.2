Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7900A345005
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhCVTiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:38:16 -0400
Received: from smtp.outgoing.loopia.se ([93.188.3.37]:19081 "EHLO
        smtp.outgoing.loopia.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhCVThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:37:51 -0400
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 943FE1A9555A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:37:48 +0100 (CET)
Received: from s645.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 83DF62E29DC0;
        Mon, 22 Mar 2021 20:37:48 +0100 (CET)
Received: from s474.loopia.se (unknown [172.22.191.5])
        by s645.loopia.se (Postfix) with ESMTP id 76DB41579FBA;
        Mon, 22 Mar 2021 20:37:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-999 required=6.2
        tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from s500.loopia.se ([172.22.191.6])
        by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
        with LMTP id Y9M4kmGR0kRr; Mon, 22 Mar 2021 20:37:47 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 155.4.131.157
Received: from localhost.localdomain (h-155-4-131-157.NA.cust.bahnhof.se [155.4.131.157])
        (Authenticated sender: carl@hgsystem.se)
        by s500.loopia.se (Postfix) with ESMTPSA id 91D641E32E7C;
        Mon, 22 Mar 2021 20:37:47 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH v2 0/2] Add hardware monitoring support for TI TPS53676
Date:   Mon, 22 Mar 2021 20:37:32 +0100
Message-Id: <20210322193734.75127-1-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hardware monitoring support for TI TPS53676 Dual-channel D-CAP+,
dual-channel (N + M <= 7 phases) step-down, multiphase controller
with AVSBus.

The support is added to the existing pmbus/tps53679 driver.

This patch has been tested with a Flex BMR474 converter.

v2
-Shorten commit message line length
-Add length check on returned data from USER_DATA_03 register
-Reorder i2c_device_id list alphabetically

Erik Rosen (2):
  Add trivial device entry for tps53676
  Add support for TPS53676

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 Documentation/hwmon/tps53679.rst              | 13 ++++-
 drivers/hwmon/pmbus/Kconfig                   |  4 +-
 drivers/hwmon/pmbus/tps53679.c                | 51 ++++++++++++++++++-
 4 files changed, 65 insertions(+), 5 deletions(-)


base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.20.1

