Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D242EB42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhJOIQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:16:21 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35243 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236164AbhJOIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:16:20 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 85FF52B01252;
        Fri, 15 Oct 2021 04:14:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 15 Oct 2021 04:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=A0sZcq8K/bMEVM6Z/GmabDSwCYf
        1knmEGs8b2zvlHhQ=; b=ZzfVVTn6dbh38/j3OKZRepxl9kEa3guxDRvTHgZd9UZ
        5v475Ji0wfwDq8R0BC5n6i6uI1xKhG5QXS0vU3PQrvzwCJVxNVwe4Q3512+yPov1
        FYna5xLUZmgHh55dF+5IblbiJhBiLy5Lk/tOfcYAdbifrOTRSWP62RBtkhSZfW3i
        noblBfXvaOS8rffbJ0VqHO6LzAmEdQpjLKXszHkSSGlYTUuL5UKzyeB7liYAZYFA
        2Ac2+WCIL4kXLzCZd/+moJDiL7W5ZhzTRIdM+zB9s7rqraSsP/ZvtbWGUbH3+yfT
        +XyOdsbt1tSkpZPPAY/l1GmDYFRVKSc1QEpg8utzK4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=A0sZcq
        8K/bMEVM6Z/GmabDSwCYf1knmEGs8b2zvlHhQ=; b=ktnorKikd3Z9v0GZ3qijQN
        mrCxmSbMkQNrE3w3/8mM0hlt+mshhb7YU59TimV2tezcpmFUJPCdswYfjfG7ro47
        PDHegrv1krJQQgFNCwLew5Rpfifynr/p6Dzwe29TSHr18aMmrAwv9eoZhGwTenAs
        /eaS/6rtthi1IAm/k3FWU9/PaxqnQaAnv2pk1NlhQvD4jCGfJSEowNmD9yyxhv36
        R0s/LDMbPXQ7a6tHTzn2lo0nIaLXbG4hI1shprTDIcCKT+wMmhVgqee0b8k0sghz
        +6pzsualiK/tq28vlmbADF/pwGmUP95FCFO/dEHC1SUgpoaYi8h9io+lPLZcDmNw
        ==
X-ME-Sender: <xms:UjhpYRPTiuE9SZFAtEfWxUkUSryt8k573jnHMcFlMSCE7rEiGbJZIQ>
    <xme:UjhpYT8NORnxJzMdUwfTNbaLl-iZE-PH8Vsalz4pXJhFAHbXW010MTQsTbryIUES1
    B8r9WcroCVgRg>
X-ME-Received: <xmr:UjhpYQSWpc5je8X1tcnumCxR0zoEDhW2JunBMtH2lfDL3xU-QQQoq9RWQbEQfk5wAgAOt1NkTHu_7vMzGhe8Ety9oTb2A68l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddugedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:UjhpYdvj28l7TDdqA2-jLKTA9OEvEj_vWHcs9zbvFXVtgalUSfFNwQ>
    <xmx:UjhpYZeKfrVBkpFmWCOcb47rgpnfb4Vfl2NuJXkDQc5pbTelAOf4Ug>
    <xmx:UjhpYZ1Ify1N6dGT5gBMC7Is-KSKADbopgPoGoIPmpwcQbyPWvxJlA>
    <xmx:UjhpYaXwCA88UchI6-C-P-N4WqV4iFPayIOkbPqljl8sh1hLc2T5STfKXGE>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Oct 2021 04:14:09 -0400 (EDT)
Date:   Fri, 15 Oct 2021 10:14:07 +0200
From:   Greg KH <greg@kroah.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v6 1/3] usb: Add Xen pvUSB protocol description
Message-ID: <YWk4T2HTAD3VJMYR@kroah.com>
References: <20211013075207.13910-1-jgross@suse.com>
 <20211013075207.13910-2-jgross@suse.com>
 <YWbKnEMvHGU/rv96@kroah.com>
 <54da6414-4183-2d0c-cc24-a9471ed8332b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54da6414-4183-2d0c-cc24-a9471ed8332b@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:07:35AM +0200, Juergen Gross wrote:
> On 13.10.21 14:01, Greg KH wrote:
> > On Wed, Oct 13, 2021 at 09:52:05AM +0200, Juergen Gross wrote:
> > > Add the definition of pvUSB protocol used between the pvUSB frontend in
> > > a Xen domU and the pvUSB backend in a Xen driver domain (usually Dom0).
> > > 
> > > This header was originally provided by Fujitsu for Xen based on Linux
> > > 2.6.18.
> > > 
> > > Changes are:
> > > - adapt to Linux kernel style guide
> > > - use Xen namespace
> > > - add lots of comments
> > > - don't use kernel internal defines
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > ---
> > >   include/xen/interface/io/usbif.h | 421 +++++++++++++++++++++++++++++++
> > >   1 file changed, 421 insertions(+)
> > >   create mode 100644 include/xen/interface/io/usbif.h
> > > 
> > > diff --git a/include/xen/interface/io/usbif.h b/include/xen/interface/io/usbif.h
> > > new file mode 100644
> > > index 000000000000..9494b1c9be99
> > > --- /dev/null
> > > +++ b/include/xen/interface/io/usbif.h
> > > @@ -0,0 +1,421 @@
> > > +/*
> > > + * usbif.h
> > > + *
> > > + * USB I/O interface for Xen guest OSes.
> > > + *
> > > + * Copyright (C) 2009, FUJITSU LABORATORIES LTD.
> > > + * Author: Noboru Iwamatsu <n_iwamatsu@jp.fujitsu.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to
> > > + * deal in the Software without restriction, including without limitation the
> > > + * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
> > > + * sell copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> > > + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > > + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > > + * DEALINGS IN THE SOFTWARE.
> > > + */
> > 
> > Please use a SPDX line and not license "boilerplate" text like this :(
> 
> Okay. Is this your only concern for this series? Or is it a blocking
> point for you before looking into it in more detail?

It was an easy thing to see at first glance that you hadn't taken my
previous comment about this seriously :(

> IOW: does it make sense for me to wait for further comments before
> sending a new version of the series?

Sure, you can fix this up and resend, it will take a while to review the
host controller code...

thanks,

greg k-h
