Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1602432BFE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580387AbhCCSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236240AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7F/864rAM2LXsLn2RTumaEqPOSHAgvO7AeiYInrqMtE=;
        b=Ld1Z0gu0B6SDz3iVVJ2dQRXxL83DpFxInqwrrlOiswfq3HiaxExZkznBkRGlO8ykbsp9t9
        TaPiSBtVdWihuloYUfqQMeitVn2CLMdblQZHrh4HOzT3JL4vtU53nxUIZa1ENhjqwJzdci
        Gaqhl3FnMNuPc2EtLKdKDZswwigFveA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-noziK8-KM0mRgncgbP1AYw-1; Wed, 03 Mar 2021 12:09:54 -0500
X-MC-Unique: noziK8-KM0mRgncgbP1AYw-1
Received: by mail-wr1-f72.google.com with SMTP id y5so2562327wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7F/864rAM2LXsLn2RTumaEqPOSHAgvO7AeiYInrqMtE=;
        b=maW6MV9b4oNIFddMSa+ieKIVA4PWrrFfU9MgcIOSWM45ke24HQ3JISs7Eg7NNEFXPT
         Fi2W4OfFvf3sd1GsOPtpJ/maEoOUAp7XD2b11DQzRMi58GIZ1F40vDCQHm3XAEKqZMlb
         gKyHI/EVE9Q2gfPIEJwMwxqSPmUGS7i/h5eQijwS08U8KGHXSFhJN6+F+qSXdYgKOtXZ
         ADKBD/7OWLFnEorOkhDM40djs7I4ZnFIHGv9yfXpjG/7IOYr1Cl637bSMQ9oZhuR2Voe
         NWvDMEVk1bzUdwCMxpUsM2KnF7tPW7Qs1uMo65VmZqm2mfUHE5vpIlQtogvKRZllE9gI
         tTMg==
X-Gm-Message-State: AOAM530NGPxgWJFkivGkx2qEK3VsxJlq8/0K/diJTwnwgbpEIbffUcka
        LXyPPxFLz2V4w9iKLlIxeOhq4HGxfHIp5wJRNhTZCvryWDbaj7oHyVOK87c3yYdxf2R1CvrJixw
        rSmpM6sGrzWYuXU0H+WYpkRzr0fOvzqrJQY7Go7Wbm3iLIxriy+vqxcZrs+oUplBGx3u0i4m0Ca
        IH
X-Received: by 2002:adf:fcc9:: with SMTP id f9mr28068910wrs.420.1614791392741;
        Wed, 03 Mar 2021 09:09:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOd/3vEkTscaBvAfXOjmmu9WYlY4gMDNTrj6kewRSK1AwttyOpj1Hw0ybXbSqYLoPYkcKuzg==
X-Received: by 2002:adf:fcc9:: with SMTP id f9mr28068883wrs.420.1614791392549;
        Wed, 03 Mar 2021 09:09:52 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:52 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 10/13] objtool: arm64: Accept padding in code sections
Date:   Wed,  3 Mar 2021 18:09:29 +0100
Message-Id: <20210303170932.1838634-11-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler can introduce some '0' words in code sections to pad the
end of functions.
Similar to load literal functions, record these zero words to remove
the "struct instruction" created for them.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index b4631d79f13f..592276c199eb 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -385,8 +385,23 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	switch (aarch64_get_insn_class(insn)) {
 	case AARCH64_INSN_CLS_UNKNOWN:
-		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
-		return -1;
+	{
+		/*
+		 * There are a few reasons we might have non-valid opcodes in
+		 * code sections:
+		 * - For load literal, assembler can generate the data to be
+		 *   loaded in the code section
+		 * - Compiler/assembler can generate zeroes to pad function that
+		 *   do not end on 8-byte alignment
+		 */
+		/* Compiler might put zeroes as padding */
+		if (record_invalid_insn(sec, offset, insn == 0x0))
+			return -1;
+
+		*type = INSN_OTHER;
+
+		break;
+	}
 	case AARCH64_INSN_CLS_DP_IMM:
 		/* Mov register to and from SP are aliases of add_imm */
 		if (aarch64_insn_is_add_imm(insn) ||
-- 
2.25.4

