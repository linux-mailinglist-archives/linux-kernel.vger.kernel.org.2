Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866674134DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhIUNzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhIUNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:55:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4B1B60F13;
        Tue, 21 Sep 2021 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632232449;
        bh=4Upm/PuZbLIKgUC6E/6dOdweT8yq3TxrOEEOu7IIZ2I=;
        h=From:To:Cc:Subject:Date:From;
        b=RKZfa+L1Xr3sFCyPmyXfyHH8ScvdTFdNogK07o2iwd3Q1TUZzcVqrlAQmFN09oMbF
         59NbZaC8u/qMrn2VMwojR8i+viUx+9Vk3a5BagBE+sBywzlvFjgq2AjPvhxUn8d8aS
         PBhIYYjgdlcycma/qX2ErzKxV9Gt2yGReQycGnVDWv4gtN/AMGlau3vJwd4EpXOeZf
         JaeSA5svgYHdlp73bZUA/vfaoK0gk0cFR1uxJA9sojxZvcDpwkx8VZ9hDT30uZC447
         OMqadfkqOTMoJ79acsSsHjjCXP0YsbTKil+oU83MywQzYf5tovmCwfDtCrK5RcBseB
         0RUYuW7EEf9dQ==
Received: by envy17 (sSMTP sendmail emulation); Tue, 21 Sep 2021 06:54:08 -0700
From:   markgross@kernel.org
To:     linux-kernel@vger.kernel.org, hdegoede@redhat.com
Cc:     Mark Gross <markgross@kernel.org>
Subject: [PATCH] update email addresses. Change all email addresses for Mark Gross to use markgross@kernel.org.
Date:   Tue, 21 Sep 2021 06:53:58 -0700
Message-Id: <20210921135358.85143-1-markgross@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Gross <markgross@kernel.org>

Signed-off-by: Mark Gross<markgross@kernel.org>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..9d9800f79b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6683,7 +6683,7 @@ S:	Supported
 F:	drivers/edac/dmc520_edac.c
 
 EDAC-E752X
-M:	Mark Gross <mark.gross@intel.com>
+M:	Mark Gross <markgross@kernel.org>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/e752x_edac.c
@@ -11979,7 +11979,7 @@ F:	drivers/net/ethernet/mellanox/mlxfw/
 
 MELLANOX HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hdegoede@redhat.com>
-M:	Mark Gross <mgross@linux.intel.com>
+M:	Mark Gross <markgross@kernel.org>
 M:	Vadim Pasternak <vadimp@nvidia.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
@@ -12431,7 +12431,7 @@ F:	drivers/platform/surface/surface_gpe.c
 
 MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
 M:	Hans de Goede <hdegoede@redhat.com>
-M:	Mark Gross <mgross@linux.intel.com>
+M:	Mark Gross <markgross@kernel.org>
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
@@ -18460,7 +18460,7 @@ S:	Supported
 F:	drivers/net/ethernet/tehuti/*
 
 TELECOM CLOCK DRIVER FOR MCPL0010
-M:	Mark Gross <mark.gross@intel.com>
+M:	Mark Gross <markgross@kernel.org>
 S:	Supported
 F:	drivers/char/tlclk.c
 
@@ -20376,7 +20376,7 @@ F:	arch/x86/mm/
 
 X86 PLATFORM DRIVERS
 M:	Hans de Goede <hdegoede@redhat.com>
-M:	Mark Gross <mgross@linux.intel.com>
+M:	Mark Gross <markgross@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
-- 
2.30.2

