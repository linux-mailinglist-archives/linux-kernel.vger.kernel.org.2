Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C24361D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJUMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231365AbhJUMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634819881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnZ3ounfBlwh4UazSm19Od83jKUAVNgDJA6/wGPAT4Q=;
        b=TAIIEi2Ok/HOrQYTLGcNICqWpne4kLkpX68xX/HXS63+rVbmj4svh57A2xk4mqJPeF2/Eu
        RqKt6/dUEKkxE86YP/mdGjFEM8P8zjmm0GK4yAESlOjnbUfrP/irbkQixuG8g3DCQovdfI
        nRbR11qfgjhs4edbVksNfkTdWWtuTp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-RbnOS3NeMDKbEpNp1kKAFA-1; Thu, 21 Oct 2021 08:37:58 -0400
X-MC-Unique: RbnOS3NeMDKbEpNp1kKAFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58FAD8066FD;
        Thu, 21 Oct 2021 12:37:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A76685D740;
        Thu, 21 Oct 2021 12:37:49 +0000 (UTC)
From:   =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sgarzare@redhat.com,
        davem@davemloft.net, kuba@kernel.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 06/10] vsock: set socket peercred
Date:   Thu, 21 Oct 2021 16:37:10 +0400
Message-Id: <20211021123714.1125384-7-marcandre.lureau@redhat.com>
In-Reply-To: <20211021123714.1125384-1-marcandre.lureau@redhat.com>
References: <20211021123714.1125384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AF_VSOCK socket is created, the peercreds are set to the current
process values.

This is how AF_UNIX listen work too, but unconnected AF_UNIX sockets
return pid:0 & uid/gid:-1.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1925682a942a..9b211ff49b08 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -760,6 +760,7 @@ static struct sock *__vsock_create(struct net *net,
 
 	psk = parent ? vsock_sk(parent) : NULL;
 	if (parent) {
+		sock_copy_peercred(sk, parent);
 		vsk->trusted = psk->trusted;
 #if IS_ENABLED(CONFIG_VMWARE_VMCI_VSOCKETS)
 		vsk->owner = get_cred(psk->owner);
@@ -770,6 +771,7 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_max_size = psk->buffer_max_size;
 		security_sk_clone(parent, sk);
 	} else {
+		sock_init_peercred(sk);
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
 #if IS_ENABLED(CONFIG_VMWARE_VMCI_VSOCKETS)
 		vsk->owner = get_current_cred();
-- 
2.33.0.721.g106298f7f9

