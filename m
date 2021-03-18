Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334A93407B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCROVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCROVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:21:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7821E64EF9;
        Thu, 18 Mar 2021 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616077269;
        bh=fIdVVkOWf8byJSCanlFq6jbRjFI1tGNgEbHl2JUMFcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gisaDKEHd5ULsXqZAK58LwuAcwki1SzbLOEgEfz7vJ3zHioz4lEvM/6jVUYi3D9i0
         ofp8v9PPnneUt1HYpzSynoQwMEXOCSGH4+3VUMjQdHlnfvOaQIMfuGKkTITSgizsqW
         OAtFrFu7FyMlRuikftqJwvwWldVHLTb/CqwIUazzSfD3Mykl/ZzY32lkid8Yl0QSuB
         ut1PJDKK/IfCVtAJ9lJTvEa8exQpKXJKh7nuxKlotrgz2uArtZHfvulfdCK6UrngbN
         EW0BFU+cJoLEWAC6GDAUoa8kgzQXjXqoyJeN+Tqjx5BtFvXLZJpcsfxauJhtOhh66C
         IwS6qxV6DUzoQ==
Received: by mail-oi1-f177.google.com with SMTP id x78so1719428oix.1;
        Thu, 18 Mar 2021 07:21:09 -0700 (PDT)
X-Gm-Message-State: AOAM532H55E/UQlXlwlWO+vea5XzekQEirJYbmQChrkDwXNt47855D/+
        lzY3oPTsZzjOJGxcFCCK0drwNKZuAESuQT61sPc=
X-Google-Smtp-Source: ABdhPJwkzJJoGyFNoBEcH0V9lAMmUPwLUkV5gfRYbbbYP6tDs7IEkjae9pMdsbcOpzcGiTenfGqgmZVIRrkGqRJXB0M=
X-Received: by 2002:aca:1a01:: with SMTP id a1mr3241169oia.33.1616077268763;
 Thu, 18 Mar 2021 07:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
 <20210318104433.GA6959@willie-the-truck> <20210318112859.GA25002@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210318112859.GA25002@e121166-lin.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 Mar 2021 15:20:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGhpKCWo2MSvKZMHiZFwzoD=AXNDnNhshiq1zk2BEniDw@mail.gmail.com>
Message-ID: <CAMj1kXGhpKCWo2MSvKZMHiZFwzoD=AXNDnNhshiq1zk2BEniDw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Tom Saeger <tom.saeger@oracle.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ahs3@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 at 12:29, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> [+ Al, Ard]
>
> On Thu, Mar 18, 2021 at 10:44:33AM +0000, Will Deacon wrote:
> > [+Lorenzo]
> >
> > On Tue, Mar 16, 2021 at 12:50:41PM -0600, Tom Saeger wrote:
> > > In commit 94bccc340710 ("iscsi_ibft: make ISCSI_IBFT dependson ACPI instead
> > > of ISCSI_IBFT_FIND") Kconfig was disentangled to make ISCSI_IBFT selection
> > > not depend on x86.
> > >
> > > Update arm64 acpi documentation, changing IBFT support status from
> > > "Not Supported" to "Optional".
> > > Opportunistically re-flow paragraph for changed lines.
> > >
> > > Link: https://lore.kernel.org/lkml/1563475054-10680-1-git-send-email-thomas.tai@oracle.com/
> > >
> > > Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> > > ---
> > >  Documentation/arm64/acpi_object_usage.rst | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Lorenzo, please could you ack the change below if you're happy with it?
> > If so, I can take it as a fix.
>
> I don't see any issue with this patch, more so given that the IBFT
> legacy discovery method was decoupled from the ACPI table method,
> so it looks sound on ARM64.
>
> However, I would like to get Al and Ard opinions on this to make sure
> there is not something I am missing (in particular wrt the rationale
> behind the "Not Supported" in the docs).
>

Both the original change and this documentation change look fine to me.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
