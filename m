Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03684307FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhA1U0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231464AbhA1UZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611865442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=54I4OH5A+bejmVro9oo5kF+/gWENP7z9qc/XX1w/vI8=;
        b=TklPzJUS2uG0gQQ/tpBs12zX2huQLkaFuCWZLGm9RoXnnm1xQOUGzXdyBEqEx+OC9lxO4m
        N8RANwFF1Nicn/SD94sHIaGVjATN2EnVCTgkH9hSheD6jBXMxLub+RZy/bTxYfNyepIIVs
        VFfv1kwV7Oxhp7Xn5PTGwBAwfgIho9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-c6duDxXFNa-eUeXCLFTQjQ-1; Thu, 28 Jan 2021 15:24:00 -0500
X-MC-Unique: c6duDxXFNa-eUeXCLFTQjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760DB80ED8E;
        Thu, 28 Jan 2021 20:23:59 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2810A1F45D;
        Thu, 28 Jan 2021 20:23:59 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 0ED98416D87F; Thu, 28 Jan 2021 17:23:35 -0300 (-03)
Message-ID: <20210128202134.608115362@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 28 Jan 2021 17:21:34 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [patch 0/3] nohz_full: only wakeup target CPUs when notifying new tick dependency (v5)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

v5: actually replace superfluous rcu_read_lock with lockdep_assert
v4: only IPI if the remote task is on the remote runqueue (PeterZ/Frederic)
v3: replace superfluous rcu_read_lock with lockdep_assert (PeterZ)




