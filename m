Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703FF3FBED8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhH3WMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbhH3WLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C7C061292;
        Mon, 30 Aug 2021 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=R3HkEdIHiJGxr3qjSmlIsWUqgZslXmlZn4O75MC8KaA=; b=17ZB/P3XkJ6X2AFl2We58UPTKh
        3ORcVk2toSPLNMYedttXPKFCsdbviJeOSTIa3+3/xiqaO/eQZfrbVosHFo1Ho6DRP+2SNUq+6Fg4a
        2fHKO/Hd11fm6w3qXCNc+7db1sFC9bibAV61DnYCCUJX33+82zIndMPT3jgrguhZCmJRZS3sfFOP8
        A3Km4ANvZNLcdD7hNfgkXlYUWesUcmwS/LHMV3khtolzAoF5Vy5AaA8iReY2fd3LV/kq4ZiqrCr1O
        /VMtgdxbym/znpSZ1oO8FpUU7cSB7lBRYssPfRQ+sRn0j41Y2iohJu45o44Z3aSZHKTitB/E2NrlK
        5gDpnXAQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTj-000khC-Ha; Mon, 30 Aug 2021 22:10:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/15] block: third batch of add_disk() error handling conversions
Date:   Mon, 30 Aug 2021 15:09:45 -0700
Message-Id: <20210830221000.179369-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third set of block drivers add_disk() error handling
patches. It's a bit bigger set than the first two sets given the
pcd/pf/pd drivers could use some love before the conversions.

Please let me know if you spot any issues.

The full set of changes can be found on my branch titled
20210830-for-axboe-add-disk-error-handling-v2 [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210830-for-axboe-add-disk-error-handling-v2

Christoph Hellwig (4):
  pcd: move the identify buffer into pcd_identify
  pcd: cleanup initialization
  pf: cleanup initialization
  pd: cleanup initialization

Luis Chamberlain (11):
  z2ram: add error handling support for add_disk()
  aoe: add error handling support for add_disk()
  m68k/emu/nfblock: add error handling support for add_disk()
  drbd: add error handling support for add_disk()
  um/drivers/ubd_kern: add error handling support for add_disk()
  xtensa/platforms/iss/simdisk: add error handling support for
    add_disk()
  n64cart: add error handling support for add_disk()
  pcd: add error handling support for add_disk()
  pcd: fix ordering of unregister_cdrom()
  pcd: capture errors on cdrom_register()
  pd: add error handling support for add_disk()

 arch/m68k/emu/nfblock.c             |   9 +-
 arch/um/drivers/ubd_kern.c          |  13 +-
 arch/xtensa/platforms/iss/simdisk.c |  13 +-
 drivers/block/aoe/aoeblk.c          |   6 +-
 drivers/block/drbd/drbd_main.c      |   6 +-
 drivers/block/n64cart.c             |  12 +-
 drivers/block/paride/pcd.c          | 304 +++++++++++++---------------
 drivers/block/paride/pd.c           | 146 ++++++-------
 drivers/block/paride/pf.c           | 223 +++++++++-----------
 drivers/block/z2ram.c               |   7 +-
 10 files changed, 365 insertions(+), 374 deletions(-)

-- 
2.30.2

