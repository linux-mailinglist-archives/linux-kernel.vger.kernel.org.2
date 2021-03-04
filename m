Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC01732D723
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhCDPwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232223AbhCDPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614873024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQt2Y0bDQy5kebuxLoR8afLNrZ5ZNUK/gHrzh5pdHhA=;
        b=MLDxIBFJCtqpn6uneNZFenPeDDQS5zDgH9GW+9nb1s99KpEcNYj8PmwT6uWuoskwozGu58
        hKmbG1rHghKl+fJf38/P16mTcBJuRM2hmmOYFH+EZ94C2iF/jnaTsEa6LaH/5im71oeVBM
        VpYMGsmLcsnCYGNxesBnCN8G7SU+1Yc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-RjiLGdaqOROzcpTHFjSWPw-1; Thu, 04 Mar 2021 10:50:22 -0500
X-MC-Unique: RjiLGdaqOROzcpTHFjSWPw-1
Received: by mail-qv1-f71.google.com with SMTP id h10so20794323qvf.19
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQt2Y0bDQy5kebuxLoR8afLNrZ5ZNUK/gHrzh5pdHhA=;
        b=M+phavnmye0wH+SBNpmx6SmBCyPrWO+fUnWnwX47mYPwBVxkkUfOI155v+Ab7DlSoF
         9zZa2zquBmlIProXIfD23pnxmpSgvLJ0riL968iq8tZAZX0ijS+7yFWBog7b9hTVk3HU
         ypCMJzg3KscHcbxqEZvIU59AyX3Bpr99Ubl0de9b8aH7WowO+jCotw9hJcODvwX28XQZ
         KpM6HyOBTVsmC4UOKJdWHr50xJr4w+fkMgPk/tcMGKYHpIo/sYLN6fzNdJ4JPvn/G/3R
         LS2EfeX4luPCe/zYqm/JZuaEBwVWIjewauFI+lTFzqP6MZBaG/OyWHq5Ea836HI5T5cu
         M3GA==
X-Gm-Message-State: AOAM533b9c2e0maf6BRB6qfjnCCr+oJ8gTRhukHyZWuOgSCnNFbVgwUm
        ZSMl4arPvEhSqBEMl8va0fiog1yFMfT0hjzTCoiofBNjSC0Bvxm/5zbxTlSCKmtmrTl+u/xQejD
        mbIg1JxhLzMaBk7wyznFiQx5a
X-Received: by 2002:a05:6214:18d2:: with SMTP id cy18mr4719973qvb.50.1614873022173;
        Thu, 04 Mar 2021 07:50:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3l8J0s9E9vj9Tchr6GSaSM3eRe+MoXYdmMgBMHvxK4rTrHy2WwPSYwx+R0iUueuirWX2d4A==
X-Received: by 2002:a05:6214:18d2:: with SMTP id cy18mr4719956qvb.50.1614873021927;
        Thu, 04 Mar 2021 07:50:21 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id c27sm3389693qko.71.2021.03.04.07.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:50:21 -0800 (PST)
Date:   Thu, 4 Mar 2021 10:50:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH 1/4] userfaultfd.2: Add UFFD_FEATURE_THREAD_ID docs
Message-ID: <20210304155019.GX397383@xz-x1>
References: <20210304015947.517713-1-peterx@redhat.com>
 <20210304015947.517713-2-peterx@redhat.com>
 <b0583d47-43ba-6077-9d93-074cd34993f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0583d47-43ba-6077-9d93-074cd34993f3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:22:18AM +0100, Alejandro Colomar (man-pages) wrote:
> Hello Peter,

Hi, Alex,

> 
> On 3/4/21 2:59 AM, Peter Xu wrote:
> > UFFD_FEATURE_THREAD_ID is supported since Linux 4.14.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   man2/userfaultfd.2 | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> > index e7dc9f813..2d14effc6 100644
> > --- a/man2/userfaultfd.2
> > +++ b/man2/userfaultfd.2
> > @@ -77,6 +77,12 @@ When the last file descriptor referring to a userfaultfd object is closed,
> >   all memory ranges that were registered with the object are unregistered
> >   and unread events are flushed.
> >   .\"
> > +.PP
> > +Since Linux 4.14, userfaultfd page fault message can selectively embed fault
> > +thread ID information into the fault message.  One needs to enable this feature
> > +explicitly using the
> > +.BR UFFD_FEATURE_THREAD_ID
> 
> This should use [.B] and not [.BR].
> .BR is for alternate Bold and Roman.
> .B is for bold.
> 
> (There are more appearances of this in the other patches.)

Yeah I got a bit confused when differenciating those two, since I also see
similar usage, e.g.:

.BR O_CLOEXEC

I'll fix all of them appeared in current patchset.  Let me know if you also
want me to fix all the existing uses of ".BR" too where ".B" would suffice.
Otherwise I won't touch them since I can't say they're wrong either (I think
most of them should generate the same output with either ".BR" or ".B" if
there's only one word?).

Thanks,

-- 
Peter Xu

