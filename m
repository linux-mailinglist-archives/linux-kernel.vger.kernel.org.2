Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3459C3FDEAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbhIAPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244357AbhIAPbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67A2E61059;
        Wed,  1 Sep 2021 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630510205;
        bh=nCh6zNcho5BtR/i0GnEfEV1QeXQKLNeQ8tDuAktq0JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLqoLyzmpO2v8y46e4RXFml+xxeWOSTsXsoNUVaLYym2BbF7+yqAf2W0RIftnEs8l
         DgsaKZ+bMWq5NL8fopxO1+ejhrqPTC/Rwg5EqxTGfUIl5QLat4R1oP4KGnjmKrp7n7
         KVEhTbsrvMxrl1WOLWySD8kfgFtvBhnxOjePpaPA=
Date:   Wed, 1 Sep 2021 17:30:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krish Jain <krishjain02939@gmail.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <YS+cexhuqldPaACs@kroah.com>
References: <20210829144531.c2syu4vv4s22dlg7@h510>
 <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
 <20210831133533.6aayzjghdakrhy56@h510>
 <13366651.n50aozgL3V@localhost.localdomain>
 <20210831230014.cp46vho2hnndacjp@h510>
 <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 05:20:13PM +0200, Krish Jain wrote:
> On Wed, Sep 1, 2021 at 1:00 AM Bryan Brattlof <hello@bryanbrattlof.com> wrote:
> >
> > On this day, August 31, 2021, thus sayeth Fabio M. De Francesco:
> > >
> > > I just want to *really* thank you for the hard work you got involved and that
> > > you carried out with one of the highest levels of professionalism (and
> > > patience :)) very few of us could ever equal (not I, for sure).
> > >
> > > I thank you also not for the technical hints you gave to Krish, instead for
> > > your your choice "to not rob [you] Krish the opportunity to learn".
> > >
> > > Actually I was tempted to write something like "first do this, than that, and
> > > finally run this tool". But I was able to desist, by learning from you how
> > > people should be helped for real.
> > >
> > > Most of us here should learn by your attitude.
> > >
> > > Thanks again, seriously.
> > >
> >
> > Thank you for such kind words, Fabio.
> >
> > I was very lucky to be, and still am, surrounded by people who
> > demonstrated this idea to me when I was young. I am very happy to see
> > others here see how beneficial and helpful (in the long term) learning
> > this way can be.
> >
> > I'm grateful to have found and be a part of this community.
> > ~Bryan
> >
> 
> 
> 
> Interesting.
> 
> "make drivers/staging/android/ " works now (finally!) and shows me the
> errors when I mess up in the file  ashmem.c for example.
> Furthermore, " make CCFLAGS=-Werror W=1 drivers/staging/android/    "
> outputs the same errors too just more verbose. So it works completely
> now, However, "make CCFLAGS=-Werror W=1 M=drivers/staging/android/
> " just takes to new prompt line and does not output anything. Do you
> know why?

"M=pathname" is different than "pathname", you are asking for different
things to happen here, so depending on your kernel configuration,
different things will be built (or not built).

And don't mes with CCFLAGS settings for building the kernel unless you
_really_ know what you are doing.  For staging tree work, it's not
advised at all.

good luck!

greg k-h
