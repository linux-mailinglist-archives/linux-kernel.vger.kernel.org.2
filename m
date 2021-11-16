Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15537453430
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhKPOdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229739AbhKPOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637073052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGLlb2K1KnZJ8ryHE7dGxeg/3e8ozhLXbMUxWhBTJfg=;
        b=UudBm6wdgmJ4kALlTz63qQNkziF7kXOINDvQI1UAJwgKuUpPKp8UCT0V4j/208G1BFQYTW
        ax78ilIVQMdNz0vuXFytnkXa5A4NGB85TQ9m4IjovDiFA9Aa7Gqz8prrUSZtpFcM158iHf
        ORwfLxA83hvoBIdQKV3VvPNhSyCRc88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-ArEdRfuQNniYOwp8p3EbZA-1; Tue, 16 Nov 2021 09:30:51 -0500
X-MC-Unique: ArEdRfuQNniYOwp8p3EbZA-1
Received: by mail-wm1-f72.google.com with SMTP id o10-20020a05600c4fca00b0033312e1ed8bso1567002wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGLlb2K1KnZJ8ryHE7dGxeg/3e8ozhLXbMUxWhBTJfg=;
        b=J2CGGy89rNjriro8NC4wvmc8NyiEMK8y69aU9NXRk96bLhMe1PsEBGkNrN8XziCcBl
         sJcMdNrT/NdWSGHiei13Et4Kf3HMAcCmly4CGhYuMQDqNqkplVioyZZj4LWDz+fOGTmh
         XCqb5nGorPSr2JvklnuxlnBmnEVKGnPhqC9yGcovBrJdo1Uop4wZQCydZFjlyCx9QL5a
         rKfzy/qFZkTQRB/fG0TDAt1yhJc1weOTVn4atgL6BnTGVvVt+Um2ckrdKUkIplXUhAMr
         ZL51TBSU2+QK/mxOBSH4btFPh30p3dLj6NzmkEipl+1m2ZzAjSMqq1PQ9UQXuNIuK9u3
         2CSA==
X-Gm-Message-State: AOAM5305EGs18v7+qeR68XEAueaxHGB7ECa2drSl2thBXR0JAKRfGqFa
        J3dYJ9lpnzq55tYtBkbwhCVPN53r5SR2mkZUAnZnDaq6DtzJRkp0NLUEe1RxrbTBJ68GiVTHvJm
        xnUD0w6tCL3izI0ioPoWr0rAiI6lnW+imUzjx28an
X-Received: by 2002:a5d:628f:: with SMTP id k15mr10058476wru.363.1637073048898;
        Tue, 16 Nov 2021 06:30:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwQ9c1DU7hDbd1YcLisoG+/tIlG+wgenks4qBRCL9wz5r2a/gmGwOMoiIhDt4fczvM+rVPkw3QVsAVHXwsGUM=
X-Received: by 2002:a5d:628f:: with SMTP id k15mr10058457wru.363.1637073048723;
 Tue, 16 Nov 2021 06:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20211115165313.549179499@linuxfoundation.org> <20211115165315.847107930@linuxfoundation.org>
 <CAHc6FU7a+gTDCZMCE6gOH1EDUW5SghPbQbsbeVtdg4tV1VdGxg@mail.gmail.com>
 <YZMBVdDZzjE6Pziq@sashalap> <CAHc6FU4cgAXc2GxYw+N=RACPG0xc=urrrqw8Gc3X1Rpr4255pg@mail.gmail.com>
 <YZO4wIfpjxnzZjuh@kroah.com> <CAHc6FU7BU2-B2x=JV0HtLci6=mGy2XxLNNGh1f4DGtVbeJFcVA@mail.gmail.com>
 <YZO9Bv3yJC5P92c8@kroah.com>
In-Reply-To: <YZO9Bv3yJC5P92c8@kroah.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 16 Nov 2021 15:30:37 +0100
Message-ID: <CAHc6FU74ih7Sk7tWmvMy9OsyO2=f0cO7fUoBREKnFQSKf+zyig@mail.gmail.com>
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

On Tue, Nov 16, 2021 at 3:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 16, 2021 at 03:00:19PM +0100, Andreas Gruenbacher wrote:
> > On Tue, Nov 16, 2021 at 2:57 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Nov 16, 2021 at 02:54:10PM +0100, Andreas Gruenbacher wrote:
> > > > On Tue, Nov 16, 2021 at 1:54 AM Sasha Levin <sashal@kernel.org> wrote:
> > > > > On Mon, Nov 15, 2021 at 06:47:41PM +0100, Andreas Gruenbacher wrote:
> > > > > >Greg,
> > > > > >
> > > > > >On Mon, Nov 15, 2021 at 6:10 PM Greg Kroah-Hartman
> > > > > ><gregkh@linuxfoundation.org> wrote:
> > > > > >> From: Andreas Gruenbacher <agruenba@redhat.com>
> > > > > >>
> > > > > >> commit 0c8eb2884a42d992c7726539328b7d3568f22143 upstream.
> > > > > >>
> > > > > >> When switching from __get_user to fault_in_pages_readable, commit
> > > > > >> 9f9eae5ce717 broke kvm_use_magic_page: like __get_user,
> > > > > >> fault_in_pages_readable returns 0 on success.
> > > > > >
> > > > > >I've not heard back from the maintainers about this patch so far, so
> > > > > >it would probably be safer to leave it out of stable for now.
> > > > >
> > > > > What do you mean exactly? It's upstream.
> > > >
> > > > Mathieu Malaterre broke this test in 2018 (commit 9f9eae5ce717) but
> > > > that wasn't noticed until now (commit 0c8eb2884a42). This means that
> > > > this fix probably isn't critical, so I shouldn't be backported.
> > >
> > > Then why did you tag it to be explicitly backported to all stable
> > > kernels newer than 4.18?
> >
> > Well, sorry for that. What else do you expect me to do in addition to
> > pointing out the mistake?
>
> Ah, I think we are misunderstanding each other here.  I will go drop it,
> but in the future maybe "hey, I didn't mean to mark this for stable, can
> you please drop it?" might be a bit more direct and to the point.

Yes, the stable Cc was an accident on my side (caused by a script that
takes a SHA1 and spits out Fixes: and Cc: tags). Sorry and thanks for
dropping the patch.

Andreas

