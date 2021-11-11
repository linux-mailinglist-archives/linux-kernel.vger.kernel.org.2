Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A866444D57C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhKKLFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232995AbhKKLFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:05:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 519106135E;
        Thu, 11 Nov 2021 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636628576;
        bh=djNzPwGB6ZZr+KxL5x18Tn2XQt9fbgK3pthmL8hf28I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwqZ1cTi3XMQr8thFOlOsYCKYt1rITunrfegbDeQlCvMZU1R0W87cww+azaB/e/rg
         xuwxSbqlJhAF3EpftZkmsY8Riq/NoxM0Up5cGE4UnR0kFv3N859+bgpbsvf2sVHp48
         2VqSRZkFmVbKd9LWtyjG5qEsddJlkJgjQCPoUw2hHaqdKAG5QiVqpQ2IaGuBq0Zjfj
         il4CLh7IuNUrHFl4bhEx1lpasp/4Md3NlSQKnQl9CmYwA6WZG+M24hZqRQaeOhul/o
         Z+V1kVhURlLls44KaWq4z9DUYcRpbETz6cq6S1IwmB1o0PDh4rpVWm3eviQ4EFy3Ax
         I98hjvwMIl6WQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86/mm: make kernel_physical_mapping_change() __init
Date:   Thu, 11 Nov 2021 13:02:39 +0200
Message-Id: <20211111110241.25968-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211111110241.25968-1-rppt@kernel.org>
References: <20211111110241.25968-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

kernel_physical_mapping_change() is __meminit although it is only called by
__init function early_set_memory_enc_dec().

Make kernel_physical_mapping_change() __init.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 36098226a957..9a24532d2b85 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -794,7 +794,7 @@ kernel_physical_mapping_init(unsigned long paddr_start,
  * when updating the mapping. The caller is responsible to flush the TLBs after
  * the function returns.
  */
-unsigned long __meminit
+unsigned long __init
 kernel_physical_mapping_change(unsigned long paddr_start,
 			       unsigned long paddr_end,
 			       unsigned long page_size_mask)
-- 
2.28.0

