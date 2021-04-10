Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6372A35AA10
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDJBxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhDJBxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED983C0613DB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so4058338pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=TATxB4hoHrl7AuMi8a0DHNb5Kmu8bAxZ3uenSVNb0cGoKSD2LgnuvFoYxXZxuG6Ylv
         8R4qxc7jefszsMNGYvQ8i7cB+naJoUDMQZhAuhEVzZ80sckwsMNHu8JkSdrrvmjLfwS/
         571Zl+M7yxRJ8sDbw4nHC2qHVamBwRwSLCzvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=rgpEZMzVsvcE+9+M934U710ioRo7/CPuniqp6LFfSyk6c2lCGMv+LPItDMSCiFzOwQ
         mxGHKtDXKRh89lkB84mtovPml5VrcDTCS01GWrJolA9u41G7tyQXPnr4+WVs0M+LoN7c
         WcscwqGX5QX3shruqTtFrX36MNK2eSBs2GSjri19Ft4cqlseI4jQGtVKVRyS1OQ/ospy
         cbtN+5tzO4aJRXqRRq8T3ZL0DYonS4j1oeUbRjDz1K53OOoo+wtv3nCI/gL1GLGJ2p17
         pOA2Q7TiY+KKglwaTJA2CI3EGIo6w3QGFCFpqICiWbomTB3bevbMKGOTjzNhH6Q8GQuQ
         hkYw==
X-Gm-Message-State: AOAM531KWh5XmUuFNpNpym4BAvHgDni1t4SrF64uPkyiSgHKW0+MfxDl
        M0YTUUvwHKyRzuuAz0KGXBnO3A==
X-Google-Smtp-Source: ABdhPJzyxldSDP7H5pjBIjRgi6UihNmQETmKqWp+MXziOgy32lArYF2e0Je12WLqqt9es6uEopFuFw==
X-Received: by 2002:a17:90b:1198:: with SMTP id gk24mr16661509pjb.73.1618019589568;
        Fri, 09 Apr 2021 18:53:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 09/13] scripts/decode_stacktrace.sh: Silence stderr messages from addr2line/nm
Date:   Fri,  9 Apr 2021 18:52:56 -0700
Message-Id: <20210410015300.3764485-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
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

