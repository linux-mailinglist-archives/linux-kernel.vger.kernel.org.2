Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427463F5A18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhHXIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhHXIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:48:47 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:48:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g21so30438916edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jk6xBwZp29Fyk+wKRE0LSbGZQOFjJkPDJWbElWDwoQY=;
        b=eIg1uy3Pxb/OkF8xaW0tQ9ZnBp4e01p8TEuMJ4I/NaCra4QSTOmJ6tITDbAkGOFd0M
         dWgrvolEcW97W3LDnEmCyNeHc2I5j0XztUU9lnb0q8D18rsWQbjo58fj+7TIDVh1GdZU
         pEWSJ7ulJnZgczTE7M1Nw0qPp040rEB92XwxuVK1nW8+VmOXd5/vjvq8UtAXmMGTzatO
         rJOoitWkKX4DZqNVZ9ktaazCJClZ0IMm/o8+8+lEyt3urO6fvdS7FNMLVn9I4Vvt66lZ
         rN9Nl+N3sBH1z5G6aOIRcPbxgY8Ct2LISWr7DDcOJQduoVHXDe8rDe7A/BJL7Gy1MIQ4
         2Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jk6xBwZp29Fyk+wKRE0LSbGZQOFjJkPDJWbElWDwoQY=;
        b=pS4nMd3Pwya+58vERqL19IzYZWVikFD9QL22/swHzroHmXBFzX1A35fKFuGRU/opQW
         5n7P6aXxvYsb2ZRdw6VQo/mPI+z51tZPniRS/VORd+lPWA2Hla7avMDLoAIstsw/WieY
         qzkdy6aiZKKO0g6bd4MzTHBTvL++I2JKwrX4EEZMXFd+MU+SrTza4YZJS49uISEk337C
         wzEVjHXbhzBHkvgZ8bXuHlbk9dvgR6wAYEdaBUWlt0mVAbYTOZT9/Q6ZnlzAPxYQkhGl
         TDvcCDPcFr3Yc1jmo2X2Q8dPHVeLmNmUyHDBObyjQk4NG5Sb24SCS6vA+xyTQGSHiSo0
         mtJQ==
X-Gm-Message-State: AOAM531PKSDqtIYbCVy3StoQT/MJc+0n04Xx5XLAU1/O6lYvlBS6j5I5
        cUL1IYGwSFxXrRQHXol3rjxT9OOCKbUji8Zyl0M=
X-Google-Smtp-Source: ABdhPJwhymhGPFvohYfFxBEGQRbq7zsTX6RJ9LyFtoXl6kaUpSDVBBamfrgXFsejhRW5Q2AzmoWzHhQ/hNVzcFKuBy0=
X-Received: by 2002:aa7:d147:: with SMTP id r7mr41738062edo.148.1629794882606;
 Tue, 24 Aug 2021 01:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABv53a_q4jzsXib7ovRs=eOwqcQ-oKb8c7DA7uUSPf+0tt6aog@mail.gmail.com>
 <20210823170624.GA1420@agape.jhs> <CABv53a9aR8mXE_quxRX06aX3WAKGSOyMqrG8AmqrsvftjH7xyg@mail.gmail.com>
 <CABv53a_9GstHzLbbbghFxU_YDxC0ckh3+bGu4RqAmGL39BHMMg@mail.gmail.com> <20210824074643.GA1731@agape.jhs>
In-Reply-To: <20210824074643.GA1731@agape.jhs>
From:   iLifetruth <yixiaonn@gmail.com>
Date:   Tue, 24 Aug 2021 16:47:26 +0800
Message-ID: <CABv53a9x_FbTY0=D_TGsHdS3XsUVg5M=S5WYVNdQXaVSC=XVYQ@mail.gmail.com>
Subject: Re: staging: possible buffer overflow in rtw_wx_set_scan function in driver/staging/rtl8723bs
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-kernel@vger.kernel.org, Qiang Liu <cyruscyliu@gmail.com>,
        yajin@vm-kernel.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, Martin Kaiser <martin@kaiser.cx>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        paskripkin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 3:46 PM Fabio Aiuto <fabioaiuto83@gmail.com> wrote:
>
> Hello,
>
> [sorry for resend, I updated the CC field]
>
> On Tue, Aug 24, 2021 at 03:04:04PM +0800, iLifetruth wrote:
> > Here are the fixes and the contents of the patch file we suggest.
> >
> > [PATCH]staging: rtl8723bs: prevent ->ssid overflow in rtw_wx_set_scan()
> >
> > This fixing patch is ported from the upstream commit
> > 74b6b20df8cf(staging: rtl8188eu: prevent ->ssid overflow in
> > rtw_wx_set_scan()) which fixes on another driver numbered rtl8188eu.
> > This code has a check to prevent read overflow but it needs another
> > check to prevent writing beyond the end of the ->ssid[] array in
> > driver rtl8723bs.
> >
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > index f95000df8942..3b859b71bf43 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > @@ -1222,9 +1222,9 @@ static int rtw_wx_set_scan(struct net_device
> > *dev, struct iw_request_info *a,
> >
> >                                 sec_len = *(pos++); len -= 1;
> >
> > -                               if (sec_len > 0 && sec_len <= len) {
> > +                               if (sec_len > 0 && sec_len <= len &&
> > sec_len<= 32) {
> >                                         ssid[ssid_index].SsidLength = sec_len;
> > -                                       memcpy(ssid[ssid_index].Ssid,
> > pos, ssid[ssid_index].SsidLength);
> > +                                       memcpy(ssid[ssid_index].Ssid,
> > pos, sec_len);
> >                                         ssid_index++;
> >                                 }
> >
> > --
> >
> > Thanks for your confirmation,
> > - iLifetruth
> >
>
> the patch looks fine. Just some points:
>
> - If the patch related to wext support removal will
>   be accepted, the patch isn't necessary. So I will wait
>   until I know the community-maintainer decision.
>

OK, I see the situation now, and I will submit a relevant patch to the
Linux-staging tree at a suitable time.
