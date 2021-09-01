Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CFD3FE13C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbhIARjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236428AbhIARjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630517897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DWtkvJlMDUuSVpfpufPPMomOgMZOfFN4R7d4sEHZZ8Q=;
        b=bvmboH6Qpn34XbzkNcJqginTZZ708IghLpcDh5dmYM4nRRynShZkLVsNORUfcjH98HqRG4
        QvUkCrO4mW+aNtQHOxcvRc7ELYXUNjftVJd1Mz2uKmcGQzK2hcOve2KBZH8eKYu6/cfR1n
        JNFn6xec963XCtUdbNSIe7kcJE07y6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-d4wxk0hHOo6tRm1XpjtNJw-1; Wed, 01 Sep 2021 13:38:16 -0400
X-MC-Unique: d4wxk0hHOo6tRm1XpjtNJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2C4501E3;
        Wed,  1 Sep 2021 17:38:15 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C48305DEB8;
        Wed,  1 Sep 2021 17:38:07 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4C7A541752A0; Wed,  1 Sep 2021 14:34:01 -0300 (-03)
Date:   Wed, 1 Sep 2021 14:34:01 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nitesh Lal <nilal@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20210901173401.GB48995@fuller.cnet>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.706875395@fuller.cnet>
 <CAFki+Lnso5j+cbDsd74+YM+-sT-zTYuymyJLY2Sw1ho3SHW74Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFki+Lnso5j+cbDsd74+YM+-sT-zTYuymyJLY2Sw1ho3SHW74Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:11:56AM -0400, Nitesh Lal wrote:
> On Tue, Aug 24, 2021 at 11:42 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > Add documentation and userspace sample code for prctl
> > task isolation interface.
> >
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> >
> > ---
> >  Documentation/userspace-api/task_isolation.rst |  211 +++++++++++++++++++++++++
> >  samples/Kconfig                                |    7
> >  samples/Makefile                               |    1
> >  samples/task_isolation/Makefile                |    9 +
> >  samples/task_isolation/task_isol.c             |   83 +++++++++
> >  samples/task_isolation/task_isol.h             |    9 +
> >  samples/task_isolation/task_isol_userloop.c    |   56 ++++++
> >  7 files changed, 376 insertions(+)
> 
> [...]
> 
> > +       if (ret) {
> > +               perror("mlock");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       ret = task_isol_setup();
> > +       if (ret)
> > +               return EXIT_FAILURE;
> 
> The above check condition should be 'ret == -1', isn't it?

task_isol_setup returns 0 on success, so fail to see the point 
of testing for ret == -1 rather than ret != 0 ?

