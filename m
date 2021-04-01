Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522C6351AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhDASDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236534AbhDARp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwV//pfUkUzEK4qUvEWrBTQWqHmhscbg2Y3mQx3dZvY=;
        b=TS2NCLawmvBEMb1wXZp2k5jMFvxeTpda0yU3pctglUEYbQYATedCDiRvMV0CJMHn+bCRAy
        bL8nRjqFJ5dCchjD7NYJEnBmPFB9iPNrD2ADAU5BCxImJDp7tvqrPQkHBSogEHjLotW3Bm
        /BQaAROXJxn6oGyw9lCuY1bH1bKal50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-uaGc33Z2NwS4S4xi3p-K7A-1; Thu, 01 Apr 2021 12:43:24 -0400
X-MC-Unique: uaGc33Z2NwS4S4xi3p-K7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0905B382;
        Thu,  1 Apr 2021 16:43:13 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1178F1B49D;
        Thu,  1 Apr 2021 16:43:06 +0000 (UTC)
Date:   Thu, 1 Apr 2021 12:43:01 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/2] audit: document /proc/PID/loginuid
Message-ID: <20210401164301.GC3141668@madcap2.tricolour.ca>
References: <cover.1616095045.git.rgb@redhat.com>
 <14139c54992a4b50448fbbf07ebbfed743e09f3a.1616095045.git.rgb@redhat.com>
 <20210401154827.2f801300@coco.lan>
 <CAHC9VhQ6d7_gX2dWSK9Wnk1p+w+1yOPb=Yf8fTCeMbhGru0iUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ6d7_gX2dWSK9Wnk1p+w+1yOPb=Yf8fTCeMbhGru0iUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-01 09:57, Paul Moore wrote:
> On Thu, Apr 1, 2021 at 9:48 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > Em Thu, 18 Mar 2021 15:19:10 -0400
> > Richard Guy Briggs <rgb@redhat.com> escreveu:
> > > Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> > > was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> > > loginuid through proc")
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid
> > >
> > > diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> > > new file mode 100644
> > > index 000000000000..e7c100b9ab18
> > > --- /dev/null
> > > +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> > > @@ -0,0 +1,15 @@
> > > +What:                Audit Login UID
> > > +Date:                2005-02-01
> > > +KernelVersion:       2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
> > > +Contact:     linux-audit@redhat.com
> > > +Format:              %u
> >
> > The ABI definition doesn't include a "Format:" symbol. See:
> >
> >         Documentation/ABI/README
> >
> > For the valid ones.
> >
> > This change causes a warning at the ABI parser:
> >
> >
> >         $ ./scripts/get_abi.pl validate
> >         Warning: file Documentation/ABI/stable/procfs-audit_loginuid#5:
> >                 tag 'contact' is invalid. Line
> >                         Format:         %u
> >         Warning: file Documentation/ABI/stable/procfs-audit_loginuid#21:
> >                 tag 'contact' is invalid. Line
> >                         Format:         %u
> >
> > You should either drop it or add it to the parser and to the README
> > file, if the ABI maintainers are ok with such new field.
> 
> Thanks Mauro, I didn't realize there were tools that parsed these files.
> 
> Richard, please post a patch that drops the 'Format:' line from the
> newly added audit files as soon as possible so I can merge it into
> audit/next.

Ok.  I'll roll it into the description so we don't lose that
information.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

