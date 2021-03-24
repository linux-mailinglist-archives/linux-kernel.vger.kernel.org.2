Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A69346F36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhCXCFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhCXCE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:04:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36074C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so346268pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=Cn0B21J23pzQidKwR37+K7imoRuEatFWxJMHNduAvnVnAn+8Re81lNGX8ohV2hiNL1
         F3beFd2xxLBwGrHtxBMBXpDy7HGcfTXeP5p2ao44UhhfM+yPB1JyQSOCEOaEUMBi9dhh
         9H0ANL5dV6GZWtVAEsHiqHdalKf9ABPJHh1bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/ZASyQfX+/tqRIkOrBGq/AZs5OIA35OUiNyEj7G8I4=;
        b=hty0KcezmzmpsAqVxUkXCgeFI+6oF3HsrJdo8+5LpvuGbDz9cK91q/2ywXE7lcouw9
         yE6q/4hktuLSrpH5WV8Hm0GkEZiA3w+eIwU+pFaKWBIGUmmC7sBEaoU2ff78+DPAlZWX
         wYtQTw+JjzoqEbats24aH/6HEGUtkTgDsukzsz/UCfW5ztruQVjhV+HSNHQFvNqzYG9Z
         gHdi4yji5jqi5AUfpRNASQbCZ9DZdNsbzZ/ijmLZAux7QZoBqi/jRAmf8rBrxSIackwT
         mNGtAaGaClszQRnALHP8jvi5a5LlsJwY2YzOjK9CsjcmHrgxCkclXnrPCuPmxTpQsXz2
         t56w==
X-Gm-Message-State: AOAM531mgXWZ3VQeaR56KhQL4Bsy8REXqRBQ0MCPCDzLnwZxrWXZ1xqS
        YAyTp/sg/o/1Se1M7X4qk+EiCw==
X-Google-Smtp-Source: ABdhPJx7DpV/r90bbbYA76MMMDcIpEuAkqtl3YWChrd/8DE9YDktkia/MELWh4db2qszcn7lHAVCZA==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr1018843pjb.46.1616551496836;
        Tue, 23 Mar 2021 19:04:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 08/12] scripts/decode_stacktrace.sh: Silence stderr messages from addr2line/nm
Date:   Tue, 23 Mar 2021 19:04:39 -0700
Message-Id: <20210324020443.1815557-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
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

