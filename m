Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC9426CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhJHOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:21:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbhJHOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:21:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5914D20140;
        Fri,  8 Oct 2021 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633702752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pNRxqDzRd//O+QxPugznEJ//I+bfjQ3sudVxpkNPHwc=;
        b=au5vd2FzDudAbuVRHoP5Rw1v3z854jAMXJKhfBYq0t/8y4dO2+eN0hzwzX7RPRMCwnN8P4
        NW49dv2ufXw16oMepaw/D6USyweuzCpRvhIMQj9tyR0SWJ4JjPpGpKhLQvtSuRhiK2hXnI
        W69xoCTDIjCNs/3XGtwyArG97YCHhAc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3330B13F32;
        Fri,  8 Oct 2021 14:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bMY5C2BTYGFYAwAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 08 Oct 2021 14:19:12 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.15-rc5
Date:   Fri,  8 Oct 2021 16:19:11 +0200
Message-Id: <20211008141911.25271-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc5-tag

xen: branch for v5.15-rc5

It contains the following patches:

- a small series to fix two minor issues in the Xen privcmd driver plus
  a cleanup patch for that driver

- a series fixing multiple issues related to running as PVH guest and
  some related earlyprintk fixes for other Xen guest types

- another fix of an issue introduced in 5.15 the Xen balloon driver

Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/include/asm/xen/pci.h                  | 11 +++--
 arch/x86/pci/xen.c                              | 15 ++++---
 arch/x86/platform/pvh/enlighten.c               | 12 +++---
 arch/x86/xen/Kconfig                            | 19 +++++----
 arch/x86/xen/Makefile                           |  2 +-
 arch/x86/xen/enlighten.c                        | 54 ++++++++++++++++++++++---
 arch/x86/xen/enlighten_pv.c                     | 35 +---------------
 arch/x86/xen/enlighten_pvh.c                    | 10 ++++-
 arch/x86/xen/mmu_pv.c                           |  2 +-
 arch/x86/xen/xen-ops.h                          |  5 ++-
 drivers/tty/hvc/hvc_xen.c                       | 13 +++---
 drivers/xen/Kconfig                             |  4 +-
 drivers/xen/balloon.c                           | 21 +++++++---
 drivers/xen/privcmd.c                           | 18 ++++-----
 include/xen/xen-ops.h                           | 15 +++----
 16 files changed, 135 insertions(+), 103 deletions(-)

Jan Beulich (12):
      xen/privcmd: replace kcalloc() by kvcalloc() when allocating empty pages
      xen/privcmd: fix error handling in mmap-resource processing
      xen/privcmd: drop "pages" parameter from xen_remap_pfn()
      xen/x86: prevent PVH type from getting clobbered
      xen/x86: allow PVH Dom0 without XEN_PV=y
      xen/x86: make "earlyprintk=xen" work better for PVH Dom0
      xen/x86: allow "earlyprintk=xen" to work for PV Dom0
      xen/x86: make "earlyprintk=xen" work for HVM/PVH DomU
      xen/x86: generalize preferred console model from PV to PVH Dom0
      xen/x86: hook up xen_banner() also for PVH
      x86/PVH: adjust function/data placement
      xen/x86: adjust data placement

Juergen Gross (1):
      xen/balloon: fix cancelled balloon action
