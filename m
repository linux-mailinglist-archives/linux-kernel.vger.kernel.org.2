Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68803FF535
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347175AbhIBU6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344797AbhIBU6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:58:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D1EF600D4;
        Thu,  2 Sep 2021 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630616233;
        bh=HWrI6rFLd2/Y9jP7+A8RsUe5lf2U6wY+IKNzSYzswdE=;
        h=Subject:From:To:Cc:Date:From;
        b=i7GiS3L6j2/PtfT3x+w8JVdeEtGJU+1ehYpiF+usA0nhl3E6jlPTKkMn6ZK6ObDrH
         B4+d/AyDu7G0vvk54XShvL3C0XCOCoc2HDjbSeuLO35zsQTJVDz5/koDA5+Wh/YN2R
         Grfg49uwlQqo8vDoqE0TP7IGsPlZQZi312IxBwVn2RORQCxWiK46b2yXtuTkpASISl
         yvMI5rZztTF4IRDBdXatIVpW8kZvoAuoTDdL9Gegxb4RlodRVlT6VgUaqRzhRxc+VL
         TuQXqchT7ffI6OYoUmmLumIiGWvFbrD+Hiw0f+XlJSzsqqT/bvw63omtV/T4T9AmmE
         Mh14NqqLYKcNg==
Message-ID: <d52ae0ad5e1b59af7c4f54faf3fc098461fd82b3.camel@kernel.org>
Subject: [PATCH] tracing: Dynamically allocate the per-elt hist_elt_data
 array
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Sep 2021 15:57:12 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the hist_elt_data.field_var_str[] array unconditionally to a
size of SYNTH_FIELD_MAX elements wastes space unnecessarily.  The
actual number of elements needed can be calculated at run-time
instead.

In most cases, this will save a lot of space since it's a per-elt
array which isn't normally close to being full.  It also allows us to
increase SYNTH_FIELD_MAX without worrying about even more wastage when
we do that.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1


