Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42813D93C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhG1REC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhG1RD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627491837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsHibXntA5nrdCKJ3pn/OIwa0FmfD/AJLSfptD0KLdY=;
        b=h0uMlroN1SESeuWMbfAdRynyaKGaovE8S4Wr1qqh1H6qyPxaDAEF8bvF3zKnxUW87zisD+
        AQSASAlL9Fj5QEc4Hc3gOxsH0mP4sDOCnHck7TSvhwoIRbYh0S+wNMhUGq0vse3u4LOs3t
        6J3r3YkqSYm+GUaVkLiFrtBVuqRSNRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-w4UBFodnMoa8M9yeBZxIqQ-1; Wed, 28 Jul 2021 13:03:56 -0400
X-MC-Unique: w4UBFodnMoa8M9yeBZxIqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B4FF1026201;
        Wed, 28 Jul 2021 17:03:55 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3895310016F7;
        Wed, 28 Jul 2021 17:03:48 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 83F644172EDB; Wed, 28 Jul 2021 13:21:21 -0300 (-03)
Date:   Wed, 28 Jul 2021 13:21:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Lal <nilal@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210728162121.GB24635@fuller.cnet>
References: <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
 <20210727145209.GA518735@fuller.cnet>
 <20210727234539.GH283787@lothringen>
 <20210728093707.GA3242@fuller.cnet>
 <e0135b88dad323d0abd1ce05081e0b554421af7c.camel@redhat.com>
 <20210728131610.GA11900@fuller.cnet>
 <CAFki+LkQwoqVTKmgnwLQQM8ua-ixbLp8i+jUT6xF15k6X=89mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFki+LkQwoqVTKmgnwLQQM8ua-ixbLp8i+jUT6xF15k6X=89mw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:00:01AM -0400, Nitesh Lal wrote:
> > > A latency sensitive
> > > application might be OK with the former but not with the latter.
> >
> > Two alternatives:
> >
> > 1) The pattern above, where particular subsystems that might interrupt
> > the kernel are enabled automatically if the kernel supports it.
> >
> > Pros:
> > Applications which implement this only need to be changed once,
> > and can benefit from new kernel features.
> >
> > Applications can disable particular features if they turn
> > out to be problematic.
> >
> > Cons:
> > New features might break applications.
> >
> > 2) Force applications to enable each new feature individually.
> >
> > Pros: Won't cause regressions, kernel behaviour is explicitly
> > controlled by userspace.
> >
> > Cons: Apps won't benefit from new features automatically.
> >
> > ---
> >
> > It seems to me 1) is preferred. Can also add a sysfs control to
> > have a "default_isolation_feature" flag, which can be changed
> > by a sysadmin in case a new feature is undesired.
> >
> > Thoughts?
> >
> >
> The first option may work specifically with the sysfs interface that you
> mentioned, however, IMHO (2) is safer than regressing the workloads. Also,
> if the previously implemented controls are good enough for the workload
> then there should not be a need to enable the new ones.

OK, can set default_isolation_feature as 0 then, which admin can 
configure to a non-default value. This would enable the new
features only if the admin enables them.

Thanks.

