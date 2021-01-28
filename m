Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C530743F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhA1K6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhA1K6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:58:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 071EC6146D;
        Thu, 28 Jan 2021 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611831452;
        bh=tpQLEl3JcKJKah5jOR4EJ16hQaTeFdER9R5YaRN/lpk=;
        h=From:To:Cc:Subject:Date:From;
        b=OVzQhhOic7sERItejIOnfrOuEpOnfMvqtcsdZcGkcf1KIUlRvjZSvxzh3eu8hpSzG
         nuV34mkip7GpR1W6pkVGyVnzFlg4SxeKy2aGrciPwVGnUsAdaKcpHDhk17ScMKrHm1
         NTAyIr6M88s6hlKtMNfHQwxCxCC9HSZH/6QAJElp4Zw8ywsQLyMXhXVZf5eqBZSEN5
         ddKxFS+qx5JusIDd+SBKbtzwMfS/j0GChPOu4zRef2bbpsRNI55d10O5gHJY1hTQkW
         9kbTzk/o+mz7ClN/NLRPiW0V/SYpaJTvvbfuixxZ9fEriS0FDKhAtPtFiL4fn831YI
         YBQXPRGESUs4g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [PATCH v2 0/2] x86/setup: consolidate early memory reservations
Date:   Thu, 28 Jan 2021 12:57:09 +0200
Message-Id: <20210128105711.10428-1-rppt@kernel.org>
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

For now there is no actual problem because in top-down mode we allocate
from the end of the memory and in bottom-up mode we allocate above the
kernel image. But there is a patch in the mm tree that allow bottom-up
allocations below the kernel:

https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com

and with this change we may get a memory corruption if an allocation steps
on some of the firmware areas that are yet to be reserved.

The below patches consolidate early memory reservations done during
setup_arch() so that memory used by firmware, bootloader, kernel text/data
and the memory that should be excluded from the available memory for
whatever other reason is reserved before memblock allocations are possible.

The patches are vs v5.11-rc3-mmots-2021-01-12-02-00 as I think they are
prerequisite for the memblock bottom-up changes, but if needed I can rebase
then on another tree.

v2:
* get rid of trim_platform_memory_ranges() and call trim_snb_memory()
  directly, per Boris comments
* massage changelog and comments to use passive voice, per Boris
* add Acked-by and Reviewed-by, thanks Boris and David

v1: https://lore.kernel.org/lkml/20210115083255.12744-1-rppt@kernel.org

Mike Rapoport (2):
  x86/setup: consolidate early memory reservations
  x86/setup: merge several reservations of start of the memory

 arch/x86/kernel/setup.c | 96 ++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 54 deletions(-)

-- 
2.28.0

