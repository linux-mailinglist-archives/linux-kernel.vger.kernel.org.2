Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49F53D4A22
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGXU6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhGXU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627162714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQ9nYZF7TCv1Im5A1JNzguL1rttUs8MvyEizhk+cJ88=;
        b=A0eZC9i93zZZTNeGY6Gh7nBtkoWuP+u+qiADG75sylFkWP5trLL8VcjNjWICFTcNoFEevG
        VxddHrS/nsmyvhsKMBiHgut+oFOWU8E31qj0ArviF9hMItYnUc6nKYEmvvtRe2tcgNLbEv
        clfWWsR7yLRJ33bVTjnsllUxynATHAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-RloOE1wUNLOsPUI_d0EfsQ-1; Sat, 24 Jul 2021 17:38:33 -0400
X-MC-Unique: RloOE1wUNLOsPUI_d0EfsQ-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020a5d42480000b02901404c442853so2547065wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQ9nYZF7TCv1Im5A1JNzguL1rttUs8MvyEizhk+cJ88=;
        b=sV7TUZgP/Hy1+hXpaTDIlMstjJNMV6XrX/nKX+CjlAyPCCWJ3aLe0/YpoND71zs6x3
         sNSWegBx6UcUFaEwpiGK+Ta6uhSqaUL//N2IqjnkvynQQqO71DfnucBS9wKO+hyQxOa6
         AcxpTTKpWlqR4Wt5S3BROHVD1OKBm+pDX4IyAG70TzrkPouy7OYftWrNadSJ6E7U1ZEU
         JzrHq2Dj2dXg2xoCEVVZJEr903JwWjKp3xzyYZEolIhaRF/+GEt1o9ZuA3yocF6taew/
         mtci8cw2QslHToQf+8erD4PETHHjXceXTInAF3ekTcc+rCJ1P14UdFIISD+/NofhLYxc
         tMcg==
X-Gm-Message-State: AOAM531ZLanPbc7MFhoRkeTRxCtnDqOPZz5JMym5Y5p3AQd45tuVlfZW
        16lmJhjtjaxKg9QXc28wy4C19E2vXBmPS/5RI60qY4FCIcuk3qqn8MJk0VkwOYe1Zpoq3MwHoLp
        1W90MzUy4D0A+ejIG2ikUUVQ50cCmSUibShjRxgzo
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr11408639wrp.211.1627162711891;
        Sat, 24 Jul 2021 14:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Kv/M6qskCAa2iYidDcO94F9rO3w70hsI/xsveCv4ij53/4AEZQooofItTEg7clN8/LfjbNCETI0gEwwmduY=
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr11408629wrp.211.1627162711767;
 Sat, 24 Jul 2021 14:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com> <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk>
In-Reply-To: <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 24 Jul 2021 23:38:20 +0200
Message-ID: <CAHc6FU5nGRn1_oc-8rSOCPfkasWknH1Wb3FeeQYP29zb_5fFGQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 10:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Jul 24, 2021 at 12:52:34PM -0700, Linus Torvalds wrote:
> > ...
> > > +                       if (fault_in_user_pages(start, len, true) != len)
> > > +                               return -EFAULT;
> >
> > Looking at this once more, I think this is likely wrong.
> >
> > Why?
> >
> > Because any user can/should only care about at least *part* of the
> > area being writable.
> >
> > Imagine that you're doing a large read. If the *first* page is
> > writable, you should still return the partial read, not -EFAULT.
>
> Agreed.
>
> > So I think the code needs to return 0 if _any_ fault was successful.
>
> s/any/the first/...
>
> The same goes for fault-in for read, of course; I've a half-baked conversion
> to such semantics (-EFAULT vs. 0; precise length is unreliable anyway,
> especially if you have sub-page failure areas), need to finish and post
> it...

Hmm, how could we have sub-page failure areas when this is about if
and how pages are mapped? If we return the number of bytes that are
accessible, then users will know if they got nothing, something, or
everything, and they can act accordingly.

Thanks,
Andreas

