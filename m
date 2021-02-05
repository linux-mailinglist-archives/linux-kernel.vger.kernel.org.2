Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF63119F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhBFDZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhBFCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:42:59 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FDC08EC66
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:29:39 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 21106AEDEF7; Fri,  5 Feb 2021 23:28:57 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/5] dax-device: Some cleanups
Date:   Fri,  5 Feb 2021 23:28:37 +0100
Message-Id: <20210205222842.34896-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I didn't get any feedback for the (implicit) v1 of this series that
started with Message-Id: 20210127230124.109522-1-uwe@kleine-koenig.org,
but I identified a few improvements myself:

 - Use "dax-device" consistently as a prefix
 - Instead of requiring a .remove callback, make it explicitly
   optional. (Drop checking for .remove from former patch 1, introduce
   new patch "Properly handle drivers without remove callback")
 - The new patch about remove being optional allows to simplify one of
   the two dax drivers which is implemented in patch 4
 - Patch 5 got a bit smaller because we now have one driver less with a
   remove callback.
 - Added Andrew to To: as he merged dax drivers in the past.

Andrew: Assuming you consider these patches useful, would you please
care for merging them?

Best regards
Uwe

Uwe Kleine-König (5):
  dax-device: Prevent registering drivers without probe callback
  dax-device: Properly handle drivers without remove callback
  dax-device: Fix error path in dax_driver_register
  dax-device: Drop an empty .remove callback
  dax-device: Make remove callback return void

 drivers/dax/bus.c    | 22 ++++++++++++++++++++--
 drivers/dax/bus.h    |  2 +-
 drivers/dax/device.c |  8 +-------
 drivers/dax/kmem.c   |  7 ++-----
 4 files changed, 24 insertions(+), 15 deletions(-)


base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.29.2

