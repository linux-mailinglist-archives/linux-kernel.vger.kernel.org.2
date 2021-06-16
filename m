Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174383AA535
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhFPUYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 16:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233355AbhFPUYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 16:24:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF5FD60FF4;
        Wed, 16 Jun 2021 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623874922;
        bh=QTWcOvraqZaabAlaEhyvzzla1yuYg5YKUaWR97ZT/hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AGAbp3C+e5xX2UZoz+OqLZj9hRzEeydmomx2MFWpcD3VSHZdXeqpiWhUASFr/2Ac4
         /U87a6HJuPPq8Ry/zWJMXdos4hEWQnA2g0ywkosMq0haA5x14G46Z8ijbANhXzOv+G
         FxDOf/Hiwio6ddijD9MSJR0daL79+QECSfaYxcoBFSAqqGCe0mEZTefuoeAgVIB0nB
         RUeoDuoKt27WjiYpw/37+TEWPwPPp6blmBvf5fQ6M4Ts+bPGU0lo59eTzvGqwUTiLI
         JyvNcPQbwvvQydjCJIyu+RTGqLwfeb//fOyot2hpa40S1/BgqCA/iKViNcwQan/fk+
         V6CEHQET4NM2Q==
Date:   Wed, 16 Jun 2021 22:21:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     mark gross <mgross@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/29] docs: admin-guide: hw-vuln: avoid using ReST
 :doc:`foo` markup
Message-ID: <20210616222156.3727599d@coco.lan>
In-Reply-To: <20210616182128.GJ70758@linux.intel.com>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
        <4e378517761f3df07165d5ecdac5a0a81577e68f.1623824363.git.mchehab+huawei@kernel.org>
        <20210616182128.GJ70758@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 16 Jun 2021 11:21:28 -0700
mark gross <mgross@linux.intel.com> escreveu:

> On Wed, Jun 16, 2021 at 08:27:19AM +0200, Mauro Carvalho Chehab wrote:
> > The :doc:`foo` tag is auto-generated via automarkup.py.  
> and that is not good why?

Patch 00 contains a little more info:

	https://lore.kernel.org/linux-doc/cover.1623824363.git.mchehab+huawei@kernel.org/T/#t

Basically, some Kernel developers rely on editor features to jump directly
into other files. Using Documentation/foo.rst enable such features.

> 
> > So, use the filename at the sources, instead of :doc:`foo`.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../hw-vuln/special-register-buffer-data-sampling.rst          | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> > index 3b1ce68d2456..966c9b3296ea 100644
> > --- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> > +++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst
> > @@ -3,7 +3,8 @@
> >  SRBDS - Special Register Buffer Data Sampling
> >  =============================================
> >  
> > -SRBDS is a hardware vulnerability that allows MDS :doc:`mds` techniques to  
> I thought the point of :doc:`mds` was to insert a tag or link to the mds
> document.
> 
> > +SRBDS is a hardware vulnerability that allows MDS
> > +Documentation/admin-guide/hw-vuln/mds.rst techniques to  
> will this make a hyper-link in generated HTML docs?

It will still generate the same hyper-links in HTML, LaTeX and PDF outputs,
as the automarkup.py extension will convert Documentation/foo.rst into
doc:`foo`.


> 
> FWIW I'm ok with this change either way.  I just wanted to understand a little
> better.
> 
> --mark
> 
> >  infer values returned from special register accesses.  Special register
> >  accesses are accesses to off core registers.  According to Intel's evaluation,
> >  the special register reads that have a security expectation of privacy are
> > -- 
> > 2.31.1
> >   



Thanks,
Mauro
