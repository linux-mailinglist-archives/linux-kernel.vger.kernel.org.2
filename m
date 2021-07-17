Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EED3CC3C3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhGQOQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 10:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbhGQOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626531200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IL9abqLFpQxnCVMsSaErThGRkK/d52bEDlY1K//VL08=;
        b=duSuOK4xfpWcKiA0M+kUSjm6AauDKe29E+pLOfM1hT4AkhKVE0+ihi3zMlEq/cPzW7Kc0h
        Qx0BgNaVM1UaBOvFipz01WFiBRx+Rm5WgdoPA/oZoRGfESSAUlqX8ppudwjD8Z3carmZBT
        Ud9G8C4K9lnwvodhyzTqOp2z/7wZCLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-gsBxIYOTOFerUq2VdtjRMw-1; Sat, 17 Jul 2021 10:13:18 -0400
X-MC-Unique: gsBxIYOTOFerUq2VdtjRMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 425741084F55;
        Sat, 17 Jul 2021 14:13:17 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-14.rdu2.redhat.com [10.10.119.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B150380;
        Sat, 17 Jul 2021 14:13:16 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id D8C3A3C0205; Sat, 17 Jul 2021 11:13:14 -0300 (-03)
Date:   Sat, 17 Jul 2021 11:13:14 -0300
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
Subject: [ANNOUNCE] 4.14.239-rt119
Message-ID: <YPLleq6XlLnSwqgj@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.239-rt119 stable release.

This release is just an update to the new stable 4.14.239 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: ae45d0714cf4e05f0bfdf481e594e0507243c3d2

Or to build 4.14.239-rt119 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.239.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.239-rt119.patch.xz


Enjoy!
Luis

