Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650C2396691
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhEaRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234501AbhEaRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 13:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622480493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KgeuUpWscxV0iX92OxtBjDCB+O57pxCNA2/BtpkCAC0=;
        b=ELDXLd9IBDYQrZ90Wxw3bNUeYEBBDpHUOKJqXxmQVfrbrgF0OzLjeFlxwz8wJH4GRmg5kV
        ZTMKf7WugvjZ3G9tQIdFT70x1GNMYlRfrWIwyin1FaT4OWVN02eZqbQQiJ6Ue0hTvbHsps
        +QxH5Nj5R8wG0lA6WXjcHqQmBOc1fcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-b3soyx8DNjKj70Gm-K6TNA-1; Mon, 31 May 2021 13:01:31 -0400
X-MC-Unique: b3soyx8DNjKj70Gm-K6TNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B9F6D241;
        Mon, 31 May 2021 17:01:30 +0000 (UTC)
Received: from max.com (unknown [10.40.192.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F8EA59460;
        Mon, 31 May 2021 17:01:25 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [RFC 0/9] gfs2: handle page faults during read and write
Date:   Mon, 31 May 2021 19:01:14 +0200
Message-Id: <20210531170123.243771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's a set of fixes for how gfs2 handles page faults during read and
write syscalls.  The patch queue is ready for merging except for two
open issues.  May I ask you to shed some light or ask the right person
to help us out?

Right now, the filesystem can end up trying to take a lock it's already
holding, which causes it to BUG.  We can recognize and mostly deal with
that simple case, but more complex scenarios exist which involve
multiple locks and / or incompatible locking modes.  To handle those, we
switch to trylocks where necessary.

The patches appear to be working as itended, with the following
remaining questions:

(1) Jan Kara has pointed out [*] that returning VM_FAULT_SIGBUS from the
.fault / .page_mkwrite ops will raise SIGBUS, which would be visible to
user space.  This hasn't been observed in our testing; instead, accesses
to the mmapped memory via call chains like:

  iov_iter_fault_in_readable -> fault_in_pages_readable -> __get_user

would simply fail with -EFAULT, as we're expecting.

From looking at do_user_addr_fault and do_sigbus in arch/x86/mm/fault.c,
my impression is that VM_FAULT_SIGBUS will not cause SIGBUS to be raised
in kernel mode, and that we can rely on the -EFAULT behavior for
triggering the retries at the filesystem level.

(2) The patch queue introduces the same kind of trylock behavior for
both .fault (gfs2_fault) and .page_mkwrite (gfs2_page_mkwrite).  I'm not
aware of any situation in which we can actually end up in .page_mkwrite
during a .read_iter or .write_iter operation, so the trylock behavior in
.page_mkwrite might be harmless but unnecessary.


Thank you very much,
Andreas


[*] https://listman.redhat.com/archives/cluster-devel/2021-May/msg00080.html

Previous posting of this patch queue:

https://listman.redhat.com/archives/cluster-devel/2021-May/msg00073.html

New xfstest for mmap + page faults during read / write:
 
https://lore.kernel.org/fstests/20210531152604.240462-1-agruenba@redhat.com/

Andreas Gruenbacher (9):
  gfs2: Clean up the error handling in gfs2_page_mkwrite
  gfs2: Add wrapper for iomap_file_buffered_write
  gfs2: Add gfs2_holder_is_compatible helper
  gfs2: Fix mmap + page fault deadlocks (part 1)
  iov_iter: Add iov_iter_fault_in_writeable()
  gfs2: Add wrappers for accessing journal_info
  gfs2: Encode glock holding and retry flags in journal_info
  gfs2: Add LM_FLAG_OUTER glock holder flag
  gfs2: Fix mmap + page fault deadlocks (part 2)

 fs/gfs2/aops.c      |   6 +-
 fs/gfs2/bmap.c      |  31 ++++----
 fs/gfs2/file.c      | 175 +++++++++++++++++++++++++++++++++-----------
 fs/gfs2/glock.c     |  12 +++
 fs/gfs2/glock.h     |  27 ++++++-
 fs/gfs2/incore.h    |  41 +++++++++++
 fs/gfs2/inode.c     |   2 +-
 fs/gfs2/log.c       |   4 +-
 fs/gfs2/lops.c      |   2 +-
 fs/gfs2/meta_io.c   |   6 +-
 fs/gfs2/super.c     |   2 +-
 fs/gfs2/trans.c     |  16 ++--
 include/linux/uio.h |   1 +
 lib/iov_iter.c      |  20 ++++-
 14 files changed, 265 insertions(+), 80 deletions(-)

-- 
2.26.3

