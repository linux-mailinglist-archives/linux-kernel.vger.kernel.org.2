Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18D3379BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhEKAkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhEKAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA80AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k19so14826142pfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=UABmLGa86YKY8UY25Ew/P+Do/oOF1ylDP+T1fpwJCHj65bEStDLFMj5R522Iexrcs8
         R89Z53QA7d9gafkZdC2q2WU/Ml/rdAVgLNU7TTDCdIZ1y9W25LQbsyXOqPZ3jHl6v7Zp
         7/kGquGcTkbJ2JqqzLhYjeglvZQjv/85yEBEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=NdUZkKjJAeQkFVZn13R3KpAneUkkljMDwEa5KukRgk8nq1kBLh3ra93+KqtFf0SuFl
         9oJaS6v6ppFogyEfuf0WjR+cVdQtrIPMBzBPyDvRVIzI+WhPaffbnI1F1NpIIb7lm3AB
         JGjSUZs3AiLB4u0VS9pvkdVqGiQ0vIFmFX1A0i/9dRIVS2vJuAWoMAfg8vzmyImkDZLC
         Hzzq4Y/SsOjHJLK2cQ1tvbkLGuZDxA4dR9/pgvG1cLN7+EZYdpJy1L3j8vMV3Px8VHDC
         A9gNTiWlM1YaRoNnvzP8wnN3bW5H/NqtfeQFP+F3T+wx9XlFi4PYypzYKWyxJ8LyHYCC
         qUsQ==
X-Gm-Message-State: AOAM533M6ssBwm2yj0hlL784N92gtPrrq/qHUTrFTRo8QHIrHK98iX4e
        yYXm+V1It78GDQPWz3jk3D7S7g==
X-Google-Smtp-Source: ABdhPJwlbq5Erysg4tR1GRvEjxnsVbOdM7Rat44//6Fybw/5Dl3hHIOD1jz0PXDKCcYRxxdGxPQdgw==
X-Received: by 2002:a65:640c:: with SMTP id a12mr27448438pgv.229.1620693539278;
        Mon, 10 May 2021 17:38:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6 09/13] scripts/decode_stacktrace.sh: Silence stderr messages from addr2line/nm
Date:   Mon, 10 May 2021 17:38:41 -0700
Message-Id: <20210511003845.2429846-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
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

