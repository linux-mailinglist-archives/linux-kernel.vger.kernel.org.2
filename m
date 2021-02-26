Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A02326338
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBZNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:17:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZNR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:17:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614345402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gPicBlvbf8VxlREpUzvDTkJ45cjDUMZKb5OA8osUY9A=;
        b=nO60bCQ37/R22NjlBvecJb14IxPqjYbIcmh0cm6ukT5HpHO/pzHFMDMwld1TrP3we9GW8d
        KSKfxxideYrGYBKl78uCdMFYrBdkJUHQkDU4SjH8jNdBuPSETwuCI1MvT9CUMOoH01pCRu
        rvtYzo5B9GvFKRG9O3y3dtBmd+bNMys=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B9DDAD74;
        Fri, 26 Feb 2021 13:16:42 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.12-rc1
Date:   Fri, 26 Feb 2021 14:16:41 +0100
Message-Id: <20210226131641.4309-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc1-tag

xen: branch for v5.12-rc1

It contains:

- A small series for Xen event channels adding some sysfs nodes for
  per pv-device settings and statistics, and 2 fixes of theoretical
  problems.

- two minor fixes (one for an unlikely error path, one for a comment).

Thanks.

Juergen

 Documentation/ABI/testing/sysfs-devices-xenbus | 41 ++++++++++++++++
 drivers/xen/events/events_base.c               | 27 ++++++++++-
 drivers/xen/evtchn.c                           | 29 ++++++-----
 drivers/xen/xen-acpi-processor.c               |  3 +-
 drivers/xen/xen-front-pgdir-shbuf.c            | 11 ++++-
 drivers/xen/xenbus/xenbus_probe.c              | 66 ++++++++++++++++++++++++++
 include/xen/xenbus.h                           |  7 +++
 7 files changed, 168 insertions(+), 16 deletions(-)

Jan Beulich (1):
      xen-front-pgdir-shbuf: don't record wrong grant handle upon error

Juergen Gross (3):
      xen/events: add per-xenbus device event statistics and settings
      xen/evtchn: use smp barriers for user event ring
      xen/evtchn: use READ/WRITE_ONCE() for accessing ring indices

Kees Cook (1):
      xen: Replace lkml.org links with lore
