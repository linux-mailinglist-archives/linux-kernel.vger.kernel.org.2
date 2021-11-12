Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7944E5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 12:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhKLMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhKLMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:02:24 -0500
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Nov 2021 03:59:34 PST
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FDDC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:59:34 -0800 (PST)
Received: from sas1-4cbebe29391b.qloud-c.yandex.net (sas1-4cbebe29391b.qloud-c.yandex.net [IPv6:2a02:6b8:c08:789:0:640:4cbe:be29])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id BBABB2E1B03;
        Fri, 12 Nov 2021 14:57:58 +0300 (MSK)
Received: from sas1-9d43635d01d6.qloud-c.yandex.net (sas1-9d43635d01d6.qloud-c.yandex.net [2a02:6b8:c08:793:0:640:9d43:635d])
        by sas1-4cbebe29391b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 0QQVcukGiP-vvsOJjRX;
        Fri, 12 Nov 2021 14:57:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1636718278; bh=R5ZMQRibNY1OTxEqQuPKVv6aMPzqNjPhHpcY4O16Fpw=;
        h=Cc:Date:Subject:To:From:Message-Id;
        b=zNqxj5Kj7DY1vOxGz0i9FPUTFU3ZMElDliDEWLUhr/zjCNq1x1M5HN9QqcSeCqkvH
         SLXQGkC0ZaWPKyRZxgHVb9tt+d9Qww7Xa+es+8Ql85+B/e2BcM8hTW7w/7iHIrFG+K
         008P5iWpwNrSggJZolNDH03VGJMme9HYqtWa6FPI=
Authentication-Results: sas1-4cbebe29391b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from oleglatin-nix.yandex.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:b88a:7e5d:6e3a:bd70])
        by sas1-9d43635d01d6.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPS id oJ6Nrfjt7U-vv0KuQYw;
        Fri, 12 Nov 2021 14:57:57 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Oleg Latin <oleglatin@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     nfraser@codeweavers.com, jolsa@redhat.com, peterz@infradead.org,
        dmtrmonakhov@yandex-team.ru
Subject: [PATCH] perf: add missing cpu entry in json output
Date:   Fri, 12 Nov 2021 14:57:38 +0300
Message-Id: <20211112115738.175001-1-oleglatin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After converting perf.data with 'perf covert data --to-json' the
resulting json file missing cpu entries:

	{
	    "timestamp": 5716840788599,
	    "pid": 79661,
	    "tid": 79661,
	    "comm": "python3",
	    "callchain": [
		{
		    "ip": "0xffffffffafd05fc0"
		}
	    ]
	},

Seems addr_location::thread::cpu is never assigned during
machine__resolve() call. This patch uses addr_location::cpu to store it
in json file.

Signed-off-by: Oleg Latin <oleglatin@yandex-team.ru>
---
 tools/perf/util/data-convert-json.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index f1ab6edba446..b0e3d69c6835 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -168,8 +168,8 @@ static int process_sample_event(struct perf_tool *tool,
 	output_json_key_format(out, true, 3, "pid", "%i", al.thread->pid_);
 	output_json_key_format(out, true, 3, "tid", "%i", al.thread->tid);
 
-	if (al.thread->cpu >= 0)
-		output_json_key_format(out, true, 3, "cpu", "%i", al.thread->cpu);
+	if (al.cpu >= 0)
+		output_json_key_format(out, true, 3, "cpu", "%i", al.cpu);
 
 	output_json_key_string(out, true, 3, "comm", thread__comm_str(al.thread));
 
-- 
2.25.1

