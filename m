Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6432378D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346137AbhEJMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhEJLRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA70461492;
        Mon, 10 May 2021 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620645160;
        bh=9UxqKxbzLJfVW1nRZBSiPPEQqqBLd5TtF5qWnJvu8aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+sfVmaPY46AjzpwxCJhIwQtwtYb9OgaCK54iKKwIsumWiQy963X0ZropmtymFy+I
         8QvbtBXJCBqBImfd3Fk16fYOSbkgcqi7XH0AReZsSRMIR5znlThlk1ltf/f/Ex+3uv
         sMRejmlNPvQrTrlpDazhTKw4DNBucKu/DUwOTWuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Liu Zhi Qiang <liuzhiqiang26@huawei.com>,
        Ye Bin <yebin10@huawei.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.12 342/384] ext4: fix ext4_error_err save negative errno into superblock
Date:   Mon, 10 May 2021 12:22:11 +0200
Message-Id: <20210510102026.051105528@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510102014.849075526@linuxfoundation.org>
References: <20210510102014.849075526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

commit 6810fad956df9e5467e8e8a5ac66fda0836c71fa upstream.

Fix As write_mmp_block() so that it returns -EIO instead of 1, so that
the correct error gets saved into the superblock.

Cc: stable@kernel.org
Fixes: 54d3adbc29f0 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
Reported-by: Liu Zhi Qiang <liuzhiqiang26@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://lore.kernel.org/r/20210406025331.148343-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -56,7 +56,7 @@ static int write_mmp_block(struct super_
 	wait_on_buffer(bh);
 	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
-		return 1;
+		return -EIO;
 
 	return 0;
 }


