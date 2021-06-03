Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAC39A1A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFCM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFCM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:57:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B32C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:55:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 6EF3C1F43044
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] Initialize debugfs/ksysfs earlier?
Date:   Thu,  3 Jun 2021 15:55:33 +0300
Message-Id: <20210603125534.638672-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg & all,

I would like to add a new debugfs file like in the next patch but
I'm having a problem with commit 56348560d495 ("debugfs: do not
attempt to create a new file before the filesystem is initalized").

The problem is debugfs is initialized after the driver core, during
the core initcall, so I get an -ENOENT failure due to the above commit.

My first reaction is to move the ksysfs_init() and debugfs_init() calls
before the driver core init which works. Would that be ok?

An alternative would be to create the new debugfs file somewhere else
than the driver core, but I'm not sure where would be a good location,
maybe in debugfs_init()? Doesn't seem right.

Any guidance is appreciated, thank you,
Adrian

Adrian Ratiu (1):
  drivers: base: Expose probe failures via debugfs

 drivers/base/core.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
 lib/Kconfig.debug   | 23 ++++++++++++++
 2 files changed, 96 insertions(+), 3 deletions(-)

-- 
2.31.1

