Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7058133CCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhCPFJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhCPFIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:32 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:32 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z9so11573374iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htX0GqU6SZkWbjYifZPrkAhgQetxZFDFqQT1RkdFhhM=;
        b=NvJlK5Vc7SXd4zJX+hjyeMvmWxmjo6i3aporWqUs3kQ//4UaNZFFlfEjQk4T0CXOs8
         dpYMUpcuZ2fvfpp0fAsZBDam5PK6qKY3AsqTvd9Ywqf3jtTZnPFC+q4+DzdjBr4+D1ap
         RNLfDA3XzemmGdswULlCrdvPVIvXj9HhtYPi7ApXAkyjblIy7c4wMZfektm6+hAdsM/V
         wuEo/WaWMnTArlZjS/ne78InI8fns27nBh+bG0tTnctvPEBxwYeNFMF+/P/lifROwSdC
         X18hk2L7cVd3TyaKdq8QG7v5A2QeGGofn34iemUI4m0xE/2e8TIfuON0oESiDRku6Epy
         Bnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htX0GqU6SZkWbjYifZPrkAhgQetxZFDFqQT1RkdFhhM=;
        b=Mz4xwBTUcFnSUBLUg/Jdif2coQOvi91OCRL2TwtvhZBeZuslwby5lnP0hJcU6IWaso
         Hog/5NSYic1Sirdu8BPG+hfKuVPzJErt6smTsVeXDMvDfSAbbbmdl2i9AlZB/TW83B15
         njEsPrw5aOkCTIg0HMEQPK3x62NbhZtSAd/rK8420r3QCI+hIs3xYYXvnDg+4hsBG/Xs
         41NgsmAP+FF/xY5vRM3z0eDHGgJfdFrJ2dRqCteWKaVW2qQe2/T+NCeSWY+544W6aXK5
         7kqd1Mhj4YT5Zxl98T8ic6GZpSEqF4JLMEo1GuZbBZHdmP++XtNYzaKu03siXNgSGV3h
         yDBg==
X-Gm-Message-State: AOAM533mMlQS6GJ9PrlYHGRIHCL1xaJJjpQE9Z57D+Q6BgKm6p2UyTqK
        mgb8Nt7OcLTFWxzM+/MlZK9aWE8/stOYYQ==
X-Google-Smtp-Source: ABdhPJxj4ANLkTeIFQRNOlR86v3e98NhL883O3qiM89loBj1yd14l1w5p7KmYUXLhWja14gItjv31w==
X-Received: by 2002:a92:cda1:: with SMTP id g1mr864441ild.141.1615871312157;
        Mon, 15 Mar 2021 22:08:32 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 14/18] dyndbg: add ddebug_site(_get|_put) abstraction
Date:   Mon, 15 Mar 2021 23:07:57 -0600
Message-Id: <20210316050801.2446401-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace direct ->site refs with _get(),_put() internal API.  Right
now, _get() just returns ->site and _put() does nothing.  Later we can
replace that implementation with one using ->module_index to fetch
then forget site data dynamically.

Several approaches are possible:

A: !site -> fill from backing store

1st try at this is/was using zram.  At init, it copied each callsite
into a zs-allocation, and all site-> refs afterward went thru
_get/_put to zs-map on demand, and zs-unmap the site info.  This
worked until I tried to keep callsites mapped while they're enabled,
when it gave lockdep warns/panics.  IIRC theres a zram patchset doing
something with locking; I need to retry this approach, even if other
options are better, this might be a validating use case.

B: block store

Another approach is to compress the new linker section, using some
algorithm thats good at indexed decompression.  I probed this
approach, using objcopy, unsuccessfully:

   objcopy --dump-section __dyndbg=dd \
	   --dump-section __dyndbg_sites=ddsites $IMG

From vmlinux.o dumps were mostly empty (pre-link/reloc data?)
and vmlinux didnt have the section.

C: callsite composed from __dyndbg[N] & __dyndbg_site[N]

We know _ddebug records are in a vector, either in the builtin
__dyndbg linker section, or the same from a modprobed one.  The
builtin section has all builtin module sub-sections catenated
dogether.

At init, we iterate over the section, and "parse it" by creating a
ddebug_table for each module with prdebugs.  ddebug_table.num_debugs
remembers the size of each modules' vector of prdebugs.

We need a few things:

- _ddebug.index field, which knows offset to start of this sub-vector.
  this new field will be "free" because the struct has padding.
  it can be initialized during init, then RO.

- a back-pointer at the beginning of the sub-vector, to the
  ddebug_table "owning" (but not containing) this sub-vector of
  prdebugs.

If we had both, we could get from the ddebug element to its vector
root, back up to the owning ddebug_table, then down to the _callsite
vector, and index to the right element.  While slower than a pointer
deref, this is a cold path, and it allows elimination of the
per-callsite pointer member, thus greater density of the sections, and
still can support sparse site info.

That back-pointer feels tricky.  It needs to be 1st in the sub-vector

D: (C1?) add a header record to each sub-vector

If we can insert a header record into each modules' __dyndbg* section
sub-vectors, we can simplify the cold path above; a single sites*
pointer in the header can give us access to __dyndbg_sites[N]

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5529b17461ae..34329e323ed5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -144,6 +144,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
+{
+	return dp->site; /* passthru abstraction */
+}
+static inline void ddebug_site_put(struct _ddebug *dp)
+{
+}
+
 static int ddebug_match_site(const struct ddebug_query *query,
 			     const struct _ddebug *dp,
 			     const struct _ddebug_site *dc)
@@ -239,16 +247,18 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_site *dc = dp->site;
+			struct _ddebug_site *dc;
+
+			dc = ddebug_site_get(dp);
 
 			if (!ddebug_match_site(query, dp, dc))
-				continue;
+				goto skipsite;
 
 			nfound++;
 
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
-				continue;
+				goto skipsite;
 
 			ddebug_alter_site(dp, modifiers);
 
@@ -264,6 +274,9 @@ static int ddebug_change(const struct ddebug_query *query,
 					  dt->mod_name, dp->lineno,
 					  ddebug_describe_flags(dp->flags, &fbuf),
 					  dp->format);
+
+		skipsite:
+			ddebug_site_put(dp);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -633,11 +646,11 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *__dynamic_emit_prefix(struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
-	const struct _ddebug_site *desc = dp->site;
+	const struct _ddebug_site *desc;
 
 	*buf = '\0';
 
@@ -653,6 +666,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (!(dp->flags & _DPRINTK_FLAGS_INCL_ANYSITE))
 		return buf;
 
+	desc = ddebug_site_get(dp);
 	if (desc) {
 		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 			pos += snprintf(buf + pos, remaining(pos), "%s:",
@@ -670,6 +684,8 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (pos >= PREFIX_SIZE)
 		buf[PREFIX_SIZE - 1] = '\0';
 
+	ddebug_site_put(dp);
+
 	return buf;
 }
 
@@ -952,7 +968,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	dc = dp->site;
+	dc = ddebug_site_get(dp);
+
 	if (dc) {
 		seq_printf(m, "%s:%u [%s]%s =%s \"",
 			   trim_prefix(dc->filename), dp->lineno,
@@ -968,6 +985,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		seq_puts(m, "\"\n");
 	}
 
+	ddebug_site_put(dp);
+
 	return 0;
 }
 
-- 
2.29.2

