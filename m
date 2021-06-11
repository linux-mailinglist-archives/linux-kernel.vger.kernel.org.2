Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B93A46C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFKQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFKQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:02 -0400
Message-Id: <20210611163111.515164108@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jCMRsoWgBYLZU5Bxc0Uf78M0BivlUdtVBvvPSJhRszs=;
        b=wRaBD6F/uvo+19jJFiMVIOWy3nERdYLFRxQIEte4e2V7XKbkU7BCf49roU/kh+SzCVVNVl
        xGTZbZVnyY4RAKY4yIUnI39BC7OvooqpCYZx0YmEHUyP7uhhWZKk6qLIq7WNe7xP7HrgQ0
        HMQRbW6bWbmfPzOIJyiLLQExxRt4ulv+SmfsXZFwNNjJ075t1xNpMB+IbeTicxVWKomFKH
        b9wvQOcVZUHsQuF2WHhD9oGyf2/XQHv6zVTg8Bl6JsUZrSc4ZhQFYANpGmH2QnJfGgFnU4
        GP8wGYMbFt7BKhSimpNLidWIdfRcXtBBs9c73PBKNt/mUqgOBWveJMW0byuKjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jCMRsoWgBYLZU5Bxc0Uf78M0BivlUdtVBvvPSJhRszs=;
        b=zDUVI5j0Fws7Km9fub73P8Qn+KNnULcalq9O0+kT+4v9U7z3VHQn4tpSf+fKsK8fXQRnEc
        uMShDFKtygRQb2DQ==
Date:   Fri, 11 Jun 2021 18:15:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch 05/41] x86/fpu: Limit xstate copy size in xstateregs_set()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the count argument is larger than the xstate size, this will happily
copy beyond the end of xstate.

Fixes: 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/regset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -117,7 +117,7 @@ int xstateregs_set(struct task_struct *t
 	/*
 	 * A whole standard-format XSAVE buffer is needed:
 	 */
-	if ((pos != 0) || (count < fpu_user_xstate_size))
+	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
 	xsave = &fpu->state.xsave;

