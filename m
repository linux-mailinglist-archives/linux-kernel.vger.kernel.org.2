Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10E734AB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhCZPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:21:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhCZPUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:20:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616772041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NrmGcC2ZP4daaG+xsdVC0fXaJPEx+1DgPs02v8goGVk=;
        b=oYHzOIoZx/tDcWlR8XF59Mu1DXAWuKbd3PrNwGqf5RsX+jeA76c6bWgafJsnjYDQdY3ufP
        +iYWV/UJtcW4rQSGsiQr/EBX5jsXb02cEE5BTcMqSqNa3M580tXot57+nxt8dIqaJREsko
        jynVEWOae0sYyUgkvTmRfnM9H5WXNGk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2305AC6A;
        Fri, 26 Mar 2021 15:20:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc5
Date:   Fri, 26 Mar 2021 16:20:41 +0100
Message-Id: <20210326152041.25735-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc5-tag

xen: branch for v5.12-rc5

It contains a small series with a more elegant fix of a problem which
was originally fixed in rc2.

Thanks.

Juergen

 arch/x86/include/asm/xen/page.h | 12 ------------
 arch/x86/xen/p2m.c              |  7 ++-----
 arch/x86/xen/setup.c            | 16 ++++++++++++++--
 drivers/xen/Kconfig             |  4 ++--
 4 files changed, 18 insertions(+), 21 deletions(-)

Roger Pau Monne (2):
      xen/x86: make XEN_BALLOON_MEMORY_HOTPLUG_LIMIT depend on MEMORY_HOTPLUG
      Revert "xen: fix p2m size in dom0 for disabled memory hotplug case"
