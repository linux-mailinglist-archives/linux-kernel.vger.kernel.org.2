Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395CB44CC70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhKJWVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233898AbhKJWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636582682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cGTOzuKgGfZcDjVsrb0vtL9uCD+1inop5sEVC7ZUv/8=;
        b=SmqpFDC/K+hxI1i49ub0R4LmPu84Al1kHx86mbM4btf/dLGbYgwwtA22aOFiLC5iQgaZxQ
        hpMFBenGlcyNMIsEYIM+V2xKDbIPZFraIm9kZMwsjtLbg1mtcwYVaGOZhBZ5t4m8nlE3zb
        XQx0lSj/0DyM9GV5VJDNpEotZkeI+04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ZZ0Wl7hGMkS2L8UXoE3GKg-1; Wed, 10 Nov 2021 17:17:56 -0500
X-MC-Unique: ZZ0Wl7hGMkS2L8UXoE3GKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC4EB18D6A25;
        Wed, 10 Nov 2021 22:17:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C344D5E26A;
        Wed, 10 Nov 2021 22:17:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Date:   Wed, 10 Nov 2021 17:17:30 -0500
Message-Id: <20211110221732.272986-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that when an x86 system was being stressed by running
various different benchmark suites, the clocksource watchdog might
occasionally mark TSC as unstable and fall back to hpet which will
have a signficant impact on system performance.

The current watchdog clocksource skew threshold of 50us is found to be
insufficient. So it is changed back to 100us before commit 2e27e793e280
("clocksource: Reduce clocksource-skew threshold") in patch 1. Patch 2
adds a Kconfig option to allow kernel builder to control the actual
threshold to be used.

Waiman Long (2):
  clocksource: Avoid accidental unstable marking of clocksources
  clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW

 kernel/time/Kconfig       |  9 ++++++
 kernel/time/clocksource.c | 58 ++++++++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 13 deletions(-)

-- 
2.27.0

