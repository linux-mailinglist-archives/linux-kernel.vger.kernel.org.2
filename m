Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4743D81F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhJ1A3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhJ1A3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:29:43 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:27:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i14so5846225ioa.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8m0fEvNaJU95RYH2afnAHTcF2ogyu1uTCTqMVbN47Q=;
        b=YRrvvDf+LqvbcR1yxFKtOH8Mau0goOw5tPN4QG0cAgY35kwTkGsp8RHZqJAlAhhc4Y
         Cs8WiLIa3euVsYuc6bJ/2vQPai1XQS82vyYogxWsPsLxn+UNkcaAQH2QWUwM5dhPJWc7
         WypDUxzbRdVmerKv7O5CdHAbjQvrabsdJMA8dUkLukcFIabI6c59z1lxCfJJ/DkcW3Si
         NqeThArgeTgSnVOGns3L4FJZv4xhp0wX92m+aXdmHY7nCmpu0V4IDCilzzty5WZ6n6ZE
         HmWXqzY56sifJ/BGk9Ome5AUEL+CCcgMKDUX5AzzNnWvTe5bQtKqOMdpROzXmdlAjEKX
         W4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8m0fEvNaJU95RYH2afnAHTcF2ogyu1uTCTqMVbN47Q=;
        b=zTFUcJcbr5R0GK2WQNiePq0+HV2qHbqzLMfeil9pZXCjaGnF2fb7MUDeywoOkhZVlf
         HNUjutfHILQLiGA8fQQ+l/ozm6I0HkKHXJY/XxwBTxli0lt8HXH8roeBbewyJHXpK243
         Sxg587y4uZ2cKG3aBIbcEpdS6d9jJ5ZGPaDAbFm8icVD38StDeog02NRUyYz2zwJVcoT
         Nf/95ISSuF9kUVHtyDuZJemFYM5WJ0JePDQAtQbJXhSY3SH+xsH6UcICYH19UUD9q6Dk
         IZFWBE7v9Kcrce8CxNKk00oCHercGTRD4X5Y+AISFkgdp5Mq4k777JEIkbA7W2bkBhPL
         +OXg==
X-Gm-Message-State: AOAM533QVhrdhxL3LOwY5gEkDCPnZCSIfBoCN4PIZOsVaDB1W62NDIcp
        IHRNjirjfJve+drAD0txeoR1EQfsWFNXzAwu6T26EA==
X-Google-Smtp-Source: ABdhPJwyw63144CGFcWfrLqbMXt0o9IUrInz6dSxLpKwKOGw1/p5eW8eUbkUTp7bNuYGjAeQIn9ZmrD0yUf2sapIyIY=
X-Received: by 2002:a05:6602:148b:: with SMTP id a11mr595213iow.85.1635380837204;
 Wed, 27 Oct 2021 17:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOhMmr7bWv_UgdkFZz89O4=WRfUFhXHH5hHEOBBfBaAR8f4Ygw@mail.gmail.com>
 <CA+h21hqrX32qBmmdcNiNkp6_QvzsX61msyJ5_g+-FFJazxLgDw@mail.gmail.com>
 <YXY15jCBCAgB88uT@d3> <CA+pv=HPyCEXvLbqpAgWutmxTmZ8TzHyxf3U3UK_KQ=ePXSigBQ@mail.gmail.com>
 <61f29617-1334-ea71-bc35-0541b0104607@pensando.io> <20211027123408.0d4f36f2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <61e27841-5ceb-1975-ab3b-abdf8973c9f2@eaglescrag.net>
In-Reply-To: <61e27841-5ceb-1975-ab3b-abdf8973c9f2@eaglescrag.net>
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Wed, 27 Oct 2021 20:27:06 -0400
Message-ID: <CA+pv=HOyQHAzeYJwZmp_gncxj-iXmFL7kYowbYfwf1ntc64rgg@mail.gmail.com>
Subject: Re: Unsubscription Incident
To:     "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Shannon Nelson <snelson@pensando.io>,
        Benjamin Poirier <benjamin.poirier@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Lijun Pan <lijunp213@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 4:42 PM John 'Warthog9' Hawley
<warthog9@eaglescrag.net> wrote:
>
> On 10/27/21 12:34 PM, Jakub Kicinski wrote:
> > On Mon, 25 Oct 2021 11:34:28 -0700 Shannon Nelson wrote:
> >>>> It happened to a bunch of people on gmail:
> >>>> https://lore.kernel.org/netdev/1fd8d0ac-ba8a-4836-59ab-0ed3b0321775@mojatatu.com/t/#u
> >>> I can at least confirm that this didn't happen to me on my hosted
> >>> Gmail through Google Workspace. Could be wrong, but it seems isolated
> >>> to normal @gmail.com accounts.
> >>>
> >>> Best,
> >>>
> >>
> >> Alternatively, I can confirm that my pensando.io address through gmail
> >> was affected until I re-subscribed.
> >
> > Did it just work after re-subscribing again? Without cleaning the inbox?
> > John indicated off list that Gmail started returning errors related to
> > quota, no idea what that translates to in reality maybe they added some
> > heuristic on too many emails from one source?
>
> At least for the users I've had anyone mention to me (which for the
> record apparently this happened on the 11th, and people are only
> reaching out now about), the reasons for the unsubscribe was that the
> upstream servers were reporting that the users in question were over
> quota permanently.  We take that hinting at face value, and since the
> server is telling us (basically) that the user isn't going to be
> accepting mail anytime soon, we go ahead and unsubscribe them and clear
> the queue so that the users don't cause unnecessary back log.  Noting,
> this is an automated process that runs and deals with this that runs
> periodically.
>
> Also noting, that there's not a good way to notify individuals when this
> happens because, unsurprisingly, their email providers aren't accepting
> mail from us.
>
> If folks reach out to postmaster@ I'm more than happy to take a look at
> the 'why' something happened, and I'm happy to re-subscribe folks in the
> backend saving them the back and forth with majorodomo's command system.
>

John,
That's great.

>
> If I had to speculate, something glitched at gmail, a subset of users
> got an odd error code returned (which likely wasn't the correct error
> code for the situation, and noting the number of affected users is
> fairly small given the number of users from gmail that are subscribed).
>  Likely similar to when gmail had that big outage and it reported
> something way off base and as a result every gmail user got unsubscribed
> (and subsequently resubscribed in the backend by me when the outage was
> over).
>

Is there any way to detect if something like that affects Google
Workspace hosted inboxes too? Sounds like those in that group who were
affected were very few though but I thought I'd ask anyway.

>
> - John 'Warthog9' Hawley
>

Thanks,
             -slade
