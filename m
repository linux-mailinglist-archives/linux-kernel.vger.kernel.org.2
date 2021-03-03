Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13232BFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580298AbhCCSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236269AbhCCRLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mYRxjaYFimzJkE35k0hSqse9qtwA1S+xm+5PuBe57Q=;
        b=F0vX3h+V6dwrQiQhV5ncOVcDy9wsgLwZ1KXU+QPplG4VhiVGrNJFMIuE7S+bz5T4hxqCEj
        r3k0ZCPKE1ugi92PXjEvtjBMMDzkRG9IdADgV+K1tnx6Y7rxlUipKB4jFFXyPBuXrE2l4m
        SQHW3BEoJemN7qxTDBcmyrnxirh0ZFk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-ok1-c--hPKyq9Pue_3FKAA-1; Wed, 03 Mar 2021 12:09:55 -0500
X-MC-Unique: ok1-c--hPKyq9Pue_3FKAA-1
Received: by mail-wr1-f71.google.com with SMTP id v1so2494336wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mYRxjaYFimzJkE35k0hSqse9qtwA1S+xm+5PuBe57Q=;
        b=hiPEm2RF5clunDnbMWrifFj3FDava/AUNQTwLcL1DNxS6Ij1wpz7ZQU5t4ryeiKFBv
         iFuwntlid5B9dKkIGELtZHYhpnod8dSIYlMAJlpV4q3akJrCiZpUmE+97Wvm81eXl6Hn
         7CnnxPnrfyFBqcGhXPL5j4PvFb9VGha8KSE0ByJdHAyt/NuMAnrPj23BoCHxtXmftv7u
         otToLPBvolzFgMMx5tnKKAnIs3tPL+bn2IiblymywqGIbxkRmTmR266pKbsGMxYEeaLh
         qxUcceiGYYn0J5CucqCw0B8u2MNHf3zxVsPkrioBD4cSW+VxUcajlM3uNzuQ8h6qe5a2
         k69w==
X-Gm-Message-State: AOAM532OGyuZ6cbJ/gqAnaeultaCtyQ+SignGedOFMMqrCpmKIPdkc/+
        VA7zmZ4coknW5OVux6AGQZm7Fco8YlO0uGmeqr+pAhzzsUL/KtmT5h+zz+P8XZElX+v12H6Q3GN
        A67M9Kj2l0Ua//WNesn3lnDR367BZlJl9E0zE7rnZYA6hmWeDyRbUbLqo03njK58g3Fk/loSq1p
        ew
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr28586351wrp.112.1614791394001;
        Wed, 03 Mar 2021 09:09:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8q1b30kNoZXF00T55vpdszusbndOu0xEWjI6Fi3a15DamHiY3RwZ/krp7t8t0SFSDVYujEA==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr28586331wrp.112.1614791393855;
        Wed, 03 Mar 2021 09:09:53 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:53 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 11/13] objtool: arm64: Handle supported relocations in alternatives
Date:   Wed,  3 Mar 2021 18:09:30 +0100
Message-Id: <20210303170932.1838634-12-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on get_alt_insn() in arch/arm64/kernel/alternative.c, arm64
alternative code adapts offsets for static branches and adrp
instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 45f283283091..a70b91e8bd7d 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -10,7 +10,11 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc)
 {
-	return false;
+	u32 opcode = *(u32 *)(insn->sec->data->d_buf + insn->offset);
+
+	return aarch64_insn_is_branch_imm(opcode) ||
+	       aarch64_insn_is_adrp(opcode) ||
+	       !aarch64_insn_uses_literal(opcode);
 }
 
 
-- 
2.25.4

