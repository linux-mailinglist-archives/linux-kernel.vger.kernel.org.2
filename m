Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2003BC40E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 01:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhGEXY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 19:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhGEXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 19:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625527308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=fqb62Oj6q7MhimrV/SzzoOpI+G1FzVoe0GiS/CpgbBE=;
        b=HFcMxt4RC0XjorpPvRgf0ss3OB6EtFmLv2qr6L3fsvLcXyjA07KcWc6d/zkjWYSKPRtGU0
        i6fz+GyDZX7jxMrMwKPSoYeHGj3bidGBhCXxqfAlBW6iI1CB1EUzq47IHLxrvRP6CU1THN
        1caQ+EgqFUpv00YSYohusMPNvA2oBtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-IHltO_dZMTuRRi8nrVuHMA-1; Mon, 05 Jul 2021 19:21:47 -0400
X-MC-Unique: IHltO_dZMTuRRi8nrVuHMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78C41800C78;
        Mon,  5 Jul 2021 23:21:45 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-116-244.rdu2.redhat.com [10.10.116.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 699D160864;
        Mon,  5 Jul 2021 23:21:44 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 781AE3C0205; Mon,  5 Jul 2021 20:21:42 -0300 (-03)
Date:   Mon, 5 Jul 2021 20:21:42 -0300
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
Subject: [ANNOUNCE] 4.9.274-rt183
Message-ID: <YOOUBnewb+bBngLm@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.274-rt183 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: b83ffe399e5c0f6ef9af95b335bda1bac23af739

Or to build 4.9.274-rt183 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.274.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.274-rt183.patch.xz


Enjoy!
Luis

