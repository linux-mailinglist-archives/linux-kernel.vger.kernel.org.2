Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2131A35AA07
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhDJBxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhDJBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:53:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF0FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:53:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so5858783pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2VXPRSzjiKxcTyyAMZiN061Gj8hWE1HEpDUbWdOVnc=;
        b=O3ZDp5T2By6EDjuoVoMz0DjqtkvHqS98WdRbd+SW3hKuuUO4fW3gKgY85X4XrzL14I
         hyPD59vsacJlFh0h95DMJpDj1vdAlf9VNBzVtVbUngQ16fLye4GVpKO7Yur55W2XxfNr
         2rJit8/dxGaxXYoTUAwT43CBzu7A2f+QxPLnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2VXPRSzjiKxcTyyAMZiN061Gj8hWE1HEpDUbWdOVnc=;
        b=ZVhkjOMDZz6yWA4WL2SDUG99poo4ny2MuMrhF8mxW5hyD2GyvrjYUMBwDyD36Z/M/R
         qZJeYLp6Su1aM0bau8r/7mDJtbcplas6T8evd5YHnK7m22gA4gOxVI4XGbUSvZvxbHlR
         6W+uFocVSy4ZpE/hhh2KKoKsaYdRvEu4bsa4bQ3Z/N5fKpOy4j2eT4JbS2h6G5AhTXHY
         tXEIJ7g+eh3JtsI4QmjnsqyiTUGefIQW2guE1N4FnlJx4o4EON9gUW/KkxVL9FztONuV
         EMkaufatJTzXjvioL4eupb2ivPFIhv3MhuBjiBUyXcVnJW1H0I1JTXWkfE0n2bSBBMWC
         vi1w==
X-Gm-Message-State: AOAM533j9RjGmH5CDdGMcz8hVWEPESq8mRbKJNNpdZExiYik1lWjP+5e
        v1Proz3BD5qt54WNiRXEEZ22Wg==
X-Google-Smtp-Source: ABdhPJzHEYchZOH7IAqMXwnIxbAefeNPnuE+SH/valACbMGKoEGhEqXHBdPT6ZLj6sk8ehj7cVa7mQ==
X-Received: by 2002:a17:902:db05:b029:ea:c726:590f with SMTP id m5-20020a170902db05b02900eac726590fmr137229plx.61.1618019582739;
        Fri, 09 Apr 2021 18:53:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5141:7881:7013:743b])
        by smtp.gmail.com with ESMTPSA id n23sm3837962pgl.49.2021.04.09.18.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:53:02 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v4 01/13] buildid: Only consider GNU notes for build ID parsing
Date:   Fri,  9 Apr 2021 18:52:48 -0700
Message-Id: <20210410015300.3764485-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210410015300.3764485-1-swboyd@chromium.org>
References: <20210410015300.3764485-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel elf files have various notes that also happen to have an elf
note type of '3', which matches NT_GNU_BUILD_ID but the note name isn't
"GNU". For example, this note trips up the existing logic:

 Owner  Data size   Description
 Xen    0x00000008  Unknown note type: (0x00000003) description data: 00 00 00 ffffff80 ffffffff ffffffff ffffffff ffffffff

Let's make sure that it is a GNU note when parsing the build ID so that
we can use this function to parse a vmlinux's build ID too.

Reported-by: Petr Mladek <pmladek@suse.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/buildid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 6156997c3895..e014636ec3eb 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -31,6 +31,7 @@ static inline int parse_build_id(void *page_addr,
 
 		if (nhdr->n_type == BUILD_ID &&
 		    nhdr->n_namesz == sizeof("GNU") &&
+		    !strcmp((char *)(nhdr + 1), "GNU") &&
 		    nhdr->n_descsz > 0 &&
 		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
 			memcpy(build_id,
-- 
https://chromeos.dev

