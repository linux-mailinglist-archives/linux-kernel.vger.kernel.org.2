Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5983F8FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbhHZUiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 16:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243550AbhHZUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 16:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630010251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkzbDwHntc2mOiZybPIdS6qrY0R5yvA3NCMKaJd6k+I=;
        b=IUmNqNq50pFGqYVDCtwCMha8ZodhGue1gThOFghpZ8tf7UJCoosNUA6XlXHsppyJpUQkM2
        VRwPRBLbr4AB3fwPq8MXBCtjLkbSfK2GznK5oRWSXv3bWEDwuqXG4tQfAJ2TaM6/RCqlQ/
        z4ILYJYVoewBjAFtahcjr0Cnxvmw9YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-UFt8a_lrNXuOJrYC8aFi7g-1; Thu, 26 Aug 2021 16:37:30 -0400
X-MC-Unique: UFt8a_lrNXuOJrYC8aFi7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1229760CE;
        Thu, 26 Aug 2021 20:37:28 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A13E60C04;
        Thu, 26 Aug 2021 20:37:22 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 974A3416D8BC; Thu, 26 Aug 2021 17:37:18 -0300 (-03)
Date:   Thu, 26 Aug 2021 17:37:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20210826203718.GA177929@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.706875395@fuller.cnet>
 <20210826095958.GA908505@lothringen>
 <20210826121131.GA152063@fuller.cnet>
 <alpine.DEB.2.22.394.2108262111200.358100@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2108262111200.358100@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 09:15:57PM +0200, Christoph Lameter wrote:
> On Thu, 26 Aug 2021, Marcelo Tosatti wrote:
> 
> > Decided on a separate prctl because the inheritance control
> > is not a feature itself: it acts on all features (or how task isolation
> > features are inherited across fork/clone).
> 
> I am having a hard time imagening use cases for such a feature since I
> usally see special code sections optimized to run without OS jitter and
> not whole processes. AFAICT You would not want to have any of these on
> because they cause performance regression if you must do syscalls related
> to process startup and termination.

The documentation has:

+==================
+Userspace support
+==================
+
+Task isolation is divided in two main steps: configuration and activation.
+
+Each step can be performed by an external tool or the latency sensitive
+application itself. util-linux contains the "chisol" tool for this
+purpose.
+
+This results in three combinations:
+
+1. Both configuration and activation performed by the
+latency sensitive application.
+Allows fine grained control of what task isolation
+features are enabled and when (see samples section below).
+
+2. Only activation can be performed by the latency sensitive app
+(and configuration performed by chisol).
+This allows the admin/user to control task isolation parameters,
+and applications have to be modified only once.
+
+3. Configuration and activation performed by an external tool.
+This allows unmodified applications to take advantage of
+task isolation. Activation is performed by the "-a" option
+of chisol.

The util-linux patch changelog has:

util-linux: add chisol tool to configure task isolation
  
Add chisol tool to configure task isolation. See chisol -h
for details.

For example, to launch a version of oslat that activates
task isolation:

chisol -q vmstat_sync -I conf ./oslat -f 1 -c 5 -D 5m

-q vmstat_sync: enable quiescing of per-CPU vmstats 
-I conf: inherit task isolation configuration.

====

So you can _configure_ the parameters of task isolation outside 
your application, but activation (just before the realtime loop),
can be done inside it (which requires modification of the 
application). See the oslat/cyclictest patches.

So to answer your question: chisol allows task isolation to be
configured and activated externally from a latency sensitive app 
(which at this moment means every system call, after activation,
will sync the vmstats on return to userspace... which obviously
slow things down). But you can then run unmodified applications
(while paying the cost of slower startup times).

Activation of different features before exec'ing a new application
will of course depend on what the feature does...

> Since we are adding docs: Could we have some sample use cases for
> when these features are useful?

There is one sample at samples/task_isolation/task_isol_userloop.c,
do you mean more samples would be useful ? (there are two i know of:
the one you mentioned and the one Thomas mentioned).

