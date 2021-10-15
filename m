Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF242FC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbhJOT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:58:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:44090 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhJOT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:58:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9699E251023;
        Fri, 15 Oct 2021 15:55:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9wT8PKr05D3g; Fri, 15 Oct 2021 15:55:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 68186250DA7;
        Fri, 15 Oct 2021 15:55:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 68186250DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1634327755;
        bh=MXGjdD09LWEfTk5KuZoTHi2rl/afydBcqYhBo/MudXs=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=ViP7H/rAcPgzGpDd3/cCsVe6gUqfMuyvuggtcXOo++YK6CVxBtEKuJGFFoLefvfgW
         /0AIiF1AlyJ63hyB6HK8VcS50NSVeeto9zSugzlggPD5fqucWwcZtIWGwuosh5VFU3
         o7yyL9ttNMU6+6hLeUEOOnGyLBQrHW5Ln3gFhK9hmgx649xOn3rCJmXhA06kIwd6JT
         AmdTmgHkzR1PwVwPHIttUfv2JKLazDl39A/FVOg7MB7BaErEc+Al8E940OO9xOYMgj
         oWOgLyvvFyzq+pJ4SZrlVYDronTieU0Z4lHwotPjgKxlG3qsXpkgqmeuCnT4WjLfBz
         g1OOVqXXlZq1w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 54CW4Fcd6RAd; Fri, 15 Oct 2021 15:55:55 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id 4D41C251110;
        Fri, 15 Oct 2021 15:55:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix missing trace_boot_init_histograms kstrdup NULL checks
Date:   Fri, 15 Oct 2021 15:55:50 -0400
Message-Id: <20211015195550.22742-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_boot_init_histograms misses NULL pointer checks for kstrdup
failure.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 8d252f63cd78..0580287d7a0d 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -430,6 +430,8 @@ trace_boot_init_histograms(struct trace_event_file *f=
ile,
 		/* All digit started node should be instances. */
 		if (trace_boot_compose_hist_cmd(node, buf, size) =3D=3D 0) {
 			tmp =3D kstrdup(buf, GFP_KERNEL);
+			if (!tmp)
+				return;
 			if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply hist trigger: %s\n", tmp);
 			kfree(tmp);
@@ -439,6 +441,8 @@ trace_boot_init_histograms(struct trace_event_file *f=
ile,
 	if (xbc_node_find_subkey(hnode, "keys")) {
 		if (trace_boot_compose_hist_cmd(hnode, buf, size) =3D=3D 0) {
 			tmp =3D kstrdup(buf, GFP_KERNEL);
+			if (!tmp)
+				return;
 			if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply hist trigger: %s\n", tmp);
 			kfree(tmp);
--=20
2.20.1

