Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9702438D40F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhEVGzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:55:19 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:24644 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229865AbhEVGzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:55:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id 7itr2500C21Fzsu03itsYF; Sat, 22 May 2021 08:53:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 08:53:52 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/5] misc/pvpanic: Fix some errro handling path and simplify code
Date:   Sat, 22 May 2021 08:52:35 +0200
Message-Id: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie was previously sent in 2 parts, one for -pci.c and one for
-mmio.c.
Execpt the patch 5/5 which is new, the 4 first patches are the same as the
ones previously posted. Only the description has been slighly updated.

Pacth 5/5 is a proposal to simplify code and turn 'pvpanic_probe()' into a
fully resource managed version.
This way callers don't need to do some clean-up on error in the
probe and on remove.


"Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>" was only
added on patch 1 and 3. I was unsure if his Reviewed-by was also related to
the s/GFP_ATOMIC/GFP_KERNEL/ of patch 2 et 4.

Christophe JAILLET (5):
  misc/pvpanic-pci: Fix error handling in 'pvpanic_pci_probe()'
  misc/pvpanic-pci: Use GFP_KERNEL instead of GFP_ATOMIC
  misc/pvpanic-mmio: Fix error handling in 'pvpanic_mmio_probe()'
  misc/pvpanic-mmio: Use GFP_KERNEL instead of GFP_ATOMIC
  misc/pvpanic: Make 'pvpanic_probe()' resource managed

 drivers/misc/pvpanic/pvpanic-mmio.c | 17 ++--------------
 drivers/misc/pvpanic/pvpanic-pci.c  | 22 ++++-----------------
 drivers/misc/pvpanic/pvpanic.c      | 30 ++++++++++++++---------------
 drivers/misc/pvpanic/pvpanic.h      |  3 +--
 4 files changed, 22 insertions(+), 50 deletions(-)

-- 
2.30.2

