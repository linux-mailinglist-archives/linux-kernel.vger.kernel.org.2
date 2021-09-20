Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9675F412687
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbhITS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhITS5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 171B7606A5;
        Mon, 20 Sep 2021 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632164144;
        bh=4Upm/PuZbLIKgUC6E/6dOdweT8yq3TxrOEEOu7IIZ2I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NHHc9iJHui8I45UwnRuR0sopiG3P5lUJtu8Z2qnCH76ohA+wfYyIDXtMNKYHuJOuh
         Y5qPX4CdSb2x0bH/XkRkPaoC5lFWdSlP+jmi9LEGPoRO9b30exUwm2t01jFaPYNgfB
         Ai1wd62TPUuQHxvZf3oLqEqRrWtJSvHaNq3kuFwHYY1npfNIkcHvTHlrOo1Nw4v0VF
         ODpYGppbh9a2H1ByS/CwplETSmEGXOAZ2S/Yyi8UcCm7Ub6KqtUn+f+XeOxrU/wCeA
         dXOIazE9JZeggnVRu9UzyzQ/t/Y4HHCQQZ7FeXdtv768EKlRtDpWW969fvEH1zFvGD
         Ig9N/92dLfkNA==
Received: by envy17 (sSMTP sendmail emulation); Mon, 20 Sep 2021 11:55:42 -0700
From:   markgross@kernel.org
To:     linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: [PATCH] update email addresses. Change all email addresses for Mark Gross to use markgross@kernel.org.
Date:   Mon, 20 Sep 2021 11:55:35 -0700
Message-Id: <20210920185535.83416-2-markgross@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920185535.83416-1-markgross@kernel.org>
References: <20210920185535.83416-1-markgross@kernel.org>
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

