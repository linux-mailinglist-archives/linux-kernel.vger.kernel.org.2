Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3873FEA09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbhIBHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:30:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53068 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhIBHaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:30:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18F7720312;
        Thu,  2 Sep 2021 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630567762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IhcUjy8QGji2IABo6zcQqKi+1URPttsD+rMluhzr+U0=;
        b=gmK9k6utB4XDKQvE7yRgd7hk0/UUoy/oSRCveEWBBA12IccGUhOvjxNCVAqE7Hv9LWIwzf
        RfboEvRXeWHC5aZvw5Ej+gSD+W065MgGPNiCDNnnWXjNWBjs38EK8644ge/S3VHdKXlmfT
        f8HsXXPLRLgwX4qF6ZXJoXm+7xmJI1I=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DE1D813887;
        Thu,  2 Sep 2021 07:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id am2SNFF9MGH1OQAAGKfGzw
        (envelope-from <jgross@suse.com>); Thu, 02 Sep 2021 07:29:21 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.15-rc1
Date:   Thu,  2 Sep 2021 09:29:21 +0200
Message-Id: <20210902072921.27763-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15-rc1-tag

xen: branch for v5.15-rc1

It contains the following changes:

- some small cleanups
- a fix for a bug when running as Xen PV guest which could result in
  not all memory being transferred in case of a migration of the guest
- a small series for getting rid of code for supporting very old Xen
  hypervisor versions nobody should be using since many years now
- a series for hardening the Xen block frontend driver
- a fix for Xen PV boot code issuing warning messages due to a stray
  preempt_disable() on the non-boot processors

Thanks.

Juergen

 arch/x86/xen/enlighten_pv.c        |  12 +---
 arch/x86/xen/mmu_pv.c              |   4 +-
 arch/x86/xen/p2m.c                 |   4 +-
 arch/x86/xen/platform-pci-unplug.c |  16 ++---
 arch/x86/xen/smp_pv.c              |   1 -
 drivers/block/xen-blkfront.c       | 126 ++++++++++++++++++++++++-------------
 drivers/pci/xen-pcifront.c         |  30 +++++----
 drivers/xen/features.c             |  18 ++++++
 drivers/xen/gntdev.c               |  36 +----------
 drivers/xen/xenbus/xenbus_client.c |   9 +--
 10 files changed, 141 insertions(+), 115 deletions(-)

Jing Yangyang (1):
      drivers/xen/xenbus/xenbus_client.c: fix bugon.cocci warnings

Juergen Gross (9):
      xen: fix setting of max_pfn in shared_info
      xen: check required Xen features
      xen: assume XENFEAT_mmu_pt_update_preserve_ad being set for pv guests
      xen: assume XENFEAT_gnttab_map_avail_bits being set for pv guests
      xen/blkfront: read response from backend only once
      xen/blkfront: don't take local copy of a request from the ring page
      xen/blkfront: don't trust the backend response data blindly
      xen: remove stray preempt_disable() from PV AP startup code

Sergio Miguéns Iglesias (1):
      xen/pcifront: Removed unnecessary __ref annotation

zhaoxiao (1):
      x86: xen: platform-pci-unplug: use pr_err() and pr_warn() instead of raw printk()
