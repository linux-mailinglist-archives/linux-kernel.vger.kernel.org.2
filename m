Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48C40F6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbhIQLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIQLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:24:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43724C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=R/oDDB1X8KW8mjUHzbdJN1KMLEZY1CFlvWgnnv8S4Uc=; b=nzwFrW1SKy3hCJNV/zS+6rAnwJ
        t7tRbpFxxIV8VeKhqsaoqS9PjTazZLt/gM5ePreDeuEFhHxaDwkzZr8Px8m2/+UY3srD6CjRTkdEy
        mz3t8GkQt/NckHA3rI3JQB9XgrtF2N1D3UUMEIF52TLQKoxY5MeVdPYv6PtHQUSseY24HcjBvFd9e
        XrN2TiSQGqUSzjP1PFSO7V/XP0tmCfOjyRgAuv/C3OE+BLFoP4Ig6OEBkKzPV5vDBsenTm55F2p9S
        DyvJUCb3PvzmnsHartOuZF8Y2KQdbVJwfEigapHFnI49u6ubqOXHUwTysPGIbAhoyu7XKE14mZRB6
        Cr7x7naA==;
Received: from [2001:4bb8:184:72db:2935:708c:157b:6f23] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRBx6-000Bo8-Gh; Fri, 17 Sep 2021 11:22:53 +0000
Date:   Fri, 17 Sep 2021 13:22:42 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for Linux 5.15
Message-ID: <YUR6gpm+mTWqdil6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 67f3b2f822b7e71cfc9b42dbd9f3144fa2933e0b:

  blk-mq: avoid to iterate over stale request (2021-09-12 19:32:43 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15

for you to fetch changes up to 70f437fb4395ad4d1d16fab9a1ad9fbc9fc0579b:

  nvme-tcp: fix io_work priority inversion (2021-09-14 10:32:05 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15

 - fix ANA state updates when a namespace is not present (Anton Eidelman)
 - nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show
   (Dan Carpenter)
 - avoid race in shutdown namespace removal (Daniel Wagner)
 - fix io_work priority inversion in nvme-tcp (Keith Busch)
 - destroy cm id before destroy qp to avoid use after free (Ruozhu Li)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix ANA state updates when a namespace is not present

Dan Carpenter (1):
      nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show()

Daniel Wagner (1):
      nvme: avoid race in shutdown namespace removal

Keith Busch (1):
      nvme-tcp: fix io_work priority inversion

Ruozhu Li (1):
      nvme-rdma: destroy cm id before destroy qp to avoid use after free

 drivers/nvme/host/core.c       | 15 +++++++--------
 drivers/nvme/host/multipath.c  |  7 +++++--
 drivers/nvme/host/rdma.c       | 16 +++-------------
 drivers/nvme/host/tcp.c        | 20 ++++++++++----------
 drivers/nvme/target/configfs.c |  2 +-
 5 files changed, 26 insertions(+), 34 deletions(-)
