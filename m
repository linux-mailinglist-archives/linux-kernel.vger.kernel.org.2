Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1075344048F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhJ2VAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhJ2VAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:00:34 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F2C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:58:05 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mgYwq-006YvE-2T; Fri, 29 Oct 2021 16:58:00 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 50F65560090; Fri, 29 Oct 2021 16:57:59 -0400 (EDT)
Date:   Fri, 29 Oct 2021 16:57:59 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: mce: Add errata workaround for Skylake SKX37
Message-ID: <20211029205759.GA7385@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata SKX37 is word-for-word identical to the other errata listed in
this workaround.   I happened to notice this after investigating a CMCI
storm on a Skylake host.  While I can't confirm this was the root cause,
spurious corrected errors does sound like a likely suspect.

Signed-off-by: Dave Jones <davej@codemonkey.org.uk>

diff --git arch/x86/kernel/cpu/mce/intel.c arch/x86/kernel/cpu/mce/intel.c
index acfd5d9f93c6..bb9a46a804bf 100644
--- arch/x86/kernel/cpu/mce/intel.c
+++ arch/x86/kernel/cpu/mce/intel.c
@@ -547,12 +547,13 @@ bool intel_filter_mce(struct mce *m)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
+	/* MCE errata HSD131, HSM142, HSW131, BDM48, HSM142 and SKX37 */
 	if ((c->x86 == 6) &&
 	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
 	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
 	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
-	     (c->x86_model == INTEL_FAM6_HASWELL_G)) &&
+	     (c->x86_model == INTEL_FAM6_HASWELL_G) ||
+	     (c->x86_model == INTEL_FAM6_SKYLAKE_X)) &&
 	    (m->bank == 0) &&
 	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
 		return true;
