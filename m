Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2132974D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbhCAWga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237994AbhCARko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:40:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A29650BF;
        Mon,  1 Mar 2021 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614617799;
        bh=0mV45bypa6kitTbFNkNAkO7c1lm1xmFlqHNzitc9pOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ggzi0VviC3NuE4HjpNpPtA3+WE7sqdMc6ZHjdhGNIYNMHZo6AFFeQsEvL8RLmgdV7
         mgSSkKDWxAMy8rXqmIxz/WLg743YJAckn3xg5TrVvsdn0xPATfgE/axfKCCrWF9wQh
         S77vD/5kZH2dBKDBMgW16kDYuO8+Suta5VCOwBcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 160/340] objtool: Fix error handling for STD/CLD warnings
Date:   Mon,  1 Mar 2021 17:11:44 +0100
Message-Id: <20210301161056.193468152@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161048.294656001@linuxfoundation.org>
References: <20210301161048.294656001@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 6f567c9300a5ebd7b18c26dda1c8d6ffbdd0debd ]

Actually return an error (and display a backtrace, if requested) for
directional bit warnings.

Fixes: 2f0f9e9ad7b3 ("objtool: Add Direction Flag validation")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/dc70f2adbc72f09526f7cab5b6feb8bf7f6c5ad4.1611263461.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1b7e748170e54..1cff21aef0730 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2192,15 +2192,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_STD:
-			if (state.df)
+			if (state.df) {
 				WARN_FUNC("recursive STD", sec, insn->offset);
+				return 1;
+			}
 
 			state.df = true;
 			break;
 
 		case INSN_CLD:
-			if (!state.df && func)
+			if (!state.df && func) {
 				WARN_FUNC("redundant CLD", sec, insn->offset);
+				return 1;
+			}
 
 			state.df = false;
 			break;
-- 
2.27.0



