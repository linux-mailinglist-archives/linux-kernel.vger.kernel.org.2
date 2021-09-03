Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAFB3FFFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348576AbhICMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:19:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58522 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhICMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:19:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88E6F203B7;
        Fri,  3 Sep 2021 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630671479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/XvyiQWkqGmCCmHBNihZZxMuMR1mKh/8eRaYXMw6HHg=;
        b=1hll4FFBlSWbgMAcIA1+QOVtnIhERwPUObk4cNNsjV6V3jW3abm7yKfzIRylr0iDStAcrX
        aRdyoGEgvll/J2/fQxN7vG4upM0ENINXZgGg5jU6BqP5IZ4bL7j6H+0X6Pbq8cpM38Ridk
        a2EsiNEH3VYZajeWi6YXN8y4SF9Nq8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630671479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/XvyiQWkqGmCCmHBNihZZxMuMR1mKh/8eRaYXMw6HHg=;
        b=Qxr6DfJnRJBPvmYpR3oLROZ/vmaFbfn6R/I6xHJlA2/Yx6hZf5yvuq++BQu9d2OcuQ9YOo
        7mergQcDzMLu4PBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 83567A3B97;
        Fri,  3 Sep 2021 12:17:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 79124518DFA9; Fri,  3 Sep 2021 14:17:59 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1] nvme-tcp: enable linger socket option on shutdown
Date:   Fri,  3 Sep 2021 14:17:57 +0200
Message-Id: <20210903121757.140357-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the no linger is set, the networking stack sends FIN followed by
RST immediately when shutting down the socket. By enabling linger when
shutting down we have a proper shutdown sequence on the wire.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
The current shutdown sequence on the wire is a bit harsh and
doesn't let the remote host to react. I suppose we should
introduce a short (how long?) linger pause when shutting down
the connection. Thoughs?

 drivers/nvme/host/tcp.c | 1 +
 include/net/sock.h      | 1 +
 net/core/sock.c         | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e2ab12f3f51c..6c6dc465147a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1558,6 +1558,7 @@ static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
 
 static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 {
+	sock_reset_linger(queue->sock->sk);
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_calls(queue);
 	cancel_work_sync(&queue->io_work);
diff --git a/include/net/sock.h b/include/net/sock.h
index 66a9a90f9558..313a6c8ba51c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2777,6 +2777,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
+void sock_reset_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
 void sock_set_rcvbuf(struct sock *sk, int val);
diff --git a/net/core/sock.c b/net/core/sock.c
index 62627e868e03..23090a01e412 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -755,6 +755,14 @@ void sock_no_linger(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_no_linger);
 
+void sock_reset_linger(struct sock *sk)
+{
+	lock_sock(sk);
+	sock_reset_flag(sk, SOCK_LINGER);
+	release_sock(sk);
+}
+EXPORT_SYMBOL_GPL(sock_reset_linger);
+
 void sock_set_priority(struct sock *sk, u32 priority)
 {
 	lock_sock(sk);
-- 
2.29.2

