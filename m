Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58C3404C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCRLiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhCRLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:38:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=g4chIGlgUtTg3LwaMqGw4sKrFd89cdNqKSgI9ZESlNQ=; b=dwACxiSpUOQe6kOejX0ilN9f59
        cZdNDpt/FBgNyyIvdkZodMl/kUUa9roYWbJLb6jywsLb2ZTyF1XVWy3fgBh3htVvlbmvjLDC2xSfT
        EFsA53aNjR94+9BhgPo1g4IL2CHvJPj7cOyV/NTVoXTiTH0ksEhCDhx5euzLE7nPpvoqGpYRvFcBg
        t4StrVODBJawUPNs+vz3TF7ATaOn/e4vgxsWwsgQSeMvemGP6PoLMJwwAJU0XTrHa57iHbRk5gzaT
        lWzfqbdJhtr947DY/pqdzoN7lx9VMm41huhPCkzeAInKfql27LWWazLdYJnkLkAfzEiPZAg7C+fGi
        LJSii03g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMqyp-005776-Ck; Thu, 18 Mar 2021 11:38:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE987305C22;
        Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CF96420191901; Thu, 18 Mar 2021 12:38:17 +0100 (CET)
Message-ID: <20210318113610.739542434@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 12:31:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: [PATCH 3/3] static_call: Fix static_call_update() sanity check
References: <20210318113156.407406787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sites that match init_section_contains() get marked as INIT. For
built-in code init_sections contains both __init and __exit text. OTOH
kernel_text_address() only explicitly includes __init text (and there
are no __exit text markers).

Match what jump_label already does and ignore the warning for INIT
sites. Also see the excellent changelog for commit: 8f35eaa5f2de
("jump_label: Don't warn on __exit jump entries")

Fixes: 9183c3f9ed710 ("static_call: Add inline static call infrastructure")
Reported-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/jump_label.c  |    8 ++++++++
 kernel/static_call.c |   11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -407,6 +407,14 @@ static bool jump_label_can_update(struct
 		return false;
 
 	if (!kernel_text_address(jump_entry_code(entry))) {
+		/*
+		 * This skips patching __exit, which is part of
+		 * init_section_contains() but is not part of
+		 * kernel_text_address().
+		 *
+		 * Skipping __exit is fine since it will never
+		 * be executed.
+		 */
 		WARN_ONCE(!jump_entry_is_init(entry),
 			  "can't patch jump_label at %pS",
 			  (void *)jump_entry_code(entry));
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -181,7 +181,16 @@ void __static_call_update(struct static_
 				continue;
 
 			if (!kernel_text_address((unsigned long)site_addr)) {
-				WARN_ONCE(1, "can't patch static call site at %pS",
+				/*
+				 * This skips patching __exit, which is part of
+				 * init_section_contains() but is not part of
+				 * kernel_text_address().
+				 *
+				 * Skipping __exit is fine since it will never
+				 * be executed.
+				 */
+				WARN_ONCE(!static_call_is_init(site),
+					  "can't patch static call site at %pS",
 					  site_addr);
 				continue;
 			}


