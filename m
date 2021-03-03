Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401E032BFCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580211AbhCCSdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376318AbhCCRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64/r5WkavI4S3gZoMp8frzL6ATRD8fIGn6DON6cVWDE=;
        b=P51uOVD/IuXMJLMeTO5A3CSEBh9I6d1Qy9CPku97UmMb1ZMQ9fTmkMoP8xR3KvzgrLu8ip
        lkiRb0Q8PpI0xyblxr6pN0pVlsa0RdNYilwUhcN58num28HHcF5w/h5MKVSOA1C/4jOUIH
        n1GG+2OUMrxyfLjLfZVjIlgCTYFoCaM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-1iDM4uYXM-erV9uXQwV5lA-1; Wed, 03 Mar 2021 12:06:09 -0500
X-MC-Unique: 1iDM4uYXM-erV9uXQwV5lA-1
Received: by mail-wm1-f70.google.com with SMTP id a3so2073469wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64/r5WkavI4S3gZoMp8frzL6ATRD8fIGn6DON6cVWDE=;
        b=qOV8ug7rrvMrd3n00QzJX+ZuqZTONCnh6XZwj5LsX7TbuUXpKs7KMmlp1fkTovG0J0
         Albd6wkFOiy+DiUMeV9O0xaTnhM7UO6nW9MLEjHFC03E/U2CwAd507TMh4/NeM8wkehr
         mbwyX9GJTC94GjnT+tD/Wn7sfQHR9sY8L5hzLFSw2j/Numg35NomTADW19sBJ0zjdFIM
         iqCEgXYSXKDD8gNx21IM3WeAc8hLUebeWbo1/8QqByjWyq1eMZKYZ8MFknsY3thtWhtD
         f+tVxgVydGzqbjIa145VoPXU7TQCBrxqmkn8ruCvFlF5k1hTBZCKU15gPvRFG0FucjOR
         MoUg==
X-Gm-Message-State: AOAM531mbRj/AMhp2gdiDxnLx34HNyX20WHzsb1XoKGmjPELNTDNXGk7
        +PAHC/oOQfxv1IhoqDnueVU25tKxYWbBHbNj/+9ru+zsKsWISCbruROg1okfoJDz0OfJ+5qr1Zx
        /iqv2stFEUd4GGxc93YeAhJ+pK4rWuuQFhUWm6bswaPvOEJperOX4pfC5tJwAxYHGXSxTeoUVVo
        Qn
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr27514927wrw.422.1614791167670;
        Wed, 03 Mar 2021 09:06:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXgg4LC86syFIZcm3E1I9s1XBSGKdgt+1bHuhqJPSgqyu1UN0Tf170oV70c/ULAuYT4m1/Rw==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr27514907wrw.422.1614791167413;
        Wed, 03 Mar 2021 09:06:07 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:06:07 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 7/8] arm64: insn: Add some opcodes to instruction decoder
Date:   Wed,  3 Mar 2021 18:05:35 +0100
Message-Id: <20210303170536.1838032-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170536.1838032-1-jthierry@redhat.com>
References: <20210303170536.1838032-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add decoding capability for some instructions that objtool will need
to decode.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/include/asm/insn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 185f52ef0228..388aa22eacb1 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -296,6 +296,12 @@ __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
 __AARCH64_INSN_FUNCS(prfm,	0x3FC00000, 0x39800000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
+__AARCH64_INSN_FUNCS(store_imm,	0x3FC00000, 0x39000000)
+__AARCH64_INSN_FUNCS(load_imm,	0x3FC00000, 0x39400000)
+__AARCH64_INSN_FUNCS(store_pre,	0x3FE00C00, 0x38000C00)
+__AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
+__AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
+__AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
@@ -304,6 +310,8 @@ __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
 __AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
 __AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
+__AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
 __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
 __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
 __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
@@ -336,6 +344,7 @@ __AARCH64_INSN_FUNCS(rev64,	0x7FFFFC00, 0x5AC00C00)
 __AARCH64_INSN_FUNCS(and,	0x7F200000, 0x0A000000)
 __AARCH64_INSN_FUNCS(bic,	0x7F200000, 0x0A200000)
 __AARCH64_INSN_FUNCS(orr,	0x7F200000, 0x2A000000)
+__AARCH64_INSN_FUNCS(mov_reg,	0x7FE0FFE0, 0x2A0003E0)
 __AARCH64_INSN_FUNCS(orn,	0x7F200000, 0x2A200000)
 __AARCH64_INSN_FUNCS(eor,	0x7F200000, 0x4A000000)
 __AARCH64_INSN_FUNCS(eon,	0x7F200000, 0x4A200000)
-- 
2.25.4

