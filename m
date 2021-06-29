Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7533B70AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhF2K3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232834AbhF2K3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624962439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x398MrgI290saNP+FLjnBg/QVE3FScuPBdMIn1/f/oM=;
        b=W0PEfBgdUGXTWEaLr4cC5GtuSruVYQc9FdH5N6jp4j/Q3Xk4/LokZqW3lZbbtfVQRF/Etp
        Q196SIAcFtLNyKcmd/rjKFFHreP5OzbqorjdCrgBzLzMZo+GXgVXmyzVzZWKT+5MYIOZzZ
        DVvmc/ldugvppYyCs5loEqrHj7d09cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Sq3c5XtyMduPGC4MWKn3OA-1; Tue, 29 Jun 2021 06:27:17 -0400
X-MC-Unique: Sq3c5XtyMduPGC4MWKn3OA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D959219057A6;
        Tue, 29 Jun 2021 10:27:16 +0000 (UTC)
Received: from max.com (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 425BE100164A;
        Tue, 29 Jun 2021 10:27:12 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Various minor gfs2 cleanups and fixes
Date:   Tue, 29 Jun 2021 12:27:10 +0200
Message-Id: <20210629102710.1934579-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 changes for 5.14.

Thanks a lot,
Andreas

The following changes since commit 62fb9874f5da54fdb243003b386128037319b219:

  Linux 5.13 (2021-06-27 15:21:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-fixes

for you to fetch changes up to 7a607a41cdc6c6f27b8e234cb44ce57070513dac:

  gfs2: Clean up gfs2_unstuff_dinode (2021-06-29 10:56:51 +0200)

----------------------------------------------------------------
Various minor gfs2 cleanups and fixes

----------------------------------------------------------------
Andreas Gruenbacher (6):
      gfs2: Fix do_gfs2_set_flags description
      gfs2: Fix underflow in gfs2_page_mkwrite
      gfs2: Fix error handling in init_statfs
      gfs2: Clean up the error handling in gfs2_page_mkwrite
      gfs2: Unstuff before locking page in gfs2_page_mkwrite
      gfs2: Clean up gfs2_unstuff_dinode

Baokun Li (1):
      gfs2: Use list_move_tail instead of list_del/list_add_tail

 fs/gfs2/bmap.c       | 62 ++++++++++++++++++++---------------------
 fs/gfs2/bmap.h       |  2 +-
 fs/gfs2/dir.c        |  2 +-
 fs/gfs2/file.c       | 79 ++++++++++++++++++++++++++++++++--------------------
 fs/gfs2/glock.c      |  3 +-
 fs/gfs2/ops_fstype.c |  1 +
 fs/gfs2/quota.c      |  2 +-
 7 files changed, 85 insertions(+), 66 deletions(-)

