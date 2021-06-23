Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77103B1DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFWPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624462960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FywmPLYhhFRN4WW/md3yWe6mYjbslEQ7H0Xa8zhu5pQ=;
        b=KhC8FLy52bCNUi1mK8D3ocPHUllV+RAiZrNPlfuwIaZALADCSUE1Ts/yT9u+FiAzGKgjhN
        zaheIKo6mQa/UgX+lagNHSYkiottUpWeAQUZb12iaJ5VSTHe4/WdMwKS3+faFpQ8PlYkHM
        I5y3vqwj+vDIoBb2ZR+hT7Lc+JqFZTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-y-UNkku0MO2cXrYdTMRMSQ-1; Wed, 23 Jun 2021 11:42:39 -0400
X-MC-Unique: y-UNkku0MO2cXrYdTMRMSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F140A100B3B2;
        Wed, 23 Jun 2021 15:42:37 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-189.rdu2.redhat.com [10.10.118.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDA181007623;
        Wed, 23 Jun 2021 15:42:32 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH] objtool: Don't make .altinstructions writable
Date:   Wed, 23 Jun 2021 10:42:28 -0500
Message-Id: <6c284ae89717889ea136f9f0064d914cd8329d31.1624462939.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When objtool creates the .altinstructions section, it sets the SHF_WRITE
flag to make the section writable -- unless the section had already been
previously created by the kernel.  The mismatch between kernel-created
and objtool-created section flags can cause failures with external
tooling (kpatch-build).  And the section doesn't need to be writable
anyway.

Make the section flags consistent with the kernel's.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cedf3ede7545..32b2739f6115 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -683,7 +683,7 @@ static int elf_add_alternative(struct elf *elf,
 	sec = find_section_by_name(elf, ".altinstructions");
 	if (!sec) {
 		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_WRITE, size, 0);
+					 SHF_ALLOC, size, 0);
 
 		if (!sec) {
 			WARN_ELF("elf_create_section");
-- 
2.31.1

