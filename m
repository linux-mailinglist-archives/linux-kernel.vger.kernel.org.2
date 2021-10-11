Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B414E428E09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhJKNfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235575AbhJKNfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D59B460F24;
        Mon, 11 Oct 2021 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633959193;
        bh=NC29iQhY2uGfBUQZ0jOW13dZSCjYvmt4aSw5omB9AfA=;
        h=From:To:Cc:Subject:Date:From;
        b=RucD2lts33iehxcJX19N5wnH2a/L3Bt8jHaXWJfqR8ZZm+2cFVtMQUGQxDMafdKCf
         fgooLYsVftBTx/DuZD1PxybsojLbM3LKisgpV0IyiP04TXPlujY7WaYSGyZitRfp2h
         JyIZMV33sPfwjcXDQ2fe9KsLxpHL3YidzXDo0PygW5RnT6hvPggkpcqQDb6ko1Rxmq
         FkrqPry34ftLxa9RsWjEh3xZV5prBk5efO7fB/dbKYSt4ouoGLNfjODc9wuqgl7pgE
         C4kiO5edbYTmrVoyRg8UpOJdY9wg2VbkyDpwt1uFAhjB86GCxQdJmqvlZFEfWQqwOX
         y4vOzdAE84yfA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/2] Introduce simple pidfd to task helper
Date:   Mon, 11 Oct 2021 15:32:43 +0200
Message-Id: <20211011133245.1703103-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; h=from:subject; bh=UogWz9L05GC/Gry5hzXxCEotYF9uHRoKarED0b5f3eA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSm2PwIXs7883xQhcUS//1Xj8/Y/NunPuPlFp5zTJrtBydt PO9t01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRvHhGhhuvf3/N3mZer32V5ddyZv uvcz+4bZBaXjE39ZPszcNVi/kZ/vulPGG44FaUdnOGCj9Lc47jl+c7nerubHD3URW6N2WVMw8A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey everyone,

This adds a simple helper to get rid of some code duplication introduced
with the addition of two new pidfd-based syscalls in mm. We should've
probably added the helper right away and I think I mentioned this during
in the review on one of the revisions but we probably just lost track of
it. If this looks ok to you, I'll queue this up for next.

/* v2 */
Add a note to the kernel doc what the caller is expected to clean up.
No semantical changes.

Thanks!
Christian

Christian Brauner (2):
  pid: add pidfd_get_task() helper
  mm: use pidfd_get_task()

 include/linux/pid.h |  1 +
 kernel/pid.c        | 36 ++++++++++++++++++++++++++++++++++++
 mm/madvise.c        | 15 +++------------
 mm/oom_kill.c       | 15 +++------------
 4 files changed, 43 insertions(+), 24 deletions(-)


base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
2.30.2

