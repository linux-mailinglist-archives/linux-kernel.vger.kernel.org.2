Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109813079DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhA1Peu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:34:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:49970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhA1Pem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:34:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611848036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=D5OYwaFxK/AYOwT4ncyOrXqBEV4/eu+1M6R/qN+DFI0=;
        b=W5AmWTVXQ+hg+J2XIu9xHUnE2UFHAlRi65K/7iy6cyqOvwRYgc9P+38qiTh4m01P02bJhG
        1dQGcW0pYJWZO/ujcxBa4nC4EonOH+6C65E3ZOO6zCQgA3DzMIMl/3uS5TKsuzBOAnY8fn
        upcXyenuXozBO410T9hiarsnJrOmMPE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8FC0ACB7;
        Thu, 28 Jan 2021 15:33:56 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.11-rc6
Date:   Thu, 28 Jan 2021 16:33:56 +0100
Message-Id: <20210128153356.13823-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc6-tag

xen: branch for v5.11-rc6

It contains the following fixes:

- A fix for a regression introduced in 5.11 resulting in Xen dom0 having
  problems to correctly initialize Xenstore.

- A fix for avoiding WARN splats when booting as Xen dom0 with
  CONFIG_AMD_MEM_ENCRYPT enabled due to a missing trap handler for the
  #VC exception (even if the handler should never be called).

- A fix for the Xen bklfront driver adapting to the correct but
  unexpected behavior of new qemu.


Thanks.

Juergen

 arch/x86/include/asm/idtentry.h   |  1 +
 arch/x86/xen/enlighten_pv.c       | 15 ++++++++++++++-
 arch/x86/xen/xen-asm.S            |  1 +
 drivers/block/xen-blkfront.c      | 20 +++++++-------------
 drivers/xen/xenbus/xenbus_probe.c | 31 +++++++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 14 deletions(-)

David Woodhouse (1):
      xen: Fix XenStore initialisation for XS_LOCAL

Juergen Gross (1):
      x86/xen: avoid warning in Xen pv guest with CONFIG_AMD_MEM_ENCRYPT enabled

Roger Pau Monne (1):
      xen-blkfront: allow discard-* nodes to be optional
