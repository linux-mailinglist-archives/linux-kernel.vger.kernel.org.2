Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33CE34F72B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhCaDFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhCaDFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t18so8774432pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=UmCRFjwYapvTg9UaoS02BiUULjjKGFV+ES9mtEcw34/3yR5TTrcNKoJpQ7z0jNcPSs
         pVgRzCkS9F6WmdAHvG6d7xML0ULVKbORRtOhfRGBNPhxy3c58+mi4mcg7DgWo5tBAQYK
         b763U8zEKCdM+EHnxH2/SpLOgnc6KhGgONFWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=ixdWL7wrveoANJXQNwgsRmrlPOlMkb+X58ZUu/8RDTVwUEK94ODjzhkSDqBIQQ9zaD
         7HVSo1064EpeFOVikmLmaZBt+l2KP35yIGqJdFnNxkQQsBZsdvKfatdj7GauTCrkrGRa
         S09/SXS7CLd5RHjBHQkDRWAP1WgpjcDGif6gwG2kZEyUEd5YZGbuEL1W2RoN3Ti1Tzth
         daQ0RPldJxU/4DpUgoxH3YkIiG/3hE8a3bhtjiQ4iWXRNjlla3bfAhcQKBQJq3//WY30
         e7zQZZWKgjxbyg4qJMP/UHY1Y+XBxiSE781F2/VJfrgo2ne1+Yq4CxVGGWFJcwfC+soP
         RrIQ==
X-Gm-Message-State: AOAM5300cr3Tk6/Xbp5f/tuup6qO/cakm+g+Z80UW5SWA8C5An+AKygP
        O+4NIt8J7qzeObRQD1riRGOjWQ==
X-Google-Smtp-Source: ABdhPJy5X0f3GjgV3m/PgKddXAb243IvYjXFz3+iKFAjv9AwOSUTsktYobaFQy90qDqyvMw7rLMEdA==
X-Received: by 2002:a17:90b:f15:: with SMTP id br21mr1365385pjb.234.1617159933491;
        Tue, 30 Mar 2021 20:05:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v3 08/12] scripts/decode_stacktrace.sh: Silence stderr messages from addr2line/nm
Date:   Tue, 30 Mar 2021 20:05:16 -0700
Message-Id: <20210331030520.3816265-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
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

