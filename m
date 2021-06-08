Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065C13A0705
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhFHWju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235069AbhFHWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623191870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=hU9Z+k4PbIuygfnTvPbkUAh8pchKy0IOnGXpgtml0Yk=;
        b=NzA8fEkSTgVkobbaUocznduLx08eIIHJJfRtL9PSWXoOHOAY4VXNasomW1Futm3LaoaCZi
        yRZtuXXByNDGnbDfjVVov/vs/cMyexHQg/ORZHPJo9AevIWgoW7RAH9J1RzQTJJVJRJX+d
        mC6Ep0wTeBkrrUq/6NfFI/IRsR1lk2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-8tz-tpWAMj-hQ8sOrhZl4w-1; Tue, 08 Jun 2021 18:37:48 -0400
X-MC-Unique: 8tz-tpWAMj-hQ8sOrhZl4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 340548018A7;
        Tue,  8 Jun 2021 22:37:47 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-82.rdu2.redhat.com [10.10.119.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6065B5C1C2;
        Tue,  8 Jun 2021 22:37:46 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 939233C0174; Tue,  8 Jun 2021 19:37:44 -0300 (-03)
Date:   Tue, 8 Jun 2021 19:37:44 -0300
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
Subject: [ANNOUNCE] 4.14.235-rt115
Message-ID: <YL/xOK5iPaPr3lBp@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.235-rt115 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: e2f3b0bf7e4424143fa3f626290644989cdb6277

Or to build 4.14.235-rt115 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.235.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.235-rt115.patch.xz


Enjoy!
Luis

