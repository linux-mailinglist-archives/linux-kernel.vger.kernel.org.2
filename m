Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351AD3B97F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhGAVJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234158AbhGAVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625173585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=k2ppV8GaZxnsF/ngB3ZEy193ksSbr0wzGfXo/mHZEtI=;
        b=MmJoaE9rWHyouaOyenfefg2HH/IBp1dfedJWJtpiooCKzSdZfolVtLB2Ea3XsYB+viAO3e
        QnKCRL3ToneR86QMwJ87G+OTO9f5ZQnPRuyjDXRmZhyXbWQ2szr/saD/NH5sEMXja53Cy/
        UrjjwCD9alQyN8mHoeCeNXjygRik6xM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-uRCrKSC1OhyiC-gK5MIh0g-1; Thu, 01 Jul 2021 17:06:24 -0400
X-MC-Unique: uRCrKSC1OhyiC-gK5MIh0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED00CCC622;
        Thu,  1 Jul 2021 21:06:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08D0C60BD9;
        Thu,  1 Jul 2021 21:06:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1CDF34179B8D; Thu,  1 Jul 2021 18:06:06 -0300 (-03)
Message-ID: <20210701210336.358118649@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 01 Jul 2021 18:03:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: [patch 0/5] optionally sync per-CPU vmstats counter on return to userspace
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
the mlock, vmstat shepherd can restart vmstat worker thread on
the CPU in question.
 
To fix this, optionally sync the vmstat counters when returning
from userspace, controllable by a new "vmstat_sync" isolcpus
flags (default off).

See individual patches for details.


