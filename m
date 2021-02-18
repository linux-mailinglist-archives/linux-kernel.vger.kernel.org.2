Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2541131EA25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhBRM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:58:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:58922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233036AbhBRLQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:16:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2B19ACD4;
        Thu, 18 Feb 2021 11:15:47 +0000 (UTC)
Date:   Thu, 18 Feb 2021 12:15:47 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pstore: fix compression
Message-ID: <20210218111547.johvp5klpv3xrpnn@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore_compress() and decompress_record() use a mistyped config option
name ("PSTORE_COMPRESSION" instead of "PSTORE_COMPRESS").
As a result compression and decompressionm of pstore records is always
disabled.

Use the correct config option name.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Fixes: fd49e03280e596e54edb93a91bc96170f8e97e4a ("pstore: Fix linking when crypto API disabled")

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 32f64abc277c..d963ae7902f9 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -269,7 +269,7 @@ static int pstore_compress(const void *in, void *out,
 {
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION))
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS))
 		return -EINVAL;
 
 	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
@@ -671,7 +671,7 @@ static void decompress_record(struct pstore_record *record)
 	int unzipped_len;
 	char *unzipped, *workspace;
 
-	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION) || !record->compressed)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
 		return;
 
 	/* Only PSTORE_TYPE_DMESG support compression. */

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

