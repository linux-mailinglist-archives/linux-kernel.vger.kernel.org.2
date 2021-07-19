Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB133CEC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378604AbhGSRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350526AbhGSPvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475E66135F;
        Mon, 19 Jul 2021 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626712197;
        bh=7odciAydSk5Q3z51rIbPwPstVSNzJouMg7/OKx7znec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZVhuJoj53Ih7YUefIqIeDFjtpgXORCZRMEOjYieDUMModtbRLkg6uijLCxNkRmzH
         Zt/uVd5NRYGJDNsN2HEbGbZuZao20jGorVb00k9z5tiMwKtD9EZBFUZf3sQobO5Cbz
         6i+KKfofcPTwg5lVLWEn3F/MGZAXWHbzjZ6SwAJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 287/292] s390/irq: remove HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Mon, 19 Jul 2021 16:55:49 +0200
Message-Id: <20210719144952.355189462@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719144942.514164272@linuxfoundation.org>
References: <20210719144942.514164272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 0aa4ff7688632a86bdb133fa106f2ccd514b91a7 ]

This is no longer true since we switched to generic entry. The code
switches to the IRQ stack before calling do_IRQ, but switches back
to the kernel stack before calling irq_exit().

Fixes: 56e62a737028 ("s390: convert to generic entry")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4fcd460f496e..0cf31cb872e5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -161,7 +161,6 @@ config S390
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO
 	select HAVE_IOREMAP_PROT if PCI
-	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
-- 
2.30.2



