Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD813CC3BE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhGQOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 10:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230003AbhGQOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626530841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=bb5bUOTyVVN+A0OrmEfAJLEWvvoprG+HWPTbuM/uaps=;
        b=g1a+QOYtZCSKT4b+vSGzBJIE2XQqSPcBMIJUo8YTZmGOe2MNqju7wQA0Dw38HYGZm3jyal
        WOtHI9twasO2a0IjcaCuZtwKxR+JcjSanP891cP5VlyFORX3BqO0+xIsX7vzYyXB/vRXLt
        X0ygjPGU7n6VJ00PXnT9GP5FWenySTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-uN2JNViGNJOI2qGnQ0IssQ-1; Sat, 17 Jul 2021 10:07:18 -0400
X-MC-Unique: uN2JNViGNJOI2qGnQ0IssQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36AD0100B3AC;
        Sat, 17 Jul 2021 14:07:16 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-14.rdu2.redhat.com [10.10.119.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C20F60C0F;
        Sat, 17 Jul 2021 14:07:14 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 13FCB3C0205; Sat, 17 Jul 2021 11:07:13 -0300 (-03)
Date:   Sat, 17 Jul 2021 11:07:13 -0300
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
Subject: [ANNOUNCE] 4.9.275-rt184
Message-ID: <YPLkEbAIoISgp4um@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.275-rt184 stable release.

This release is just an update to the new stable 4.9.275 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 91deb31e498354b6ca5225d031fa75a274db2da7

Or to build 4.9.275-rt184 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.275.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.275-rt184.patch.xz


Enjoy!
Luis

