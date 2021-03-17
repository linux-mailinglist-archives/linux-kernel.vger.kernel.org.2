Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356333EA43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhCQGzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhCQGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:34 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C8C061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id u10so508346ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQL/W75MSU0DRUtt9sCf5hnviB9clK/4b2Gzsa0rVUQ=;
        b=fgEt5TCD1ouDC3WcgzFzfvN/XqtDPOc+msQ3IHmiITdnmMj2rFqR+rUJvimsf0h32a
         OYhelOaFRGBfCQZOumaZxFfvZLkLRaKn1CINKfacCbMOSF7f9DYAjuNJ7BILWRxXhYgd
         4M+H4kufII6adBQY7/eq4vHJdl6nx/b5N/BhNwh3T787CwN7CsHreri0EeFunkkkGRv4
         lP0pwz6OSYCJjc+jeeI/gZ4UO9/EjQM9lzJoNTZo3xnj8hGSe110rPUqGzTV6lUdQjPv
         td1VWGgSvhJ8gxIFaUCIoooc+o/GlnYFZ7cJEI2a7eNYptG/JV4H4QjtTpN1hqToyXdu
         RccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQL/W75MSU0DRUtt9sCf5hnviB9clK/4b2Gzsa0rVUQ=;
        b=AFM+wzzA9XJdSy3/YfswZlRkVSk9nT2//EsIw1hfBa8SUNqAeog5toYJxRitciTHvH
         wjqLIYP944s9414HEuAU3Y1Tv6QegrRFi8utldTaUQ8O03IVdK0Inu8aTcWdD+TA3zdB
         7LT4FnlA8P3UXKHQfCIBcSG5fx94coEv477I/i1eCg9Lq/rMz7OJOKEAM7XBGtLk8HEB
         UmXPoJu1MUzNeyxXgswI7XnQ56BAJKwwaxsfnAqjeqpJ79wnRp6CRmdUb+JAqlRp22cs
         Mz9+iT3ad0XNJPIXZM4AiSdASUBnPl6hfn1+Y5dmNstKg/S+4X4DeARYWt/Ge8f1kOYf
         iaGg==
X-Gm-Message-State: AOAM533l4g1ZQZNbhkZU7QPf5BZq1Km1W1VMf9YaujzklckVI946QqPB
        xG1w9/38cFCMRjS2EwR7X1g=
X-Google-Smtp-Source: ABdhPJzCpjcZai5txZjumLQ5WQK/1zhZNEHUlaRH8t4UXeivcBt8xkrg+PHWffNddoj22SSm5Ho5iw==
X-Received: by 2002:a05:6e02:d4a:: with SMTP id h10mr6594164ilj.107.1615964073779;
        Tue, 16 Mar 2021 23:54:33 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 14/19] dyndbg: add ddebug_site(_get|_put) abstraction
Date:   Wed, 17 Mar 2021 00:54:07 -0600
Message-Id: <20210317065412.2890414-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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
index be2e97ae2da9..1f59407b6a83 100644
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

