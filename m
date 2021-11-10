Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8337744C8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhKJTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhKJTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:31:13 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:28:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j193-20020a636eca000000b002dd417e52dcso1968560pgc.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/aWGND/F6ntziI0dW8iiRvhFG8if0Tsmgz/yjRc0t6o=;
        b=aCmYaF00W3ZOH8BdtuQRW/ZznVRVppyQM+/NgmQday1lfncZRDwqRjNbrqBuxLGulP
         Q6tERg2CkVtUOHws5Vdt/0C+rMeOCCr3Gyoch+LStVoKhEoA6Ef4Xg2jM2ex4H5bsNL/
         sy+nKnYvOflDgBk1x8aOZXyuRZPzHVpjA+QAjiQ9yFIZChHGLvkituphgOcGeVAX29Cp
         ZfvsV4k3lcxJl8DNn53Pt3q4sWEfpCcdzgRSb2YKt4Z8Ti3WhsSZkG8VW5N2ewP4JONe
         SwNgY/WHDMMbU2ObsheCR78kEKOrjN4LSwFLHujdzpWxuwwSzdyZdrTSfce9+sNqgxY3
         iUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/aWGND/F6ntziI0dW8iiRvhFG8if0Tsmgz/yjRc0t6o=;
        b=xx9g+PTvW2Jn+pKXNJ6KBQyVGVJteNR6boRVOA7WTW8Icsr0+AK8vRXzA8Ev+/51E3
         VglqEJyzZZMldfOWtzDEz5t2uq/olyoRIBrB3Ij2Elye7QTcUKM64LOI7yYpE++LxIxV
         biC7idCOJybfa7hQPAFFlMPSYz7Vnme6E3vVi2eu7E17VFJby63xdvne9eQwrGY6ta+I
         filxm+pcZ5tQaFZme6mSCU8ppIngxUTH4Ih1fHhCxzNEPV55dnr0h6BemMx8OK80PCbI
         McOMXUB5w4/ElKd0KamZmJO5+VqJqRGSU7rN7/HTU6Gw8GYrxyaZ8WhKODGYUTZC1kq5
         mGRg==
X-Gm-Message-State: AOAM533x1u0UMTQM7nO1pWKryWsn1B2D1LODsOs/2clK5u3lyy4Zbw0m
        cy7VVQUWs31ttmcvmb2zKaS0t2bKjW2+
X-Google-Smtp-Source: ABdhPJy5P/EFCCuCEakkKRU/T6io2aQYrbJSfyG5NCDC40EifARdk3p5GUHYAFKXl3Gf3wQPnDJ637hd9sqW
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:4dfd:fd26:e53e:22cb])
 (user=joshdon job=sendgmr) by 2002:a05:6a00:10d2:b0:44d:f03e:46c7 with SMTP
 id d18-20020a056a0010d200b0044df03e46c7mr1432616pfu.0.1636572505131; Wed, 10
 Nov 2021 11:28:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:27:40 -0800
Message-Id: <20211110192740.358437-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] sched/core: explicitly initialize coresched state
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some coresched state may be left as non-zero when we flip off coresched
(ie. core_cookie, core_forceidle_count, etc.). This won't cause any
issues when we flip coresched back on, but it is better to be more
explicit about resetting this state.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b0be8ad6bb7e..2c17f5e91402 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -282,13 +282,23 @@ static void __sched_core_flip(bool enabled)
 	cpumask_copy(&sched_core_mask, cpu_online_mask);
 	for_each_cpu(cpu, &sched_core_mask) {
 		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+		struct rq *rq;
 
 		sched_core_lock(cpu, &flags);
 
-		for_each_cpu(t, smt_mask)
-			cpu_rq(t)->core_enabled = enabled;
+		for_each_cpu(t, smt_mask) {
+			rq = cpu_rq(t);
+
+			rq->core_pick = NULL;
+			rq->core_enabled = enabled;
+
+		}
 
-		cpu_rq(cpu)->core->core_forceidle_start = 0;
+		rq = cpu_rq(cpu)->core;
+		rq->core_cookie = 0;
+		rq->core_forceidle_count = 0;
+		rq->core_forceidle_occupation = 0;
+		rq->core_forceidle_start = 0;
 
 		sched_core_unlock(cpu, &flags);
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

