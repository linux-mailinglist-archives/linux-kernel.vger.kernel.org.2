Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A587E3F12FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhHSF6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:58:05 -0400
Received: from smtpbguseast1.qq.com ([54.204.34.129]:53260 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhHSF6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:58:04 -0400
X-Greylist: delayed 86513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Aug 2021 01:58:04 EDT
X-QQ-mid: bizesmtp46t1629352632t2uch5l9
Received: from localhost.localdomain (unknown [58.240.82.166])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 19 Aug 2021 13:57:11 +0800 (CST)
X-QQ-SSF: 0140000000700030B000000A0000000
X-QQ-FEAT: b4ip87mFn2nxtx/OGuv9KZPuwKTHMJvQ8g8FfMVMBRzcPp/vZr5QafUY/Hq4K
        em0O9fbX3GIQzmmPQdaMBVqDaGXWhBdVkX2LPHDHxIE/yj9Ie3gASSSfZtTgDHIvIr9ANtM
        xRe5f7Nb5/hAdVk8EmOYgUBT0TsrrNNVknf3qzWl57HM63D4eP7k74K56WdtuqZw8Bjk4HC
        CEqyMtZHRn0XXQ2qzmffZDZF52oCahtn7aOkjL9YIBXtKgLtcSYYeSNe8DXGHUC5Gnc5YCT
        h2TvZ2+t5IK/PSlO5WmAhP25dWrw6ZdyBB+hF4ddk/o9H5qU+o7KsvoWKdWct22hkh9s13h
        gKi4ndQE4UtQZwoN5ZkXK24u2CBWImi9Eiu3FUz
X-QQ-GoodBg: 1
From:   wangyangbo <wangyangbo@uniontech.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiehuanjun@uniontech.com,
        wangyangbo <wangyangbo@uniontech.com>
Subject: [PATCH 1/1] io_uring: Add register support to other PAGE_SIZE
Date:   Thu, 19 Aug 2021 13:56:57 +0800
Message-Id: <20210819055657.27327-1-wangyangbo@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <24d10cda-445e-10f3-d249-dac254e199e0@kernel.dk>
References: <24d10cda-445e-10f3-d249-dac254e199e0@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now allocated rsrc table uses PAGE_SIZE as the size of 2nd-level, and
accessing this table relies on each level index from fixed TABLE_SHIFT
(12 - 3) in 4k page case. In order to correctly work in non-4k page,
define TABLE_SHIFT as non-fixed (PAGE_SHIFT - shift of data) for
2nd-level table entry number.

Signed-off-by: wangyangbo <wangyangbo@uniontech.com>
---
pleasure to receive comments

 fs/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4d5c970eacdb..605b008ba29b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -92,12 +92,12 @@
 #define IORING_MAX_CQ_ENTRIES	(2 * IORING_MAX_ENTRIES)
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
 
-/* 512 entries per page on 64-bit archs, 64 pages max */
+/* only define max */
 #define IORING_MAX_FIXED_FILES	(1U << 15)
 #define IORING_MAX_RESTRICTIONS	(IORING_RESTRICTION_LAST + \
 				 IORING_REGISTER_LAST + IORING_OP_LAST)
 
-#define IO_RSRC_TAG_TABLE_SHIFT	9
+#define IO_RSRC_TAG_TABLE_SHIFT	(PAGE_SHIFT - 3)
 #define IO_RSRC_TAG_TABLE_MAX	(1U << IO_RSRC_TAG_TABLE_SHIFT)
 #define IO_RSRC_TAG_TABLE_MASK	(IO_RSRC_TAG_TABLE_MAX - 1)
 
-- 
2.20.1



