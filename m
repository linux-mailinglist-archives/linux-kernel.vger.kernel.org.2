Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0A37B929
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhELJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:30:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2459 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:30:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg8Z21s0szBtSv;
        Wed, 12 May 2021 17:26:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 17:29:24 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 03/17] tty: tty_buffer: Add a blank line after declarations
Date:   Wed, 12 May 2021 17:26:11 +0800
Message-ID: <1620811585-18582-4-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620811585-18582-1-git-send-email-tanxiaofei@huawei.com>
References: <1620811585-18582-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line after declarations, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_buffer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 9733469..5509b5d 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -91,6 +91,7 @@ EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 int tty_buffer_space_avail(struct tty_port *port)
 {
 	int space = port->buf.mem_limit - atomic_read(&port->buf.mem_used);
+
 	return max(space, 0);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_space_avail);
@@ -312,11 +313,13 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size)
 {
 	int copied = 0;
+
 	do {
 		int goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
 		int flags = (flag == TTY_NORMAL) ? TTYB_NORMAL : 0;
 		int space = __tty_buffer_request_room(port, goal, flags);
 		struct tty_buffer *tb = port->buf.tail;
+
 		if (unlikely(space == 0))
 			break;
 		memcpy(char_buf_ptr(tb, tb->used), chars, space);
@@ -348,10 +351,12 @@ int tty_insert_flip_string_flags(struct tty_port *port,
 		const unsigned char *chars, const char *flags, size_t size)
 {
 	int copied = 0;
+
 	do {
 		int goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
 		int space = tty_buffer_request_room(port, goal);
 		struct tty_buffer *tb = port->buf.tail;
+
 		if (unlikely(space == 0))
 			break;
 		memcpy(char_buf_ptr(tb, tb->used), chars, space);
@@ -431,8 +436,10 @@ int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 		size_t size)
 {
 	int space = __tty_buffer_request_room(port, size, TTYB_NORMAL);
+
 	if (likely(space)) {
 		struct tty_buffer *tb = port->buf.tail;
+
 		*chars = char_buf_ptr(tb, tb->used);
 		if (~tb->flags & TTYB_NORMAL)
 			memset(flag_buf_ptr(tb, tb->used), TTY_NORMAL, space);
-- 
2.8.1

