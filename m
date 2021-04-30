Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125E136FE78
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhD3Q3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229579AbhD3Q26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619800088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=x9ksO6ZCSFOGH5MOABSY/p3OrJ5NQvgB4b95HTK7c9U=;
        b=XixyVF5kGysNiQiofqgB97kbbrtoShWkx3zjF5tRpJFJRJ9iB1tB0Dr/QhQkM3mNpLVVJB
        DGONpmX2NSENx63lsJueNZgFuaqoL0MpAme/NEUxOzSVoFfzSToCP+TwGEI95HX4ziwC6t
        UrtcCF3pFggrPtfI/MaVQPpipFpikMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-oKgXHhbmMJ-TXJdPOVBniw-1; Fri, 30 Apr 2021 12:28:06 -0400
X-MC-Unique: oKgXHhbmMJ-TXJdPOVBniw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778D580D698;
        Fri, 30 Apr 2021 16:28:05 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 318D75C1D0;
        Fri, 30 Apr 2021 16:28:05 +0000 (UTC)
Date:   Fri, 30 Apr 2021 11:28:03 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.13
Message-ID: <20210430162803.GA15511@redhat.com>
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

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.13

This set includes more dlm networking cleanups and improvements for
making dlm shutdowns more robust.

Thanks,
Dave


Alexander Aring (13):
      fs: dlm: fix debugfs dump
      fs: dlm: fix mark setting deadlock
      fs: dlm: set connected bit after accept
      fs: dlm: set subclass for othercon sock_mutex
      fs: dlm: add errno handling to check callback
      fs: dlm: add check if dlm is currently running
      fs: dlm: change allocation limits
      fs: dlm: use GFP_ZERO for page buffer
      fs: dlm: simplify writequeue handling
      fs: dlm: check on minimum msglen size
      fs: dlm: remove unaligned memory access handling
      fs: dlm: flush swork on shutdown
      fs: dlm: add shutdown hook

Yang Yingliang (1):
      fs: dlm: fix missing unlock on error in accept_from_sock()


 fs/dlm/config.c    |  86 ++++++++++++++++--------
 fs/dlm/config.h    |   1 -
 fs/dlm/debug_fs.c  |   1 +
 fs/dlm/lock.c      |   2 -
 fs/dlm/lockspace.c |  20 +++---
 fs/dlm/lowcomms.c  | 194 ++++++++++++++++++++++++++++++-----------------------
 fs/dlm/lowcomms.h  |   5 ++
 fs/dlm/midcomms.c  |  33 +++++----
 fs/dlm/rcom.c      |   2 -
 9 files changed, 202 insertions(+), 142 deletions(-)

