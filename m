Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0327F3437D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 05:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVEO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 00:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhCVEO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 00:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616386468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=a4v4LZd/KuNB4nVBOBAV0fJoffXp/cjO8///uHfP+rY=;
        b=FL83ETxnQdDfI1qujRiv94Q2e/DiCAJVp5PrPuDQGLO0Ht9nYgoySNQWJAGOvQGJsTM7SV
        UIF2xmweWJfaO8XzUqn3IxM2Rj+1IOEDDnV4cGg5yrrkWesOCsbuIhzr3oCPat4iIc9cJc
        j+kNxjQpJncJEbniONuAfSGBDP1GB/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Tr9bnYNBMRihkF_mIxSP9A-1; Mon, 22 Mar 2021 00:14:25 -0400
X-MC-Unique: Tr9bnYNBMRihkF_mIxSP9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCFE1084C95;
        Mon, 22 Mar 2021 04:14:24 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-44.rdu2.redhat.com [10.10.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 758F6100AE42;
        Mon, 22 Mar 2021 04:14:23 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A7BEC3C1752; Mon, 22 Mar 2021 01:14:21 -0300 (-03)
Date:   Mon, 22 Mar 2021 01:14:21 -0300
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
Subject: [ANNOUNCE] 4.9.260-rt174
Message-ID: <161638639759.450582.3060675159400489865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.260-rt174 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: a1ce8735f60285bcf3df3ab01e1ea2588e90c540

Or to build 4.9.260-rt174 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.260.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.260-rt174.patch.xz

Enjoy!
Luis

