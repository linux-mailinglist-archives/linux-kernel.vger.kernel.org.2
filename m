Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6141F3A9FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhFPPlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235110AbhFPPin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 441E5613DA;
        Wed, 16 Jun 2021 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623857778;
        bh=tZaP+6/s9yOkjDybCztanFkilmzGz5z8nX72fuboOgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVioMnFuLxsCq7F5kVij/9iR6kUPND7HwcbJk4+PZAj/yyiMtr600FOSxY4UJa9Yt
         FItMDyWiJHfNuTsbQW87D41Fg1xQN3xNcNB5TErWz2iVwj3rgWTYWnmNTUKP86rBrG
         7SqiBr58aydTAJ6g20HLjwSX03Jv8/HHu1/i3R5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zheng Yongjun <zhengyongjun3@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 37/38] net: Return the correct errno code
Date:   Wed, 16 Jun 2021 17:33:46 +0200
Message-Id: <20210616152836.567175469@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210616152835.407925718@linuxfoundation.org>
References: <20210616152835.407925718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yongjun <zhengyongjun3@huawei.com>

[ Upstream commit 49251cd00228a3c983651f6bb2f33f6a0b8f152e ]

When kalloc or kmemdup failed, should return ENOMEM rather than ENOBUF.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/compat.c b/net/compat.c
index ddd15af3a283..210fc3b4d0d8 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -177,7 +177,7 @@ int cmsghdr_from_user_compat_to_kern(struct msghdr *kmsg, struct sock *sk,
 	if (kcmlen > stackbuf_size)
 		kcmsg_base = kcmsg = sock_kmalloc(sk, kcmlen, GFP_KERNEL);
 	if (kcmsg == NULL)
-		return -ENOBUFS;
+		return -ENOMEM;
 
 	/* Now copy them over neatly. */
 	memset(kcmsg, 0, kcmlen);
-- 
2.30.2



