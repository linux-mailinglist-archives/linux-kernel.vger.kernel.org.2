Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6EB3D235C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhGVLwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:52:25 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21353 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGVLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:52:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626957169; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RjraAwfcEUAaLLcBFBJiG//haboxoQTo3Vmy3KL3b75g26mGZAZhFMpM9O72bCBUhGM6UDnQIFsEd1vFcZYv/XiumjpinsXpaqdIaB5elaS+1GzAkShfjmWtdDhwnvNJ6OVy+zb94tZ39ZP5uFlem3P73ALEHPyDij50Wn0riTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626957169; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=DsBLta2Pf+TK6Ka/qZ4n4thM6rf6CZnKPL/RL0BszfI=; 
        b=Z2ZRV7vxTtq/Xxn7Q6JY8VduhXOtfMGxy4bXKCKK61vXzcXF/Rh1mmuZn6ccK7B/QXplsNIq7iAaZjguXv7urJ7hqIVHXjm8KrjsyxQsfuiz2xvBgvVOCxV+FXAqj1NORPsNpvtTYPO7v+77kztoeZdZ1pLgNRjkkaXLrWOzSrQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626957169;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=DsBLta2Pf+TK6Ka/qZ4n4thM6rf6CZnKPL/RL0BszfI=;
        b=XDjE6nFmVDEwaEeX1E9VgWtxcRRMl1soEUUdB7bm44aaNA/760jrPSAZp92DyavE
        79VCXo/KK1kW1egR4ePbxCQIbZVEV06KBXK8yTBhW10ZI4p41AS+VatvL/uzouMIC9f
        Kn34uKzJMq0SMypI5LrqsfBugg3AJP/Zi/aYGFFs=
Received: from localhost.localdomain (49.207.63.174 [49.207.63.174]) by mx.zohomail.com
        with SMTPS id 1626957166177298.18070444753164; Thu, 22 Jul 2021 05:32:46 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v6 0/2] firmware_loader: fix uaf in firmware_fallback_sysfs 
Date:   Thu, 22 Jul 2021 18:02:27 +0530
Message-Id: <20210722123229.8731-1-mail@anirudhrb.com>
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

The first patch does some cleanup of the error codes and documents
them properly. The second patch goes on to actually fix the bug.

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

 drivers/base/firmware_loader/fallback.c | 44 +++++++++++++++++--------
 drivers/base/firmware_loader/firmware.h |  6 +++-
 drivers/base/firmware_loader/main.c     |  2 ++
 3 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.26.2

