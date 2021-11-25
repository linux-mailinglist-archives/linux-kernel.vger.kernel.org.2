Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6A45D2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353497AbhKYCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 21:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353061AbhKYCDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:03:09 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F3C0619F6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 17:32:31 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so7071630otl.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 17:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcIV9fs5PyBSfa8FV0YzjooJWjW0D+74R3qAHQeRX8M=;
        b=QUhGk3vk91ygQk18q/T2Obk2GdUO7o4voQUE+c550rL2W99ipNmHT/v6D+I5MNCNju
         s78xKvZ4o3fNcLDsBIkwt3npsvk2nbziDgNlI2TT7BHn5QqvcwLBVlERPA9jPjaROtc7
         /Ru3j06woPJtEhRt6j+8fVxNvSqVvBJsIyk3cgwqbmeY85/E3MU+e6ayx0mbVYtqlt6C
         hU7hoDbOYxat10F4yktTnsiUOOMqWxvpGqNdNBav4McUizb94Hgl9Cl3tdKS+THTSTRq
         YTiutGC6w/50nsgnwLCUmmSUgg0O1KpKYq5al+IeHKw1HFfmsuS7k8jNSVN+fCBfWk1s
         4RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcIV9fs5PyBSfa8FV0YzjooJWjW0D+74R3qAHQeRX8M=;
        b=JJonp/7zc9LotxgUlkW4eRMrKhiMZ8utc6/DYo1X0Hy17ufxIc5ToAu+c2xifCeoQR
         V+iuly49DYdwcs2d9La2+5UFXmnBSpiK8+dRRACKeUiDqZla54gYcxnHszg4gvJREMRh
         gryrvBDZh2TdtQoHoafwoTyYlWSKdp+5XSyBy4oBxjfWtE7gNh1rtBVE2ijdf+TQB8OB
         LBo2re/8jl5zsJ0VCDfLOL/AvEZ27haxnmDHhMHXWrWaIHr3U6r2yI5CkNzZcdDbjcO1
         HuX0BB3oicGlSzWdNfr1FpHZJTfuPK4JIsCg93pFX5/02I5IfpPQoHHEPas0Hj059w5G
         vG/A==
X-Gm-Message-State: AOAM532/OSOGnDVXjVpv6vs3gRvbgHf3v0eN5IIOiCpT3XFzkO0mIjy9
        EBKRmFIcRmVAdlJAHAYLWs4amix85KmOqnG8lyhIJ/iz7+H09Ddl
X-Google-Smtp-Source: ABdhPJxitMWPao0qjKr4Y4SZbF53M1MtR/rPyuY0L6znUn1P5gW/0cKis5BNE+ptHSw62jbZT2mp5fzErNiD6xYc9I8=
X-Received: by 2002:a9d:326:: with SMTP id 35mr17920012otv.41.1637803951319;
 Wed, 24 Nov 2021 17:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20211122195350.GA166134@makvihas> <YZ4NL3TvLYMa/Tzu@kroah.com>
In-Reply-To: <YZ4NL3TvLYMa/Tzu@kroah.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Thu, 25 Nov 2021 07:02:20 +0530
Message-ID: <CAH1kMwRPLP998GjKx7bkL_LQE8hVNdCThwBJ7W8iNo1mPUyEZQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary NULL check
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        straube.linux@gmail.com, martin@kaiser.cx,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> And are you sure this ever could be NULL?
Yes.

The function rtw_free_netdev() performs a NULL check before actually
freeing the structure, so the "if (pnetdev)" check isn't really
necessary before calling rtw_free_netdev().
That's the reason why I removed that check.


On Wed, Nov 24, 2021 at 3:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 23, 2021 at 01:23:50AM +0530, Vihas Mak wrote:
> > remove unnecessary NULL check surrounding rtw_free_netdev(), as the check
> > is already performed inside rtw_free_netdev() in
> > drivers/staging/r8188eu/os_dep/osdep_service.c.
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
> >  drivers/staging/r8188eu/os_dep/usb_intf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > index 5a35d9fe3fc9..392bd7868519 100644
> > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > @@ -466,8 +466,7 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
> >               if1->hw_init_completed);
> >       rtw_handle_dualmac(if1, 0);
> >       rtw_free_drv_sw(if1);
> > -     if (pnetdev)
> > -             rtw_free_netdev(pnetdev);
> > +     rtw_free_netdev(pnetdev);
>
> As Dan said, this isn't usually a good idea to hide this.
>
> And are you sure this ever could be NULL?
>
> thanks,
>
> greg k-h



-- 
Thanks,
Vihas
