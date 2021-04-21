Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254DB367488
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 23:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhDUVEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 17:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243738AbhDUVE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 17:04:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12C7661430;
        Wed, 21 Apr 2021 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619039036;
        bh=IaBb1c3cX98QzIPvD5RUvOgFDyvnR2QxDhJCuML849Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4PKMD6iLGZftn0UsLnqVBptSgwr3yY91BEsXwBDbraPTAiy++DCYaPXPAxnMeahO
         mlmmUEjW2eECjPyg5+dEhfppczCwFZWLxlAJW+N1qn+YaogCJthXo5DmaDAiXPjkvC
         B0rc8v+c1DEJzsw3F5ep2h/jA70gEDqwnBSQfvSrLDmalZJBSIMKv+BguVTBffpHUt
         zMhwnh2TRKKtRM9zWlzeRpClGC0mpTHE1OAVIJ0K0vsXQ84PAg4Vz2mU8FIkU6CeQ7
         v8DN7dPXuOw8yiOLFo6cRCxkns0os0sMv/d7gYeZ0euxVpxfEe3oyMv7ZCYZKdnuXK
         ePAX/EiB++d4w==
Received: by mail-ed1-f45.google.com with SMTP id y3so14655748eds.5;
        Wed, 21 Apr 2021 14:03:55 -0700 (PDT)
X-Gm-Message-State: AOAM533Qpzppni5a4hDIyOxyAVWqmXgQpRmtbCzoAA1KUKewAIoY4VCt
        s7A+dJo4gYp7+npOWauwy9obTlQKW3VFLmUPHA==
X-Google-Smtp-Source: ABdhPJxSwlINOXfFFJEjV/5x0Grlz+Qr9MJ+PMZ3ryTTbMIEDaePb7cG3Q6zi2myMXZvukAXKmVusm2aZTB01dhWQ00=
X-Received: by 2002:aa7:cd51:: with SMTP id v17mr40993285edw.137.1619039034660;
 Wed, 21 Apr 2021 14:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210421154548.1192903-1-robh@kernel.org> <98f083c9-5e2d-6388-88f6-4883e025bebf@gmail.com>
In-Reply-To: <98f083c9-5e2d-6388-88f6-4883e025bebf@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Apr 2021 16:03:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJt5_zCcu-zFmZkPNtuNrOKZBiEoD2foM-uhU56Lg2Hg@mail.gmail.com>
Message-ID: <CAL_JsqJJt5_zCcu-zFmZkPNtuNrOKZBiEoD2foM-uhU56Lg2Hg@mail.gmail.com>
Subject: Re: [PATCH] of: overlay: Fix kerneldoc warning in of_overlay_remove()
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 2:38 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 4/21/21 10:45 AM, Rob Herring wrote:
> > '*ovcs_id' causes a warning because '*' is treated as bold markup:
> >
> > Documentation/devicetree/kernel-api:56: ../drivers/of/overlay.c:1184: WARNING: Inline emphasis start-string without end-string.
> >
> > Fix this to use the normal '@' markup for function parameters.
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/overlay.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index d241273170fd..67c9aa6f14da 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -1181,7 +1181,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
> >   * If an error is returned by an overlay changeset post-remove notifier
> >   * then no further overlay changeset post-remove notifier will be called.
> >   *
> > - * Return: 0 on success, or a negative error number.  *ovcs_id is set to
> > + * Return: 0 on success, or a negative error number.  @ovcs_id is set to
> >   * zero after reverting the changeset, even if a subsequent error occurs.
> >   */
> >  int of_overlay_remove(int *ovcs_id)
> >
>
> The change results in incorrect information.  I am guessing that "@*ovcs_id"
> would not be valid syntax (I have not tried it).  The changed version says
> that the pointer ovcs_id is changed to zero, but the actual action is to
> change the value pointed to by ovcs_id is changed to zero.  Is there a
> valid syntax to say this?

I was assuming the reader should know how parameters work in C...
Having previously beat my head with the syntax here, I went with the
easy route. Normal rSt syntax would be ``*`` to escape it. But
kerneldoc isn't normal syntax. Turns out just plain "*@ovcs_id" works
without warning and highlights the parameter (which was missing
before).

I'll update the commit.

Rob
