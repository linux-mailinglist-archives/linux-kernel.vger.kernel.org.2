Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1E43ABE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 07:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhJZF60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 01:58:26 -0400
Received: from first.geanix.com ([116.203.34.67]:37410 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233555AbhJZF6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:58:24 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 029B8D6C1D;
        Tue, 26 Oct 2021 05:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1635227759; bh=h0WfNzdXW1YTJlL4xfDpH76ZL8VMf+fPy+pRovMxQhk=;
        h=From:To:Cc:Subject:Date;
        b=b2e8MNt/MPgJgdQzZljubImA+DHkFNu/NzcESXXESwMw2S8tROeSehhsj3ALT0Vu+
         ueqlBBUehKnon+qtFd8pGadSx0v5Mvyaaq2EWVhWBiOA650cSNOzxyAYEJPT0/KSCe
         O7a8fL6wogSo6OmRIRb5tEOfLt8YSKqmNu10nrdiIRgvk8MFBr3VGDYjEmTWTUhi11
         TSnT00gEwbDp3D1S4X03j2GxjKALTIlkBlJ4y0fb1AKvTMJkaq+uG2nrWLjB90rEXD
         CWI/Qdan6sG7jwvvGBC/GW/NNsCFtJdn1K0Cm1AGNa3RJMIPUWujsswFDBYFF27FtN
         auPSQzhlQgtSA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] mtd: core: protect access to mtd devices while in suspend
Date:   Tue, 26 Oct 2021 07:55:47 +0200
Message-Id: <20211026055551.3053598-1-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow-up on discussion in:
https://lkml.org/lkml/2021/10/4/41
https://lkml.org/lkml/2021/10/11/435

Changes since v3:
 - edited commit msg and author for mtdconcat patch

Changes since v2:
 - added signoff's to patch from Boris
 - removed accidential line break
 - kept tests consistent: master->master.suspended == 0 -> !master->master.suspended
 - added comments to mtdconcat patch
 - moved mtdconcat before ('mtd: core: protect access to MTD devices while in suspend')

Changes since v1:
 - removed __mtd_suspend/__mtd_resume functions as they are not used by
   mtdconcat anymore.
 - only master mtd_info is used for mtd_{start,end}_access(). Warn if we
   got mtd's.
 - added Boris patch for using uninitialized _suspend/_resume hooks when
   bbt scanning
 - mtdconcat uses device _suspend/_resume hooks
 - I don't really like the macro proposal from Boris
   mtd_no_suspend_void_call()/mtd_no_suspend_ret_call() I think they
   make the code complex to read and the macro's doesn't fit every
   where anyway...

Changes since from rfc v1/v2:
 - added access protection for all device access hooks in mtd_info.
 - added Suggested-by to [1/3] patch.
 - removed refereces to commit ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
   from commit msg as commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") is 
   to be blamed.
 - tested on a kernel with LOCKDEP enabled.

Boris Brezillon (2):
  mtd: rawnand: nand_bbt: hide suspend/resume hooks while scanning bbt
  mtd: mtdconcat: don't use mtd_{suspend,resume}()

Sean Nyekjaer (2):
  mtd: core: protect access to MTD devices while in suspend
  mtd: rawnand: remove suspended check

 drivers/mtd/mtdconcat.c          |  15 +++-
 drivers/mtd/mtdcore.c            | 124 +++++++++++++++++++++++++++----
 drivers/mtd/nand/raw/nand_base.c |  52 ++++---------
 drivers/mtd/nand/raw/nand_bbt.c  |  28 ++++++-
 include/linux/mtd/mtd.h          |  81 ++++++++++++++++----
 include/linux/mtd/rawnand.h      |   5 +-
 6 files changed, 230 insertions(+), 75 deletions(-)

-- 
2.33.0

