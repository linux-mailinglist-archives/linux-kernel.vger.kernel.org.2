Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EDD4201B8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 15:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhJCNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhJCNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 09:35:35 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6620C0613EC;
        Sun,  3 Oct 2021 06:33:47 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3A636C1D32E;
        Sun,  3 Oct 2021 15:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1633268026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mIYYiuaK7RnIFNO4Pd0IkOhjPGFSnIVabnzRF0jk9y8=;
        b=PiKrIFsX7Tyw7ZOQrf98SI4kBpEEpEm6WxK2eqRoWjLhGyr6qkCCSECiH6SVMtEetdnU8u
        PCfQIbO9eQJ/vj9BSnDalDpSD017VyyK48fETe2tG3UKq2DDoBkT86GLKaq5bk8tDt7igd
        TbI+yMUNY6RaUP/bCq1iHkVUMj5PJv0=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: [PATCH 0/3] hwmon: add ASUS Pro WS X570-ACE support
Date:   Sun,  3 Oct 2021 15:33:41 +0200
Message-Id: <20211003133344.9036-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on hwmon-next + [1].

ASUS Pro WS X570-ACE board carries an nct6775 chip, which needs proper
support without kernel command line quirk. Also, the sensors of this
board can be monitored via BREC WMI method.

This submission addresses both issues.

Please review.

Thanks.

[1] https://lore.kernel.org/lkml/20211002210857.709956-1-pauk.denis@gmail.com/

Oleksandr Natalenko (3):
  hwmon: (nct6775) add Pro WS X570-ACE
  hwmon: (asus_wmi_sensors) split out T_Sensor
  hwmon: (asus_wmi_sensors) add Pro WS X570-ACE

 drivers/hwmon/asus_wmi_sensors.c | 19 ++++++++++++++++---
 drivers/hwmon/nct6775.c          |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.33.0

