Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076153E193E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhHEQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhHEQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628179916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZakMte/0L7s7IgwKc/bUKkusvi9eLHIsRG5ah5ccXOU=;
        b=aoxjr3DWnQwjGKBxUiDebdD5N7iqM/9lRKu9a2tK0BeQP9o5KCnCNua0ZwbT6KwjRxfcqp
        8ekxb2LmZRgrwfN34+99z3vvAGrf6v9bzn8ETITcPNjcBN1rAlGdTG0grcnzGnlr3G4RWR
        HOgrE2bpqmsX11Kuh+tYEBeceuz21IQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-s_ksa3ISMxm8HfUOUQfhzQ-1; Thu, 05 Aug 2021 12:11:53 -0400
X-MC-Unique: s_ksa3ISMxm8HfUOUQfhzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A27C1006C80;
        Thu,  5 Aug 2021 16:11:52 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.193.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 835BF5C1D0;
        Thu,  5 Aug 2021 16:11:51 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     konrad@kernel.org
Cc:     rppt@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] iscsi_ibft: fix warning in reserve_ibft_region()
Date:   Thu,  5 Aug 2021 18:11:50 +0200
Message-Id: <20210805161150.115363-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %pa to print a physical address.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/firmware/iscsi_ibft_find.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
index a0594590847d..94b49ccd23ac 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -83,7 +83,7 @@ void __init reserve_ibft_region(void)
 				if (pos + len <= (IBFT_END-1)) {
 					ibft_phys_addr = pos;
 					memblock_reserve(ibft_phys_addr, PAGE_ALIGN(len));
-					pr_info("iBFT found at 0x%lx.\n", ibft_phys_addr);
+					pr_info("iBFT found at %pa.\n", &ibft_phys_addr);
 					return;
 				}
 			}
-- 
2.27.0

