Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945F231CAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBPMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:41:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:48134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhBPMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:41:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613479216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X3blwfF7NbGXbiKfZpPPBVAn/s2HDWS/Ulzem1ZAomk=;
        b=jk7/SGiWFBznoGqTALSPOXjELreX060pqbsJdjQkx3ySvnDY886OEXayPN/m7HrhTFyq8v
        4DnGLRQQ1ok0Oi2aumVaFc8pWBRyIG4be3Op9woQ0CyVFtjY9dcGOKEu4OT5IVxMI8gqd1
        m6KegIYDvLBojLzL5pKVsLn5xCINBwM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8760FAF2C;
        Tue, 16 Feb 2021 12:40:16 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc1
Date:   Tue, 16 Feb 2021 13:40:15 +0100
Message-Id: <20210216124015.28923-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12-rc1-tag

xen: branch for v5.12-rc1

This batch contains a series of Xen related security fixes, all related
to limited error handling in Xen backend drivers.


Thanks.

Juergen

 arch/arm/xen/p2m.c                  |  6 ++++--
 arch/x86/xen/p2m.c                  | 15 +++++++--------
 drivers/block/xen-blkback/blkback.c | 32 ++++++++++++++++++--------------
 drivers/net/xen-netback/netback.c   |  4 +---
 drivers/xen/gntdev.c                | 37 ++++++++++++++++++++-----------------
 drivers/xen/xen-scsiback.c          |  4 ++--
 include/xen/grant_table.h           |  1 +
 7 files changed, 53 insertions(+), 46 deletions(-)

Jan Beulich (8):
      Xen/x86: don't bail early from clear_foreign_p2m_mapping()
      Xen/x86: also check kernel mapping in set_foreign_p2m_mapping()
      Xen/gntdev: correct dev_bus_addr handling in gntdev_map_grant_pages()
      Xen/gntdev: correct error checking in gntdev_map_grant_pages()
      xen-blkback: don't "handle" error by BUG()
      xen-netback: don't "handle" error by BUG()
      xen-scsiback: don't "handle" error by BUG()
      xen-blkback: fix error handling in xen_blkbk_map()

Stefano Stabellini (1):
      xen/arm: don't ignore return errors from set_phys_to_machine
