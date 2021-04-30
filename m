Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30736F54D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhD3FX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhD3FXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619760187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=l7oKMMT+XNtVc/ZMVdgpJ1tZ7/QtGg3Jw4wIOtbASXM=;
        b=KcNgcRedocWs11LULoH070YbSie/OKi6ozrnPB34SegnYyKe3HZb6FGiMPVzWW1uulFbSj
        JQM2eI/dkZJq2iyRl7meRFtqSiod4WCrkSbfERiFE/GJ33wLP77/2ap2WQL0y1N1TNja1g
        x0W85mIHO6AxTcKgmhuC4ocwu5fsQ34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-QIslFUjeNf6zvCuZwXzB7w-1; Fri, 30 Apr 2021 01:23:05 -0400
X-MC-Unique: QIslFUjeNf6zvCuZwXzB7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641CC801B14;
        Fri, 30 Apr 2021 05:23:04 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-234.phx2.redhat.com [10.3.117.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3045810016FD;
        Fri, 30 Apr 2021 05:23:04 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 997BD3C0053; Fri, 30 Apr 2021 02:23:02 -0300 (-03)
Date:   Fri, 30 Apr 2021 02:23:02 -0300
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
Subject: [ANNOUNCE] 4.9.268-rt179
Message-ID: <YIuUNjVL/iHt8aGH@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.268-rt179 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: b8160fb4c27d6074eae16a18371b0b2761faa7e2

Or to build 4.9.268-rt179 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.268.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.268-rt179.patch.xz


You can also build from 4.9.264-rt178 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.264-rt178-rt179.patch.xz

Enjoy!
Luis

