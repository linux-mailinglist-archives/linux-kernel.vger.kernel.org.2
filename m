Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1BD3E50F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhHJCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237494AbhHJCIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 781DD61052;
        Tue, 10 Aug 2021 02:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561281;
        bh=vaf7IXrO+D43TpfJjrN9eJvnVZ3kEp0F/CUYvNolEU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDXqIAtd6FB5Xu0Sp1lXRQL+86uCrGyyhNbbV2yhYWsANIp3JU+mYYsK6NeZZp3dn
         WF34FyxieWwDVGZ7JjKx7JHKyc9eR39YAYqr8kxNRZgWkwGGz9RMLbdtjLdBQSY+Cg
         /OW9ivOIi4WAozF+6y9HdQnBFxplIF7235pEcSGS/AC9A/kB4zB6NtkZ3u+WuL3hHw
         MJYfv9f9LME8EFKvCQg0HSaEbXbTVAlqOvQ/yOYHAGGEnkzr318EltnxVybn2GUFbv
         JCzBg4jIENEdNPwD1mVyTLsXkeIPG8fz9r6ZBpaeQCmk1hD2rns3FdmZEfXtkRGoSX
         4vEdconVUMa8A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 07/10] tools/bootconfig: Support per-group/all event enabling option
Date:   Tue, 10 Aug 2021 11:07:58 +0900
Message-Id: <162856127850.203126.16694505101982548237.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162856122550.203126.17607127017097781682.stgit@devnote2>
References: <162856122550.203126.17607127017097781682.stgit@devnote2>
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

