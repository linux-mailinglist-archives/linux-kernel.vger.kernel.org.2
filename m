Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01BA31DFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhBQUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:03:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39234 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhBQUDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:03:41 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lCT2E-0000E1-Sx; Wed, 17 Feb 2021 20:02:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: remove redundant initialization of variable zipped_len
Date:   Wed, 17 Feb 2021 20:02:54 +0000
Message-Id: <20210217200254.196243-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable zipped_len is being initialized with a value that is
never read and it is being updated later with a new value. The
initialization is redundant and can be removed. Clean up the code
and move the scope of zipped_len.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/pstore/platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 32f64abc277c..e79bc527289d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -410,7 +410,6 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		char *dst;
 		size_t dst_size;
 		int header_size;
-		int zipped_len = -1;
 		size_t dump_size;
 		struct pstore_record record;
 
@@ -440,6 +439,8 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			break;
 
 		if (big_oops_buf) {
+			int zipped_len;
+
 			zipped_len = pstore_compress(dst, psinfo->buf,
 						header_size + dump_size,
 						psinfo->bufsize);
-- 
2.30.0

