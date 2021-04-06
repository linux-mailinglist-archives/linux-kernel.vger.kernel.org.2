Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D935520B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbhDFL1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:27:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16353 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245505AbhDFL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF4vQ0jZlz941Y;
        Tue,  6 Apr 2021 19:25:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:27:23 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 00/10] tty: Fix some coding style issues
Date:   Tue, 6 Apr 2021 19:24:38 +0800
Message-ID: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some issues reported by checkpatch.pl. All of them are
coding style issues, no function changes.

Differences from v1 to v2:
- Remove one redundant tab for the patch 02/10.
- Add some expression optimization for some sentenses following
- Jiri's advice for the patch 04/10.

Xiaofei Tan (10):
  tty/sysrq: Add a blank line after declarations
  tty/sysrq: Fix issues of code indent should use tabs
  tty: tty_jobctrl: Add a blank line after declarations
  tty: tty_jobctrl: Fix coding style issues of block comments
  tty: tty_jobctrl: Remove spaces before tabs
  tty: tty_ldisc: Fix an issue of code indent should use tabs
  tty: tty_ldisc: Add a blank line after declarations
  tty: tty_ldisc: Fix coding style issues of block comments
  tty: tty_ldisc: Do not use assignment in if condition
  tty: tty_ldisc: Remove the repeated word 'the'

 drivers/tty/sysrq.c       | 35 ++++++++++++++++++-----------------
 drivers/tty/tty_jobctrl.c | 29 +++++++++++++++++++----------
 drivers/tty/tty_ldisc.c   | 41 ++++++++++++++++++++++++++---------------
 3 files changed, 63 insertions(+), 42 deletions(-)

-- 
2.8.1

