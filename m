Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19BF40F6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbhIQLgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:36:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33278 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbhIQLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:36:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AFDF1FDC7;
        Fri, 17 Sep 2021 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631878527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HcGZS+FDX8DdT1W8lmf9U7WzYN/MAtRfhAF9s0ohGYM=;
        b=WD3lw50Gt+6ZMpkmVs40GJTztbcc911Io34NZGq4RfGTN7onx9wdnRg5XiuqTpO3kHYcQ2
        UWLLLN+bzcioig35fjD2mkEpEW54WB+D42oTlQS2zJGkbi4RK7O9pRa7MiPP96kd8Zm35X
        LTIF7U12YiZ+shwCAA1egJwg0XOM75M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E730014102;
        Fri, 17 Sep 2021 11:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +CBmN359RGFAKQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 17 Sep 2021 11:35:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.15-rc2
Date:   Fri, 17 Sep 2021 13:35:26 +0200
Message-Id: <20210917113526.7963-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc2-tag

xen: branch for v5.15-rc2

It contains:
- The first hunk of a Xen swiotlb fixup series fixing multiple minor
  issues and doing some small cleanups
- Some further Xen related fixes avoiding WARN() splats when running
  as Xen guests or dom0
- A Kconfig fix allowing the pvcalls frontend to be built as a module

Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c |  7 +++++
 arch/x86/xen/mmu_pv.c       |  7 +++--
 drivers/base/power/trace.c  | 10 ++++++++
 drivers/xen/Kconfig         |  2 +-
 drivers/xen/balloon.c       | 62 ++++++++++++++++++++++++++++++++-------------
 drivers/xen/swiotlb-xen.c   | 37 +++++++++++++--------------
 6 files changed, 85 insertions(+), 40 deletions(-)

Jan Beulich (9):
      xen/pvcalls: backend can be a module
      swiotlb-xen: avoid double free
      swiotlb-xen: fix late init retry
      swiotlb-xen: maintain slab count properly
      swiotlb-xen: suppress certain init retries
      swiotlb-xen: limit init retries
      swiotlb-xen: drop leftover __ref
      swiotlb-xen: arrange to have buffer info logged
      swiotlb-xen: drop DEFAULT_NSLABS

Juergen Gross (4):
      xen/balloon: use a kernel thread instead a workqueue
      PM: base: power: don't try to use non-existing RTC for storing data
      xen: reset legacy rtc flag for PV domU
      xen: fix usage of pmd_populate in mremap for pv guests
