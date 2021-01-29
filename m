Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3495630866F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhA2H26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhA2H2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:28:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB3C061786
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id md11so5335445pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeN9gKBBM/q6ukcOgQJMkKFDzkcULPM9HldUw032FnY=;
        b=pI+dfoj3vbIoNcfLsrCmQQebn2SGwolZ8tjzCiTRGKAwwDE5Xs45A2wFFQF12m+Eus
         7ohAKzLK85IDFK5UPhdtE2GqbwR78IpQf6FKcTh8sCU/zQdcsiMA0byPRsjXRdDI/zOA
         7yCuxaOuEF1Siu7f4Z7T6+bt+fZYZIIOwGIGfItJrRg5B3purFjXVcRVp1t/DuwKRhlM
         1HSj3MGNSd7Rw9p94fr0QGkDpY9ZgA5C/45kdd0fQ5copfwm/uxGKN1WJqd6wxrboaj2
         tJLzLKDYqMGTbshdtS6cjx0PbdjhSyZReDp3xjjvFi2cZEKVLsKs6wHgggD8dVnQEZl2
         qZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeN9gKBBM/q6ukcOgQJMkKFDzkcULPM9HldUw032FnY=;
        b=bv2SvGpLK6qX3uFDYcck45MSs4Uf5bgn04INM7MwGaMFXvXN/td2QFj1MBKcc/FmHO
         9DjC9TDS0yIC6XsSudGODKmgLPwbgqEjb8T5FlDXrCsxk5QcUEN+DExtuuTjJtCPNRQa
         FxuigRf9uZ+hPl+dbp1v5vVDjn0DYyqZRTSJ90xkwI1O7605NiRyx4QBaalk3rSpyZp1
         3V8fqabC3Z2DXQO44coRuC+w86BFPsU9hxjzIZ+rH8RkpBPzwN9x7iScaTrsgrCe0jJn
         u+pfy7rcnNQ3pfOVxA11WbUfe1/4EzHewq2+RWYVz3Dr9xaoCavCT8aARnHTOmm2Uyn9
         vzQw==
X-Gm-Message-State: AOAM531Pi4OxnoMBI1BJt1qRqcKZfOFctrlgmRucTM+8eLxh7rnHFNp7
        lxGmzFhX6NA/Az0xg4ZoMhOXdw==
X-Google-Smtp-Source: ABdhPJwlNcA/ObZV9DrBR8m57xMt6Jscn9GQvfq8C+a9YnXIKsu1R6FtQT7qU9Y0dtnQTRDtsV0AVg==
X-Received: by 2002:a17:902:744b:b029:e1:2169:6272 with SMTP id e11-20020a170902744bb02900e121696272mr1847825plt.35.1611905258844;
        Thu, 28 Jan 2021 23:27:38 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id m4sm8135093pfa.53.2021.01.28.23.27.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 23:27:38 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH V7 2/6] scripts: dtc: Build fdtoverlay tool
Date:   Fri, 29 Jan 2021 12:54:06 +0530
Message-Id: <4a201dea3ba11a00cab7e936dfc1140dac1a1ae3.1611904394.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611904394.git.viresh.kumar@linaro.org>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay going forward. Lets start building it.

The fdtoverlay program applies one or more overlay dtb blobs to a base
dtb blob. The kernel build system would later use fdtoverlay to generate
the overlaid blobs based on platform specific configurations.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/dtc/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 4852bf44e913..c8c21e0f2531 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,13 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile
 
-hostprogs-always-$(CONFIG_DTC)		+= dtc
+hostprogs-always-$(CONFIG_DTC)		+= dtc fdtoverlay
 hostprogs-always-$(CHECK_DT_BINDING)	+= dtc
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
+# The upstream project builds libfdt as a separate library.  We are choosing to
+# instead directly link the libfdt object files into fdtoverlay.
+libfdt-objs	:= fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
+libfdt		= $(addprefix libfdt/,$(libfdt-objs))
+fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
+
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
 
-- 
2.25.0.rc1.19.g042ed3e048af

