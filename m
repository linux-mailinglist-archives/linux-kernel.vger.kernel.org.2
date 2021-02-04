Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C630E988
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhBDBjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231841AbhBDBjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612402671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=OCdZ2jNvOj5BMIALkYAvTgs5RXLYvCU9ccCxLkClJnM=;
        b=N3OWRuLNCcJKDoBuOQv/WnkPJJyH5gZjSIg0a1qKJxMrm3FqgWGIQnI9QzMl4rNGL5BQlT
        OOfDO3pdf2dqK7dQCpWlJx18ecB/R64NoM/BoqPXkrxprmJ6ft/82A5ldG4MC5GWPnE3k6
        zNbpU1izeNKKU7HhTapByJ0aWL/wahg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-mFmD6EaNNZe-alWZr57G6A-1; Wed, 03 Feb 2021 20:37:47 -0500
X-MC-Unique: mFmD6EaNNZe-alWZr57G6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FDE801960;
        Thu,  4 Feb 2021 01:37:46 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-114-22.rdu2.redhat.com [10.10.114.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 705B877BE5;
        Thu,  4 Feb 2021 01:37:45 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 883133C00CE; Wed,  3 Feb 2021 22:37:43 -0300 (-03)
Date:   Wed, 3 Feb 2021 22:37:43 -0300
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
Subject: [ANNOUNCE] 4.9.255-rt170
Message-ID: <20210204013743.GA696322@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.255-rt170 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 38abb89e640d41df8c16cc1b770853d278beec73

Or to build 4.9.255-rt170 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.255.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.255-rt170.patch.xz

Enjoy!
Luis

