Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CEF38BB64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhEUBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236410AbhEUBOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5965361355;
        Fri, 21 May 2021 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621559608;
        bh=LM15UHAX7XIvUWWap02WPhXkiLJ5e4m0TMbCFTmBn0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ew5iaWXeIIeRGnoLEVn5ClB7+i3+YF8HAEswUqsUNIkoOWOP2biSgTWkCqo7fP51a
         xcQRBmsLEkVDroV6dNhkD1bKfGRfS4f3kOQiAY2WmARYvdXUNEvx3xEUVJmQzr46Vs
         jFcevocawDUt5vulnf7rs4MeAU0BFukkGddFQg+B0EDCmRwxNAq1GBm6CJIRQK4MEC
         w32S3fmshDmtE4CWwSzCjJmQ81Pmzf5sWgTztk5WSUdK6TibXWor/VzI52NCUe1OFP
         iSOEHkSfWXrbHY/DXN5Xk/Fm0QSaZIeuF7eIUWgBJYmuA7krghxta6PCVq8JXVx+Yb
         Vc93MSCE0NLow==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
Date:   Thu, 20 May 2021 18:12:39 -0700
Message-Id: <20210521011239.1332345-4-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521011239.1332345-1-nathan@kernel.org>
References: <20210521011239.1332345-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we handle all of the sections in a Hexagon defconfig, select
ARCH_WANT_LD_ORPHAN_WARN so that unhandled sections are warned about by
default.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a409967af1..e5a852080730 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,6 +30,7 @@ config HEXAGON
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select SET_FS
+	select ARCH_WANT_LD_ORPHAN_WARN
 	help
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
-- 
2.32.0.rc0

