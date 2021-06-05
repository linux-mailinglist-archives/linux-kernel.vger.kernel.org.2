Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B877E39C8B9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFENVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhFENU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5F7761431;
        Sat,  5 Jun 2021 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899118;
        bh=0eg/qQj43/pYb/pkZfHCH47Ta5ORGHZpDLIZwyYMQ5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLfidv/mDuJa6jC3Um/xmU4ixYPBOc3mmvjaWwLQrq5Xf4n9eW9FdQ0LOYdRB6qle
         pVybXQ+VVZKROyOe+APiCR96jbEDVaR1k5huWxz1Vw+xrRLR1jBYAur24yvKB6hFnj
         JJoeOaL/r4VGONkjXbeMiwTPuRmHLbmSdrRaImixPoiX/7TX5vyhVDlS9G5TO/WDUM
         R6rxkMP0p/Cnrk2ZrXmRZFBwOkoO2uLaRsIDavAyKPH8FP7SmlPgQOFx6fevhjV2r6
         RF6jADq6+os6XP6t50pvMskmHsLpD5UtZkO571rdhLT1i30+X/KngT293ka1n1y0aU
         utkxR3Ykh/wSw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GGf-Ub; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 34/34] docs: x86: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:33 +0200
Message-Id: <65a78bd39b0d317de9623976449e273e92a1e1c0.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

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

