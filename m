Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93EC426388
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhJHEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229599AbhJHEGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633665882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpOeeNqdFywLsnpSsY/131/qyW/smsuqZ49HHXhjb5s=;
        b=W8ytLb2H1HGHAqS7wlhWlTw/+UpQhr3KAStTL1y2JH7TtK1zbBo1BUL5XgCabedcCBysIw
        zJdVYmRNbEn0BoRIO/W3a0aW2wgbYYZpSHioaBTd2Cd2XogieBhWiXwnVZb7CM22P2jZUx
        2Q7ydK/J92oRFNaq+iVtzlxhevqdTHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-qeLJKDxPPSC98f9nSIIWlw-1; Fri, 08 Oct 2021 00:04:28 -0400
X-MC-Unique: qeLJKDxPPSC98f9nSIIWlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6280B362F9;
        Fri,  8 Oct 2021 04:04:27 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB5565D740;
        Fri,  8 Oct 2021 04:04:22 +0000 (UTC)
Date:   Fri, 8 Oct 2021 12:04:18 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 1/4] kernel/watchdog: trival cleanups
Message-ID: <YV/DQr8dO5b3K+2a@piliu.users.ipa.redhat.com>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-2-kernelfans@gmail.com>
 <YVrKOUVnDFjKOiNZ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVrKOUVnDFjKOiNZ@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:32:41AM +0200, Petr Mladek wrote:
> On Thu 2021-09-23 22:09:48, Pingfan Liu wrote:
> > No reference to WATCHDOG_DEFAULT, remove it.
> > 
> > And nobody cares about the return value of watchdog_nmi_enable(),
> > changing its prototype to void.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Wang Qing <wangqing@vivo.com>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Santosh Sivaraj <santosh@fossix.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/nmi.h | 2 +-
> >  kernel/watchdog.c   | 5 +----
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > index 750c7f395ca9..b7bcd63c36b4 100644
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
> >  void watchdog_nmi_stop(void);
> >  void watchdog_nmi_start(void);
> >  int watchdog_nmi_probe(void);
> > -int watchdog_nmi_enable(unsigned int cpu);
> > +void watchdog_nmi_enable(unsigned int cpu);
> >  void watchdog_nmi_disable(unsigned int cpu);
> >  
> >  /**
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index ad912511a0c0..6e6dd5f0bc3e 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -30,10 +30,8 @@
> >  static DEFINE_MUTEX(watchdog_mutex);
> >  
> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
> > -# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
> >  # define NMI_WATCHDOG_DEFAULT	1
> >  #else
> > -# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED)
> >  # define NMI_WATCHDOG_DEFAULT	0
> >  #endif
> >  
> > @@ -95,10 +93,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
> >   * softlockup watchdog start and stop. The arch must select the
> >   * SOFTLOCKUP_DETECTOR Kconfig.
> >   */
> > -int __weak watchdog_nmi_enable(unsigned int cpu)
> > +void __weak watchdog_nmi_enable(unsigned int cpu)
> 
> It is __weak. spart specific implementation is in
> arch/sparc/kernel/nmi.c. It has to be updated as well.
> 
Oops, I will fix it.

Thanks,

	Pingfan

