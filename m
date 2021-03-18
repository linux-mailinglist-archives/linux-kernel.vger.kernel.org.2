Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9268340BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhCRRYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhCRRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:23:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880C7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HhuonSvujdoEBuhQWy3ySTmBOZryLmMhppVY1D+1Ovk=; b=iCp0hpuCUOkQewXKaXBfbxpqMs
        nIeQ4BCuo5DJRTg8twQm2XSDiGYWUU23Frr7Y2y1EY3v/iuKSRnwtj58KRR0eaRTYZstvRbefK3jB
        Lkx/2yqvlV0URvQP4xfgaYUGBkXYbfzA8eeWjwm/qWZU02SPbt/CkCtNUtOSCxno8G9NxFnmZawph
        3HxoHa4YCVFJOMuiK7hzmLupOAYmInFjUkhQ3WGwo90UpFKyPDOC4T8GY6I6A2kp7sGO4K8WZCJIE
        HQHSbJISly3OzvWc1Rm0MK+lXxiUzJLfXd0dvmOC+Oiwi69FKhgaMLVOhK0FiIFet+RLP4NoVip+z
        7+gMxswQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMp-005kEU-Ha; Thu, 18 Mar 2021 17:23:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32DDF3070D5;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D2EE213C0F59; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.643221109@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 04/14] objtool: Correctly handle retpoline thunk calls
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like JMP handling, convert a direct CALL to a retpoline thunk
into a retpoline safe indirect CALL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -953,6 +953,18 @@ static int add_call_destinations(struct
 					  dest_off);
 				return -1;
 			}
+
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+			/*
+			 * Retpoline calls are really dynamic calls in
+			 * disguise, so convert them accordingly.
+			 */
+			insn->type = INSN_CALL_DYNAMIC;
+			insn->retpoline_safe = true;
+
+			remove_insn_ops(insn);
+			continue;
+
 		} else
 			insn->call_dest = reloc->sym;
 


