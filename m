Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA632A97B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575994AbhCBSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:30:36 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41570 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578862AbhCBPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:35:21 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4D45372C8B8;
        Tue,  2 Mar 2021 18:34:38 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by imap.altlinux.org (Postfix) with ESMTP id 1CEBB4A4721;
        Tue,  2 Mar 2021 18:34:38 +0300 (MSK)
From:   Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        linux-kernel@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] vmci_host: print unexpanded names of ioctl requests in debug messages
Date:   Tue,  2 Mar 2021 18:33:46 +0300
Message-Id: <20210302153346.300416-1-glebfm@altlinux.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__stringify macro function expands its arguments, but in this messages
we expect to see ioctl request name instead of it's _IOC macro
expansion.

$ cat stringify.c

#include <stdio.h>
#include <asm/ioctl.h>

#define __stringify_1(x)	#x
#define __stringify(x)		__stringify_1(x)

#define VMCI_DO_IOCTL(ioctl_name) \
    char *name = __stringify(IOCTL_VMCI_ ## ioctl_name);

int main() {
        VMCI_DO_IOCTL(INIT_CONTEXT)
        printf("%s\n", name);
}
$ cc stringify.c
$ ./a.out
(((0U) << (((0+8)+8)+14)) | (((7)) << (0+8)) | (((0xa0)) << 0) | ((0) << ((0+8)+8)))

Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
---
 drivers/misc/vmw_vmci/vmci_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 2d8328d928d5..da1e2a773823 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -908,7 +908,7 @@ static long vmci_host_unlocked_ioctl(struct file *filp,
 				     unsigned int iocmd, unsigned long ioarg)
 {
 #define VMCI_DO_IOCTL(ioctl_name, ioctl_fn) do {			\
-		char *name = __stringify(IOCTL_VMCI_ ## ioctl_name);	\
+		char *name = "IOCTL_VMCI_" # ioctl_name;		\
 		return vmci_host_do_ ## ioctl_fn(			\
 			vmci_host_dev, name, uptr);			\
 	} while (0)
-- 
glebfm
