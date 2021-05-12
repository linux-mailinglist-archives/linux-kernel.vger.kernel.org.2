Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06C37B92B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhELJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:30:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2460 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Z22KVYzBtTM;
        Wed, 12 May 2021 17:26:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:23 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 00/17] tty: Fix some coding style issues
Date:   Wed, 12 May 2021 17:26:08 +0800
Message-ID: <1620811585-18582-1-git-send-email-tanxiaofei@huawei.com>
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

Xiaofei Tan (17):
  tty: tty_baudrate: Remove unnecessary tab and spaces in comment
    sentence
  tty: tty_baudrate: Fix coding style issues of block comments
  tty: tty_buffer: Add a blank line after declarations
  tty: tty_buffer: Remove the repeated word 'the'
  tty: tty_buffer: Fix coding style issues of block comments
  tty: tty_io: Remove spaces before tabs
  tty: tty_io: Add a blank line after declarations
  tty: tty_io: Fix spaces required around that ':'
  tty: tty_io: Fix trailing whitespace issues
  tty: tty_io: Fix coding style issues of block comments
  tty: tty_io: Remove the repeated word 'can'
  tty: tty_io: Fix an issue of code indent for conditional statements
  tty: tty_io: Delete a blank line before EXPORT_SYMBOL(foo)
  tty: tty_io: Remove return in void function
  tty: tty_port: Delete a blank line before EXPORT_SYMBOL(foo)
  tty: tty_port: Add a blank line after declarations
  tty: tty_port: Fix coding style issues of block comments

 drivers/tty/tty_baudrate.c | 13 ++++++----
 drivers/tty/tty_buffer.c   | 20 +++++++++++----
 drivers/tty/tty_io.c       | 61 ++++++++++++++++++++++++++--------------------
 drivers/tty/tty_port.c     | 16 +++++++-----
 4 files changed, 67 insertions(+), 43 deletions(-)

-- 
2.8.1

