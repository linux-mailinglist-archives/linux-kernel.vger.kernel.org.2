Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAD39C9CB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFEQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 12:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 12:15:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 415F261107;
        Sat,  5 Jun 2021 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622909598;
        bh=SA5TEU+2VLG56VJsWiXFfbq1+IATGpk0WcRtynKouYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h8je3nNfdPMWLaSstwksH2HUFfv92PhNait5QX6wGaW6wJu2PYnONmGWNPvewgMMx
         m2coc7Ajx5QYNAsd5PcE29AshjLvujwf98ajO97ibsGlQQgt/IPk27C7jmA6y1YDjo
         v43xIsTn2ZMs7T/EvAj/7enc6bO/84cIzevLaAN8fCaUxru1ZIV5LLK3VvKHLvb7P/
         nKgHGI9mndrTluywCQaCpxcoY9SgrLknMuxrB8GJe+dmm+UXEAkcvus0sObF79ELu1
         SMI1GCWHejulJjZttGbpzs0xfiuw5cPmllOOhs88CWLQPpG+GeerS6zMVTsnxbZFGx
         PylZk6V8d1e6w==
Date:   Sat, 5 Jun 2021 18:13:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Marco Elver <elver@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/34] docs: dev-tools: testing-overview.rst: avoid
 using ReSt :doc:`foo` markup
Message-ID: <20210605181314.1e76f10d@coco.lan>
In-Reply-To: <CABVgOS=vcZX5w4tyQg9nsDyJ0sKdS-McgVNzVd9mqeLy1NTCFA@mail.gmail.com>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
        <63fe86c8de5cced00a1bb5d18d6c7f087268565a.1622898327.git.mchehab+huawei@kernel.org>
        <CABVgOS=vcZX5w4tyQg9nsDyJ0sKdS-McgVNzVd9mqeLy1NTCFA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 5 Jun 2021 23:43:55 +0800
David Gow <davidgow@google.com> escreveu:

> On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > The :doc:`foo` tag is auto-generated via automarkup.py.
> > So, use the filename at the sources, instead of :doc:`foo`.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---  
> 
> Hmm... I'd originally wanted this to read more like the name of the
> tool than the path to the doc file, but given the :doc: prefix and
> backticks are equally ugly, and no less confusing to the plain-text
> reader than the filename, I'm happy to have this changed. Particularly
> if we're standardising on this across the kernel documentation.

Yeah, the idea is to avoid :doc: treewide, at least for simple cases.

I'm proposing that we should still keep using:

	:doc:`some description <foo>`

for named references, which is still ugly in plain-text, but can be
used to provide a better hyperlink when the docs are converted
into html/LaTeX/pdf, as it would be converted (in html) as:

	<a href="foo.html">some description</a>

> Reviewed-by: David Gow <davidgow@google.com>

Thanks!
Mauro

> 
> 
> -- David
> 
> >  Documentation/dev-tools/testing-overview.rst | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> > index b5b46709969c..65feb81edb14 100644
> > --- a/Documentation/dev-tools/testing-overview.rst
> > +++ b/Documentation/dev-tools/testing-overview.rst
> > @@ -71,15 +71,15 @@ can be used to verify that a test is executing particular functions or lines
> >  of code. This is useful for determining how much of the kernel is being tested,
> >  and for finding corner-cases which are not covered by the appropriate test.
> >
> > -:doc:`gcov` is GCC's coverage testing tool, which can be used with the kernel
> > -to get global or per-module coverage. Unlike KCOV, it does not record per-task
> > -coverage. Coverage data can be read from debugfs, and interpreted using the
> > -usual gcov tooling.
> > +Documentation/dev-tools/gcov.rst is GCC's coverage testing tool, which can be
> > +used with the kernel to get global or per-module coverage. Unlike KCOV, it
> > +does not record per-task coverage. Coverage data can be read from debugfs,
> > +and interpreted using the usual gcov tooling.
> >
> > -:doc:`kcov` is a feature which can be built in to the kernel to allow
> > -capturing coverage on a per-task level. It's therefore useful for fuzzing and
> > -other situations where information about code executed during, for example, a
> > -single syscall is useful.
> > +Documentation/dev-tools/kcov.rst is a feature which can be built in to the
> > +kernel to allow capturing coverage on a per-task level. It's therefore useful
> > +for fuzzing and other situations where information about code executed during,
> > +for example, a single syscall is useful.
> >
> >
> >  Dynamic Analysis Tools
> > --
> > 2.31.1
> >  



Thanks,
Mauro
