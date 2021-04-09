Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04209359E75
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhDIMR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:17:57 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:29813 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhDIMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:17:56 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 08:17:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1617970664;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=kXQadYr7lBMnMrP9f0KECt/GboONQfDPaqej/fNyBjM=;
  b=AAv1YbK5TwdZL4ZhlkeX6SQXRqZciDc7YeiwhWGFm3hxanxEI7qwl/bk
   k+8OZ4NSwUiF/vKEZtReAEHsYLRgSHNzXlbT+dkI0xIK3cCM8R409nJf4
   AkxLBsB/EOXh7voYcPCyvf6+8BwnQPr+BUEhw7eOmjHfpbR8ytN2HomZy
   c=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: nozO2MJ1xcVf0oIqZGCiEbLfXCUaRqSL8bB63wXvhlhdvPkAn+hnoyyMhJzCDByp8y9qmX03w2
 wyMDK5LoPpfLE0Us55g0z1t2U3KRoi7eoqZQ/yblsPDyTYfnQJggbJhKRaZuF5lj/rhOfty4en
 lzTAKw3JCk5kUAW90y9JXdacPJtVBA94Sl49clbjN2Hp57Wg1evYJKD93/4L5uklh6DU0uWq7A
 XxixjN7qZ03QiyyMacCxASzmN86/x91eoEwZmlzGCPyssGSto0exTjnnLbe3+iMCNDA1MFeOTR
 7fM=
X-SBRS: 4.0
X-MesageID: 42727005
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
IronPort-HdrOrdr: A9a23:bFjS3qFPe/NogvkupLqFOpHXdLJzesId70hD6mlYVQFVfsuEl8
 qngfQc0lvOhCwMXWw78OrsBICrSxrnlaJdy48XILukQU3aqHKlRbsSibfK7h/BP2nF9uBb3b
 p9aKQWMrfNJHVzkMqS2maFOvk6xt3vys6VrMP/61socg1wcaFn6G5Ce2OmO2l7XhNPC5Z8NL
 f03LslmxOadX4abtu2CxA+NoCum/TxmI/7ehlDPhY76WC15g+A0qLwEBSTw34lIlFy6IolmF
 KlryXJop+Nntv+4R/a2m/V4f1t6abc4+oGPuOgoIw4Lj3tjyyheYhuXaaT1QpF3N2H2RIRv/
 Tn5zsmIsRv+1PdF1vF3ifF6k3b/xsFr1/k1FOCjnPoraXCNUwHIvsEv611WF/9ySMbzbZB+Z
 MO5U21nd5rKCmFuyLH693BR3hR5zGJiEtnq8E/pThiS4cEAYUhy7A3zQduP7orOjn104wjGP
 kGNrCn2N9mNWmXaH3UpQBUsaWRd0V2Gh+HR34LsdCO3w5Xm2hkz1AZyNZ3pAZ5yK4A
X-IronPort-AV: E=Sophos;i="5.82,209,1613451600"; 
   d="scan'208";a="42727005"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, <x86@kernel.org>
Subject: [PATCH] x86/cpu: Comment Skylake server stepping too
Date:   Fri, 9 Apr 2021 13:10:27 +0100
Message-ID: <20210409121027.16437-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Further to commit 53375a5a218e ("x86/cpu: Resort and comment Intel
models"), CascadeLake and CooperLake are steppings of Skylake, and make up
the 1st to 3rd generation "Xeon Scalable Processor" line.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Peter Zijlstra <peterz@infradead.org>
CC: Tony Luck <tony.luck@intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org

It is left as an exercise to the reader to ponder why the 3rd generation Xeon
Scalable brand is formed of both CooperLake and IceLake parts.
---
 arch/x86/include/asm/intel-family.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b15262f1f645..955b06d6325a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -33,7 +33,7 @@
  *		_EX	- 4+ socket server parts
  *
  * The #define line may optionally include a comment including platform or core
- * names. An exception is made for kabylake where steppings seem to have gotten
+ * names. An exception is made for skylake/kabylake where steppings seem to have gotten
  * their own names :-(
  */
 
@@ -74,6 +74,8 @@
 #define INTEL_FAM6_SKYLAKE_L		0x4E	/* Sky Lake             */
 #define INTEL_FAM6_SKYLAKE		0x5E	/* Sky Lake             */
 #define INTEL_FAM6_SKYLAKE_X		0x55	/* Sky Lake             */
+/*                 CASCADELAKE_X	0x55	   Sky Lake -- s: 7     */
+/*                 COOPERLAKE_X		0x55	   Sky Lake -- s: 11    */
 
 #define INTEL_FAM6_KABYLAKE_L		0x8E	/* Sky Lake             */
 /*                 AMBERLAKE_L		0x8E	   Sky Lake -- s: 9     */
-- 
2.11.0

