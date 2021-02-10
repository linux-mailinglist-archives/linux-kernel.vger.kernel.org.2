Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6AA317497
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhBJXnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhBJXnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:43:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4491FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:42:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l18so2150396pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFikYFwybT43KhfwAWuo5Uo1WoOz2TApfJ3bBww9mwg=;
        b=VG+XyCeqy1PsosZzW5tG9X0j+Wqu5CcJdhDlTwWzgW7dE+AO5liTnjqnmHfNdJKQlW
         VDDlJWx6hPnV/d/nlK1UoDfmEzj/BxLHSK3BiNnLlFZMspPP05wCFBu1NZZoToSXXxn4
         lJWt54Piiwz5BdqFDI2n768KxNZZyGW0OSVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFikYFwybT43KhfwAWuo5Uo1WoOz2TApfJ3bBww9mwg=;
        b=KlTiHqr5S025NGlsC/KdZQ+R6oEPvZJmxlUPE0GP6ahsAc1hZ0TcmGrsX7pA4oDSTD
         EQkFEobmH52y8r+G5ngW9ZsRoIqNKNx9nv7fUhQ2zzLW//KtJmxdU6GA42wJ0pQ7T2ig
         1f1lg1jl8eovPg8AKvOColL78p95Ar2HMGbTdx6y4cyiJdhtO1pcvhwJc4ZrZbrFOGLD
         oe6QPJuI8HikyiNErAlenWMuhBekAqjI0BZQBPH7YQhO4sCikL0mJGgrFUIY6kaA1+sT
         caYkNGSSxsCVESrEzN8dq2oSDcEoit1D1bdxXbJYs0EFVsDwyEdTy8O/oMse3hSOUX8t
         IbbQ==
X-Gm-Message-State: AOAM533Wa+ylZtXcf5GrRhCMdxZ0+9XJH39lPUtHtNYljoN8xE30RIbP
        CvfiXLrEdyoUjVlGikmDxWBpIw==
X-Google-Smtp-Source: ABdhPJyVuOlyDCyajLNByOoKnfYyZbrMcDVvFbAy758bYFE4fFnjItMCFdOlA6gf0ugS1O0JJVYRcA==
X-Received: by 2002:a17:90a:5217:: with SMTP id v23mr1302071pjh.126.1613000543878;
        Wed, 10 Feb 2021 15:42:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm3351670pfn.5.2021.02.10.15.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:42:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] perf: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:42:19 -0800
Message-Id: <20210210234220.2401035-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=d89e1266230a4146f32e045cbb1d10e6aa793c24; i=kibymBR3NWr0zhqACHK8V2XQBH69LDXy/fMY3ecCoOs=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=lVAPWxEVH+HmwgFOp4zCtDYuv+gQKMjZjkfptTz19L0=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkb1sACgkQiXL039xtwCalgw//eKt hNC9Rz5Cbt+D94sUvysx3qABbTcQ1ga57rjVfAWGMuIrbtMDr5ajIY6Gf8KIkNJC/QZu+fIjNaTrj 8ZUZR8IFPW2FEQjq0V0i/WI28SZiZeucpHR1TeSxo0xIs6Rno8vmMLepkQMUoA1PeQuPYj9QwIUT2 KOIVPh7wEBZvmVpK6VuVtIAI4eQpFAyYwQg9zNPvIlmVS/R2lDkGEaM/Qzl3kN2lFuyFgEGV4ClwW YH6WscsQ4OQzg20ZXe6C5vuSooHhw/cG51Ee0f69nEOUL4EnN5kYoC2RHScFQpSuEkV4PjhNZaJVM d6FHl6q/pK7r6YULSJWU/PNKubo+z3fE0SpselcTJ6/rCCfGiH/iAhjQldrn5emie/+eVn4OD/5Nt KYq/JX1YVKcAvsisk1MoamhzVXOvP4eNL4v3NFtXhXSRSlANheDNod3xNvwCC+rqMSjXWZ+heYpDt 0oU8bRdvhVWsufzN4b0kFY28J/nysrlMVpkVRWakZO4w3koQuMZDmzVmxinD6FqTbjUrfgl2KvJjg h9LWDAxWVLpwy6m8ybpYBzlZVHbPCAjlrnNhDTBCijDFXg0SdV2eqxvSAIxSXqCeDdDgqJJ8HLmCe CVyUXukhtYWLR2tPvz2TCT/W6JQxZNlMhGNt9h5/Gs8JaOhCyLZnCWqgZ5MWBnw0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/perf/Documentation/examples.txt | 2 +-
 tools/perf/util/data-convert-bt.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/examples.txt b/tools/perf/Documentation/examples.txt
index a4e392156488..c0d22fbe9201 100644
--- a/tools/perf/Documentation/examples.txt
+++ b/tools/perf/Documentation/examples.txt
@@ -3,7 +3,7 @@
 		****** perf by examples ******
 		------------------------------
 
-[ From an e-mail by Ingo Molnar, http://lkml.org/lkml/2009/8/4/346 ]
+[ From an e-mail by Ingo Molnar, https://lore.kernel.org/lkml/20090804195717.GA5998@elte.hu ]
 
 
 First, discovery/enumeration of available counters can be done via
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 27c5fef9ad54..8b67bd97d122 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -948,7 +948,7 @@ static char *change_name(char *name, char *orig_name, int dup)
 		goto out;
 	/*
 	 * Add '_' prefix to potential keywork.  According to
-	 * Mathieu Desnoyers (https://lkml.org/lkml/2015/1/23/652),
+	 * Mathieu Desnoyers (https://lore.kernel.org/lkml/1074266107.40857.1422045946295.JavaMail.zimbra@efficios.com),
 	 * futher CTF spec updating may require us to use '$'.
 	 */
 	if (dup < 0)
-- 
2.25.1

