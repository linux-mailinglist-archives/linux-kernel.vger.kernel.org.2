Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A704D3DE53C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhHCEZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhHCEYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:24:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACC9610FB;
        Tue,  3 Aug 2021 04:23:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAly7-002qnR-Tg; Tue, 03 Aug 2021 00:23:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 09/21] libtracefs: Add line number and index to expr structure
Date:   Tue,  3 Aug 2021 00:23:35 -0400
Message-Id: <20210803042347.679499-10-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to have better error messages, record the line number and index
when an expr structure is created. Then this can be used to show where in
the SQL sequence a problem was found if the building of the synth event
has issues.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-sqlhist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index 933b3609733b..887c2441a39e 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -72,6 +72,8 @@ struct expr {
 	struct expr		*free_list;
 	struct expr		*next;
 	enum expr_type		type;
+	int			line;
+	int			idx;
 	union {
 		struct field	field;
 		struct filter	filter;
@@ -300,6 +302,8 @@ static void *create_expr(struct sqlhist_bison *sb,
 	sb->table->exprs = expr;
 
 	expr->type = type;
+	expr->line = sb->line_no;
+	expr->idx = sb->line_idx;
 
 	switch (type) {
 	case EXPR_FIELD:	return &expr->field;
-- 
2.30.2

