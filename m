Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9A3BA942
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhGCPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 11:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhGCPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 11:37:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 477DA6161E;
        Sat,  3 Jul 2021 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625326521;
        bh=v12eb72egTXGRlWePIt6/447N/jAOeFwRe4l3/n4s4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6Uo402ut0NQfNvNx3Kkb/41rXOyumsg8PmLzOXxidW+RD87QOi2JRkZ/iZjbW4WL
         KZqwpupmAfS7ymtzKUbyLiwuib5BfBixecE5qapTXxAHrdEgD6ukzwPP1j0zyi44ZN
         LACa0oW8PPY6Kki6Y7n+T97p0zw4jHzJK4dzAlN0RVuaV7qa7qSICW34xkFt1qd4P9
         twypupb2S/w76YyaLvlq9Xaa43/1QCHTX8eJHPX66OWV7+woWTahoKfWLO2128S6tM
         zQZ5cO9f1lXdT6sp5UVvNkyMsaUg/QHMgxXvA3GUJNAzt/be+SmRDkFLz6Qy0+Ga/B
         STNyM5UPXAlmA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf-probe: Fix debuginfo__new() to enable build-id based debuginfo
Date:   Sun,  4 Jul 2021 00:35:18 +0900
Message-Id: <162532651863.393143.11692691321219235810.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162532651032.393143.4602033845482295575.stgit@devnote2>
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhriamat@kernel.org>

Fix debuginfo__new() to set the build-id to dso before
dso__read_binary_type_filename() so that it can find
DSO_BINARY_TYPE__BUILDID_DEBUGINFO debuginfo correctly.
However, this may not change the result, because elfutils
(libdwfl) has its own debuginfo finder. With/without this patch,
the perf probe correctly find the debuginfo file.

This is just a failsafe and keep code's sanity (if you use
dso__read_binary_type_filename(), you must set the build-id
to the dso.)

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhriamat@kernel.org>
---
 tools/perf/util/probe-finder.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index b029c29ce227..02ef0d78053b 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -118,12 +118,17 @@ struct debuginfo *debuginfo__new(const char *path)
 	char buf[PATH_MAX], nil = '\0';
 	struct dso *dso;
 	struct debuginfo *dinfo = NULL;
+	struct build_id bid;
 
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
 	if (!dso)
 		goto out;
 
+	/* Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO */
+	if (is_regular_file(path) && filename__read_build_id(path, &bid) > 0)
+		dso__set_build_id(dso, &bid);
+
 	for (type = distro_dwarf_types;
 	     !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
 	     type++) {

