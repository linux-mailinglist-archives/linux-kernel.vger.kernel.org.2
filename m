Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0491420B33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhJDMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:53:32 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39622
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhJDMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:53:31 -0400
Received: from wittgenstein.fritz.box (ip5f5bd0d9.dynamic.kabel-deutschland.de [95.91.208.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BD28D4199E;
        Mon,  4 Oct 2021 12:51:41 +0000 (UTC)
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/2] Introduce simple pidfd to task helper
Date:   Mon,  4 Oct 2021 14:50:48 +0200
Message-Id: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This adds a simple helper to get rid of some code duplication introduced
with the addition of two new pidfd-based syscalls in mm. We should've
probably added the helper right away and I think I mentioned this during
in the review on one of the revisions but we probably just lost track of
it. If this looks ok to you, I'll queue this up for next.

Thanks!
Christian

Christian Brauner (2):
  pid: add pidfd_get_task() helper
  mm: use pidfd_get_task()

 include/linux/pid.h |  1 +
 kernel/pid.c        | 34 ++++++++++++++++++++++++++++++++++
 mm/madvise.c        | 15 +++------------
 mm/oom_kill.c       | 15 +++------------
 4 files changed, 41 insertions(+), 24 deletions(-)


base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
-- 
2.30.2

