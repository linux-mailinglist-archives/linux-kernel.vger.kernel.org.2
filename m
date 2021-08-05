Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA23E0E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 08:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbhHEGpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 02:45:15 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37194
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237906AbhHEGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:45:12 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 50B6640642
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628145898;
        bh=lf78NJpzyTn5+xfO0MJuGl1hxrAd7DxHOuUABJBSCnA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WreLCdu+LvqkamrV/3Mn7SC2V/2AwDT27sB+ljNBhs/yw7XeJscQKp8wCkS3sil/Q
         s2HZHuGQ7UQi1nqr+TqR0HQI8Brh34FuDml+7Tf3wh3xkOLOq0NFsGdQ4U33QuXreF
         /F2J0pYrc4J/dhz5RzIQwwXJZBZpB8KoeTJcRQI6+gTTbc0cFVYk2yAZAiyrJeIal/
         VwNUEELZDMuJp+5ZQ8G2Y2NjmuWyEFeElZQk1rblsz7u1kSptDxyIG2hbbIvY8e7Dt
         /+FHWVxmEkVy0AQsSmR6m52V5pzW/nZsROZ4a0XxwjPwrYYHXUWRWSCTDcfiHMYt03
         t3sJurfxEtFTA==
Received: by mail-ed1-f71.google.com with SMTP id l3-20020aa7c3030000b02903bccf1897f9so2639911edq.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 23:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lf78NJpzyTn5+xfO0MJuGl1hxrAd7DxHOuUABJBSCnA=;
        b=moM1dkLVoRHaN3eQRdh/W51fMuP0HPGPKFjnQxNHikZVIgiDEOkchg3/By2BAlOGAn
         vJSFzBxQBTg4t/4CgqmcbeJc2HjjtGFOZypI6V0H3+QII71Ygo4URQW8YTEJQ7qwHDMk
         oC/zWpTZcUw4pYdWW5NpF5+DmSzmKG9hcqpelM8ZzK+rOh9sz3Al0w5NPQCQkwLAWnaD
         +hnCQB7+ct55oOS+m0FF0lHIsHIXM+v0GDMipK07qexjTh6xg4azcrMoVkCBCWKafNP/
         yFFe12wJi8A6bQYPswmn0wIzX+hMu3MDimV1DIg/srjse7Z1ysy+5aUsDUeMokw3i5Te
         vPDA==
X-Gm-Message-State: AOAM530dcEqLUfYq3cGBwrDHDHASC0nn+ge6FuAVUcVKRv5WMOUJfl1a
        2aVg9j5zMc81pkPcV9A9dXB6+VpojKdEu//Mggl/yHZG0odJOPBusOXccQ45cpGDhc74zpXPFs+
        mkEhL02l01bPGwPktSa/noueBDqzmlKUK47PbILHO/XsPypgm6PQFIT0olg==
X-Received: by 2002:a17:906:9246:: with SMTP id c6mr3195940ejx.78.1628145897956;
        Wed, 04 Aug 2021 23:44:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqjsI6JemIIuY794RpMMfiDJoj9bUt1D9azDWR4CXWzEdLSaGiRX8BgZFXs515GJhDFnrG0bSM1vUpujGkS9Y=
X-Received: by 2002:a17:906:9246:: with SMTP id c6mr3195929ejx.78.1628145897706;
 Wed, 04 Aug 2021 23:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160949.592227-1-kai.heng.feng@canonical.com>
 <2d594d0b06401887debd5ec462edcffdc813318a.camel@perches.com>
 <CAAd53p4dXVkuBXShCesEQkPi52CuaVm3tRBnD4S13saLdEGsRQ@mail.gmail.com> <3e8d8a3bcde7b0a2f4f1587c6febf88b7261db05.camel@perches.com>
In-Reply-To: <3e8d8a3bcde7b0a2f4f1587c6febf88b7261db05.camel@perches.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 5 Aug 2021 14:44:42 +0800
Message-ID: <CAAd53p6iVPyy+PO4HmmY_mbLYCQ=3G4oCW7PMHB+X5hbH+hHoQ@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: Append parenthesis back to trimmed
 subsystem name
To:     Joe Perches <joe@perches.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 2:33 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2021-08-05 at 14:17 +0800, Kai-Heng Feng wrote:
> > On Thu, Aug 5, 2021 at 12:22 AM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Thu, 2021-08-05 at 00:09 +0800, Kai-Heng Feng wrote:
> > > > When a closing parenthesis gets trimmed, there can be unmatched
> > > > parenthesis in the subsystem name. This doesn't play well with
> > > > git-send-email:
> > > > (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...) from: 'scripts/get_maintainer.pl'
> > > > Unmatched () '(open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)' '' at /usr/lib/git-core/git-send-email line 554.
> > > > error: unable to extract a valid address from: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)
> > > >
> > > > So append parenthesis back if it was trimmed to make git-send-email
> > > > work again:
> > > > (cc-cmd) Adding cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Mooresto...)) from: 'scripts/get_maintainer.pl'
> > >
> > > Probably better just to add --norolestats to the invoking command-line.
> >
> > This can solve the issue beautifully, thanks!
> >
> > >
> > > > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > > []
> > > > @@ -1252,9 +1252,10 @@ sub get_subsystem_name {
> > > >
> > > >
> > > >      my $subsystem = $typevalue[$start];
> > > >      if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
> > > > -     $subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
> > > > +     my $parenthesis = substr($subsystem, -1) eq ")";
> > > > +     $subsystem = substr($subsystem, 0, $output_section_maxlen - ($parenthesis ? 4 : 3));
> > > >       $subsystem =~ s/\s*$//;
> > > > -     $subsystem = $subsystem . "...";
> > > > +     $subsystem = $subsystem . "..." . ($parenthesis ? ")" : "");
> > >
> > > Given an $output_section_maxlen number of possible parentheses, this should
> > > probably use a while...
> >
> > Or maybe count the parentheses in two runs?
> >
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> > index 2075db0c08b8e..08315074acffa 100755
> > --- a/scripts/get_maintainer.pl
> > +++ b/scripts/get_maintainer.pl
> > @@ -1252,9 +1252,21 @@ sub get_subsystem_name {
> >
> >      my $subsystem = $typevalue[$start];
> >      if ($output_section_maxlen && length($subsystem) >
> > $output_section_maxlen) {
> > +       my $need_closing = 0;
> >         $subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
> >         $subsystem =~ s/\s*$//;
> > -       $subsystem = $subsystem . "...";
> > +
> > +       if (substr($subsystem, -1) eq "(") {
> > +           $subsystem = substr($subsystem, 0, -2);
> > +       } else {
> > +           my $opening = () = $subsystem =~ /\(/g;
> > +           my $closing = () = $subsystem =~ /\)/g;
> > +           if ($opening != $closing) {
> > +               $need_closing = 1;
> > +           }
> > +       }
> > +
> > +       $subsystem = $subsystem . "..." . ($need_closing ? ")" : "");
>
> This wouldn't necessarily work as you need to have balanced parentheses...
>
> It could be something like:
>
>         my $open_parens = () = $subsystem =~ /\(/g;
>         my $close_parens = () = $subsystem =~ /\)/g;
>         $subsystem .= ')' x ($open_parens - $close_parens);

OK, let me think how do it without exceeding $output_section_maxlen.

Kai-Heng

>
>
