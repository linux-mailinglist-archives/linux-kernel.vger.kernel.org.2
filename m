Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9A3A0520
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhFHU1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234291AbhFHU13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623183935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zlHhUt2bpdgq+Wakvku5Uf132tRpf/xlKxOC2NbaV+E=;
        b=DLHqWAqwt7JhT/G3MYHwqUxTPGPvD6srOZi4bv2r0uObv8N2TvkIvTmXurnPDjzYCFslRg
        PaP0TRjFaxXRnVqERcE7HZTasUa9PZpy1pAnqJU01JL6N4OaD1+60D25X62fPG2PUFIQIy
        tur98kopN5URLpi3W/tnegxD7IQp/l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-AKHuFTNzNB2NIkqlC32dkw-1; Tue, 08 Jun 2021 16:25:32 -0400
X-MC-Unique: AKHuFTNzNB2NIkqlC32dkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A984107ACCA;
        Tue,  8 Jun 2021 20:25:30 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-82.rdu2.redhat.com [10.10.119.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E4C65D6D3;
        Tue,  8 Jun 2021 20:25:29 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A00CA3C0174; Tue,  8 Jun 2021 17:25:27 -0300 (-03)
Date:   Tue, 8 Jun 2021 17:25:27 -0300
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
Subject: [ANNOUNCE] 4.9.271-rt182
Message-ID: <YL/SNw5fOK0Sxb98@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.271-rt182 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: f11e2b11b6871c031fac201cd2625de4696a63bf

Or to build 4.9.271-rt182 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.271.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.271-rt182.patch.xz


Enjoy!
Luis

