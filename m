Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D63B7594
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhF2Pkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234549AbhF2Pkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624981085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZvEt7bEKf4QUzdzCkar8PX3Yay1pkkOVyVE1rkXd+nc=;
        b=b/+UAyogg27ci7hq0MSiFmergOQe8gCuTS+jijuOj4UI0CwA77nStYHwnAuY/BBXWr+MKU
        ZtL64luwprGF3QTT2/GT2LOiecNmBXBgMnkq36kxRrJ8hTAKIUV6Djjm01bH8a/GX29jQB
        MYi9Z0jVklZGoFkNzvUT5x0+6tnbhMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Xuf1EWhaOwSFsoLwgIYS9g-1; Tue, 29 Jun 2021 11:38:03 -0400
X-MC-Unique: Xuf1EWhaOwSFsoLwgIYS9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52401835ACD;
        Tue, 29 Jun 2021 15:38:02 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 667935C1D0;
        Tue, 29 Jun 2021 15:38:02 +0000 (UTC)
Date:   Tue, 29 Jun 2021 10:38:00 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.14
Message-ID: <20210629153800.GA7428@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.14

This is a major dlm networking enhancement that adds message
retransmission so that the dlm can reliably continue operating
when network connections fail and nodes reconnect.  Previously,
this would result in lost messages which could only be handled
as a node failure.

Thanks,
Dave

Alexander Aring (24):
      fs: dlm: always run complete for possible waiters
      fs: dlm: add dlm macros for ratelimit log
      fs: dlm: fix srcu read lock usage
      fs: dlm: set is othercon flag
      fs: dlm: reconnect if socket error report occurs
      fs: dlm: cancel work sync othercon
      fs: dlm: fix connection tcp EOF handling
      fs: dlm: public header in out utility
      fs: dlm: add more midcomms hooks
      fs: dlm: make buffer handling per msg
      fs: dlm: add functionality to re-transmit a message
      fs: dlm: move out some hash functionality
      fs: dlm: add union in dlm header for lockspace id
      fs: dlm: add reliable connection if reconnect
      fs: dlm: add midcomms debugfs functionality
      fs: dlm: don't allow half transmitted messages
      fs: dlm: fix lowcomms_start error case
      fs: dlm: fix memory leak when fenced
      fs: dlm: use alloc_ordered_workqueue
      fs: dlm: move dlm allow conn
      fs: dlm: introduce proto values
      fs: dlm: rename socket and app buffer defines
      fs: dlm: fix race in mhandle deletion
      fs: dlm: invalid buffer access in lookup error

Colin Ian King (2):
      fs: dlm: Fix memory leak of object mh
      fs: dlm: Fix spelling mistake "stucked" -> "stuck"

 fs/dlm/config.c       |   18 +-
 fs/dlm/config.h       |    5 +-
 fs/dlm/debug_fs.c     |   54 ++
 fs/dlm/dlm_internal.h |   42 +-
 fs/dlm/lock.c         |   16 +-
 fs/dlm/lockspace.c    |   14 +-
 fs/dlm/lowcomms.c     |  411 +++++++++++----
 fs/dlm/lowcomms.h     |   25 +-
 fs/dlm/member.c       |   37 +-
 fs/dlm/midcomms.c     | 1343 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/dlm/midcomms.h     |   15 +
 fs/dlm/rcom.c         |  123 +++--
 fs/dlm/util.c         |   10 +-
 fs/dlm/util.h         |    2 +
 14 files changed, 1924 insertions(+), 191 deletions(-)

