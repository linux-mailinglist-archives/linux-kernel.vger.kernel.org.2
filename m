Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB8428BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhJKLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235994AbhJKLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633950334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqwarFeT31WucRL0zO1fL8nWRb97yKjsbZwzOxQYcE0=;
        b=Zpv+rDiTnhMeBdGrb+Z4rdaxBxjoSWJF+ATKlmRQuRsJ2q2FZi764UDPYlK9cXz658WVT3
        74VJCE3XfiDRrloLKODsnzF9B9S+cNyUNoKWUpYqxV/Pl5UOoUneJeJHMkZfWm0UoDdDEh
        8F1k5kA3e2vh/BFVW/Eic4b4VCj6E+w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-CPrQnuffOze3hUbZ_co0Dw-1; Mon, 11 Oct 2021 07:05:33 -0400
X-MC-Unique: CPrQnuffOze3hUbZ_co0Dw-1
Received: by mail-wr1-f72.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso12972173wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqwarFeT31WucRL0zO1fL8nWRb97yKjsbZwzOxQYcE0=;
        b=XUAP2isIpq+n4TekB6Zwlr9TPBvhUCMN9pHtLqoWBXpUT2mc9LX6+91LhjXeN/r8N2
         W9yeDGXo+shV9XQwYRJDYzZs7hRpt1E49olFAzyMS0ojhW9G1MtbS66lGgUY2sxVYZrr
         NEZBufjMehkU55ODgpQAD2UkK1OkQm4X6jTvhGkvrmWnTzTHPJElu+Be6YB21TmNOlXG
         FWrfVRU26KSiMDFjBidCFvYfMAXPX4ZmmEJmynoK5n9tPXCcK0v7Ue877pj2xEb7ve4F
         oqbUZq8IoMmPfsx8sI0RBp726obKs+4U9Q6davQUzuy1coVnoK6MhOoXKqn/M1hmMGkw
         vwyA==
X-Gm-Message-State: AOAM530H32saiR/+I5kgEPAJgEOvDFGRuqbc4zMmViShZHJBhCOAVFel
        6mLU0ksNOMKc4/Gv+LuHigFpakEZMcwDtueaG9dahTV8L/x43w/IrJe3O9fD1gq1fVP4TOTe5Qp
        n9VkI4vdrHPdbtzvH2w8mO3cXnOx/Xge7Nk/W9lC8
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr1062875wrx.142.1633950332622;
        Mon, 11 Oct 2021 04:05:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymCu73G3BRVLMl9xIjMR0joyr0NS2Ue72qfyWiUehpYMDt1yD/CSX8Bop+8rXWnzKIdbYUvwRga/7vANKIHH8=
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr1062853wrx.142.1633950332452;
 Mon, 11 Oct 2021 04:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201103194912.184413-1-jcline@redhat.com> <20201125202648.5220-1-jcline@redhat.com>
 <b4da382b17a77b66e45fd374c9d806dac6054e3a.camel@redhat.com>
 <YRoN0vWFN6Lw22ej@eldamar.lan> <418fdcbcf554d34cc6423a88974f916b64b3664c.camel@redhat.com>
 <YWPiU+9G0AKglHmi@eldamar.lan>
In-Reply-To: <YWPiU+9G0AKglHmi@eldamar.lan>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 11 Oct 2021 13:05:21 +0200
Message-ID: <CACO55tvokQBKz1ZyhK_2hN=V7rgV3n_L=PYNh8RLA+y8n93qRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/nouveau: fix a use-after-free in postclose()
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Lyude Paul <lyude@redhat.com>, Jeremy Cline <jcline@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently checking the ML for such old patches, just have to make
sure it's actually fine and not breaking stuff as well.

But I think we will pull this in soonish, I just also work on
improving our CI stuff at the same time by trying out some things.

On Mon, Oct 11, 2021 at 9:06 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Hi Ben,
>
> On Tue, Aug 17, 2021 at 04:32:31PM -0400, Lyude Paul wrote:
> > It may have been, we're in the process of trying to change around how we
> > currently accept nouveau patches to stop this from happening in the future.
> >
> > Ben, whenever you get a moment can you take a look at this?
> >
> > On Mon, 2021-08-16 at 09:03 +0200, Salvatore Bonaccorso wrote:
> > > Hi,
> > >
> > > On Fri, Mar 26, 2021 at 06:00:51PM -0400, Lyude Paul wrote:
> > > > This patch series is:
> > > >
> > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > >
> > > > Btw - in the future if you need to send a respin of multiple patches, you
> > > > need
> > > > to send it as it's own separate series instead of replying to the previous
> > > > one
> > > > (one-off respins can just be posted as replies though), otherwise
> > > > patchwork
> > > > won't pick it up
> > >
> > > Did this patch series somehow fall through the cracks or got lost?
>
> Looking some older threads, noticed this one. Ben did you got a chance
> to look at it, or is it now irrelevant by other means?
>
> Regards,
> Salvatore
>

