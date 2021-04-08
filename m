Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B6357AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDHDHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:07:25 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:42801 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHDHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:07:23 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 13835cFD004262;
        Thu, 8 Apr 2021 12:05:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 13835cFD004262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617851139;
        bh=GpXRb8Xvp/w1GnVfjTpR+YiZfspPXvv4oGzHOYIKuJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=nrI2O1AshjyLr6gExlk9z/rNuTeLwGOkQIvLp48wdJShXAZLoZjnL8cEhKZAYi/RK
         FTqW+fcg6KHfT8A1Hn0mL3KRSTWXZv/eGo+gE0CvmtmcKO5ajHxpiYY7qULQjFgyBo
         UHurizwjEEk+pPIvlIJddKLdbK9p0zXtZp0fk7kqUfTVrN1VBqaOTevXO9kxqSfsKM
         55X0GNJEhIeJOdVqarnt9z7ZAiSmQHxaBdKALOhq3ODwuFGnP5nlZnC0aig21NQt6r
         Shg+ATamzJ/QQtyh/M9Q/1ntijQW0WXLHpcaFhS7oWQ7VdaSdGMfWOEs7OiW2VaQZF
         y/+T0oM17y7gw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove old workaround for GCC < 4.9
Date:   Thu,  8 Apr 2021 12:05:34 +0900
Message-Id: <20210408030534.196347-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/process/changes.rst, the minimum supported
GCC version is 4.9.

This workaround is dead code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 5f8544cf724a..32dd693b4e42 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -181,12 +181,6 @@ CC_FLAGS_FTRACE := -pg
 ifdef CONFIG_MPROFILE_KERNEL
 CC_FLAGS_FTRACE += -mprofile-kernel
 endif
-# Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
-ifndef CONFIG_CC_IS_CLANG
-CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
-endif
 endif
 
 CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
-- 
2.27.0

