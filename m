Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B0432686
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhJRSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhJRSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634582173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fNnXaAF3agw8VaX480AMuK94cWpmSSUZAApFuOi+wRA=;
        b=fbWWJkJp7uq4vVRoYwvukzClN3hdDil5ZjNU/6TL9n7CqnO6RRUrxNJTEq0q9HT68Hzxo6
        SAaLrdbxUFPsZ7NOTX71uuisPDG2CPFw9QyNql91FVISrISM1V97/XKDDz7rUH1FqDgTPB
        dB6XsRSjNCIxxbymeTAk5YuRHAfZFdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-b7gh9ljzOIeX8FgktKivmw-1; Mon, 18 Oct 2021 14:36:10 -0400
X-MC-Unique: b7gh9ljzOIeX8FgktKivmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B85919200C2;
        Mon, 18 Oct 2021 18:36:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1C717F72;
        Mon, 18 Oct 2021 18:36:09 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     torvic9@mailbox.org
Subject: [PATCH v2] KVM: x86: avoid warning with -Wbitwise-instead-of-logical
Date:   Mon, 18 Oct 2021 14:36:08 -0400
Message-Id: <20211018183608.589083-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new warning in clang top-of-tree (will be clang 14):

In file included from arch/x86/kvm/mmu/mmu.c:27:
arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
        return __is_bad_mt_xwr(rsvd_check, spte) |
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                 ||
arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning

The code is fine, but change it anyway to shut up this clever clogs
of a compiler.

Reported-by: torvic9@mailbox.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7c0b09461349..66782e796c0a 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -315,7 +315,7 @@ static __always_inline bool is_rsvd_spte(struct rsvd_bits_validate *rsvd_check,
 	 * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
 	 * (this is extremely unlikely to be short-circuited as true).
 	 */
-	return __is_bad_mt_xwr(rsvd_check, spte) |
+	return __is_bad_mt_xwr(rsvd_check, spte) ||
 	       __is_rsvd_bits_set(rsvd_check, spte, level);
 }
 
-- 
2.27.0

