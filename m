Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91936432817
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhJRUB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231903AbhJRUB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:01:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74FC061038;
        Mon, 18 Oct 2021 19:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634587186;
        bh=KAXBuWYupeaJD1U70E8BV2rqTCvsJwIgsD4thLR+jc0=;
        h=From:To:Cc:Subject:Date:From;
        b=WPk83g8WnrxWv1IY3W0C/NijqMwQw90a3pUTUZLtzb/gAjv378IJwH7A9Vx62wW0S
         1gQWYnUK/+fz+4DQtcfakzj+v4uncmfyJhZSsLDLDmqAsq6GA9cCy95v3oYWlHFSNV
         q62zOPgj8QUhXnKnuWZhNoX/2RaK8viDDegfCtapRwNy1gTryPm/1B4aCjaqWDkOWy
         plt6Swv0ZmHKYOUptWs51MwdX8A9Y8BMbAIf+A1sjocyaYv1V7vXd4fbPhTNi3KRvi
         8gP8Ji3/oXqYXHo3/hfsqPZSGqD3qRoLm4sHC7Pt0U8ce2PDPXaxNqLZCSBBFXcbB4
         deYuBKVlGVtXg==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] NIOS2: fix for v5.15, part 2
Date:   Mon, 18 Oct 2021 14:59:45 -0500
Message-Id: <20211018195945.2462739-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix for NIOS2 for v5.15.

Thanks,

Dinh

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_for_v5.15_part2

for you to fetch changes up to 4cce60f15c04d69eff6ffc539ab09137dbe15070:

  NIOS2: irqflags: rename a redefined register name (2021-10-18 11:22:59 -0500)

----------------------------------------------------------------
NIOS2 fixes for v5.15, part 2
- Renamed CTL_STATUS to CTL_FSTATUS to fix a redefined warning

----------------------------------------------------------------
Randy Dunlap (1):
      NIOS2: irqflags: rename a redefined register name

 arch/nios2/include/asm/irqflags.h  | 4 ++--
 arch/nios2/include/asm/registers.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
