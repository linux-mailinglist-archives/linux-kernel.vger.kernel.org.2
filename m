Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD41333F4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhCQP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232045AbhCQP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615996731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5yOSfsW07vqRDTUyWiwltNsLbSctUow3AY/lS8mayaU=;
        b=eySEqpnxIZ4iVT888VV1NCw0XnHnjLgTZibP2suIsQsn4mzlgwZD1NYsGIBJKUmuS/VF9m
        KnnJ22rbWznnZBATPDQlIorOFrIWtDAuFwZNGyCIzRwEoJJ8uBwPm+1Gwzhu1mKy3bQ9Fp
        DYw2X9ubrrxhtaVXj0Aj1ZyrmzXcBCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-uE3gcsSAPJmOrmJR1qXuyg-1; Wed, 17 Mar 2021 11:58:49 -0400
X-MC-Unique: uE3gcsSAPJmOrmJR1qXuyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02BA08B0AD3;
        Wed, 17 Mar 2021 15:58:32 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A53EA5D9C0;
        Wed, 17 Mar 2021 15:58:30 +0000 (UTC)
Date:   Wed, 17 Mar 2021 11:58:28 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH 1/2] audit: document /proc/PID/loginuid
Message-ID: <20210317155828.GI3141668@madcap2.tricolour.ca>
References: <cover.1615414262.git.rgb@redhat.com>
 <df2ca2e9817140dd5c4ff97297b60700b96cb898.1615414262.git.rgb@redhat.com>
 <CAHC9VhQHsYJnEh_J8ovFGQ9JyNew6C-HCSuFcQamOK3MuAHgQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQHsYJnEh_J8ovFGQ9JyNew6C-HCSuFcQamOK3MuAHgQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-12 14:15, Paul Moore wrote:
> On Thu, Mar 11, 2021 at 11:41 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Describe the /proc/PID/loginuid interface in Documentation/ABI/stable that
> > was added 2005-02-01 by commit 1e2d1492e178 ("[PATCH] audit: handle
> > loginuid through proc")
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  Documentation/ABI/stable/procfs-audit_loginuid | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/ABI/stable/procfs-audit_loginuid
> 
> After ~15 years, it might be time ;)
> 
> > diff --git a/Documentation/ABI/stable/procfs-audit_loginuid b/Documentation/ABI/stable/procfs-audit_loginuid
> > new file mode 100664
> > index 000000000000..fae63bef2970
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/procfs-audit_loginuid
> > @@ -0,0 +1,15 @@
> > +What:          Audit Login UID
> > +Date:          2005-02-01
> > +KernelVersion: 2.6.11-rc2 1e2d1492e178 ("[PATCH] audit: handle loginuid through proc")
> > +Contact:       linux-audit@redhat.com
> > +Format:                u32
> 
> I haven't applied the patch, but I'm going to assume that the "u32"
> lines up correctly with the rest of the entries, right?

Yes, they do.  I'm wondering if they should read instead "%u" since the
internal kernel representation isn't as important as what format (number
base) is expected and presented.

> > +Users:         auditd, libaudit, audit-testsuite, login
> 
> I think these entries are a bit too specific as I expect the kernel to
> outlive most userspace libraries and applications.  I would suggest
> "audit and login applications" or something similar.

In other examples, users range from a description to an email address,
to a URI, to a repository name or address, to a package name, to
specific files.  I'd prefer to be as specific as reasonably possible
without going into gory detail.

> > +Description:
> > +               The /proc/$pid/loginuid pseudofile is written to set and
> 
> I'm really in no position to critique someone's English grammar, but
> if we're talking about changes I might add a comma after "set", "...
> is written to set, and read to get ...".

This would be the Oxford comma debate, and has a sronger preference by
USA-ians that Brits.  It can help disambiguate meaning in a list of
three or more items.

> > +               read to get the audit login UID of process $pid.  If it is
> > +               unset, permissions are not needed to set it.  The accessor must
> > +               have CAP_AUDIT_CONTROL in the initial user namespace to write
> > +               it if it has been set.  It cannot be written again if
> > +               AUDIT_FEATURE_LOGINUID_IMMUTABLE is enabled.  It cannot be
> > +               unset if AUDIT_FEATURE_ONLY_UNSET_LOGINUID is enabled.
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

