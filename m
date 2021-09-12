Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012EE407F20
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhILSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhILSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:06:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 11:04:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so11001044wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=30MIuYuFKdJf40vmfRkFfYIkgojb9w4Sveh8T6JqTIY=;
        b=NQU0LrbVkBNcnuE2ohqjZ/xmUuag5caPUvJrfNXkWCF9Qwe3iXppFRcY1MiYVP46Ya
         7HSxwcrxKGi9dNwWW6SoZwY9w+lS0XmBkK7yJz/ua85jti/89+/v4aIQ62eRhP1P6t3z
         vwOiJ8SVBD/+MEV6rixg3AYjDGPwOLeLu3bkmKFL8szCrtL2dWsS9Nt3yRgrNe/v85Tx
         tLGJVhIxrK0dXHPLnAqq6HRBf4kB/Td6staVXeVHw1VfWwEfMS8Q1mhleoJcUrPZqkXb
         fO/xa1qrOVzthCYYD0S2/9oBVo+PDVilKUcKcbwkVSeQhop5a/ixNSxKSvx18A3g6RpH
         8Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30MIuYuFKdJf40vmfRkFfYIkgojb9w4Sveh8T6JqTIY=;
        b=l8QQLL7WXxCDXwdwOhbVJBLNlAk9x3Q92vo0vfj2TKDXDVTxo3PKfRdaOaAPY61sId
         Agwkk8gz+hBfYras9pxEpIlOtdUAsg7HGH72rdgNDTiZd1qR8h2yAUGpk6gta7Iu+2HU
         1tmN1E51kEm2+Th9JlsKz9Eefp6ZrOUo0FE/QoXnvFcZTk4jO+7516ioGeeWsSY8dQ0Q
         geX9oyWgoLZhGqtA3irMMrggzeYNjl3PuGjIX6sm88/5GBiQbnyfAxLFRS5FBVthRGdp
         gDFc9faS7v0B05XBme5XFJzcDXrkwdAuOyIwfssUHDbM9dvf5NpOTHO2GqyowdOqcVWH
         upeQ==
X-Gm-Message-State: AOAM533h1FUlSdd7PlePUx7GBQiJOgVeVaO4i/QzjpvSTPgd1KlNHfCX
        hwX+EG9abilz2/Ckip/Mo6Ra0w==
X-Google-Smtp-Source: ABdhPJwHgNmJMorq848Kg2GjnJwUfIU+y1oJqvt87fYXadc5494OVps3HFkGWneUfBvNHJRiVFyThg==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr3482075wru.274.1631469885977;
        Sun, 12 Sep 2021 11:04:45 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m29sm5337397wrb.89.2021.09.12.11.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:04:45 -0700 (PDT)
Date:   Sun, 12 Sep 2021 19:04:43 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Lukas Prediger <lumip@lumip.de>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YT5BO7bUMMkwNCTh@equinox>
References: <CAA=Fs0mEprM0hErRY-kw7bOVqEw3o6X=--OixQ=_fNXdV_-QGQ@mail.gmail.com>
 <20210911174816.55538-1-lumip@lumip.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911174816.55538-1-lumip@lumip.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 08:48:17PM +0300, Lukas Prediger wrote:
> Hi Randy, Hi Phil,
> 
> >>
> >> Hi Lukas,
> >>
> >> Just a minor nit:
> >>
> >> On 9/10/21 2:16 PM, Lukas Prediger wrote:
> >> > +#define MEDIA_CHANGED_FLAG   0x1     /* Last detected media change was more \
> >> > +                                      * recent than last_media_change set by\
> >> > +                                      * caller.                             \
> >> > +                                      */
> >>
> >> Drop the "continuation" backslashes.
> >> They are not needed.
> >>
> >> thanks.
> >> --
> >> ~Randy
> >>
> 
> Hm, my IDE was complaining about these but I just tested building without and
> that worked fine. No idea what that was about then..
> 
> >
> > Dear Lukas,
> >
> > Happy to take these out for you and save you resubmitting.
> > I'm very happy with patch anyway. Once I hear back from
> > you I'll send onto Jens with my approval after one final test :-)
> >
> 
> That would be very nice of you!
> 
> >
> > Thanks again for the code.
> >
> 
> My pleasure, and thanks for the helpful feedback!
> 
> >
> > Regards,
> > Phil
> 
> Best regards,
> Lukas

Dear Lukas,

This v3 patch does not apply to my tree, or the mainline one for that
matter. A few problems I've noticed that are the cause of this:

Misnamed file:
Documentation/ioctl/cdrom.rst - this file should actually be:
Documentation/userspace-api/ioctl/cdrom.rst (and is in v2)

Failed hunks:
v3 fails on applying the changes to drivers/cdrom/cdrom.c as well, due
to two hunks failing (because of different lines preceding your
changes).

It also fails to apply the second hunk to include/uapi/linux/cdrom.h,
again due to differences in pre-existing content. Did you base this v3
patch against a different/older tree/branch?

Please advise, many thanks. As mentioned before, v2 applied perfectly
fine for me.

Regards,
Phil
