Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29637397580
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhFAOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:36:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40906 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhFAOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:36:01 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 98E0E72C8B5;
        Tue,  1 Jun 2021 17:34:18 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by imap.altlinux.org (Postfix) with ESMTP id 79B784A46EC;
        Tue,  1 Jun 2021 17:34:18 +0300 (MSK)
From:   Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: [PATCH v2] userfaultfd: fix UFFDIO_CONTINUE ioctl request definition
Date:   Tue,  1 Jun 2021 17:34:32 +0300
Message-Id: <20210601143432.1002481-1-glebfm@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ioctl request reads from uffdio_continue structure which justifies
_IOC_READ flag.
See NOTEs in include/uapi/asm-generic/ioctl.h for more information.

Fixes: f619147104c8 ("userfaultfd: add UFFDIO_CONTINUE ioctl")
Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Acked-by: Peter Xu <peterx@redhat.com>
---
 include/uapi/linux/userfaultfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v2 fix commit message

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

