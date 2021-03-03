Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5732C00C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580735AbhCCSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235711AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWF0orywTk6sSBoNe4C5h01Io2O6mFpLcN5QACAx9O0=;
        b=XWn+EpDM0geDnsXo9g95SGI+uqaagDiK04BpCW55XQnnlIep0YWIwiOg5CqzwPl2Ny8UHm
        HHCjND90ZgFKHnwGbmV7mDzRjZ8MZ1QWsG3ZPphaBy+d4UnwxckuqhB8sMOES1R3dEny3o
        SH9Wj23i0rHRwzynPbU05E5mVgaoan8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-LIAlUBGuOZq6lK2JyBnkwg-1; Wed, 03 Mar 2021 12:09:48 -0500
X-MC-Unique: LIAlUBGuOZq6lK2JyBnkwg-1
Received: by mail-wm1-f71.google.com with SMTP id r21so2065055wmq.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWF0orywTk6sSBoNe4C5h01Io2O6mFpLcN5QACAx9O0=;
        b=bR8kmHS7vuYfnArzyZH+/Ww+aCm7q+3EMgR39CS3tTjvXhNLy0Ab1OCXYcegl3iAxI
         UT3hshGlg6mekX4NuTWcmV0v8x3ERWcdHLS72Sg3J53JdeGaYVkxUhSNnZvZBsUzI8yG
         A4vXlkW9EkbpkAZjrV5KIlMxB272i2vSlrHlWPoAOgeHFYDqs3ICsFKZaGCfQ8J7V4fW
         N/Hp877Q9q/MhjF4KQQhqqGusqzWHb+8SCvLwNKeuqgRMrACPsfL5YdCuv7FzMYUx1uB
         MkJe40T9X2DmkEOzVsRYTBBOIZ0O9KG1piMMs4YCAM3QXogmrx4m0oNTKeEIx3cTmrrX
         Vu/A==
X-Gm-Message-State: AOAM530thBOZ1RNJKyp3GcVmzW0xeXTj23WalgH5N3OwJo5kG3rMv3xe
        ATELqe96gAyC5r1puRoPlOSVAzsF98KstmHJaFBn5kUcLU/zr/F5GSg0h2j6+t1jY/PR7XICYr0
        YZ7evzW8WJPKdILwZ3clyed2UN0t8C5yQAL5dwdPB/0wVQS7rqbMsP/FVaNYNi/3CqdB25ql+TC
        fA
X-Received: by 2002:adf:ed87:: with SMTP id c7mr13641912wro.9.1614791386821;
        Wed, 03 Mar 2021 09:09:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx05Vi/zvlG4OeONWEvWUC22x1iawnyv19GdtCJkQapzFaCPnD19uv8JIlhkCuYgvPrAdXX8A==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr13641882wro.9.1614791386562;
        Wed, 03 Mar 2021 09:09:46 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:46 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 06/13] objtool: arm64: Decode jump and call related instructions
Date:   Wed,  3 Mar 2021 18:09:25 +0100
Message-Id: <20210303170932.1838634-7-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode branch, branch and link (aarch64's call) and return instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 54eeb8704a42..983f16b8b2af 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -215,6 +215,28 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		}
 		*type = INSN_OTHER;
 		break;
+	case AARCH64_INSN_CLS_BR_SYS:
+		if (aarch64_insn_is_ret(insn) &&
+		    aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn) == AARCH64_INSN_REG_LR) {
+			*type = INSN_RETURN;
+		} else if (aarch64_insn_is_bl(insn)) {
+			*type = INSN_CALL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_blr(insn)) {
+			*type = INSN_CALL_DYNAMIC;
+		} else if (aarch64_insn_is_b(insn)) {
+			*type = INSN_JUMP_UNCONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_br(insn)) {
+			*type = INSN_JUMP_DYNAMIC;
+		} else if (aarch64_insn_is_branch_imm(insn)) {
+			/* Remaining branch opcodes are conditional */
+			*type = INSN_JUMP_CONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else {
+			*type = INSN_OTHER;
+		}
+		break;
 	default:
 		*type = INSN_OTHER;
 		break;
-- 
2.25.4

