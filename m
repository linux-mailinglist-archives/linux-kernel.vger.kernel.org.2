Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BA34CB34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhC2Iox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233980AbhC2I1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71FBE619A7;
        Mon, 29 Mar 2021 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617006384;
        bh=t+78ARRy+Zp+PWsY434rcxDjEhFah7gtlT0eaFU/Cog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+rnEjJ4dX+wziQqxIcEDK7CLDLE6Tqb89e8HTvj22vYCkY81RkjA5CX7sNjWf0yx
         YpooR0rbciU1w40hUWE2bdXyx+FGF+tjz5lISIONG8gUvwV7B4lly+bQttbaagrjWf
         B1e+XoU8Djsp5Jq3/8kdF2Q1cXqjpygX49tKdRPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 176/221] octeontx2-af: Fix memory leak of object buf
Date:   Mon, 29 Mar 2021 09:58:27 +0200
Message-Id: <20210329075635.021745601@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329075629.172032742@linuxfoundation.org>
References: <20210329075629.172032742@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 9e0a537d06fc36861e4f78d0a7df1fe2b3592714 ]

Currently the error return path when lfs fails to allocate is not free'ing
the memory allocated to buf. Fix this by adding the missing kfree.

Addresses-Coverity: ("Resource leak")
Fixes: f7884097141b ("octeontx2-af: Formatting debugfs entry rsrc_alloc.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index c018121d4cc5..bc870bff14df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -163,8 +163,10 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 		return -ENOSPC;
 
 	lfs = kzalloc(lf_str_size, GFP_KERNEL);
-	if (!lfs)
+	if (!lfs) {
+		kfree(buf);
 		return -ENOMEM;
+	}
 	off +=	scnprintf(&buf[off], buf_size - 1 - off, "%-*s", lf_str_size,
 			  "pcifunc");
 	for (index = 0; index < BLK_COUNT; index++)
-- 
2.30.1



