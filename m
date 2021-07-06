Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E53BD7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhGFNnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:43:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:36034 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhGFNnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:43:09 -0400
X-Greylist: delayed 1040 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 09:43:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=VWq52QzJY61Hg9Lh5zyzVxOv+TLoT34Qy5rgyEf6fBM=; b=rIBCGOscqGai
        6TZr5OCxVKA+hHIhc2cNNUErPv6ci+RjRRySAd3Fhw+CWOgxRXN5ZMkvm6WpdLxdrzf43QQ62Uofr
        HN1tr12wQef21oCK+9MCg7ct661hHvpq97fxuXSaRh2+7IOnxw3qQFOf0S18lxQP38DwPRhPn27c1
        fWJDs=;
Received: from [192.168.15.247] (helo=mikhalitsyn-laptop.sw.ru)
        by relay.sw.ru with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1m0l2Y-0034RU-T2; Tue, 06 Jul 2021 16:23:06 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace was changed
Date:   Tue,  6 Jul 2021 16:22:57 +0300
Message-Id: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Task IPC namespace shm's has shm_rmid_forced feature which is per IPC namespace
and controlled by kernel.shm_rmid_forced sysctl. When feature is turned on,
then during task exit (and unshare(CLONE_NEWIPC)) all sysvshm's will be destroyed
by exit_shm(struct task_struct *task) function. But there is a problem if task
was changed IPC namespace since shmget() call. In such situation exit_shm() function
will try to call
shm_destroy(<new_ipc_namespace_ptr>, <sysvshmem_from_old_ipc_namespace>)
which leads to the situation when sysvshm object still attached to old
IPC namespace but freed; later during old IPC namespace cleanup we will try to
free such sysvshm object for the second time and will get the problem :)

First patch solves this problem by postponing shm_destroy to the moment when
IPC namespace cleanup will be called.
Second patch is useful to prevent (or easy catch) such bugs in the future by
adding corresponding WARNings.

Regards,
Alex

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Milton Miller <miltonm@bga.com>
Cc: Jack Miller <millerjo@us.ibm.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>

Alexander Mikhalitsyn (2):
  shm: skip shm_destroy if task IPC namespace was changed
  ipc: WARN if trying to remove ipc object which is absent

 ipc/shm.c  | 10 +++++++++-
 ipc/util.c |  6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.31.1

