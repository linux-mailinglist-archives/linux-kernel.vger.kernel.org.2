Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5823E4931
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhHIPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235816AbhHIPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26A8C6101E;
        Mon,  9 Aug 2021 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524123;
        bh=vaf7IXrO+D43TpfJjrN9eJvnVZ3kEp0F/CUYvNolEU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS++zJTKNf/DIHpEdXKcsG7C55Fotq0O7WN36X+vkD+nr9T3UgcchOumKrzYWThlt
         +Tj5Tx90okVNQ8R+ppnVfamx8leEnxPh4KrrzMKA9nrB/UzbvI2yhPve8psHnbhymy
         lk0cNaBJRH+CjiZUD8to5vi5M0NzN5aRGkSeR1yNuJT2XGzJoLG7zwAh99/I+ND0qQ
         OvX6ijY8W0xz2XwI+PlO2r9IBDsYflLF0KQ2DlmtCzz/9kLIr1qrTjLxyaWY5P5KTV
         M18gaOtt/BMlg2Wt1/aM0O0wO8LFTRUwDqmPITkdjDIoUeYI0k7MW/Oo/ufPwuQB1U
         T0pOyFqLvgkLA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 07/10] tools/bootconfig: Support per-group/all event enabling option
Date:   Tue, 10 Aug 2021 00:48:41 +0900
Message-Id: <162852412145.143877.6394144627145731780.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162852406891.143877.12110677006587392853.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index feb30c2c7881..651049c782c0 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -101,6 +101,12 @@ setup_event() { # prefix group event [instance]
 	else
 		eventdir="$TRACEFS/events/$2/$3"
 	fi
+	# group enable
+	if [ "$3" = "enable" ]; then
+		run_cmd "echo 1 > ${eventdir}"
+		return
+	fi
+
 	case $2 in
 	kprobes)
 		xbc_get_val ${branch}.probes | while read line; do
@@ -127,6 +133,13 @@ setup_events() { # prefix("ftrace" or "ftrace.instance.INSTANCE") [instance]
 			setup_event $prefix ${grpev%.*} ${grpev#*.} $2
 		done
 	fi
+	if xbc_has_branch ${1}.event.enable; then
+		if [ "$2" ]; then
+			run_cmd "echo 1 > $TRACEFS/instances/$2/events/enable"
+		else
+			run_cmd "echo 1 > $TRACEFS/events/enable"
+		fi
+	fi
 }
 
 size2kb() { # size[KB|MB]

