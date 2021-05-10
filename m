Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C2378311
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhEJKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232391AbhEJKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:34:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C0F06143B;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=qbGBdK6Dwqp+EOhX3dciZCOOsQHVxjxZ9wKH8IR54CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXVjlzU0SjDh0Vnv0rdDspZTLTt4S5KHjPrwAeqEz1brn33i36hB+nXJlzuVMIgfP
         xuwhc7yaBIYyOIoRTLuH92YIUt2UCsa16SSe//4AXpCaPvF4oMuAk0y2NzwmOSHZ2m
         JGCNGaUXuUTPRXV3oCEDAS7TL2DENwFHhAHQq6o8BRsp6ExTvkb4wxA3BpjTX8ka0O
         65DcW6uShXQ5vV5OKJKLfVKKTjnPN6fINBUH6e1k4J5lydTldGTWE2k0cN/dmHmAB2
         e+gs0pqlbhF7VONie+gGzzQwnk4l7vC5yus/umWvDNomjr7MDUBAp1zxIqHsUFTXW9
         fL9WbtRtOJYNg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UY7-EY; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 46/53] docs: arm64: arm-acpi.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:58 +0200
Message-Id: <ea4905192df5262beed5bf2edbed08a32c5cb67e.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
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

