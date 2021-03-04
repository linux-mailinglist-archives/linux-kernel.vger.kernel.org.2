Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9888A32D16C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbhCDLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:01:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:58864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239126AbhCDLBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:01:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614855654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WXqHPe+Ifnv5Vf7F0Ne6BsKMUPRrUe3g+NOcm0DY8Po=;
        b=Wb2k58m2tPyw8HJWGN4OpsnluwahwTkXLlCH83ups3omce9KolKDdUZKnr/01mnQARefe6
        zdjprHYQ/al8PYmwTYY3Rq8ttMQj/0SNMlm663huu2nT5pLiph5X/3ZaxSkSR750/lMIrJ
        7ERgKTScfUWv8MxgMKMRzBnsI93uAhQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F411AE1F;
        Thu,  4 Mar 2021 11:00:54 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc2
Date:   Thu,  4 Mar 2021 12:00:53 +0100
Message-Id: <20210304110053.8787-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc2-tag

xen: branch for v5.12-rc2

It contains fixes for 2 security issues (XSA-367 and XSA-369).


Thanks.

Juergen

 arch/arm/xen/p2m.c                | 35 ++++++++++++++++++++++---
 arch/x86/include/asm/xen/page.h   | 12 +++++++++
 arch/x86/xen/p2m.c                | 54 ++++++++++++++++++++++++++++++++++-----
 arch/x86/xen/setup.c              | 25 +++---------------
 drivers/net/xen-netback/netback.c | 12 ++++++++-
 5 files changed, 104 insertions(+), 34 deletions(-)

Jan Beulich (2):
      Xen/gnttab: handle p2m update errors on a per-slot basis
      xen-netback: respect gnttab_map_refs()'s return value

Juergen Gross (1):
      xen: fix p2m size in dom0 for disabled memory hotplug case
