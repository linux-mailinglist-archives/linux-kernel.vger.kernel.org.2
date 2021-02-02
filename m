Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4AA30BB3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhBBJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBBJij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:38:39 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9106C061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:38:23 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 19so19187246qkh.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yg8qLn6EBRblBdGN89hb4qppVjdAkF53EYMnS584DQ8=;
        b=H21XDKE7kj6eviodyCfNiCshUr6Jl60NQwPGMYhq3Avfd4XS+uk55A2YxdbbFgzxui
         sL8c36XDslXNHh7ezBTjvKUKd/rdbrP+XeDnJg6BSONj3kFyiCP1BqqYjWZAKovb0L8Y
         VVt1+afdyxEhdTLjPf8UGL4I9rbDHEOd3EZ7QGqenX6ehu++KcdY5csfm9S7lrnOb58a
         dpBsBnPgWchQ74AWLHFheE2/fIvkkTxgiw7oZC13UwRhs4brUZAiP9M5nql3/PFP+2lb
         wuCfUTiV13Qxcd4YZ24kag/2/Qsm8J2h8kO7GpPaLrUelbs1buIpIbq0Wa/szKLNdIxd
         qenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yg8qLn6EBRblBdGN89hb4qppVjdAkF53EYMnS584DQ8=;
        b=XMeGDUlLl3vw0ScwHtBID59tzOOb7N67HGTnbDZDyQJqtVzsSDgfhoFR4SLtxMBLEh
         +DJb85ZUAkRCIz9CgCGfpz8hmtOfu4lgK8aVTPovkokkTjMr8ASOmpRWXgnTA5YQyylD
         66qINot8pMbykrTtlG+gLuEHh+kio57tBHQFiEv549bT2enR/b7bkG86kFnIUlI5elYY
         7nw9tLrytLbaFSc4ZQUMfqeTOe2A4Wj81kX92x8il72/FQMdbfy0vU3p1bNBUl1h1WtF
         Xt1dJeshFRUmto4O45b2mFsLLs8K5PyZIlJhr9vOUe7CT7NkFSAIiqZveODBklLkBbej
         BnOw==
X-Gm-Message-State: AOAM533niutBtwt/VWNAfbkwDzXq8tGcDJW9fSbvWIamJSqxcgqA6HBU
        dsXNxmIyFpPOPvrxlTqaBMQ=
X-Google-Smtp-Source: ABdhPJxq86fkMmfu4iLXPxDRIKQK7ZUhUum7zoVW/6IbluNr5HO7IxuObUF0GYjcobviYxjSr/GGlQ==
X-Received: by 2002:a05:620a:132a:: with SMTP id p10mr20466699qkj.124.1612258703039;
        Tue, 02 Feb 2021 01:38:23 -0800 (PST)
Received: from localhost.localdomain ([156.146.58.43])
        by smtp.gmail.com with ESMTPSA id z5sm16608357qkc.61.2021.02.02.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:38:22 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: powerpc: kernel: Fix the spelling mismach to mismatch in head.44x.S
Date:   Tue,  2 Feb 2021 15:07:46 +0530
Message-Id: <20210202093746.5198-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/mismach/mismatch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/head_44x.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 8e36718f3167..813fa305c33b 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -376,7 +376,7 @@ interrupt_base:
 	/* Load the next available TLB index */
 	lwz	r13,tlb_44x_index@l(r10)

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Increment, rollover, and store TLB index */
 	addi	r13,r13,1
@@ -471,7 +471,7 @@ interrupt_base:
 	/* Load the next available TLB index */
 	lwz	r13,tlb_44x_index@l(r10)

-	bne	2f			/* Bail if permission mismach */
+	bne	2f			/* Bail if permission mismatch */

 	/* Increment, rollover, and store TLB index */
 	addi	r13,r13,1
--
2.26.2

