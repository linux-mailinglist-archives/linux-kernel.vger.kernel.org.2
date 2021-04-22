Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D2368306
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhDVPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:51974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236397AbhDVPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619104210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DE3ajipCLGOoeJxse+uDWjYBYGnyKVCVQDv9OtWAWVI=;
        b=YlnwiUJh4StAZX+XIutv314AStIgqEqhikMDiBZkbNqgG1wcxmZslPpvM3mPjQUuOyZq7e
        8ozA0Mrkd+QJ0dJrUEi99VaukzQmizcyv+cZxSv4fcLOcPbKJLDYF8wXH2UNengKHDlTaR
        iJusQ+0aBJtbRK3RqPELQGNfl41Fisc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4992B16C;
        Thu, 22 Apr 2021 15:10:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] xen: remove some checks for always present Xen features
Date:   Thu, 22 Apr 2021 17:10:04 +0200
Message-Id: <20210422151007.2205-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some features of Xen can be assumed to be always present, so add a
central check to verify this being true and remove the other checks.

Juergen Gross (3):
  xen: check required Xen features
  xen: assume XENFEAT_mmu_pt_update_preserve_ad being set for pv guests
  xen: assume XENFEAT_gnttab_map_avail_bits being set for pv guests

 arch/x86/xen/enlighten_pv.c | 12 ++----------
 arch/x86/xen/mmu_pv.c       |  4 ++--
 drivers/xen/features.c      | 18 ++++++++++++++++++
 drivers/xen/gntdev.c        | 36 ++----------------------------------
 4 files changed, 24 insertions(+), 46 deletions(-)

-- 
2.26.2

