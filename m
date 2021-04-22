Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547E1367927
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhDVFSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDVFR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:17:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD3C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nXccVF0VLMZZqdk7lBuIpC5btmCdWymL750DLlWAg2U=; b=v+a4qYbJcGUkAzXdGc2gUyofE8
        2nPvYlXPhSOLZ9RTyLrSUgCS5S1V77rxhQU5vwocNJRytdpuRsRA/DYP2nFA8Vu8+2SSRvy5YW/+n
        sCNcWpYXsbVJLutejf2O/VtM5EuQxra9W3WUK+UcVDc64oPy9ncE4CA5/pvoPtDth4oluTsN5a17I
        UhWs5ZZLsjsEtiVQc5O3IINv5tHGoeFBU+ybFMQiNBQYElJbQrW8mL8rZ7cdVQYGXHjZp2hglO3Qe
        2QZuxdmDw834j48rVSrwawFxfpvwOVzjvk9mETisPd0P+m6BXmgL0LMekv3BrWYZd/27v+YmLc3oA
        WE3fEhJg==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZRhw-00HSwO-KM; Thu, 22 Apr 2021 05:17:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] ARC: kgdb: add 'fallthrough' to prevent a warning
Date:   Wed, 21 Apr 2021 22:16:53 -0700
Message-Id: <20210422051653.23078-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'fallthrough' macro to document that this switch case
does indeed fall through to the next case.

../arch/arc/kernel/kgdb.c: In function 'kgdb_arch_handle_exception':
../arch/arc/kernel/kgdb.c:141:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  141 |   if (kgdb_hex2long(&ptr, &addr))
      |      ^
../arch/arc/kernel/kgdb.c:144:2: note: here
  144 |  case 'D':
      |  ^~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/kernel/kgdb.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210420.orig/arch/arc/kernel/kgdb.c
+++ linux-next-20210420/arch/arc/kernel/kgdb.c
@@ -140,6 +140,7 @@ int kgdb_arch_handle_exception(int e_vec
 		ptr = &remcomInBuffer[1];
 		if (kgdb_hex2long(&ptr, &addr))
 			regs->ret = addr;
+		fallthrough;
 
 	case 'D':
 	case 'k':
