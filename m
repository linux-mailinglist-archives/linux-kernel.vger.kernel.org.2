Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD46398CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhFBOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:30:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16472C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:28:13 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id t6-20020a4ae9a60000b0290245a5133898so590691ood.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=why64ASda6N09T/+Pwk+bfH6/nnxuW96QOGPqoMB+sM=;
        b=himWBiHE+VwxlklDa6IC/8V2dgK5fHFbNVESgDjbuQkANYRI9k0+hKXBLAbaEuxicz
         uLcOW2dY/k9sQjzclIR4InK9NJ5+38dQ7yEmw8F1vjSSqslzVNKFvxaKTKOQnN0H/Kia
         9vsvC27W49445LgbTn18qjoyk4NjDGgjL35SFVLmDfm/6yfBSlpYGRlmX6WOeXQuXvn4
         UN4ylBkDbb2vP150ZIvMXmqauG8i2nmtTWt3ca36LLMbOI3CyBUC2nUomEVwRjU5txfL
         Agc1Cpgxcbv97HUroQY6VKa8FGmEq501uN4IXGhu9IaniGyLy4JH0QSuDfK4196sAcd0
         TebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=why64ASda6N09T/+Pwk+bfH6/nnxuW96QOGPqoMB+sM=;
        b=sVmmFb0x/fw+JCbtqdb+1ttmVJ9HtDI1x10FCj7WpVfVsfL7wn5FpzkTQeVZKvtD7d
         MQYFr94FkswxUtFIUslZG4c3ZRnbjsUZGD8qsrg8+0SyENxkyhvQl3ar8iTO537YB1Ay
         cl6skW3P1en8x3TdyUrfiVIx1H2r13ErLBFRfsVxBhD4BSC9zTt9aGZXnoS0S3GdHZkS
         n36RivrAoni0NxjJWMHNr7Zd2V7hgIOkCkt7/ACkwIj4J2H+qgCPJ90DWa/NsPNBGPei
         IvOuR+4IawMfP6aXa6pzp0ONsf+1/uoMDEzdgdjVrHctoTMGwzcim3AKadnnEmbeZ/Bb
         ZAxw==
X-Gm-Message-State: AOAM532s45/USvNBOB+7s8k0Qv0ajs2C3rU5+YtL+nO2vsy7O3+5lZYF
        AIKlO1aMmz2WcPvIbpd70nRjgpdSmfwzZijV+BU=
X-Google-Smtp-Source: ABdhPJxepnMcyOj6FxxdtG9fSGVa2ciFY7Sih7dFE8PhB6aUFACp+QiahnamVGV7J9Q0DPtOO/4MWYKTn6cIfZqLdBs=
X-Received: by 2002:a4a:e084:: with SMTP id w4mr24438208oos.59.1622644091377;
 Wed, 02 Jun 2021 07:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210602133659.46158-1-manikishanghantasala@gmail.com> <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
In-Reply-To: <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Date:   Wed, 2 Jun 2021 19:57:35 +0530
Message-ID: <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
To:     Alex Elder <elder@ieee.org>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this mail again as I missed to reply to all.
 Hi Alex,

I agree those are called bit-field member names rather than labels.
But the reason I mentioned is because the ./scripts/checkpatch.pl
gave out a warning saying "labels should not be indented".

Sorry for the confusion in the name I referred to. So, I think this
change is needed as I feel this is not following the coding-style by
having indent before the width for bit field member. I went through
other places in source code to make sure this is correct, and sent the
patch after confirmation.

Regards,
Manikishan Ghantasala

On Wed, 2 Jun 2021 at 19:13, Alex Elder <elder@ieee.org> wrote:
>
> On 6/2/21 8:36 AM, sh4nnu wrote:
> > From: Manikishan Ghantasala <manikishanghantasala@gmail.com>
> >
> > staging: greybus: gpio.c: Clear coding-style problem
> > "labels should not be indented" by removing indentation.
>
> These are not labels.
>
> I don't really understand what you're doing here.
>
> Can you please explain why you think this needs changing?
>
>                                         -Alex
>
> > Signed-off-by: Manikishan Ghantasala <manikishanghantasala@gmail.com>
> > ---
> >   drivers/staging/greybus/gpio.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
> > index 7e6347fe93f9..4661f4a251bd 100644
> > --- a/drivers/staging/greybus/gpio.c
> > +++ b/drivers/staging/greybus/gpio.c
> > @@ -20,9 +20,9 @@
> >   struct gb_gpio_line {
> >       /* The following has to be an array of line_max entries */
> >       /* --> make them just a flags field */
> > -     u8                      active:    1,
> > -                             direction: 1,   /* 0 = output, 1 = input */
> > -                             value:     1;   /* 0 = low, 1 = high */
> > +     u8                      active:1,
> > +                             direction:1,    /* 0 = output, 1 = input */
> > +                             value:1;        /* 0 = low, 1 = high */
> >       u16                     debounce_usec;
> >
> >       u8                      irq_type;
> >
>
