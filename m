Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFE3DF6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhHCVjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232384AbhHCVjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628026772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EM3F3OHS2L2GE9YJO2LmAbAEq5eEZ/246ein95lIcos=;
        b=Jbvn6aBnx4MaTAoXGn+r9TlxfTQ12mkXa7m512U6/dsKOeju9fVlnBskHUEnmXG2ZnYPtq
        KVsMLdGCfY4XMxLukkaokv1SlaXG/1WOBnu/0FnbW0026QJJamrqXnKvsiH6B+B72mEPhZ
        3ZqmYiy8uOfrlfBEwJqDYzn2dPnEt/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-8QIFatvCNxSMjOj-_xV6uQ-1; Tue, 03 Aug 2021 17:38:25 -0400
X-MC-Unique: 8QIFatvCNxSMjOj-_xV6uQ-1
Received: by mail-wm1-f72.google.com with SMTP id o26-20020a05600c511ab0290252d0248251so166406wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 14:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EM3F3OHS2L2GE9YJO2LmAbAEq5eEZ/246ein95lIcos=;
        b=glm9XNeHKAPnUg+XPX70BOswYWhNFMhqOnN0lOQXR9KLJnuIT7mcgxO+hacStjc0Jy
         NNzGn6+oLRfpjItCrbLjL8WmjQr2K9d52yX74FQQjDE/PLGIFrv+wiQT6P0AU5mTLZO/
         g7UIVqoTDUp1DhN7Ioe96VK0txnNTBnUeOnrA/3pErV95efvbW6YAzXahBWis4FrWUYD
         810CtLz7EkQNhXa6Va5U3D9fmX6wMVL6mg1mr0srLApRUKXeFj+jS0EWfHvTi50E7OMg
         mSInVNlByScXGiOCNacK/UUHoajzVrqtljoUfaAcGUkDKJ8gtTLMKW3ywH6F6iFkQEi0
         D5lA==
X-Gm-Message-State: AOAM530/ua8OAT9x1uc0hEG71a6Bx0YGyqaROvIJQ+fynV3PT7V4sGR/
        ZEHDY/20DY0r2dG+BAc1gX8mmHXFO4AcKIjiEe3ZLCBxDLVhGi0yBUjU9imaKgun6ZRjlipEZa0
        dXAs3sukrf9WI+7RP2GNTZu9p3rzCLrbNyjZ7vZpj
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr24885007wrl.357.1628026704024;
        Tue, 03 Aug 2021 14:38:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZzs1zl2V3LTsadj+4bR4O6BnVBDX/GlTJnBJVWvnotmNbJsR03yyQqgOjRCTvd6UqzZnYP7e1CCrvtQ8KSCA=
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr24884995wrl.357.1628026703875;
 Tue, 03 Aug 2021 14:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <20210803191818.993968-4-agruenba@redhat.com>
 <YQmtnuqDwBIBf4N+@zeniv-ca.linux.org.uk>
In-Reply-To: <YQmtnuqDwBIBf4N+@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 Aug 2021 23:38:12 +0200
Message-ID: <CAHc6FU7iAPOPO7gtDjpSAVyHwgJ7HQPEhDC_2T__DM8GPW5crQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] Turn fault_in_pages_{readable,writeable} into fault_in_{readable,writeable}
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 10:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Aug 03, 2021 at 09:18:09PM +0200, Andreas Gruenbacher wrote:
> > Turn fault_in_pages_{readable,writeable} into versions that return the number
> > of bytes faulted in instead of returning a non-zero value when any of the
> > requested pages couldn't be faulted in.  This supports the existing users that
> > require all pages to be faulted in, but also new users that are happy if any
> > pages can be faulted in.
> >
> > Neither of these functions is entirely trivial and it doesn't seem useful to
> > inline them, so move them to mm/gup.c.
> >
> > Rename the functions to fault_in_{readable,writeable} to make sure that code
> > that uses them can be fixed instead of breaking silently.
>
> Sigh...  We'd already discussed that; it's bloody pointless.  Making short
> fault-in return success - absolutely.  Reporting exact number of bytes is
> not going to be of any use to callers.

I'm not actually convinced that you're right about this. Let's see
what we'll end up with; we can always strip things down in the end.

Thanks,
Andreas

