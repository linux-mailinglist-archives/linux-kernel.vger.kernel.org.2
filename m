Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6035BD16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhDLIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237814AbhDLIpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63DA361249;
        Mon, 12 Apr 2021 08:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618217131;
        bh=9/rmLVtQR0rxgAhWp88SVpj53/FzBRpIMWunlLy8qM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tk0H/8UqFkuePQGGzDmN+KFVSz3suZlnYnnq2rqy9eN4Ooj7713g1PTuf4vMs8Tcj
         puDDvziZQoYfXkZi9UDVGrX11jiMnKHk9K4Bv/zjHNFqPh7c+RwIvnpoeHpCz6JceN
         B1yltkVT4HcphYF0A+TsasQwkqAzkbOzWUH5nz1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, =?UTF-8?q?kiyin ?= <kiyin@tencent.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 006/111] nfc: fix refcount leak in llcp_sock_connect()
Date:   Mon, 12 Apr 2021 10:39:44 +0200
Message-Id: <20210412084004.419261204@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412084004.200986670@linuxfoundation.org>
References: <20210412084004.200986670@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

commit 8a4cd82d62b5ec7e5482333a72b58a4eea4979f0 upstream.

nfc_llcp_local_get() is invoked in llcp_sock_connect(),
but nfc_llcp_local_put() is not invoked in subsequent failure branches.
As a result, refcount leakage occurs.
To fix it, add calling nfc_llcp_local_put().

fix CVE-2020-25671
Fixes: c7aa12252f51 ("NFC: Take a reference on the LLCP local pointer when creating a socket")
Reported-by: "kiyin(尹亮)" <kiyin@tencent.com>
Link: https://www.openwall.com/lists/oss-security/2020/11/01/1
Cc: <stable@vger.kernel.org> #v3.6
Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/llcp_sock.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -704,6 +704,7 @@ static int llcp_sock_connect(struct sock
 	llcp_sock->local = nfc_llcp_local_get(local);
 	llcp_sock->ssap = nfc_llcp_get_local_ssap(local);
 	if (llcp_sock->ssap == LLCP_SAP_MAX) {
+		nfc_llcp_local_put(llcp_sock->local);
 		ret = -ENOMEM;
 		goto put_dev;
 	}
@@ -748,6 +749,7 @@ sock_unlink:
 
 sock_llcp_release:
 	nfc_llcp_put_ssap(local, llcp_sock->ssap);
+	nfc_llcp_local_put(llcp_sock->local);
 
 put_dev:
 	nfc_put_device(dev);


