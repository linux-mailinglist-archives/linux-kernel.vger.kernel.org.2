Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B613FEF45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbhIBOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234355AbhIBOSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630592270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=2e6dsZkQgBYFJNmC6Zh9miYYi2IrqOsHwbxDd3eYftY=;
        b=KCnxKg/DErYZvqxtfRXfdXHnf+GJ3MugsG1AqXILXTUzM4DZojcul4qi3GRukgG6xmRE7P
        3PSoSJtWaNT+CiAgbpxB9LzPIi9TTR38QBgmLTSifmWTO8yu6X1xOEO8TUrW4iTQgnGYC5
        EQJXzwdTyDl6vi5GnN3hJg7ZD/D1wlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-LtuVe0swNuuzvGwzj_-Jxg-1; Thu, 02 Sep 2021 10:17:49 -0400
X-MC-Unique: LtuVe0swNuuzvGwzj_-Jxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0985518FF44D;
        Thu,  2 Sep 2021 14:17:48 +0000 (UTC)
Received: from redhat.com (unknown [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C074C60E3A;
        Thu,  2 Sep 2021 14:17:47 +0000 (UTC)
Date:   Thu, 2 Sep 2021 09:17:45 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.15
Message-ID: <20210902141745.GA31274@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.15

This set includes a number of minor fixes and cleanups
related to the networking changes in the last release.
A patch to delay ack messages reduces network traffic
significantly.

Thanks,
Dave

Alexander Aring (15):
      fs: dlm: use sk->sk_socket instead of con->sock
      fs: dlm: use READ_ONCE for config var
      fs: dlm: fix typo in tlv prefix
      fs: dlm: clear CF_APP_LIMITED on close
      fs: dlm: cleanup and remove _send_rcom
      fs: dlm: introduce con_next_wq helper
      fs: dlm: move to static proto ops
      fs: dlm: introduce generic listen
      fs: dlm: auto load sctp module
      fs: dlm: generic connect func
      fs: dlm: fix multiple empty writequeue alloc
      fs: dlm: move receive loop into receive handler
      fs: dlm: implement delayed ack handling
      fs: dlm: fix return -EINTR on recovery stopped
      fs: dlm: avoid comms shutdown delay in release_lockspace

 fs/dlm/dir.c          |   4 +-
 fs/dlm/dlm_internal.h |   2 +-
 fs/dlm/lockspace.c    |   3 +-
 fs/dlm/lowcomms.c     | 770 +++++++++++++++++++++++++-------------------------
 fs/dlm/lowcomms.h     |   1 +
 fs/dlm/member.c       |   4 +-
 fs/dlm/midcomms.c     |  56 +++-
 fs/dlm/rcom.c         |  29 +-
 fs/dlm/recoverd.c     |   4 +-
 9 files changed, 458 insertions(+), 415 deletions(-)

