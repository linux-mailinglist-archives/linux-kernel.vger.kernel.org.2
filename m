Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193D33A6001
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhFNK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232764AbhFNK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623666368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9XM61IljzLkk0ttuVusWr1Qy/8a5hNQuFNXR1LkOZec=;
        b=jRR/I5W7KMMSwhvDZSDRp4p78MhpGuBW5OEFosMrS32gZbilHay6BV2QmYe5NHAam104/9
        LdMacINyBgKbivMx8VecA63G3/iKUZtq4uWaUs1GOeDqqF0tFAbGLHcwHHWfuEDFXZ5WZC
        yTQC4q5xh3DYN9p8gd3ZJDgBplduUHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-NJ2QFjspOZWS_7Sya1dFiw-1; Mon, 14 Jun 2021 06:26:05 -0400
X-MC-Unique: NJ2QFjspOZWS_7Sya1dFiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A38DB1842A99;
        Mon, 14 Jun 2021 10:26:03 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-47.bne.redhat.com [10.64.54.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 012D95C233;
        Mon, 14 Jun 2021 10:26:00 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64: mm: Pass origial fault address to handle_mm_fault()
Date:   Mon, 14 Jun 2021 20:27:01 +0800
Message-Id: <20210614122701.100515-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the lower bits of fault address is cleared before it's
passed to handle_mm_fault(). It's unnecessary since generic code
does same thing since the commit 1a29d85eb0f19 ("mm: use vmf->address
instead of of vmf->virtual_address").

This passes the original fault address to handle_mm_fault() in case
the generic code needs to know the exact fault address.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 871c82ab0a30..e2883237216d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -504,7 +504,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (!(vma->vm_flags & vm_flags))
 		return VM_FAULT_BADACCESS;
-	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
+	return handle_mm_fault(vma, addr, mm_flags, regs);
 }
 
 static bool is_el0_instruction_abort(unsigned int esr)
-- 
2.23.0

