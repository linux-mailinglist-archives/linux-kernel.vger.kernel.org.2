Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168BF33ED23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCQJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:37:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCQJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:37:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lMSbr-0005OC-22; Wed, 17 Mar 2021 09:36:59 +0000
From:   Colin King <colin.king@canonical.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cifsd: Fix a handful of spelling mistakes
Date:   Wed, 17 Mar 2021 09:36:58 +0000
Message-Id: <20210317093658.5370-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several spelling mistakes in various ksmbd_err and
ksmbd_debug messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifsd/ndr.c            | 2 +-
 fs/cifsd/smb2pdu.c        | 4 ++--
 fs/cifsd/transport_rdma.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifsd/ndr.c b/fs/cifsd/ndr.c
index d96dcd9e43c6..aa0cb8fc555d 100644
--- a/fs/cifsd/ndr.c
+++ b/fs/cifsd/ndr.c
@@ -325,7 +325,7 @@ int ndr_decode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
 
 	ndr_read_bytes(n, acl->desc, 10);
 	if (strncmp(acl->desc, "posix_acl", 9)) {
-		ksmbd_err("Invalid acl desciption : %s\n", acl->desc);
+		ksmbd_err("Invalid acl description : %s\n", acl->desc);
 		return -EINVAL;
 	}
 
diff --git a/fs/cifsd/smb2pdu.c b/fs/cifsd/smb2pdu.c
index 3da96ebeae8b..4cda7df3bd70 100644
--- a/fs/cifsd/smb2pdu.c
+++ b/fs/cifsd/smb2pdu.c
@@ -2508,7 +2508,7 @@ int smb2_open(struct ksmbd_work *work)
 	if (req->NameLength) {
 		if ((req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
 			*(char *)req->Buffer == '\\') {
-			ksmbd_err("not allow directory name included leadning slash\n");
+			ksmbd_err("not allow directory name included leading slash\n");
 			rc = -EINVAL;
 			goto err_out1;
 		}
@@ -2636,7 +2636,7 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 	if (!(req->DesiredAccess & DESIRED_ACCESS_MASK)) {
-		ksmbd_err("Invalid disired access : 0x%x\n",
+		ksmbd_err("Invalid desired access : 0x%x\n",
 			le32_to_cpu(req->DesiredAccess));
 		rc = -EACCES;
 		goto err_out1;
diff --git a/fs/cifsd/transport_rdma.c b/fs/cifsd/transport_rdma.c
index 1698f7ed9c2f..4f4806d67ab0 100644
--- a/fs/cifsd/transport_rdma.c
+++ b/fs/cifsd/transport_rdma.c
@@ -485,7 +485,7 @@ static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
 		struct smb2_hdr *hdr = (struct smb2_hdr *) (recvmsg->packet
 				+ le32_to_cpu(req->data_offset) - 4);
 		ksmbd_debug(RDMA,
-				"CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemaingDataLength: %u, SMB: %x, Command: %u\n",
+				"CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemainingDataLength: %u, SMB: %x, Command: %u\n",
 				le16_to_cpu(req->credits_granted),
 				le16_to_cpu(req->credits_requested),
 				req->data_length, req->remaining_data_length,
-- 
2.30.2

