Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF9307E79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhA1SwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232334AbhA1SqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611859487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=d9DCyUiqhGMRjufRtGd0K7buDIsKCn12kYp0ACHugHk=;
        b=AnoCcZZOer0klEkXLaMo2Uh1Z2ECrFSRbLEITso+UzG8e+b+aYJIL3qR4UaNzGpDnb6vkY
        LOTHeRwKOu+TOQi1rY15Jj6WFNmZz0ogzebLd4IJEKnK983fWbPf+EpQTV2eUqeO+NNaX/
        dBTuwWsU/UZjZKyvniIdXB85LIk/WFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-B7Pqbyu0NQK69H4Y2ndRqg-1; Thu, 28 Jan 2021 13:44:44 -0500
X-MC-Unique: B7Pqbyu0NQK69H4Y2ndRqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB13A803622;
        Thu, 28 Jan 2021 18:44:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B07EE5D9F4;
        Thu, 28 Jan 2021 18:44:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E1141416D87F; Thu, 28 Jan 2021 15:44:20 -0300 (-03)
Message-ID: <20210128184048.287626221@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 28 Jan 2021 15:40:48 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [patch 0/3] nohz_full: only wakeup target CPUs when notifying new tick dependency (v4)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
performed (to re-read the dependencies and possibly not re-enter
nohz_full on a given CPU).

A common case is for applications that run on nohz_full= CPUs
to not use POSIX timers (eg DPDK). This patch changes the notification
to only IPI the target CPUs where the task(s) whose tick dependencies
are being updated are executing.

This reduces interruptions to nohz_full= CPUs.

v4: only IPI if the remote task is on the remote runqueue (PeterZ/Frederic)
v3: replace superfluous rcu_read_lock with lockdep_assert (PeterZ)


