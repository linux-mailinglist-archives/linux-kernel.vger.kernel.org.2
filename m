Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DAE3A654E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhFNLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235540AbhFNLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 668F66147D;
        Mon, 14 Jun 2021 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623667966;
        bh=BowvD/eSCy3QX3Vc3LZAqN1yb6cnkXLJ8emSXKqQH6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CroXMXIqgkPBWYXu6JcT9OMQyKap8eCLRf5Gw7BcRZU0rMFhE1F8Tdx2N8fQIuXzk
         nqmrr4fgy3SkAnWCBuPSBts2Q4AexzoeaqeWmTDajTy63KAl8iswY+1a12Gw1Vscvf
         yoMN6eWtrtrfGblJNKb95RAAzsvevBpW47AZxoHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.12 144/173] tools/bootconfig: Fix error return code in apply_xbc()
Date:   Mon, 14 Jun 2021 12:27:56 +0200
Message-Id: <20210614102702.950550025@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614102658.137943264@linuxfoundation.org>
References: <20210614102658.137943264@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

commit e8ba0b2b64126381643bb50df3556b139a60545a upstream.

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Link: https://lkml.kernel.org/r/20210508034216.2277-1-thunder.leizhen@huawei.com

Fixes: a995e6bc0524 ("tools/bootconfig: Fix to check the write failure correctly")
Reported-by: Hulk Robot <hulkci@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/bootconfig/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -399,6 +399,7 @@ static int apply_xbc(const char *path, c
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	if (fstat(fd, &stat) < 0) {
+		ret = -errno;
 		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}


