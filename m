Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA49832C010
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580775AbhCCSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235811AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fou4hHS6Kj7Ef4XTjOdeYsbso55Xp/P4KKYS6738hXk=;
        b=I92sQ01DvtaSPxuCsgst1mSpXyevjmJUTgixs/9YsdonjOMTv5ehHMxo+Lw9OAJbTmszij
        +dvB+CS68SJ4xHQuhvCmsyiR4EUFpAiF/A7gETkPauVbcF1tvYO3rxv9BFa+VFbc+Uqeu/
        ZHgIHTrd0ALMei7oGPbmSYAm7vfpR7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-pv9RVvP1P-mHslHbSH_dcw-1; Wed, 03 Mar 2021 12:09:49 -0500
X-MC-Unique: pv9RVvP1P-mHslHbSH_dcw-1
Received: by mail-wm1-f70.google.com with SMTP id u15so3280374wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fou4hHS6Kj7Ef4XTjOdeYsbso55Xp/P4KKYS6738hXk=;
        b=qebWO7p9OnwwKySdZLoZ1VMQ/yfMkKj5TwcdrhiZhJXRIvLGWAaosAWUn9drzQsJET
         SAQuqWqiVK6TF9820pOrnmeX6hneb7Dd6fjQ55R0HFBHc7IQWkYiolpizNbtjQS797xF
         ZSnzHWCf+KYuJ2mwVa+rSwqOftxv9Wm4GSl80+W1odhgbYbh6qF/x/ciFvRXTZat22lL
         /g+hTIMqlVlaWmljUfZ7awXvVxnSjrZ4erHmc1hUMWc8Bcc59wVyaGSmm7+A5aqqqqkW
         V6dJXkwfb2VCGOAdNWlRLqWuRSLfPtoTyhx06TIT7PEs3aNtvkyJF3pf/RIFG5T8fyT5
         +nhw==
X-Gm-Message-State: AOAM5332s793EZxyFn3UIBLD8S0SkXErPdYDWkPvYeGW7brWKjeptCwl
        p8qw8nriUFyIiAruKuJ766px94TgH26mbRIv9KnBeO9GGaaRaY3yPogFun5DuX6YfFQplb9LmpZ
        RFIcn0S6zazQjtzdidQQu+CGAOFOCoEBQ39YlcGXb9ARsPcDQnsXdRSld9bWNOs70NyZmdTURba
        as
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr28585976wrp.112.1614791388291;
        Wed, 03 Mar 2021 09:09:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymKaluuUCFes6NHXOE2N47/QKR9U3zwNzo7E6dxQ5WJmOp4zuKApsjHT396I53VvTpkEr8TQ==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr28585953wrp.112.1614791388102;
        Wed, 03 Mar 2021 09:09:48 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:47 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 07/13] objtool: arm64: Decode other system instructions
Date:   Wed,  3 Mar 2021 18:09:26 +0100
Message-Id: <20210303170932.1838634-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode ERET, BRK and NOPs

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 983f16b8b2af..3008dcbb5e64 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -233,6 +233,13 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			/* Remaining branch opcodes are conditional */
 			*type = INSN_JUMP_CONDITIONAL;
 			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_eret(insn)) {
+			*type = INSN_CONTEXT_SWITCH;
+		} else if (aarch64_insn_is_steppable_hint(insn)) {
+			*type = INSN_NOP;
+		} else if (aarch64_insn_is_brk(insn)) {
+			*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn);
+			*type = INSN_BUG;
 		} else {
 			*type = INSN_OTHER;
 		}
-- 
2.25.4

