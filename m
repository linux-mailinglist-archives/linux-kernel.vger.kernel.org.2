Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC843B4846
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFYRjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:39:19 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58134 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:39:19 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D038F72C8B4;
        Fri, 25 Jun 2021 20:36:56 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by imap.altlinux.org (Postfix) with ESMTP id AC2684A46EC;
        Fri, 25 Jun 2021 20:36:56 +0300 (MSK)
From:   Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] userfaultfd: uapi: fix UFFDIO_CONTINUE ioctl request definition
Date:   Fri, 25 Jun 2021 20:36:55 +0300
Message-Id: <20210625173655.50106-1-glebfm@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ioctl request reads from uffdio_continue structure written by
userspace which justifies _IOC_WRITE flag.  It also writes back to that
structure which justifies _IOC_READ flag.

See NOTEs in include/uapi/asm-generic/ioctl.h for more information.

Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/userfaultfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Please make sure this patch is merged before v5.13 is released,
otherwise the UAPI bug would have to stay for backwards ABI
compatibility.

diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index bafbeb1a2624..650480f41f1d 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -80,8 +80,8 @@
 				      struct uffdio_zeropage)
 #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
 				      struct uffdio_writeprotect)
-#define UFFDIO_CONTINUE		_IOR(UFFDIO, _UFFDIO_CONTINUE,	\
-				     struct uffdio_continue)
+#define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
+				      struct uffdio_continue)
 
 /* read() structure */
 struct uffd_msg {
-- 
glebfm

