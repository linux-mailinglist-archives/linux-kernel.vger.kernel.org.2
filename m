Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CC45E53D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357939AbhKZCky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:40:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:31570 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241209AbhKZCiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:38:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="233088571"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="233088571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 18:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="650866519"
Received: from devel-wwang.sh.intel.com ([10.239.48.106])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2021 18:32:21 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     mst@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2] virtio/vsock: fix the transport to work with VMADDR_CID_ANY
Date:   Thu, 25 Nov 2021 20:18:23 -0500
Message-Id: <20211126011823.1760-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VMADDR_CID_ANY flag used by a socket means that the socket isn't bound
to any specific CID. For example, a host vsock server may want to be bound
with VMADDR_CID_ANY, so that a guest vsock client can connect to the host
server with CID=VMADDR_CID_HOST (i.e. 2), and meanwhile, a host vsock
client can connect to the same local server with CID=VMADDR_CID_LOCAL
(i.e. 1).

The current implementation sets the destination socket's svm_cid to a
fixed CID value after the first client's connection, which isn't an
expected operation. For example, if the guest client first connects to the
host server, the server's svm_cid gets set to VMADDR_CID_HOST, then other
host clients won't be able to connect to the server anymore.

Reproduce steps:
1. Run the host server:
   socat VSOCK-LISTEN:1234,fork -
2. Run a guest client to connect to the host server:
   socat - VSOCK-CONNECT:2:1234
3. Run a host client to connect to the host server:
   socat - VSOCK-CONNECT:1:1234

Without this patch, step 3. above fails to connect, and socat complains
"socat[1720] E connect(5, AF=40 cid:1 port:1234, 16): Connection
reset by peer".
With this patch, the above works well.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 59ee1be5a6dd..ec2c2afbf0d0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1299,7 +1299,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	space_available = virtio_transport_space_update(sk, pkt);
 
 	/* Update CID in case it has changed after a transport reset event */
-	vsk->local_addr.svm_cid = dst.svm_cid;
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		vsk->local_addr.svm_cid = dst.svm_cid;
 
 	if (space_available)
 		sk->sk_write_space(sk);

base-commit: 5f53fa508db098c9d372423a6dac31c8a5679cdf
-- 
2.25.1

