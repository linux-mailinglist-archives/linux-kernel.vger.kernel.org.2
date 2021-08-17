Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83FD3EE3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhHQBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233287AbhHQBuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629165007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b/su3/QUjtOxmYxyvN2ej/0WMmIFGJxs8rzZ8U3qzXM=;
        b=AfUR1zcAPGYyshyeoCJFIf5+R2azhG+wrewjFr4vwKiVrCqeu/FiRzmehdeJskM21zacPq
        Giu2T4w9+EYwGZrGGjXZqOfZXLTpldcjQXUw7QIvfT5kcmFAtkj2uDunkTpJ8N0tutze6Z
        0wn3Wakj2tU925C4XjApJD5edAzwMR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-3Ket6qujMbeWavaMqydhMg-1; Mon, 16 Aug 2021 21:50:06 -0400
X-MC-Unique: 3Ket6qujMbeWavaMqydhMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F331107ACF5;
        Tue, 17 Aug 2021 01:50:05 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.16.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 644B719C87;
        Tue, 17 Aug 2021 01:50:00 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] objtool: x86: .altinstructions doesn't need section entry size
Date:   Mon, 16 Aug 2021 21:49:58 -0400
Message-Id: <20210817014958.1108400-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e31694e0a7a7 ("objtool: Don't make .altinstructions writable")
aligned objtool-created and kernel-created .altinstructions section
flags, but there remains a minor discrepency in their use of a section
entry size: objtool sets one while the kernel build does not.

While sh_entsize of sizeof(struct alt_instr) seems intuitive, this small
deviation can cause failures with external tooling like kpatch-build.

Fix this by creating new .altinstructions sections with sh_entsize of 0
and then later updating sec->len as alternatives are added to the
section.  An added benefit is avoiding the data descriptor and buffer
created by elf_create_section(), but previously unused by
elf_add_alternative().

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---

Hi Josh, this is a follow up for
https://github.com/dynup/kpatch/issues/1194 where I'll add some more
comments on the kpatch-side of this.  We could probably work around it
over there, but this objtool tweak looks small enough to maintain closer
kernel-built .altinstructions section properties.

 tools/objtool/arch/x86/decode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index bc821056aba9..e7087aa473f8 100644
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
@@ -692,6 +692,8 @@ static int elf_add_alternative(struct elf *elf,
 		}
 	}
 
+	sec->len += size;
+
 	s = elf_getscn(elf->elf, sec->idx);
 	if (!s) {
 		WARN_ELF("elf_getscn");
-- 
2.26.3

