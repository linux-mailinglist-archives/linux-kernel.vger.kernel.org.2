Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A183D21F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhGVJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGVJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:34:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3BFC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:14:54 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6Vj8-00019T-N1; Thu, 22 Jul 2021 12:14:50 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1m6Vj7-0001KO-2k; Thu, 22 Jul 2021 12:14:49 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] watchdog: f71808e_wdt: migrate to new kernel API
Date:   Thu, 22 Jul 2021 12:14:39 +0200
Message-Id: <cover.c711be1db54f4e07c0153266dd1a831e92e3d49d.1626948810.git-series.a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series migrates the driver to the new kernel watchdog API and
then to the driver model.

This series migrates the driver to the driver model and then to
the new kernel watchdog API.

I tested it on a f81866.

v3 -> v4:
  - Prepend fix for wrong timeout report (Guenther)
  - Remove WDOG_HW_RUNNING setting in start as the watchdog can
    be stopped (Guenther)
  - Dynamically allocate watchdog driver data (Guenther)

v3 -> RESEND:
  https://lore.kernel.org/linux-watchdog/cover.dedd9f1159389b0a438076ef5e5a46aded186463.1612457906.git-series.a.fatoum@pengutronix.de/#t
  Didn't generate any feedback over 2 months. Resending for exposure.

v2 -> v3:
  https://lore.kernel.org/linux-watchdog/20201020062112.6762-1-a.fatoum@pengutronix.de/
  - factored out identifier renaming again for easier review
  - reordered commits
  - removed refactoring that can go in later. Focusing now on kernel watchdog
    API and platform device/driver migration
  - removed platform_device_id and changed code to match by name

v1 -> v2:
  https://lore.kernel.org/linux-watchdog/20200611191750.28096-1-a.fatoum@pengutronix.de/
  - reworked to platform device/driver pair (Guenther)
  - squashed identifier renaming into the patches that touch
    the respective lines anyway
  - fixed checkpatch.pl nitpicks (Guenther)
  - fixed locally used variable declared without static (0-day)
  - fixed unneded line break due to old line limit (Guenther)
  - renamed struct fintek_wdog_data to struct fintek_wdt

Ahmad Fatoum (5):
  watchdog: f71808e_wdt: fix inaccurate report in WDIOC_GETTIMEOUT
  watchdog: f71808e_wdt: rename variant-independent identifiers appropriately
  watchdog: f71808e_wdt: migrate to new kernel watchdog API
  watchdog: f71808e_wdt: refactor to platform device/driver pair
  watchdog: f71808e_wdt: dynamically allocate watchdog driver data

 drivers/watchdog/Kconfig       |   1 +-
 drivers/watchdog/f71808e_wdt.c | 608 ++++++++++------------------------
 2 files changed, 191 insertions(+), 418 deletions(-)

base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
-- 
git-series 0.9.1
