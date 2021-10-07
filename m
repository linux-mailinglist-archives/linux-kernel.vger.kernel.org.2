Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9F425EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhJGV3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbhJGV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:29:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE03C061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ia4q4n+c6TIIxcsUR1m9I2uXVMJqgB2Q6ZnRu9B7HJM=; b=KEmRbMSIAKs3/fu8iohUdetO4z
        zkgAUO09oufKhw0TVXmRIuzHyIrNY7bIWegazVufc1Lzfq3+ccDVNgdDbp9io+IWa1c1sYFt1RhpI
        l6G77PWfS0pGhGE1XG9K1TtMFWMnAF16d4WXl6Nmg1SKgRfp3QUOvbTTUFgv+/Svh9eXI8J2Ohnd8
        ivpxWnQSISzWJCvxVpC5aLH2Sp7K6B7B+PJkYEGhwWiWFzp1TCFWTU1UgDkIo24Fsd7DbEepLExOt
        tLKsNVQEGHHqjYL5kcmikbRU5XIKgs+skF3sqrPyc+PLJl+hkhSw3fhZj7WRjORs4LQb/kqIUQM6q
        QjEsb+hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYav2-008YHY-15; Thu, 07 Oct 2021 21:27:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8FDE3004DE;
        Thu,  7 Oct 2021 23:27:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9B82E2D188961; Thu,  7 Oct 2021 23:27:10 +0200 (CEST)
Message-ID: <20211007212626.950220936@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 23:22:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: [PATCH 1/2] objtool: Optimize re-writing jump_label
References: <20211007212211.366874577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point to re-write the jump_label NOP when it's already a NOP.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1397,7 +1397,7 @@ static int handle_jump_alt(struct objtoo
 		return -1;
 	}
 
-	if (special_alt->key_addend & 2) {
+	if ((special_alt->key_addend & 2) && orig_insn->type != INSN_NOP) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {


