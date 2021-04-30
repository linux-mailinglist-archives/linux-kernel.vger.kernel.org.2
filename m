Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6F370085
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhD3SdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:33:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhD3SdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B923FB0BE;
        Fri, 30 Apr 2021 18:32:23 +0000 (UTC)
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-leds@vger.kernel.org, linux-block@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] leds: trigger: introduce block trigger
Date:   Fri, 30 Apr 2021 15:32:09 -0300
Message-Id: <20210430183216.27458-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by https://lore.kernel.org/linux-leds/20190817145509.GA18381@amd/T/
and the ledtrig-usbport implementation.
    
This patch series introduce a new LED trigger for block devices.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>

Enzo Matsumiya (2):
  block: export block_class and disk_type symbols
  leds: trigger: implement block trigger

 block/genhd.c                        |   2 +
 drivers/leds/trigger/Kconfig         |  10 +
 drivers/leds/trigger/Makefile        |   1 +
 drivers/leds/trigger/ledtrig-block.c | 293 +++++++++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 drivers/leds/trigger/ledtrig-block.c

-- 
2.31.1

