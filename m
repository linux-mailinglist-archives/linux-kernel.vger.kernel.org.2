Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3B353CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhDEI4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhDEI4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:56:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A1E761393;
        Mon,  5 Apr 2021 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617612986;
        bh=5NSqw6IImF72vYiQf0bYirPP0rCSItz7clkiJB312rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biQfoHzkBzYTTl26IlJMebEE34tNGR203X3eRPsvVt1CRd0JlE3xL3B0c26sAAzRy
         yMomg+qvjmeFNSyle+K/gK0rdXdW2AGjGrir6mr/l5D/ck9YTIzO/eyNd3K2/rzvKN
         q/73NFdsm0QYcVH340GUoV6leBtXKgER8yz9tSI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Brazdil <dbrazdil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/35] selinux: vsock: Set SID for socket returned by accept()
Date:   Mon,  5 Apr 2021 10:53:36 +0200
Message-Id: <20210405085018.919933118@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210405085018.871387942@linuxfoundation.org>
References: <20210405085018.871387942@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brazdil <dbrazdil@google.com>

[ Upstream commit 1f935e8e72ec28dddb2dc0650b3b6626a293d94b ]

For AF_VSOCK, accept() currently returns sockets that are unlabelled.
Other socket families derive the child's SID from the SID of the parent
and the SID of the incoming packet. This is typically done as the
connected socket is placed in the queue that accept() removes from.

Reuse the existing 'security_sk_clone' hook to copy the SID from the
parent (server) socket to the child. There is no packet SID in this
case.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index bd3a5ef8e59b..2fecdfe49bae 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -650,6 +650,7 @@ struct sock *__vsock_create(struct net *net,
 		vsk->trusted = psk->trusted;
 		vsk->owner = get_cred(psk->owner);
 		vsk->connect_timeout = psk->connect_timeout;
+		security_sk_clone(parent, sk);
 	} else {
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
 		vsk->owner = get_current_cred();
-- 
2.30.1



