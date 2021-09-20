Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A441262B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354606AbhITSyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385885AbhITSww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6EF260FE6;
        Mon, 20 Sep 2021 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632163015;
        bh=Y1MRtGKzuPI2JTlrjLOY35BQbbHHLFtK6fTUmmYSbY8=;
        h=From:To:Subject:Date:From;
        b=hpC+GjzApEGH34r2DiTT97Vd4nzhtRtuGJhhvtS2+/eV6n3k4ZQgfhwLdjPTOZac6
         HqePsaW6fJvadIEJmsxmEYYuMXgQxw2SggnxR30VrvTaQxeFjORHGgu+XYxjP/sEgw
         gCeN8qC2Xq1/tkAmsa96cpUTKljDa9f3dpF0W1trQC+Acb3Kcwc8iOmQJY9SGzt7ZQ
         +hbaJ/kdheytJR5BJXzhRQJ6zPoaWgPJNE4At7RwcevXi1Ehom5R3t8n5OfbtAQDAM
         D8dWXiXhVPVRyEtc2Iwqx2KUzAfR9AWGD3FHcIb9+YuWA0rDv2LXtVQY8JAku0ba/5
         kasY8eiCP2lBw==
Received: by envy17 (sSMTP sendmail emulation); Mon, 20 Sep 2021 11:36:54 -0700
From:   markgross@kernel.org
To:     linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: [PATCH] update email addresses. Change all email addresses for Mark Gross to use markgross@kernel.org.
Date:   Mon, 20 Sep 2021 11:36:54 -0700
Message-Id: <20210920183654.82668-1-markgross@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mark <mark@thegnar.org>

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

