Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB729453377
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhKPODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236943AbhKPODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637071235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQWT9RsItIh3/PVThc0IzK61qGCHH7mYKsvmzbBvIIU=;
        b=ipFEV9z+5N0l7ZXte9d/sXOnmSuRcgq/ckodIqCApH7lSVfsWgvkzM/c2h32VWj9jjX0MT
        A8TadtOAJV5BGUDWCBSZNWgIbNihCk46KC8zNr9QFSN7iwzVuT4cIwUgjvRxrSTF7uIxAx
        x2ZG2gd9/XsZQeg5JzW1DaozKWgsWzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-f3rT5ZM8NDKMecXsOb6kyg-1; Tue, 16 Nov 2021 09:00:33 -0500
X-MC-Unique: f3rT5ZM8NDKMecXsOb6kyg-1
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so1509402wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQWT9RsItIh3/PVThc0IzK61qGCHH7mYKsvmzbBvIIU=;
        b=owh6//b9LB8NsCo+X54X61Nz4kcbujBtAfgi+qh8kAs9SKva4Sn/UC82r92l9jbk2E
         C8gVBgKZwC7fOeAHk7Zs+FNRUhZ9iUUCFGDM3xfPAKDVadEHQiKrJJlTbKazo9rrOAQ0
         9CePepIDazVhKjADmJ6F2pzu0LYuCcLstOBaaH46vuLdOpVFurU/sPJuzobQLi0l6ZzB
         D6cI65xstEDMPRxDtWDBJFpLvdz7FcVDva1bUtHXfxdecRw0qsh8p4JsUe4NVuO2kxVX
         sqU4VH6ukdkC6mmkrbUqzCPLQm81CobyheFvRQ1vUa+slGQ3AT3Ibh5IQQP5IcLZ9V7l
         CegA==
X-Gm-Message-State: AOAM532IMIWGDqUsqbnBo0GExVhCkgeR7yFtk4SORjmow6IPLNmGFaTL
        yNhUyHngWPvHXCi3UuykCAdRjdFHl57YzdDDOhKbdcoUPRoplvD2Bpen/BfmITWeds1Z9pxbmoD
        W/qxyda+Da/P5Cp7fSBW+vlsZMEMyZd1SCNqEEiFU
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr71507125wmh.19.1637071231298;
        Tue, 16 Nov 2021 06:00:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrxhf6z7sBAJvOpOOUlfL2JU/LuAMJYJ+PkN53D7lmXU6CXnBwDHswetyBwnxBUgS4/QIsBFAXBYWEfbCCjFQ=
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr71507103wmh.19.1637071231144;
 Tue, 16 Nov 2021 06:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20211115165313.549179499@linuxfoundation.org> <20211115165315.847107930@linuxfoundation.org>
 <CAHc6FU7a+gTDCZMCE6gOH1EDUW5SghPbQbsbeVtdg4tV1VdGxg@mail.gmail.com>
 <YZMBVdDZzjE6Pziq@sashalap> <CAHc6FU4cgAXc2GxYw+N=RACPG0xc=urrrqw8Gc3X1Rpr4255pg@mail.gmail.com>
 <YZO4wIfpjxnzZjuh@kroah.com>
In-Reply-To: <YZO4wIfpjxnzZjuh@kroah.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 16 Nov 2021 15:00:19 +0100
Message-ID: <CAHc6FU7BU2-B2x=JV0HtLci6=mGy2XxLNNGh1f4DGtVbeJFcVA@mail.gmail.com>
Subject: Re: [PATCH 5.4 063/355] powerpc/kvm: Fix kvm_use_magic_page
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 2:57 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 16, 2021 at 02:54:10PM +0100, Andreas Gruenbacher wrote:
> > On Tue, Nov 16, 2021 at 1:54 AM Sasha Levin <sashal@kernel.org> wrote:
> > > On Mon, Nov 15, 2021 at 06:47:41PM +0100, Andreas Gruenbacher wrote:
> > > >Greg,
> > > >
> > > >On Mon, Nov 15, 2021 at 6:10 PM Greg Kroah-Hartman
> > > ><gregkh@linuxfoundation.org> wrote:
> > > >> From: Andreas Gruenbacher <agruenba@redhat.com>
> > > >>
> > > >> commit 0c8eb2884a42d992c7726539328b7d3568f22143 upstream.
> > > >>
> > > >> When switching from __get_user to fault_in_pages_readable, commit
> > > >> 9f9eae5ce717 broke kvm_use_magic_page: like __get_user,
> > > >> fault_in_pages_readable returns 0 on success.
> > > >
> > > >I've not heard back from the maintainers about this patch so far, so
> > > >it would probably be safer to leave it out of stable for now.
> > >
> > > What do you mean exactly? It's upstream.
> >
> > Mathieu Malaterre broke this test in 2018 (commit 9f9eae5ce717) but
> > that wasn't noticed until now (commit 0c8eb2884a42). This means that
> > this fix probably isn't critical, so I shouldn't be backported.
>
> Then why did you tag it to be explicitly backported to all stable
> kernels newer than 4.18?

Well, sorry for that. What else do you expect me to do in addition to
pointing out the mistake?

Thanks,
Andreas

