Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC730866A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhA2H2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhA2H2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:28:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24605C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l18so5888146pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYJHN29z38YJQy9+aRfXhxK7SVaDLVhX0WgONtRAors=;
        b=yU7MgniEnfF9zCaYCDMrurU7l+NtPr041utDGm17Pg5UIy3s5OGmry2lc8O29PJmT2
         LVX5bNWr3SeXgrQQt2zy40u4iO/yYn/yBy4oBbIpholxrlpaKjCl14vM7Wt+It4ip2sO
         2/EbYlvkfSWhF1Qo+CXfXBQEDd5xyR39ZYqaYzb4Z0fdOVBqXppSBEQkf8HD7TG7D6Zu
         LXPXITbgqPsJtiXb9mNcVFG6w/GkRS5rw0AL+VGfBTshjiJix9WcbmzhtyrnpQDKNOw2
         1pYbKPpLDjojhi2zFLNqORo+babfbQdNoiNcbBqbJherujYjpWMmXFN5dYl1tzKN7Cxg
         XT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYJHN29z38YJQy9+aRfXhxK7SVaDLVhX0WgONtRAors=;
        b=KNVOZx9XVgqTk06KSikvykLnUp9Sy/PlmNYGFy66QPxw/QcZjEHAfVbiBY62JyQQjO
         4vQkv7w7ESp11lnUo0/ahQp81uqk0QK5KTkELkQnu7ydBF4nKgfZPregjaIDhMD36D7H
         cUpOrrDDuCUDZs1iyvQDAeuP+kJMy7vYtbHPh3ohX2RhmColoEG34USnL9d5Y4WZb5An
         TtIFYAeSCjDMKk9L3uaBN+K+QFoaJo6kZQPKpA+0IYy9/cTXJzGXqsnIH3U9RLsldaQ7
         NFwLBDFsWFjmfNBs2W92f64HBikb9Hdx0neFPkZAdPFtf+wehrtKifjYtBcB29F0O55k
         lmGA==
X-Gm-Message-State: AOAM533aR2p4rBFvkC8iBDJ+7OdKRtMqjbogETs+RWXUMtQs+kJ53CMV
        ez7vNOAThBqiMcP7Hequu1DLJA==
X-Google-Smtp-Source: ABdhPJws1roV148IFu98NKdHdqjP8FiHkK7/XAlar2nEQlKWPyAxzubYcgHi2GyNXyCx5UADkv+Ylw==
X-Received: by 2002:a17:90a:dc01:: with SMTP id i1mr3192662pjv.134.1611905255766;
        Thu, 28 Jan 2021 23:27:35 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id v31sm8494685pgl.76.2021.01.28.23.27.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 23:27:35 -0800 (PST)
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
Subject: [PATCH V7 1/6] scripts: dtc: Fetch fdtoverlay.c from external DTC project
Date:   Fri, 29 Jan 2021 12:54:05 +0530
Message-Id: <28f66f70602225bb6aeb58e924c20bde9d864327.1611904394.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611904394.git.viresh.kumar@linaro.org>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will start building overlays for platforms soon in the kernel and
would need fdtoverlay tool going forward. Lets start fetching it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 scripts/dtc/update-dtc-source.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
index bc704e2a6a4a..32ff17ffd089 100755
--- a/scripts/dtc/update-dtc-source.sh
+++ b/scripts/dtc/update-dtc-source.sh
@@ -37,6 +37,7 @@ DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c
 LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
 		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
 		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
+FDTOVERLAY_SOURCE=fdtoverlay.c
 
 get_last_dtc_version() {
 	git log --oneline scripts/dtc/ | grep 'upstream' | head -1 | sed -e 's/^.* \(.*\)/\1/'
@@ -54,7 +55,7 @@ dtc_log=$(git log --oneline ${last_dtc_ver}..)
 
 # Copy the files into the Linux tree
 cd $DTC_LINUX_PATH
-for f in $DTC_SOURCE; do
+for f in $DTC_SOURCE $FDTOVERLAY_SOURCE; do
 	cp ${DTC_UPSTREAM_PATH}/${f} ${f}
 	git add ${f}
 done
-- 
2.25.0.rc1.19.g042ed3e048af

