Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5AF3E24A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbhHFIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240526AbhHFIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z83rkc119CYen1Gzw7e82XAQWuLBSFUnY84qbnJ1F9Q=;
        b=FKOwSJ1ehnLB0w6NMCy8vPoJl5CjHLnNxo4zjK5IBHpq8tq5Pn7lxnZLaNTqb6BL6wiWXE
        4ozbkJgfXMk6lBzrDYUJCiOQknCuQq0m4S5SnwIFaGtZlDzaDvo0o/wvr+ZLua2teY1QjT
        sR5X6owcs47aAPZOcTPZhtBERhBw9hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-OPg4AHfGNTiWlnVVRqRQvA-1; Fri, 06 Aug 2021 04:03:35 -0400
X-MC-Unique: OPg4AHfGNTiWlnVVRqRQvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C611A939;
        Fri,  6 Aug 2021 08:03:33 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7979E5D9DE;
        Fri,  6 Aug 2021 08:03:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/7] loop: cleanup charging io to mem/blkcg
Date:   Fri,  6 Aug 2021 16:02:55 +0800
Message-Id: <20210806080302.298297-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guys,

Cleanup charging io to mem/blkcg a bit:

- avoid to store blkcg_css/memcg_css in loop_cmd, and store blkcg_css in
loop_worker instead

- avoid to acquire ->lo_work_lock in IO path

- simplify blkcg_css query via xarray

- other misc cleanup

V4:
	- fix build failure in case of !CONFIG_CGROUPS: changed to use
	'struct cgroup_subsys_state' as parameter of the added memcg helper;
	meantime add helper loop_blkcg_css_id()

V3:
	- one patch style change in 7/7
	- rebase patch 4/7 against for-5.15/block
	- add acked-by tag

V2:
	- add helper of memcg_get_e_css
	- cleanup #ifdef
	- improve the last patch, as discussed with Dan Schatzberg


Ming Lei (7):
  mm: memcontrol: add helper of memcg_get_e_css
  loop: clean up blkcg association
  loop: conver timer for monitoring idle worker into dwork
  loop: add __loop_free_idle_workers() for covering freeing workers in
    clearing FD
  loop: improve loop_process_work
  loop: use xarray to store workers
  loop: don't add worker into idle list

 drivers/block/loop.c       | 331 +++++++++++++++++++++----------------
 drivers/block/loop.h       |   7 +-
 include/linux/memcontrol.h |  10 ++
 3 files changed, 201 insertions(+), 147 deletions(-)

-- 
2.31.1

