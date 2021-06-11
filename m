Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C622A3A46DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFKQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhFKQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C781C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:44:31 -0700 (PDT)
Message-Id: <20210611163113.869043990@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vwFoWBdVq1m8D3myIC5w9gWifkWvJ22cL6Al7n5j8z0=;
        b=fwUgtYV7KJINLPrG3RXQIuIGaIdN0Un1yn+TV57ulYN1oWYTTy53ksXcQNp2p0BUbHA6uO
        wxS5F44aUVpsC5klEIv8h0uOH0UkPXw0SBwuSio8TU7v0/2v9x3DMKvmQ/jZazZLpcUqm+
        fVNHnb0Ri0SBtvR/O5u22+MYBEsg8MmdgXkmSSoVGjjeaXNJ+2ENyy0n2PQv0WnIhWatog
        XvhxCAzZewNXO0OBjh7dUFibIe6GOiyd/gkfn/kdav+FHD+Bf2cehuf2FmdoLbtBfC+wdr
        HnIhQlIAMJX1gH0cet5+7Aq20E/ao+A7jg+eq9vBKp46EWWUiVzNEj22ZiMR7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vwFoWBdVq1m8D3myIC5w9gWifkWvJ22cL6Al7n5j8z0=;
        b=7+cLFAigXM/T8I95dHje2D+xJpxNZXshiEg9AtS+d+n93NDNWlnyGilN0iaOrauxxEeDiO
        b5zgzDSYz8PjU9DA==
Date:   Fri, 11 Jun 2021 18:15:50 +0200
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
Subject: [patch 27/41] x86/pkru: Provide pkru_write_default()
References: <20210611161523.508908024@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple and trivial helper which just writes the PKRU default
value without trying to fiddle with the tasks xsave buffer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 arch/x86/include/asm/pkru.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -60,4 +60,12 @@ static inline void write_pkru(u32 pkru)
 	fpregs_unlock();
 }
 
+static inline void pkru_write_default(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return;
+
+	wrpkru(pkru_get_init_value());
+}
+
 #endif

