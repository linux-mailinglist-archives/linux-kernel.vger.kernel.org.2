Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58632A430
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379994AbhCBKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349554AbhCBKFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:05:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D14FB64F12;
        Tue,  2 Mar 2021 10:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614679461;
        bh=F7EFwzdiJGCuUJUM4rhmyuct8ZJs4bkPmXvvBTimuS4=;
        h=From:To:Cc:Subject:Date:From;
        b=eWQYvRA+/QbPaWtGg12DWWxHmts3dBQRib7AsddTMsqcEAwURGHsaHiGDP6KI+3ln
         OVdUKwOsJlf0nMX/97t7gPDyhRmnTP+933CyJGhHS+W0pdIwtRD0+t8y+/9bXaxK6S
         3tF3HSpnXyOaZngWyd/Vum4UDv5Wx4usuYHMep4bytRtl5eNXrp52nftzv+cUBmBkv
         iOVde5WikU6HpKF7Qz7M9KW4wWl9A/R6uXRjkXp/vA8Bf5HiapCfMEXuEcqQkx1AIU
         FHvIs/gc+16X65JroeDchcU/j2sxxEKSFFRFXKbpSqHHxt4EdmDBYjt/EDXPQs6fVd
         qnpAUjW3GIMew==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/2] x86/setup: consolidate early memory reservations
Date:   Tue,  2 Mar 2021 12:04:04 +0200
Message-Id: <20210302100406.22059-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

David noticed that we do some of memblock_reserve() calls after allocations
are possible:

https://lore.kernel.org/lkml/6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com

The below patches consolidate early memory reservations done during
setup_arch() so that memory used by firmware, bootloader, kernel text/data
and the memory that should be excluded from the available memory for
whatever other reason is reserved before memblock allocations are possible.

The patches are rebased on v5.12-rc1 and I think x86 tree is the best way
to merge them.

v3:
* rebase on v5.12-rc1

v2: https://lore.kernel.org/lkml/20210128105711.10428-1-rppt@kernel.org
* get rid of trim_platform_memory_ranges() and call trim_snb_memory()
  directly, per Boris comments
* massage changelog and comments to use passive voice, per Boris
* add Acked-by and Reviewed-by, thanks Boris and David

v1: https://lore.kernel.org/lkml/20210115083255.12744-1-rppt@kernel.org

Mike Rapoport (2):
  x86/setup: consolidate early memory reservations
  x86/setup: merge several reservations of start of the memory

 arch/x86/kernel/setup.c | 95 ++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 49 deletions(-)

-- 
2.28.0

