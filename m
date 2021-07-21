Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CEC3D0E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbhGULKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhGUK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:57:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C9C0613DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:37:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hd33so2734265ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNy3fXQypRQ7iBqk6cMKq2YSr6mmZZ/erHTwxnivDio=;
        b=Y8ljgQ4FjYob6HWnaHZU9OWXYwHapFngE5+k9xRcBhvsN2DweB4e/ms4DRkrl0T8i3
         vTwWrhL93ObK9Ti6O3QXLrhVLrE4cv15UuNHuhZU9HLFqIHAsEVUrrdAsxdHMrGSFkZT
         p2nA2yImjmMTjD45DJeQbFPAwTaKvCNHydoLhmNScIBWuuu2bFXrAA1b6arj4SVS30br
         E+3TfkMkilmgMOtaTTSHDK0ch+3g0IS2ZMWo+3dFEMugyScdxdNkUtuc5ojWL5xXrcPl
         ytnTmIDGOWhp9jqAprmzYn6x4ebk38zQPh8qw2X/FLxiV/z9gUSd+IJB7ERTOipyLvot
         5bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNy3fXQypRQ7iBqk6cMKq2YSr6mmZZ/erHTwxnivDio=;
        b=ZIqu//gc3mEc8qMpMj3LmDIOhnjRHUY369xmW/bpWvU5O3JoPbk0XPGAxL8h9P0roB
         ItsRUhG7pOakM30AdKFvvH5csHduyVU1Ow4O7nYIhQPbTd0UJpGxvvY+3+hzNR+eN2Aj
         AWMHSWqzpmnBtY28i09+gqYMh9rPwfFlw5uzndKR2MsUFzvuSPcILMOpetwILPpBNm2u
         csXRHSDRaZx/QlxWLuIwNiu0ofT5wIWZUyeXaJodoPJgUK2Cqzc+t/90mSo9zW85O3IO
         /A0esWS+f9xG1nmw6O2rKc+YBOykhJyibrFrBxS0PQc02iZLFZi9K3BpkLFkJlgYB2Rd
         bkmw==
X-Gm-Message-State: AOAM531DzrIvmnnfLnn6g/4zz5F6qukBXn7+0iuf/KlSNU3ow6PrWuuO
        fB5f65Op5s5EyFrhS1o1RPXWZ/QWdHl1dPDCI0sHNvTNxOtzhw==
X-Google-Smtp-Source: ABdhPJx0yql/RS8k0xPBebJ5bG73BTqcR8BS6xkYkNuzc1oa5iwGxG0waN3SKpUNP1sP8DZVqI5Nt8g/CH3OBM7d60c=
X-Received: by 2002:a17:906:3006:: with SMTP id 6mr39020891ejz.73.1626867475291;
 Wed, 21 Jul 2021 04:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210720083805.1430892-1-mudongliangabcd@gmail.com> <YPf95Wd6pbjgeU3g@kroah.com>
In-Reply-To: <YPf95Wd6pbjgeU3g@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 21 Jul 2021 19:37:29 +0800
Message-ID: <CAD-N9QWWLFo7rABpZZfg9NHcM9Of7p0nSuZSvPkEzLMEN_y3hA@mail.gmail.com>
Subject: Re: [PATCH] tty: nozomi: change tty_unregister_device to tty_port_unregister_device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 6:58 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 20, 2021 at 04:38:05PM +0800, Dongliang Mu wrote:
> > The pairwise api invocation of tty_port_register_device should be
> > tty_port_unregister_device, other than tty_unregister_device.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/tty/nozomi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> > index 0c80f25c8c3d..08bdd82f60b5 100644
> > --- a/drivers/tty/nozomi.c
> > +++ b/drivers/tty/nozomi.c
> > @@ -1417,7 +1417,8 @@ static int nozomi_card_init(struct pci_dev *pdev,
> >
> >  err_free_tty:
> >       for (i--; i >= 0; i--) {
> > -             tty_unregister_device(ntty_driver, dc->index_start + i);
> > +             tty_port_unregister_device(&dc->port[i].port, ntty_driver,
> > +                             dc->index_start + i);
> >               tty_port_destroy(&dc->port[i].port);
> >       }
> >       free_irq(pdev->irq, dc);
> > --
> > 2.25.1
> >
>
> What commit does this fix?  Should it go to stable kernels?  Can you
> please resend it with that information?

I have sent a v2 patch.

>
> And how did you find this?

Just by manual code review when checking a fix commit.

>
> thanks,
>
> greg k-h
