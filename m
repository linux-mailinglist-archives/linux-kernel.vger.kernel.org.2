Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04522453CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhKPXsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhKPXsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637106306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0gVVERWx/6zfw7A/9AJHuKgbAmjgL0zit14eVnvwIIE=;
        b=UEpQaW00a5qDOOoUOiZIdX7lZgnucevbATRJT2DBPyct44SZz0zZKkkySgs/z0bXmVkuQZ
        YSIqXb1qjuQ3INK6NMUJacsZh8N/SSbb3xiO4YQfGZ0TExtZTT/ZuXZZZKqjXvz9gIqJ6+
        HCVk2GYoSgUeVgtINawc0i87j8lP7+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-u5NjmnbQNT6iISD6-DGHYg-1; Tue, 16 Nov 2021 18:45:05 -0500
X-MC-Unique: u5NjmnbQNT6iISD6-DGHYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3005802E62;
        Tue, 16 Nov 2021 23:45:03 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B41955BAE5;
        Tue, 16 Nov 2021 23:44:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] clocksource: Avoid incorrect hpet fallback
Date:   Tue, 16 Nov 2021 18:44:22 -0500
Message-Id: <20211116234426.837799-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that when an x86 system was being stressed by running
various different benchmark suites, the clocksource watchdog might
occasionally mark TSC as unstable and fall back to hpet which will
have a signficant impact on system performance.

The current watchdog clocksource skew threshold of 50us is found to be
insufficient. So it is changed back to 100us before commit 2e27e793e280
("clocksource: Reduce clocksource-skew threshold") in patch 1. This
patch also skip the current clock skew check if the consecutive watchdog
read-back delay contributes a major portion of the total delay. On a
1-socket 64-thread test system, it was actually found that in one the
test sample, the hpet-tsc-hpet delay was 95263ns, while the corresponding
hpet-hpet delay was 94425ns. So the majority of the delay is caused by
the hpet read.

Patch 2 reduces the default clocksource_watchdog() retries to 2 as
suggested by Paul.

Patch 3 implements dynamic readjustment of the new internal
watchdog_max_skew variable in case the current value causes excessive
skipping of clock skew checks. The following reproducer provided by
Feng Tang was used to cause the test skipping:

  sudo stress-ng --timeout 30 --times --verify --metrics-brief --ioport <n>

where <n> is the number of cpus in the system.

A sample watchdog_max_skew readjustment output was:

[  197.771144] clocksource: timekeeping watchdog on CPU8: hpet wd-wd read-back delay of 92539ns
[  197.789589] clocksource: wd-tsc-wd read-back delay of 90933ns, clock-skew test skipped!
[  197.807145] clocksource: timekeeping watchdog on CPU8: watchdog_max_skew increased to 185078ns

To avoid excessive increase of watchdog_max_skew, a limit of
10*WATCHDOG_MAX_SKEW is used over which the watchdog itself will be
mark unstable and a new watchdog will be selected if possible.

To exercise the code, WATCHDOG_MAX_SKEW was reduced to 10us. After
skipping 10 checks, the watchdog then fell back to acpi_pm. However
the corresponding consecutive watchdog delay was still about the same
leading to ping-ponging between hpet and acpi_pm becoming the watchdog.

Patch 4 adds a Kconfig option to allow kernel builder to control the
actual WATCHDOG_MAX_SKEW threshold to be used.

Waiman Long (4):
  clocksource: Avoid accidental unstable marking of clocksources
  clocksource: Reduce the default clocksource_watchdog() retries to 2
  clocksource: Dynamically increase watchdog_max_skew
  clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW

 .../admin-guide/kernel-parameters.txt         |   4 +-
 kernel/time/Kconfig                           |   9 ++
 kernel/time/clocksource.c                     | 121 +++++++++++++++---
 3 files changed, 114 insertions(+), 20 deletions(-)

-- 
2.27.0

