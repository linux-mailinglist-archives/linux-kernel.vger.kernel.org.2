Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662F3F426E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 01:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHVXuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHVXuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 19:50:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE90C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 16:50:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e15so9109880plh.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hW+MyZ0ZhseMioQm3TJnaAAxpMc4z/kDYHdzPefnuLA=;
        b=LDrWH0/91yTsHyv3UOjNih8imjQ2zDPDWHLsEqZW4ozDdBhkJ19ctpnQ77XwisKuse
         XpzyYWM4H5oPJmzKlHfMAd+T9LSZmJD4Mw78dmJdFHYyih9AhfDwGdPnBSN74tGr9zTp
         2M0mWpZWSnoTJ14sjIhMxucRcD2r72XiVkPQp4eZTX6V8cdQ9Gbkvdb5+LCoFOEg/Pnu
         PWwqn81BfgghjJPQ+VnVrsTKMm4ZEAO0reKlA5345YPnn/uIOgINDnZFlM5iu7BiB9A9
         3v5XzaxtacORwlOpmOF8ZsFs+JN8d9/nSq+ff1iiH3CNpiD/RItpS3fVBoH1DBx15pKR
         hzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hW+MyZ0ZhseMioQm3TJnaAAxpMc4z/kDYHdzPefnuLA=;
        b=T6K2856Lwu8cVex4onXGYSDhvzx/Uig9/2s9CwyC1RMCxi4axrQGSEUoB4xsgd1k8r
         Kx55W79ptzh2idjErF+qtYPyMbHn7lQdVA662d/swAfWF0D9MH8q0S7Vikv3MbTM+98g
         Ay3TEX/74AGfXj0hc68PpMdBumW1neJ9zqwhDr8F5ECiS0I5b5t7Ch9/eD2U45OMtVK/
         vgc6+gvuvhdrrSyjir1LW3IfSzdfHXAgNFr7RZIUazPWbWMl2joDbY/tg2BF0qt6VQvk
         16mJpwDQN0B7yeyKxAjaBsiJ3yZE89Br+VvXdJgb8pvOf3RyAXxc2wxWcmVU8MOzr0E8
         FQ6Q==
X-Gm-Message-State: AOAM530sttCve0WDypZNQ8VccmpjaeTCrZNC465dsdzPA6JX0BdoBkbU
        APeeLKHJjtvnjrv7JAMkA3hIjoisdGrTt4ZWVek46Q==
X-Google-Smtp-Source: ABdhPJwdpi411jgZny+g6LtxpMNySmm/2TW3G1QiD5BPg0Pa3Vf3cjKc1j3mA8iiATCSfuADaedCsza/3kut37yyktI=
X-Received: by 2002:a17:902:6ac6:b0:133:230b:e8bc with SMTP id
 i6-20020a1709026ac600b00133230be8bcmr5455400plt.22.1629676209302; Sun, 22 Aug
 2021 16:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <CAA=Fs0mU0bkXPY35fkuudoWfAps2jp1qc3ga53LXgg6d+0bVSg@mail.gmail.com>
 <20210822170435.ijsi7ep7rbdu4i3k@viti.kaiser.cx>
In-Reply-To: <20210822170435.ijsi7ep7rbdu4i3k@viti.kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 00:49:58 +0100
Message-ID: <CAA=Fs0=3T_0Ypnm8E-Eq9sxZw+VU9Y2k_Pgtk4dcR3msRqoUoA@mail.gmail.com>
Subject: Re: [PATCH 01/10] staging: r8188eu: remove unnecessary cast
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 18:04, Martin Kaiser <lists@kaiser.cx> wrote:
>
> Thus wrote Phillip Potter (phil@philpotter.co.uk):
>
> > On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:
>
> > > name is a const char * by default. This type should be ok for r8188eu.
>
> > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > > ---
> > >  drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> > > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > > index e002070f7fba..72556ac10d7d 100644
> > > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > > @@ -61,7 +61,7 @@ struct rtw_usb_drv {
> > >  };
>
> > >  static struct rtw_usb_drv rtl8188e_usb_drv = {
> > > -       .usbdrv.name = (char *)"r8188eu",
> > > +       .usbdrv.name = "r8188eu",
> > >         .usbdrv.probe = rtw_drv_init,
> > >         .usbdrv.disconnect = rtw_dev_remove,
> > >         .usbdrv.id_table = rtw_usb_id_tbl,
> > > --
> > > 2.20.1
>
> Hi Phil,
>
> > Looks ok to me, thanks. I would consider using a cover letter style
> > [PATCH 00/10] style approach as an addition in future though, just my
> > personal opinion.
>
> > Acked-by: Phillip Potter <phil@philpotter.co.uk>
>
> Thanks.
>
> This series is a mixed bag of things I found while poking around in the
> code. So I didn't think there was anything useful to say in a cover
> letter. Still, I see your point, it makes sense for a patch series to
> have a cover letter, I'll add one for future patch series.
>
> Best regards,
> Martin

Reasonable point for sure - it is your call ultimately, I like your
work in any case, so many thanks :-)

Regards,
Phil
