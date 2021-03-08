Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546F2331917
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCHVK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:10:26 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:16947 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhCHVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:10:00 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 16:10:00 EST
Received: from sc9-mailhost1.vmware.com (10.113.161.71) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 8 Mar 2021 12:54:56 -0800
Received: from vertex.localdomain (unknown [10.16.119.57])
        by sc9-mailhost1.vmware.com (Postfix) with ESMTP id 487EF2040A;
        Mon,  8 Mar 2021 12:54:57 -0800 (PST)
From:   Zack Rusin <zackr@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Martin Krastev <krastevm@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH 0/2] locking/rwsem: Add down_write_interruptible and use it
Date:   Mon, 8 Mar 2021 15:54:54 -0500
Message-ID: <20210308205456.1317366-1-zackr@vmware.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: zackr@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmwgfx has really ugly implemention of an interruptible lock trying
to match rw sem semantics. By adding a small bit of code implementing
down_write_interruptible to rwsem which already supported
down_read_interruptible we can completely remove all of the custom
code from vmwgfx.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Martin Krastev <krastevm@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

Zack Rusin (2):
  locking/rwsem: Add down_write_interruptible
  drm/vmwgfx: Remove custom locking code

 drivers/gpu/drm/vmwgfx/Makefile               |   2 +-
 drivers/gpu/drm/vmwgfx/ttm_lock.c             | 194 ----------------
 drivers/gpu/drm/vmwgfx/ttm_lock.h             | 218 ------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c            |  24 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c       |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |  57 +----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h           |  32 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c       |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |  10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c         |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c      |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c        |   4 +-
 .../gpu/drm/vmwgfx/vmwgfx_simple_resource.c   |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       |  16 +-
 include/linux/rwsem.h                         |   1 +
 kernel/locking/rwsem.c                        |  23 ++
 17 files changed, 98 insertions(+), 515 deletions(-)
 delete mode 100644 drivers/gpu/drm/vmwgfx/ttm_lock.c
 delete mode 100644 drivers/gpu/drm/vmwgfx/ttm_lock.h

-- 
2.27.0

