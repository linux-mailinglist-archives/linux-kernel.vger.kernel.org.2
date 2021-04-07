Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1503564C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349329AbhDGHJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:09:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15146 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbhDGHJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:09:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFb6Z4TZ4zpVjf;
        Wed,  7 Apr 2021 15:06:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 15:09:25 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v3 00/10] tty: Fix some coding style issues
Date:   Wed, 7 Apr 2021 15:06:40 +0800
Message-ID: <1617779210-51576-1-git-send-email-tanxiaofei@huawei.com>
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

Differences from v2 to v3:
- Fix the misunderstanding of 'period' for the patch 04/10.

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

