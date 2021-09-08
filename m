Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9678403FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350414AbhIHTVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350390AbhIHTV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC9761163;
        Wed,  8 Sep 2021 19:20:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36x-0014cB-AH; Wed, 08 Sep 2021 15:19:55 -0400
Message-ID: <20210908191955.156889693@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:19:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [for-next][PATCH 11/12] tracing: Dynamically allocate the per-elt hist_elt_data array
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Setting the hist_elt_data.field_var_str[] array unconditionally to a
size of SYNTH_FIELD_MAX elements wastes space unnecessarily.  The
actual number of elements needed can be calculated at run-time
instead.

In most cases, this will save a lot of space since it's a per-elt
array which isn't normally close to being full.  It also allows us to
increase SYNTH_FIELD_MAX without worrying about even more wastage when
we do that.

Link: https://lkml.kernel.org/r/d52ae0ad5e1b59af7c4f54faf3fc098461fd82b3.camel@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9d91b1c06957..a6061a69aa84 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -508,7 +508,8 @@ struct track_data {
 struct hist_elt_data {
 	char *comm;
 	u64 *var_ref_vals;
-	char *field_var_str[SYNTH_FIELDS_MAX];
+	char **field_var_str;
+	int n_field_var_str;
 };
 
 struct snapshot_context {
@@ -1401,9 +1402,11 @@ static void hist_elt_data_free(struct hist_elt_data *elt_data)
 {
 	unsigned int i;
 
-	for (i = 0; i < SYNTH_FIELDS_MAX; i++)
+	for (i = 0; i < elt_data->n_field_var_str; i++)
 		kfree(elt_data->field_var_str[i]);
 
+	kfree(elt_data->field_var_str);
+
 	kfree(elt_data->comm);
 	kfree(elt_data);
 }
@@ -1451,6 +1454,13 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 
 	size = STR_VAR_LEN_MAX;
 
+	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
+	if (!elt_data->field_var_str) {
+		hist_elt_data_free(elt_data);
+		return -EINVAL;
+	}
+	elt_data->n_field_var_str = n_str;
+
 	for (i = 0; i < n_str; i++) {
 		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
 		if (!elt_data->field_var_str[i]) {
-- 
2.32.0
