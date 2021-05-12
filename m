Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F337EA94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359407AbhELTHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244286AbhELQmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:42:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2FCC61D3F;
        Wed, 12 May 2021 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620835940;
        bh=k4tulv8T7OkYhDlVnvCBZSbs34StUMS4WWU6IloYYq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/QpXQxlkjkl5zYsYgfZPIJujfoG57dsHr15Ebd6u+FJyKqGutn60Uj4Eo9H5EUtp
         hnOjEQIE4uCTnBuhbQegqcduOIWhfx3wUH63YHbZwH6NDShGQUgjchq3wL/1xS+iT8
         EjSVbQyD8xnLO69XRhhGNpmYaqFEq2RDtSlyLn7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 545/677] ovl: show "userxattr" in the mount data
Date:   Wed, 12 May 2021 16:49:51 +0200
Message-Id: <20210512144855.476467979@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144837.204217980@linuxfoundation.org>
References: <20210512144837.204217980@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giuseppe Scrivano <gscrivan@redhat.com>

[ Upstream commit 321b46b904816241044e177c1d6282ad20f17416 ]

This was missed when adding the option.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Vivek Goyal <vgoyal@redhat.com>
Fixes: 2d2f2d7322ff ("ovl: user xattr")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 8cf343335029..787ce7c38fba 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -380,6 +380,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 			   ofs->config.metacopy ? "on" : "off");
 	if (ofs->config.ovl_volatile)
 		seq_puts(m, ",volatile");
+	if (ofs->config.userxattr)
+		seq_puts(m, ",userxattr");
 	return 0;
 }
 
-- 
2.30.2



