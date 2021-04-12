Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE1635C3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhDLKVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhDLKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4c/NWMcybSM22mwNKD1qzLsLS1kiYYyjoBhd+MeV46g=; b=PW9SQU7Z2Yk8cCKZ3fxKM+i4Fd
        KSltNmTcoKNhGVW7MZdhL182EuzvMR4u3+cAEeb/byUbNZiKeAsNj6/P4E+uqIbjnrWEP2o8HoE1U
        YUuykBggMY7qK8j+XuTOMDUl9DZ07VyDxZkTIKTnjKiyZV35N2lTgAk9ug/vj3eE7NoYiG1VXkhFj
        Cok5rEkcoq/1a23phYGnfH/sueg4l6bolEBJK81TNwWDqiAvZHovpsY+Vov8CVFoqTV2DpgekWBpC
        /EVJgeA4mt7FOhN7xzE8GaiBAawn4AhwGxk/drRlLY5l78O4aAkZRGHYcOLQiddMYstukCAD7VuB4
        lUL4yxug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgi-006QVC-Hu; Mon, 12 Apr 2021 10:21:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06BAE300033;
        Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF8822022420C; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412101421.609526370@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: [PATCH v2 0/9] sched: Clean up SCHED_DEBUG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have sysctl, procfs and debugfs SCHED_DEBUG interfaces, end the
insanity and move (most) everything to debugfs.

And since this is a nice moment to have people re-evaluate their 'tunings' also
change how some of the values work.

v2:
 - picked up tags
 - latestest version of that debugfs_create_str() thing
   (no extra \0, no export, no write) (rasmus)
 - re-added missing __cpumask_clear_cpu() (valsch)
 - use min() for BASE_SLICE (vingu)

