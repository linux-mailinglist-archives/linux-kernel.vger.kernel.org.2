Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8117D343514
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 22:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhCUVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 17:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbhCUVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616363467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wyqMpsK9OV9z16fyXtQOsXdDW0L+Fna0LQOvqN+7kvc=;
        b=LjBxv1AeUrpnBan21gTuXTfe3mpFKprFfPFag4dlqyb0JgUcoONrWjEfXAgH+MWdCjA1rv
        wthlhVFinm6Xi/FdBdfhgAFdM0J01ZvSKeGqm5SFpbXCWAR5aq0N7omrSAx+6kDc+UFSEi
        jjEGKB2H79O0kemdNFCGOprelx26x00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-lrGP1gj7MmOcB9m6vpmWsw-1; Sun, 21 Mar 2021 17:51:05 -0400
X-MC-Unique: lrGP1gj7MmOcB9m6vpmWsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E874F87A826;
        Sun, 21 Mar 2021 21:51:02 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-44.rdu2.redhat.com [10.10.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 308FF1992D;
        Sun, 21 Mar 2021 21:51:02 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 5A5913C1752; Sun, 21 Mar 2021 18:51:00 -0300 (-03)
Date:   Sun, 21 Mar 2021 18:51:00 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.9.257-rt171
Message-ID: <161636280491.425601.2635594973443794779@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.257-rt171 stable release.

Note that there was a futex/mutex code collision during the merge of v4.9-257.
Even though I believe that it's fixed correctly, anyone with suspicions about
futex/rtmutex behavior in this release should start looking there.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 945132447043a93a231db68172d26f08ff977987

Or to build 4.9.257-rt171 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.257.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.257-rt171.patch.xz

Enjoy!
Luis

Changes from v4.9.255-rt170:
- futex: Don't enable IRQs unconditionally in put_pi_state()


