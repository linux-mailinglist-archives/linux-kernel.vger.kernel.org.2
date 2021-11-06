Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4E446DC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhKFMF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 08:05:58 -0400
Received: from devianza.investici.org ([198.167.222.108]:52299 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhKFMF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 08:05:57 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Nov 2021 08:05:57 EDT
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4HmbRQ49v6z6vK3;
        Sat,  6 Nov 2021 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=insiberia.net;
        s=stigmate; t=1636199730;
        bh=hdcIjqqmcdvuvg4JlY5dnV4egx6+Y3+8DzIfN820cZg=;
        h=Subject:From:To:Cc:Date:From;
        b=UmoI4cbo/uPGWujztwkt1lgDhqeVQFMZW01vr5Oul6x8zBltTACcaqsHtLpyieUFl
         oUTjeQ068//Scw2PiE+mtlhg3qEB1vB5j2Da1xaCGYRWjCUprPbV88rH+FDny8DVbf
         aNPR+LDKgZgf2p8SOiurPWGe/jUlpPxhdabsLBy8=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: stefano@distruzione.org) by localhost (Postfix) with ESMTPSA id 4HmbRQ2dFlz6vJW;
        Sat,  6 Nov 2021 11:55:30 +0000 (UTC)
Message-ID: <9932762ef184fe132acf176081f8893800c83800.camel@insiberia.net>
Subject: [PATCH] Allow selecting amd-pstate without CPU_SUP_INTEL
From:   Stefano Picascia <stefano.picascia@insiberia.net>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Rui <ray.huang@amd.com>
Date:   Sat, 06 Nov 2021 11:55:29 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, even if selected, amd-pstate is not enabled unless
CPU_SUP_INTEL is also selected, due to ACPI_CPPC_LIB depending on
SCHED_MC_PRIO, which in turn depens on CPU_SUP_INTEL

The small patch below fixes it.


--- a/arch/x86/Kconfig	2021-10-31 20:53:10.000000000 +0000
+++ b/arch/x86/Kconfig	2021-11-06 09:22:46.736533394 +0000
@@ -1015,8 +1015,7 @@
 
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
-	depends on SCHED_MC && CPU_SUP_INTEL
-	select X86_INTEL_PSTATE
+	depends on SCHED_MC && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select CPU_FREQ
 	default y
 	help


