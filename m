Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942CB3D7918
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhG0Owt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231552AbhG0Owr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627397566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DgA9Rlrfe0K8o4iMU6xJAyIFk1u1w+nH9RZj3KDTT7A=;
        b=INS+HUEh5YYF+bN4Tl9SEKDXMDldcgW4qQK+7gWs3BkbiHGTXEjeN8nPbIy8wUWKJQt+Vd
        sApTN8eCG39ac0mq775HCnSwxC23S4E4KueRWylFxLZ3Up4pSSM87jhruTWvq5lD985WI9
        j5JqD2dAOFVRG3NWjtsy0yvAR4QDI9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-RP2nsDh-Mh-3aK7mhO7frA-1; Tue, 27 Jul 2021 10:52:45 -0400
X-MC-Unique: RP2nsDh-Mh-3aK7mhO7frA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2166100CAB1;
        Tue, 27 Jul 2021 14:52:41 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7317A797C3;
        Tue, 27 Jul 2021 14:52:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B1E0E4172EDE; Tue, 27 Jul 2021 11:52:09 -0300 (-03)
Date:   Tue, 27 Jul 2021 11:52:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210727145209.GA518735@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727130930.GB283787@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 03:09:30PM +0200, Frederic Weisbecker wrote:
> On Tue, Jul 27, 2021 at 02:38:15PM +0200, nsaenzju@redhat.com wrote:
> > Hi Marcelo,
> > 
> > On Tue, 2021-07-27 at 08:00 -0300, Marcelo Tosatti wrote:
> > OK, sorry if I'm being thick, but what is the benefit of having a distincnt
> > PR_ISOL_MODE instead expressing everything as PR_ISOL_FEATURES.
> > 
> >   PR_ISOL_MODE_NONE == Empty PR_ISOL_FEATURES bitmap
> > 
> >   PR_ISOL_MODE_NORMAL == Bitmap of commonly used PR_ISOL_FEATURES
> >   			      (we could introduce a define)
> > 
> >   PR_ISOL_MODE_NORMAL+PR_ISOL_VSYSCALLS == Custom bitmap
> > 
> > Other than that, my rationale is that if you extend PR_ISOL_MODE_NORMAL's
> > behaviour as new features are merged, wouldn't you be potentially breaking
> > userspace (i.e. older applications might not like the new default)?
> 
> I agree with Nicolas, and that was Thomas request too.
> Let's leave policy implementation to userspace and take
> only the individual isolation features to the kernel.
> 
> CPU/Task isolation is a relatively young feature and many users don't
> communicate much about their needs. We don't know exactly how finegrained
> the ABI will need to be so let's not make too many high level assumptions.
> 
> It's easy for userspace to set all isolation bits by itself.
> 
> Besides, those bits will be implemented one by one over time, this
> means that a prctl() bit saying "isolate everything" will have a different
> behaviour as those features get integrated. And we really want well defined
> behaviours.
> 
> Thanks.
> 
> 

OK, how about this:

...

The meaning of isolated is specified as follows:

Isolation features
==================

- prctl(PR_ISOL_GET, ISOL_SUP_FEATURES, 0, 0, 0) returns the supported
features as a return value.

- prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
the bitmask.

- prctl(PR_ISOL_GET, ISOL_FEATURES, 0, 0, 0) returns the currently
enabled features.

The supported features are:

ISOL_F_QUIESCE_ON_URET: quiesce deferred actions on return to userspace.
----------------------

Quiescing of different actions can be performed on return to userspace.

- prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0) returns
the supported actions to be quiesced.

- prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) returns
the currently supported actions to be quiesced.

- prctl(PR_ISOL_GET, PR_ISOL_QUIESCE_CFG, 0, 0, 0) returns
the currently enabled actions to be quiesced.

#define ISOL_F_QUIESCE_VMSTAT_SYNC      (1<<0)
#define ISOL_F_QUIESCE_NOHZ_FULL        (1<<1)
#define ISOL_F_QUIESCE_DEFER_TLB_FLUSH  (1<<2)
...

