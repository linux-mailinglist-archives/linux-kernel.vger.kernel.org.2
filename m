Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D835E766
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348153AbhDMUGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:06:05 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:59146 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhDMUGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:06:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5FE4B6122D44;
        Tue, 13 Apr 2021 22:05:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pb2ba3nKQmwb; Tue, 13 Apr 2021 22:05:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0C271606BA5E;
        Tue, 13 Apr 2021 22:05:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VDArCqsXGLPe; Tue, 13 Apr 2021 22:05:41 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D4E4A6122D44;
        Tue, 13 Apr 2021 22:05:41 +0200 (CEST)
Date:   Tue, 13 Apr 2021 22:05:41 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Message-ID: <1678691098.178869.1618344341740.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD fixes for 5.12-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: WK6HXCg3/KZU8vvevUTpx25CD/Z4vw==
Thread-Topic: MTD fixes for 5.12-rc7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.12-rc7

for you to fetch changes up to 2fb164f0ce95e504e2688b4f984893c29ebd19ab:

  mtd: rawnand: mtk: Fix WAITRDY break condition and timeout (2021-03-11 12:23:11 +0100)

----------------------------------------------------------------
This pull request contains the following bug fix for MTD:

- nand: Fix WAITRDY break condition and timeout in mtk driver

----------------------------------------------------------------
Hauke Mehrtens (1):
      mtd: rawnand: mtk: Fix WAITRDY break condition and timeout

 drivers/mtd/nand/raw/mtk_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
