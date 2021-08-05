Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8553E196F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhHEQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhHEQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:26:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 274C761164;
        Thu,  5 Aug 2021 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180775;
        bh=vaf7IXrO+D43TpfJjrN9eJvnVZ3kEp0F/CUYvNolEU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvcB7rza8W5UD08j4awAiFXK9+iW7HuTy3eDTr5upeXnr++I/jtCE13T3tVomzq2A
         6Fg+Art58sBGqXLPYClmFp8DiyezeRe0ySpfKoxxYOAMM8gzNonViM8Q4KDIdJgZpD
         7K7dx5j3tUmjYOcdYNTzRBzpJdbcxX4M/9PQLeal1tq52i7p80OTfs3lrMem5oEeV1
         Jr/QwdH0KKiVvP0U1lH3Hs3qRNji7SFKE3iIMA3/9Iz2Itx0TmGVZpat505IMhyq4g
         xNiUkM5r/cECyqXaLBWkeBo0+oYDU8ala5blM0iK8CTqYzi9yluVefxuw8veJVCN1R
         lhP03NCvpQRQg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 7/9] tools/bootconfig: Support per-group/all event enabling option
Date:   Fri,  6 Aug 2021 01:26:13 +0900
Message-Id: <162818077367.226227.10144273093794882054.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162818072104.226227.18088999222035270055.stgit@devnote2>
References: <162818072104.226227.18088999222035270055.stgit@devnote2>
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

