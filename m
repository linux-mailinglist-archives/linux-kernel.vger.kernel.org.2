Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA33ECBA7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhHOWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 18:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 18:24:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C6C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pTmqCP6bDwFCjXTWd+UHBKtuuPwOHDbSrKzlepP0BUE=; b=rCc+gnCJNt6uQBsnSfjHECCJaQ
        RR2RCy+gM9PIBaLzI6yeTNNaWpVxrHG2KZr8wDCjTivJqG4m3xg1jSgSUNR1nH7zmx9WqbGHxjXpk
        e2FtzH7M36jJIAE8dAVu6qvAGu59fh5h5yOW4p6ZUVdAtK5oQnultq+Bvr2TAMZeyI1ZMcbfAiDzA
        D0Qs7FCkRFrdPdPOaIXW7gC6MJ/HmZ6re9xerz+2afIszMMye0b4xki4gcaNH4B7Wvnzv62NeVqdt
        /6/7KP0QIgKNxc7m7sI2yQSMaW+P0LPnC2wMC5qniRTQFqqEJpegXvRhxYEeB98Pkvv+vOlmRkr9l
        Szdy269g==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFOXX-00Fj6S-CE; Sun, 15 Aug 2021 22:23:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Chen, Rong A" <rong.a.chen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/head_check: use stdout for error messages
Date:   Sun, 15 Aug 2021 15:23:34 -0700
Message-Id: <20210815222334.9575-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer stderr instead of stdout for error messages.
This is a good practice and can help CI error detecting and
reporting (0day in this case).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Chen, Rong A" <rong.a.chen@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/tools/head_check.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20210813.orig/arch/powerpc/tools/head_check.sh
+++ linux-next-20210813/arch/powerpc/tools/head_check.sh
@@ -56,9 +56,9 @@ expected_start_head_addr=$vma
 start_head_addr=$(cat .tmp_symbols.txt | grep " t start_first_256B$" | cut -d' ' -f1)
 
 if [ "$start_head_addr" != "$expected_start_head_addr" ]; then
-	echo "ERROR: head code starts at $start_head_addr, should be $expected_start_head_addr"
-	echo "ERROR: try to enable LD_HEAD_STUB_CATCH config option"
-	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"
+	echo "ERROR: head code starts at $start_head_addr, should be $expected_start_head_addr" 1>&2
+	echo "ERROR: try to enable LD_HEAD_STUB_CATCH config option" 1>&2
+	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh" 1>&2
 
 	exit 1
 fi
@@ -70,9 +70,9 @@ expected_start_text_addr=$(cat .tmp_symb
 start_text_addr=$(cat .tmp_symbols.txt | grep " t start_text$" | cut -d' ' -f1)
 
 if [ "$start_text_addr" != "$expected_start_text_addr" ]; then
-	echo "ERROR: start_text address is $start_text_addr, should be $expected_start_text_addr"
-	echo "ERROR: try to enable LD_HEAD_STUB_CATCH config option"
-	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"
+	echo "ERROR: start_text address is $start_text_addr, should be $expected_start_text_addr" 1>&2
+	echo "ERROR: try to enable LD_HEAD_STUB_CATCH config option" 1>&2
+	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh" 1>&2
 
 	exit 1
 fi
