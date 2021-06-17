Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A43AAC84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFQGk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhFQGk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F7A613F1;
        Thu, 17 Jun 2021 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623911900;
        bh=NES46J8fLBM5sWODCW8AHAPNTZbARRH1Rzn7KVC8Z6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L42u0fbIEQAvXZf6Gc5BsPkY8+OAyrphe38pHeaoFDtIEeFaiSva1l7BSkdZDGNbi
         XIHYUSj+vTh0VAnmuROhOwd7iisBNas0uDyCl6Jnf06IVBqr3Lgdnu98BktnpJqL7U
         qpxCZfVuZHQyPNr/EZ0ukwgRG7PfSWkT2rBjLZwP35vl+XR0/tJX/CwZgTEuTs2R/y
         C+gCkbJSUNtvGwqc8NGZOGko40E+iO1jbq/T+DN7C2vPQA+wdbFZsfbFWFFrTdoZtO
         3tm4HMbhRB5O5oQbaDimOH1R38z29MtPXOUe8SamCRowmFuTa+Te4wo9MWP4SzA13x
         DZKkNFy2EUSSQ==
Date:   Thu, 17 Jun 2021 08:38:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/29] docs: devicetree: bindings:
 submitting-patches.rst: avoid using ReST :doc:`foo` markup
Message-ID: <20210617083815.3a588868@coco.lan>
In-Reply-To: <CAL_JsqLtZhox5-d81FnWywqM6waBv5fJ26z2n9rMw8wrn4aDqg@mail.gmail.com>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
        <0048c23d47b582dd1a1959628fd2b895209ac826.1623824363.git.mchehab+huawei@kernel.org>
        <CAL_JsqLtZhox5-d81FnWywqM6waBv5fJ26z2n9rMw8wrn4aDqg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 16 Jun 2021 16:08:05 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Wed, Jun 16, 2021 at 12:27 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > The :doc:`foo` tag is auto-generated via automarkup.py.
> > So, use the filename at the sources, instead of :doc:`foo`.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../devicetree/bindings/submitting-patches.rst        | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> > index 104fa8fb2c17..8087780f1685 100644
> > --- a/Documentation/devicetree/bindings/submitting-patches.rst
> > +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> > @@ -7,8 +7,8 @@ Submitting Devicetree (DT) binding patches
> >  I. For patch submitters
> >  =======================
> >
> > -  0) Normal patch submission rules from Documentation/process/submitting-patches.rst
> > -     applies.
> > +  0) Normal patch submission rules from
> > +     Documentation/process/submitting-patches.rst applies.
> >
> >    1) The Documentation/ and include/dt-bindings/ portion of the patch should
> >       be a separate patch. The preferred subject prefix for binding patches is::
> > @@ -25,8 +25,8 @@ I. For patch submitters
> >
> >         make dt_binding_check
> >
> > -     See Documentation/devicetree/bindings/writing-schema.rst for more details about
> > -     schema and tools setup.
> > +     See Documentation/devicetree/bindings/writing-schema.rst for more details
> > +     about schema and tools setup.  
> 
> These don't match $subject.

Well, I just seek for all places where Documentation/* are, and adjusted
them to 80-columns. I'll add a comment. 

> 
> >
> >    3) DT binding files should be dual licensed. The preferred license tag is
> >       (GPL-2.0-only OR BSD-2-Clause).
> > @@ -84,7 +84,8 @@ II. For kernel maintainers
> >  III. Notes
> >  ==========
> >
> > -  0) Please see :doc:`ABI` for details regarding devicetree ABI.
> > +  0) Please see Documentation/devicetree/bindings/ABI.rst for details
> > +     regarding devicetree ABI.  
> 
> Is this new? You did review my oneliner adding ':doc:' not too long ago.

Yes. It is due to some discussion we had upstream:

	https://lore.kernel.org/linux-doc/871r9k6rmy.fsf@meer.lwn.net/

While the html/latex/pdf output is identical (as automarkup.py will
convert Documentation/foo.rst into a cross-reference), using full path
names allow developers to jump directly to other documents when they
have the path name.

> 
> >
> >    1) This document is intended as a general familiarization with the process as
> >       decided at the 2013 Kernel Summit.  When in doubt, the current word of the
> > --
> > 2.31.1
> >  



Thanks,
Mauro
