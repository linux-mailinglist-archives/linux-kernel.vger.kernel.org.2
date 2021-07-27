Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7DE3D7950
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhG0PGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:06:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:36112 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhG0PGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:06:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 067F235022D;
        Tue, 27 Jul 2021 11:06:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rO33TS3xDvKX; Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1D99D33FF61;
        Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1D99D33FF61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627398380;
        bh=fQv+ssPEfb80KwQrmgZZzVl/TASgSkNmpR7L4MAW1TE=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=TPXgSwmI2WB3nCkQ5+2twkNBKFoT+aOlwONgJ3hdT+3hdSSivUMzmderajN4CjpVI
         0v8blfn6j0tU1KN3Lt3S+p+fmVBrEqdjRpKx4pNOFQL5s9Au/OvIYXcpfoG3L2ZNW9
         7K+oAlX0YerB51G8ILGQ+YGVc+3fUz9kZ3my5LQXXE2mnHVwbGmUb8QL6EgemUBaWx
         I6DqGG+UkFslfky8Rv313P/VvsXxwX+Y6pC1ZSdGaRSp/BP8M1e+aq/uKxe9UKCf9e
         9A7/7/U8R6s/9YkZgxy3shhMonje515W1z7GKcDI2v/WH5A6P1ca08hL3r+0GOLV0E
         AhjiYOUOgLfBg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N5OKY4zstxTX; Tue, 27 Jul 2021 11:06:20 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id EB6C233FF5F;
        Tue, 27 Jul 2021 11:06:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Metzmacher <metze@samba.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/3] Fix: tracepoint: static call: compare data on transition from 2->1 callees
Date:   Tue, 27 Jul 2021 11:06:11 -0400
Message-Id: <20210727150613.20886-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727150613.20886-1-mathieu.desnoyers@efficios.com>
References: <20210727150613.20886-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On transition from 2->1 callees, we should be comparing .data rather
than .func, because the same callback can be registered twice with
different data, and what we care about here is that the data of array
element 0 is unchanged to skip rcu sync.

[ Build tested only. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/tracepoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index fc32821f8240..133b6454b287 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -338,7 +338,7 @@ static int tracepoint_remove_func(struct tracepoint *=
tp,
 	} else {
 		rcu_assign_pointer(tp->funcs, tp_funcs);
 		tracepoint_update_call(tp, tp_funcs,
-				       tp_funcs[0].func !=3D old[0].func);
+				       tp_funcs[0].data !=3D old[0].data);
 	}
 	release_probes(old);
 	return 0;
--=20
2.20.1

