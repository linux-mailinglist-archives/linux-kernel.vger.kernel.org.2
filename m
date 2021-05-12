Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A404737BD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhELM4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231713AbhELMxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C70A461411;
        Wed, 12 May 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823907;
        bh=KTM32Ye2fL9Id0AwrSb2rffCbYWJx7KuFaES6hlu5vM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kruu/u5A/QkxqqDE+ru62qmCOYAdppcU1W6wmi4zAlPcy6mKfGryGQS5qu5w63qCj
         3+qEdtb+6WX6wb0qoYBxakkuJzq7ubxLRl9PX6auSiI6nN/6Fgki065sgHUFU7RUBT
         e9U6EWnAV0md1mBj740yGthGxBYO4WA6J4R8GnYhT7jKCPx+xuQcDsPu0N9qTDRQ2B
         gMt9hojMCxc8v6UoRsyfMweXIShsa5/l10rRfOqJOJFrxoimVO7RmGQ+F9z34K4v95
         yQm8WR8c3xktpQb3hMxHE/ouxb9Yyegg26O33m/1Mm66GCoqONVEBjV5BY/d5j4hIV
         6ZfI2MKCu5XhQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoL3-0018na-MF; Wed, 12 May 2021 14:51:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/40] docs: arm64: arm-acpi.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:38 +0200
Message-Id: <4ea53cd3be333779091bea0c4680b11b83129f69.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/arm-acpi.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
index 47ecb9930dde..ceb109ff82aa 100644
--- a/Documentation/arm64/arm-acpi.rst
+++ b/Documentation/arm64/arm-acpi.rst
@@ -36,12 +36,12 @@ of the summary text almost directly, to be honest.
 
 The short form of the rationale for ACPI on ARM is:
 
--  ACPI’s byte code (AML) allows the platform to encode hardware behavior,
+-  ACPI's byte code (AML) allows the platform to encode hardware behavior,
    while DT explicitly does not support this.  For hardware vendors, being
    able to encode behavior is a key tool used in supporting operating
    system releases on new hardware.
 
--  ACPI’s OSPM defines a power management model that constrains what the
+-  ACPI's OSPM defines a power management model that constrains what the
    platform is allowed to do into a specific model, while still providing
    flexibility in hardware design.
 
@@ -69,7 +69,7 @@ Key to the use of ACPI is the support model.  For servers in general, the
 responsibility for hardware behaviour cannot solely be the domain of the
 kernel, but rather must be split between the platform and the kernel, in
 order to allow for orderly change over time.  ACPI frees the OS from needing
-to understand all the minute details of the hardware so that the OS doesn’t
+to understand all the minute details of the hardware so that the OS doesn't
 need to be ported to each and every device individually.  It allows the
 hardware vendors to take responsibility for power management behaviour without
 depending on an OS release cycle which is not under their control.
@@ -81,7 +81,7 @@ in place.  DT does exactly what Linux needs it to when working with vertically
 integrated devices, but there are no good processes for supporting what the
 server vendors need.  Linux could potentially get there with DT, but doing so
 really just duplicates something that already works.  ACPI already does what
-the hardware vendors need, Microsoft won’t collaborate on DT, and hardware
+the hardware vendors need, Microsoft won't collaborate on DT, and hardware
 vendors would still end up providing two completely separate firmware
 interfaces -- one for Linux and one for Windows.
 
-- 
2.30.2

