Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0676C37050B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 04:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhEACq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 22:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhEACqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 22:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619837164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=lQOPCGq1Y2tbVuPYb2PBvUn3NQ28x/VX0PyZRUOFJTI=;
        b=hOF8Jg6TBJl1XZZPoswUtG80ENZP0nmY4XF0amxF16tb216E1TQhC1x/A37OeVmysbya6V
        aT23s4R4LQiDaJ0570wlc9DBKsDn//VLD+fKRsdlTU4b32V3eQDIohHFGL93xDc83LQEXz
        DLZ953cMwb2oEGnxc1ZCyiowUnrWz20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-qd_Rnr7ENoewK4CTC9W8pA-1; Fri, 30 Apr 2021 22:46:02 -0400
X-MC-Unique: qd_Rnr7ENoewK4CTC9W8pA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE4E2501FE;
        Sat,  1 May 2021 02:46:00 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-234.phx2.redhat.com [10.3.117.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C2095D74B;
        Sat,  1 May 2021 02:46:00 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 7E3DD3C0053; Fri, 30 Apr 2021 23:45:58 -0300 (-03)
Date:   Fri, 30 Apr 2021 23:45:58 -0300
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
Subject: [ANNOUNCE] 4.14.227-rt110
Message-ID: <YIzA5glEJmbVEKQA@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.227-rt110 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: aed031fd6d9b1f9631c4e173b56d28857aac3b15

Or to build 4.14.227-rt110 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.227.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.227-rt110.patch.xz


Enjoy!
Luis

