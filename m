Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14B3F34BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhHTTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhHTTpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629488705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duj3eJCfkQ3SsfuEPSBfbAS1EI7agW472Nt8jTDSwdk=;
        b=ejCRWVPexpwEnBTzJwiEfTJ57a6QNsaaCZ1aU1YLrwBTeiB8oHfhDZ3s+Fx9YH1vLJAC3r
        mH+mnolV/DW+VhW2LbGKSJUChzxvwSCnnsbwKPr4ujM3ro0VBOQzBPm7txdPiB4nZx+pZz
        lucetDqylBvzgyRmLcS6AYnnSWLxLsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-cXTw8EgpOReNC6j5cGmuLw-1; Fri, 20 Aug 2021 15:45:01 -0400
X-MC-Unique: cXTw8EgpOReNC6j5cGmuLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD95F107ACF5;
        Fri, 20 Aug 2021 19:45:00 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C06E18436;
        Fri, 20 Aug 2021 19:44:59 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 1/2] objtool: make .altinstructions section entry size consistent
Date:   Fri, 20 Aug 2021 15:44:52 -0400
Message-Id: <20210820194453.395548-2-joe.lawrence@redhat.com>
In-Reply-To: <20210820194453.395548-1-joe.lawrence@redhat.com>
References: <20210820194453.395548-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e31694e0a7a7 ("objtool: Don't make .altinstructions writable")
aligned objtool-created and kernel-created .altinstructions section
flags, but there remains a minor discrepency in their use of a section
entry size: objtool sets one while the kernel build does not.

While sh_entsize of sizeof(struct alt_instr) seems intuitive, this small
deviation can cause failures with external tooling (kpatch-build).

Fix this by creating new .altinstructions sections with sh_entsize of 0
and then later updating sec->sh_size as alternatives are added to the
section.  An added benefit is avoiding the data descriptor and buffer
created by elf_create_section(), but previously unused by
elf_add_alternative().

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/objtool/arch/x86/decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index bc821056aba9..0893436cc09f 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -684,7 +684,7 @@ static int elf_add_alternative(struct elf *elf,
 	sec = find_section_by_name(elf, ".altinstructions");
 	if (!sec) {
 		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_ALLOC, size, 0);
+					 SHF_ALLOC, 0, 0);
 
 		if (!sec) {
 			WARN_ELF("elf_create_section");
-- 
2.26.3

