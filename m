Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768D04078CC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhIKOaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhIKOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:30:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C75C061574;
        Sat, 11 Sep 2021 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GEqRQ9y9a9MIz3wuwpdSf+YO6+ZP1yLEjSzwiERQLUE=; b=bQxDj5+rnE36snGRjDajJqf702
        Z/ThVOWXP8sAy/mxc8S7d11dASUIcJBUH/RZsc9LuNBWPy7jVTRpIUKTUUHkV+Wvddewz6jC8bdOm
        AAaHwGiDHO0LSG9DGs3ksvKPw9cJ29ni/DeCf6m26D135Tw57yDh5NnqUz0iF7NRAcXxSfW86xbU1
        3VflL6UBzeTc5DBrje7LICjquuUnqUDo9X+erTBQh0QXS3lr6sz42SWxhoGBFjP+T3xlhRdx6qFM6
        YVtvWy/k3z/6HcoBloGBtjh9xgSLb6DUA++mlK7KNwbZxTE0+qETwNQ12s8ViEBAj/RfvHGT32b44
        2fJYgYjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP40B-002OZ9-1G; Sat, 11 Sep 2021 14:29:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6604E9862C9; Sat, 11 Sep 2021 16:29:05 +0200 (CEST)
Date:   Sat, 11 Sep 2021 16:29:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, x86@kernel.org,
        linux-toolchains@vger.kernel.org
Subject: [PATCH] Makefile: 'Promote' -Wunused-but-set-variable to W=3
Message-ID: <20210911142905.GZ4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Upgrade -Wunused-but-set-variable to W=3 to avoid the build robots
sending endless spam for this garbage warning.

By promoting it to W=3 the robots will no longer report it and people
will no longer attempt to fix them by making the code worse.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index d53825503874..6686cc587d3b 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -28,7 +28,6 @@ KBUILD_CFLAGS += -Wmissing-format-attribute
 KBUILD_CFLAGS += -Wmissing-prototypes
 KBUILD_CFLAGS += -Wold-style-definition
 KBUILD_CFLAGS += -Wmissing-include-dirs
-KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
@@ -88,6 +87,7 @@ KBUILD_CFLAGS += -Wredundant-decls
 KBUILD_CFLAGS += -Wsign-compare
 KBUILD_CFLAGS += -Wswitch-default
 KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
+KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
 
