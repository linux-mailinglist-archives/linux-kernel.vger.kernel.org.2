Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54793377F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhEJJLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:11:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36101 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhEJJLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:11:17 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14A99o002376794
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 02:09:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14A99o002376794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620637798;
        bh=w2jntxfKiouTwpo/m7Jdyzh1asTSq/fhACeNrjlJ4Mc=;
        h=From:To:Cc:Subject:Date:From;
        b=aHwYeZKmpcMdqNoSIbwexvDwXEA2E61+DzOvJ9CgMKxthOWjWMbkm/Qe+muLWzTfR
         THlHf6cEp53QVLNUjvYZ56gCw8VSvqQYY/ioWHS5DIIUHG9nJWPVd0oBE8g/UoBXjU
         v8j1Tr94+vDhQ4AqmevXB4xSjQmX7mFbjwqMhdf2gbnkEARtGObKS2if3XUByoxa6X
         m9BrLgWuKmcl05I8PGnS7e1PqA5yEDXRrTk+3fefiNity0BirqBWrr4GhCbTpLhUCx
         CdcJAykn2eYbquQ95EljM4AygNqlk5m0s7wLcU9dtnRaRa8yy14IZtbuTSxhNnAWtO
         F7+bm7j7LhEFQ==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/3] x86/asm: macro improvements in <asm/asm.h>
Date:   Mon, 10 May 2021 02:09:37 -0700
Message-Id: <20210510090940.924953-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

This patchset adds the following improvements to <asm/asm.h>:

1. Makes the __ASM_FORM() macros accept arguments with commas. This allows
   the __ASM_FORM() macros to be used directly in header files for
   macros that can be used from either C or assembly, even for
   instructions that have multiple operands.
2. Add an _ASM_BYTES() macro for the delicate job of hand-crafting
   instructions out of bytes.
3. Replace the _ASM_MK_NOPS() macro in <asm/nops.h> with _ASM_BYTES().

The change to the tools/ directory is mainly because <asm/nops.h> now
depends on <asm/asm.h>.

--- 
 arch/x86/include/asm/asm.h        |  23 ++---
 arch/x86/include/asm/nops.h       |  24 ++---
 tools/arch/x86/include/asm/asm.h  | 189 ++++++++++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/nops.h |  24 ++---
 4 files changed, 221 insertions(+), 39 deletions(-)
