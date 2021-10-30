Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C921440664
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhJ3A2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhJ3A2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:28:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF1DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8XMSRaP9jOyh28BjfISCp2rZsrePTe87w8vCwBzdO4s=; b=tSJ1RARTk8j73HTAXCe2zaguRi
        SaEeGTPmONsYvRJgY5OHlFkQMe4otH1GqFbJQppO1UZTOJ6wTqfSolQWj+KFaKNA9kaaAtdTmGGcO
        6AfmpMtItWGSFbbOW0Qcy0iP3Ebv/YtEAvJemwgGB/dJ6ZCHcOAzTbRN3scDyRGBxbfobScyxYDbb
        4nfZ2KYQfsD4xLhYVMnGC1z/7dHal+I4n/+h2HEFPlCsuQaU8VAecnF3HScSbXlc7n/yaYnOiuHNI
        CT8Bl/L767IpfhwsIT01JZsBjKWxhc0UxhMQlZy0NUa9TNCipt7UdpKkMp3PtSmGH8Wern9iSe/zH
        b8ZnWPFA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgcCR-00CZbW-O1; Sat, 30 Oct 2021 00:26:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fadump: correct two typos in a comment
Date:   Fri, 29 Oct 2021 17:26:19 -0700
Message-Id: <20211030002619.2063-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos of 'remaining' and 'those'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Matthew Wilcox <willy@infradead.org> # 'remaining'
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/fadump.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211029.orig/arch/powerpc/kernel/fadump.c
+++ linux-next-20211029/arch/powerpc/kernel/fadump.c
@@ -73,8 +73,8 @@ static struct cma *fadump_cma;
  * The total size of fadump reserved memory covers for boot memory size
  * + cpu data size + hpte size and metadata.
  * Initialize only the area equivalent to boot memory size for CMA use.
- * The reamining portion of fadump reserved memory will be not given
- * to CMA and pages for thoes will stay reserved. boot memory size is
+ * The remaining portion of fadump reserved memory will be not given
+ * to CMA and pages for those will stay reserved. boot memory size is
  * aligned per CMA requirement to satisy cma_init_reserved_mem() call.
  * But for some reason even if it fails we still have the memory reservation
  * with us and we can still continue doing fadump.
