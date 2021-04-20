Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9173661C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhDTVvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhDTVup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F37C061343
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p67so21692006pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=lpm/F+WMqCTZXp0ehe4/7wEJNgExTU7MOaDCNbgo83BCwneyu0htLqpMrrnECmPXGE
         S5bcxzvviShOYfNDV3n1mo8y3cji4KONnCzTelgD8IkffAdBz9i4ippqo+FKAzN72PHZ
         8/cMg5qFrR+HaC0pg4n2EMayODMpOawzqthi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=p8LYu2MHXl8xeHR5UnoUKKDvPHYjKDN9RZz76rrzwZDt4SYjX9zJTw65GAUWi5zPuo
         rplDie3M0j3PiS679p/WY3tUZ7M4vvEfkvopA998cny90q/JWPoeBorxwHq19gZ8NUh0
         HByi04ohMsGPJiNe7exT5fxY6omDDOWIY0THYIQhpCNhssUZaEjhxpyw39C3UHIaInDU
         SJoDyCSaGsBFrqJiiBoiNTPSlaRJmp+mj6Lywom8sHFEMaD1uSPoDhPR+CU/CLGbFOzU
         3bcH5OfHhrYlhmmMoMOVch2mlkNeQGFed4xxDL3oPSVfD/1gm1Um5scGm0GFDkaNBYrB
         RZ8Q==
X-Gm-Message-State: AOAM530MzXyFvQAkZE5D+Dk69vdLQkFp4yQuLqKz47WV1TZ6FcLT887Q
        gv+AsfahIoybom+b19HSk00vaw==
X-Google-Smtp-Source: ABdhPJzwbW5Lvm5sq3zN+UJKjbF1Es+Fvtik4Guvtx1ESGh/s9I9L1U60Bi+bPSNNvre8NTD6a1zHg==
X-Received: by 2002:a17:90a:2e85:: with SMTP id r5mr7289506pjd.190.1618955412348;
        Tue, 20 Apr 2021 14:50:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5 09/13] scripts/decode_stacktrace.sh: Silence stderr messages from addr2line/nm
Date:   Tue, 20 Apr 2021 14:49:59 -0700
Message-Id: <20210420215003.3510247-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes if you're using tools that have linked things improperly or
have new features/sections that older tools don't expect you'll see
warnings printed to stderr. We don't really care about these warnings,
so let's just silence these messages to cleanup output of this script.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/decode_stacktrace.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index ca21f8bdf5f2..20b5af1ebe5e 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -74,7 +74,7 @@ find_module() {
 	find_module && return
 
 	if [[ $release == "" ]] ; then
-		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" | sed -n 's/\$1 = "\(.*\)".*/\1/p')
+		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" 2>/dev/null | sed -n 's/\$1 = "\(.*\)".*/\1/p')
 	fi
 
 	for dn in {/usr/lib/debug,}/lib/modules/$release ; do
@@ -128,7 +128,7 @@ parse_symbol() {
 	if [[ "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
-		local base_addr=$(nm "$objfile" | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
+		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
 		if [[ $base_addr == "" ]] ; then
 			# address not found
 			return
@@ -152,7 +152,7 @@ parse_symbol() {
 	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address")
+		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
 		cache[$module,$address]=$code
 	fi
 
-- 
https://chromeos.dev

