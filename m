Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCE379B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhEKAj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEKAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:39:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC77C061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k5so1141644pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xzqViBvQw9ylVcyAX3gKc2oNS/2BjHDe1lWbNHThZg=;
        b=P4CgVqHUqZ1T/6c5pHIRUKqk1kBLy5erb+S+dGANbmB7deF61jswPoJFn9CeQhyEna
         X4kZ/AY+SlrLWmwlMJXv0ryPhZs7TjMGiutdXqmMKkuPk1uLuzer9Gxu8M1RrB895udW
         NWhh4LCNFdRHrb1veLZsTPoCib2R8MvlYk+zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xzqViBvQw9ylVcyAX3gKc2oNS/2BjHDe1lWbNHThZg=;
        b=WgTcKVGVQEMszpyaL9PcwoOsNOnFFWbWkPFfGtvxqpdF4p5258yYQFczZKnU2uhxA9
         id5+2a5u/gKFOe3yaeMDn+MQ3IZDEyooKXQm6bEm4hZHbVlsUnTokeQIFCmZjBKDAElL
         Yv6vyhi/T1ab/pXB1LhiVRDZVmPLbhOdB1GUyW7eb4OLquDmXWh3qx19MF4EuRgSBwy9
         irXQK2EyOAkVn6rXbnmyjFW8lTKOs37XJmy+dorhd3oFOkFRp8qdGheEnt57QecUddAk
         zvJnK1XNO8rBg141jN5WIamVdGFFTCN6yvMNAIykx5TqEpgsw/sm+F+1nwOjITXMRhv1
         W+IQ==
X-Gm-Message-State: AOAM530RoSXUpzYcZcwM5nSKptkoHMCN9oEdMcJ/mQ8mhS6eI5A4Fk0r
        bWi5KVy6SJ+QFqV+Kgevq2HfYA==
X-Google-Smtp-Source: ABdhPJxak2S+FFzpJnHboF531WwZLczzMtzCVxyWdzuCyBqX3en9JFXPOw+YlDG+bKTwdtDSmVGTLQ==
X-Received: by 2002:a17:902:eb14:b029:ed:6fc3:a42c with SMTP id l20-20020a170902eb14b02900ed6fc3a42cmr26584175plb.26.1620693529236;
        Mon, 10 May 2021 17:38:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:38:48 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v6 01/13] buildid: Only consider GNU notes for build ID parsing
Date:   Mon, 10 May 2021 17:38:33 -0700
Message-Id: <20210511003845.2429846-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
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

