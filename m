Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12E3D478B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhGXLbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 07:31:34 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21339 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhGXLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 07:31:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627128719; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kvLQRvEpQMElxZAbpLLTQwts/J8tNUM7zjxqSUnCWN3CB4NppZynu6IVjCzWovcZJ6h2liepY0ChUsZSFUm7/qEI9KCn2brCZyU9UieErewLyrHatbRm5Oztpnf1u8pyVpc5yd6BCcxlGjsDeZkE4QjVGJ4d9SMfviJB8ImwFnc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627128719; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Gwqi7qz2xySqwvKyeGIDtfL3RZb4Fe+2154Q1TOO/FU=; 
        b=AA7fbXmzdTjxAlvISZMl2kGyYlhjwHG5OOrxdoXwwJ5nUJ7qiwAna5FlFQC9/3BVJMobIJwlXFnLWPuCOHbnr70RBOo57AmypWIBeG6bF20JlJzfz/jglJK344GL9QhWfBiFlwnOgSZg8ycWE9vchPJ9Z3IsXz5eo3KkA1HogpM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627128719;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=Gwqi7qz2xySqwvKyeGIDtfL3RZb4Fe+2154Q1TOO/FU=;
        b=yg7ZueEKxKRe3SgPS7bLtiDP+tq+2PwQr62WBFrTlZOIlPrN+/wNkBgzd3QpyViX
        Z2r0Jh6gRqkVXTq7U29hQCCH03RsVUEFsFUxkUydJWrLFlOMt3bx/ccmk5oPCznANrS
        ypePK8Sy6xZrCHY6WiGdXaEIkc9grUtDSSUR1X0Y=
Received: from localhost.localdomain (106.51.107.3 [106.51.107.3]) by mx.zohomail.com
        with SMTPS id 1627128715051669.0032074506994; Sat, 24 Jul 2021 05:11:55 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v7 0/2] firmware_loader: fix uaf in firmware_fallback_sysfs
Date:   Sat, 24 Jul 2021 17:41:32 +0530
Message-Id: <20210724121134.6364-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the use after free in firmware_fallback_sysfs reported
by syzbot at:

https://syzkaller.appspot.com/bug?extid=de271708674e2093097b

The first patch gets rid of the -EAGAIN return since it doesn't make
sense (see patch description for more info). The second patch goes on to
actually fix the use after free issue.

Changes in v7:
1. Don't move the error handling code from fw_load_sysfs_fallback
   to fw_sysfs_wait_timeout to simplify the patch. Also, the move
   is unnecessary.

2. Fix the commit log for the patch 1 as per Luis' suggestions.

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

 drivers/base/firmware_loader/fallback.c | 12 +++++++-----
 drivers/base/firmware_loader/firmware.h |  6 +++++-
 drivers/base/firmware_loader/main.c     |  2 ++
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.26.2

