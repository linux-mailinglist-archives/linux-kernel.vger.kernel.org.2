Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BBC3D8A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhG1Ivh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:51:37 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21394 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhG1Ivg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627462290; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Pi2KqZWuK18dhZOcGaixn0LZJgWdkezNxd8qBIbJZFG+iw/EEekkgrPsGIMi0tFbw118mPqRr4VXb0yH1Qsbu6ze5X1mC87FUG27jeSmmpnrr4AnUt4znClTTZdnmJXIEWR8oNcLrn4bN7XwuC/4LbWQAk0haZ4ZsZdCkmasFKs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627462290; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ZG502c7KtdGTgFEv3R+joxM5QstperDpibzCKlU+jAY=; 
        b=ae6WporXuPPrjLJ3wztVjYwIWkwgIpwEco1WI94e9D3HBHhihrZSGm/88ByLcgGHcpvNZ3D1NdOz2CCrJd/XGXljx6qF7ialsuDaQfuj1LgGd/QAdxHFYR6MUMJ0BjojpQOCpMHaovPcqMQalBB/KyURkk5NSC+nGVzXeKYFrBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627462290;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=ZG502c7KtdGTgFEv3R+joxM5QstperDpibzCKlU+jAY=;
        b=lS1XvwX3gAzHA4g/eFF4n6MDPueGgBpRsnS8mRqx3BiACndXi4qhqd+42WsUPXzF
        L/hdQwThyriMXQxIUy0E4ONlxVGukUcamL9GSPM4d1EOpqrNbcw1+O30mUitMjU/N9Q
        jLD2NE0JIfA4EU7Jyoe5SNj/QBeY3WPAL3GJ4P9g=
Received: from localhost.localdomain (49.207.59.170 [49.207.59.170]) by mx.zohomail.com
        with SMTPS id 1627462286332340.6254694070768; Wed, 28 Jul 2021 01:51:26 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v8 0/2] firmware_loader: fix uaf in firmware_fallback_sysfs
Date:   Wed, 28 Jul 2021 14:21:05 +0530
Message-Id: <20210728085107.4141-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the use after free in firmware_fallback_sysfs reported by
syzbot at: 
https://syzkaller.appspot.com/bug?extid=de271708674e2093097b

The first patch gets rid of the -EAGAIN return since it doesn't make
sense (see patch description for more info). The second patch goes on to
actually fix the use after free issue.

Changes in v8:
1. Added/fixed some comments as suggested by Shuah

Changes in v7:
1. Don't move the error handling code from fw_load_sysfs_fallback
   to fw_sysfs_wait_timeout to simplify the patch. Also, the move
   is unnecessary.

2. Fix the commit log for patch 1 as per Luis' suggestions.

Changes in v6:
1. v5 didn't actually remove -EAGAIN. So, fixed that.

Changes in v5:
1. Split the patch into two patches as discussed here:
   https://lore.kernel.org/lkml/20210715232105.am4wsxfclj2ufjdw@garbanzo/

Changes in v4:
Documented the reasons behind the error codes returned from
fw_sysfs_wait_timeout() as suggested by Luis Chamberlain.

Changes in v3:
Modified the patch to incorporate suggestions by Luis Chamberlain in
order to fix the root cause instead of applying a "band-aid" kind of
fix.
https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/

Changes in v2:
1. Fixed 1 error and 1 warning (in the commit message) reported by
checkpatch.pl. The error was regarding the format for referring to
another commit "commit <sha> ("oneline")". The warning was for line
longer than 75 chars.


Anirudh Rayabharam (2):
  firmware_loader: use -ETIMEDOUT instead of -EAGAIN in
    fw_load_sysfs_fallback
  firmware_loader: fix use-after-free in firmware_fallback_sysfs

 drivers/base/firmware_loader/fallback.c | 14 ++++++++------
 drivers/base/firmware_loader/firmware.h | 10 +++++++++-
 drivers/base/firmware_loader/main.c     |  2 ++
 3 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.26.2

