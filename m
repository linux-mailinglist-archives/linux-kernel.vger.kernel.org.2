Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92F2434731
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJTIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:47:56 -0400
Received: from first.geanix.com ([116.203.34.67]:37384 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJTIry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:47:54 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 12558C7EB5;
        Wed, 20 Oct 2021 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1634719538; bh=U2cnM+X/mc5mK5tveSmn1kn/3Fb65kAhrB7Tiv1YV1k=;
        h=From:To:Cc:Subject:Date;
        b=Yl9RMwcrINNd04z4ITkvJSWFHDBHrzMtju7SHnR80RDUStKsSz8F0/SH+AUdhBbQk
         hlrjbPMOEu+enFUJGo5dU2FUFIgfPusaFq28ybjhOv8AJnBSisUNoe3Oi/eysyOqsl
         QWfl3RRc+uoIl5lOvRAQBKC4Uv6jtneqNV/SqNNagQdXfpA8zyxkIIiFCbwGH/3c1T
         GlPPzDeOw0DNn5nymhv6xAFkI17XxuqTjY5bSnTxdl9y3g1TblRSkoTTBZYBgnz2+U
         N6d+l3bU8KUfuLEUbMAD516HMMa/4LFlmShTOyEKSWjRCgZ1wz2pEUOlEbW26Jauzt
         h6bZGqFaK5qSg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] mtd: core: protect access to mtd devices while in suspend
Date:   Wed, 20 Oct 2021 10:45:30 +0200
Message-Id: <20211020084534.2472305-1-sean@geanix.com>
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

Sean Nyekjaer (4):
  mtd: rawnand: nand_bbt: hide suspend/resume hooks while scanning bbt
  mtd: core: protect access to MTD devices while in suspend
  mtd: rawnand: remove suspended check
  mtd: mtdconcat: add suspend lock handling

 drivers/mtd/mtdconcat.c          |   7 +-
 drivers/mtd/mtdcore.c            | 131 +++++++++++++++++++++++++++----
 drivers/mtd/nand/raw/nand_base.c |  52 +++---------
 drivers/mtd/nand/raw/nand_bbt.c  |  28 ++++++-
 include/linux/mtd/mtd.h          |  81 +++++++++++++++----
 include/linux/mtd/rawnand.h      |   5 +-
 6 files changed, 227 insertions(+), 77 deletions(-)

-- 
2.33.0

