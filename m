Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03C3A928E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhFPGaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhFPG34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1EAE61431;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824869;
        bh=+cZwUIb2eIawYe0qtJdfrN3JRxOhmVgn9lEUBsYusQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2AsBY18G7fP6sriYFxCCIM8NPM9RF2aKvG1VV46q3JP/iWlilWPILpRRUp/byN0y
         2olTNvTH7rylonyrjCGB8OzeKrWiI/4D0RgdGOADpRX0n5E7IhWkkWS+Pm4DmQwLc9
         dmfjp/mMBvPFP8951jGBvwMMEcD+QU0gmoOQ3UIA86qItskQzwraogjhYGtO+MmLnn
         NUm3GteO6VWlXk1MB71eWm7pqfdkzVVXjzdCC7kffW+y3ivU5RXt+O6E5Gp+On+Kgk
         uTDhmfUxFYV6pRIiY5pXRE1jwj4rriwzRDfJDGkkFzf3pwB0YBs6fnMQAS9Bteuf/+
         ggx6ZXp1iQmfg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1f-004kKA-AH; Wed, 16 Jun 2021 08:27:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 29/29] docs: x86: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:44 +0200
Message-Id: <17c68b5f1d72488431c77c1de9f13683fe9f536c.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/x86/boot.rst | 4 ++--
 Documentation/x86/mtrr.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fc844913dece..894a19897005 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1343,7 +1343,7 @@ follow::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as
-described in chapter :doc:`zero-page`.
+described in chapter Documentation/x86/zero-page.rst.
 
 After setting up the struct boot_params, the boot loader can load the
 32/64-bit kernel in the same way as that of 16-bit boot protocol.
@@ -1379,7 +1379,7 @@ can be calculated as follows::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as described
-in chapter :doc:`zero-page`.
+in chapter Documentation/x86/zero-page.rst.
 
 After setting up the struct boot_params, the boot loader can load
 64-bit kernel in the same way as that of 16-bit boot protocol, but
diff --git a/Documentation/x86/mtrr.rst b/Documentation/x86/mtrr.rst
index c5b695d75349..9f0b1851771a 100644
--- a/Documentation/x86/mtrr.rst
+++ b/Documentation/x86/mtrr.rst
@@ -28,7 +28,7 @@ are aligned with platform MTRR setup. If MTRRs are only set up by the platform
 firmware code though and the OS does not make any specific MTRR mapping
 requests mtrr_type_lookup() should always return MTRR_TYPE_INVALID.
 
-For details refer to :doc:`pat`.
+For details refer to Documentation/x86/pat.rst.
 
 .. tip::
   On Intel P6 family processors (Pentium Pro, Pentium II and later)
-- 
2.31.1

