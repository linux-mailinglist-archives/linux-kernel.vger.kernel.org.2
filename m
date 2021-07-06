Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33AF3BC4A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 03:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGFBtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 21:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhGFBtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 21:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625536016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=YKIg5h3UzW78OIQwO+nqMRBi3MuwiQf9vkBP6EwICVw=;
        b=OcqNmCdrUaeCwn/ZX1ve7RTZg7d1sQCRCJXPCqVoBSgzFVL70gqq8TVkdiA0l7a35M101v
        oN4ELii0k7ZhozRf/EkZjdbidt9rdUrDVgVdUDly5pTLS9UOmsJniRUTWIDnPr5SIyJP7R
        WmDPIwj5s/mBmJob4dUqgIMmle9paIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-D-fVVYffOr2P71YnI5f-Pw-1; Mon, 05 Jul 2021 21:46:55 -0400
X-MC-Unique: D-fVVYffOr2P71YnI5f-Pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2F21100C666;
        Tue,  6 Jul 2021 01:46:53 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-116-244.rdu2.redhat.com [10.10.116.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725AF19CBC;
        Tue,  6 Jul 2021 01:46:52 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 6CE0F3C0205; Mon,  5 Jul 2021 22:46:50 -0300 (-03)
Date:   Mon, 5 Jul 2021 22:46:50 -0300
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
Subject: [ANNOUNCE] 4.14.238-rt118
Message-ID: <YOO2CgG753GveGY9@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.238-rt118 stable release.

This release is just an update to the new stable 4.14.238 version
and no RT specific changes have been made.
i
You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 5c8e6a330652e6bfd228d0b46248df5c599e7980

Or to build 4.14.238-rt118 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.238.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.238-rt118.patch.xz


Enjoy!
Luis

