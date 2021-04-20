Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A589C3661BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhDTVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhDTVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:50:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93AEC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n10so9286700plc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xzqViBvQw9ylVcyAX3gKc2oNS/2BjHDe1lWbNHThZg=;
        b=OtyAl1AGgZByCAiagwNn/q6lTf+8JsoiPSKsNtED09CG4XtELE14tVG/ArnCByypSS
         Og3aVZZppUKBRwVM/AlfoYmV+Q11snaYuFCFA27yiTP64LcQH6l8uFUaDfw0K+vJqHN9
         9q50IdbfPMs6LkCUxdFpdx68nR3vSaQOZvbxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xzqViBvQw9ylVcyAX3gKc2oNS/2BjHDe1lWbNHThZg=;
        b=peuDa6ehYPryaHre8bzRlBTkyYhMFovVvqVGw+NvQmb+by9m8i74S7TkL+T8RKQefn
         7kyH4zpzDEEdctn0gqiSdfBNr/m+j04sKAMJajyGfpi8OSoL8xc3FPkNOP2zVNZ304tu
         s4azLP0c1ks6XGdhFxFTNLuHKvvTHJdq0jhaSEisFthtqAZZje38jrZwDoMbYPB9ToKm
         dSfmEqTeBKuPQgD3Ot/EAJOiQxLESukcJVQzootoDVMLoLnUVBnl7Xo/HE3uk6cZJEZa
         Vnv+GgheiwsZ6j0zyccqHTKkXIh+VJdKvQROK4j9pi2N0uLF6/SjL7uxSejULU5bsTjO
         kkmw==
X-Gm-Message-State: AOAM532jTRI3kJ0xeuoy7RnBp0U4rH1c7I3N6xcU7ugK5FCyb/3JHV09
        /YxwmIsnyIPDHa4LNLrqdORT2A==
X-Google-Smtp-Source: ABdhPJzadlPs2pwi9X0AWDKNNSFmvh5WFJs0ezxsO6uIRNviuyv1X9zNq9+PzzIQuSDDZjJ+JO499g==
X-Received: by 2002:a17:902:ac89:b029:e6:d199:29ac with SMTP id h9-20020a170902ac89b02900e6d19929acmr30821425plr.46.1618955405560;
        Tue, 20 Apr 2021 14:50:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bf8b:4b8b:2315:3719])
        by smtp.gmail.com with ESMTPSA id c21sm31481pfo.91.2021.04.20.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 14:50:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v5 01/13] buildid: Only consider GNU notes for build ID parsing
Date:   Tue, 20 Apr 2021 14:49:51 -0700
Message-Id: <20210420215003.3510247-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210420215003.3510247-1-swboyd@chromium.org>
References: <20210420215003.3510247-1-swboyd@chromium.org>
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
Tested-by: Petr Mladek <pmladek@suse.com>
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

