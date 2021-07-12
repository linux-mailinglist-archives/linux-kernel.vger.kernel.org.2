Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF93C4E87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbhGLHTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241125AbhGLGyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 515C2610D1;
        Mon, 12 Jul 2021 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626072705;
        bh=yDKKkLbLvZHkjEhLE8CA+rE3DY6EHc3b7WO5+7l+mkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2S05zKVTDyk2zHg5C6vQftVlVCrNklw8Fp/kosy+ApUOP0OFr8fciaaaGy88HvSB
         hm//GDbkKWzcpimKfkYI9BFNaLtHVTxeT7vWz0QcXbv4Jmf1T3bJoz/mBuVtgKZxVZ
         R6wwexJYIAit5gYQ8pbUSkF4ENGA0U7EnzdiR5Fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5.10 587/593] erofs: fix error return code in erofs_read_superblock()
Date:   Mon, 12 Jul 2021 08:12:27 +0200
Message-Id: <20210712061000.108613715@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060843.180606720@linuxfoundation.org>
References: <20210712060843.180606720@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 0508c1ad0f264a24c4643701823a45f6c9bd8146 upstream.

'ret' will be overwritten to 0 if erofs_sb_has_sb_chksum() return true,
thus 0 will return in some error handling cases. Fix to return negative
error code -EINVAL instead of 0.

Link: https://lore.kernel.org/r/20210519141657.3062715-1-weiyongjun1@huawei.com
Fixes: b858a4844cfb ("erofs: support superblock checksum")
Cc: stable <stable@vger.kernel.org> # 5.5+
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/erofs/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -155,6 +155,7 @@ static int erofs_read_superblock(struct
 			goto out;
 	}
 
+	ret = -EINVAL;
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {


