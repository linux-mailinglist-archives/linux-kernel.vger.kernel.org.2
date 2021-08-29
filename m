Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14B3FAB72
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhH2MgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhH2MgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:36:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED79C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:35:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u3so24632566ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYBZNoKAcbtNdSL+F8kkawzJmRLh+kaOYHD4JZttxW4=;
        b=AZcej/jdSphU7fJhQ1DvwcdMuw/Rg7uLiTBaLEiLFBT7i22PAjhzwpFxNCHa5338ei
         y5nqLZPuPq8j2nJXJhI97JhwNiqnwLhzdz2P7nWcXNs0A0u5nLY+EwRbDo/iqoUIiIrF
         uftM8y7+yO+Mnb0qgqphUwaoT36Bt3J2mWSR+fmNYnm7JasmMTJnLtJvEGv7STl+cYE7
         4e1R2KtNVy18c4mDoQLFT//6n8Z+L5Nq6LVrFknc6q24xQIbTtz228tbxMfVyRsJc9SW
         XITHBGhSAmhFWtnbH1X6vxTDQWDghxLRvXUJZnOZQC+AmfraTUKspxl26QXA5FKGNnOx
         8a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYBZNoKAcbtNdSL+F8kkawzJmRLh+kaOYHD4JZttxW4=;
        b=gXfoFkGxKcPyymCUvrceSNCVc+55150FKkYQURLTdtOomltbpIKPCk1ZbSYFSPojzg
         y07VXLeMUUZM0fA985/YiOJQlVgVoESkIfftMJjkLInVKpAhgETULbrY6gJxbd6gSdz5
         sIJuo5XAcvwvO5kEEtYU/hhm/kSECwGpGG3kPoaInkBnpC5Wb7MEWw/iFai+eXil6u94
         TRYwuoExDI/YpE61/RLxk528xnaES2Nw855KYZwAQIMNHI0jL5Jt5jvidbVg8IiJuVFB
         QVdvDV0A9KE8hZHarI/PWAakncCGAF/vntapXp2yQkVJvf2q8JX35ZMxGFAyxmw74+NR
         zcSw==
X-Gm-Message-State: AOAM531O6N5CvUbO6aK9BmcUzP8AFJtA7cMPvD5rjycFktREH1P0w6ps
        gIFv3iKNmbq0qduPN7ZfS9b1NYjPglA=
X-Google-Smtp-Source: ABdhPJwW0Qaqfo2obGhYwtC9dXl7btM7gwIaG3Wog4ElTP6m3pr6NuVkEfz8WW4KYVb5lXPMx0ZKng==
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr20209551ejm.457.1630240514045;
        Sun, 29 Aug 2021 05:35:14 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id n13sm3851225edq.91.2021.08.29.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 05:35:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] staging: r8188eu: simplify c2h_evt_hdl function
Date:   Sun, 29 Aug 2021 14:35:11 +0200
Message-ID: <3090174.7fztx2B5dC@localhost.localdomain>
In-Reply-To: <CAA=Fs0meC_nVjb2gESnmz2pPgzNa4=QT_jnteAh4B8Cds6_0fQ@mail.gmail.com>
References: <20210828212453.898-1-phil@philpotter.co.uk> <21174665.bKA57LRvRV@localhost.localdomain> <CAA=Fs0meC_nVjb2gESnmz2pPgzNa4=QT_jnteAh4B8Cds6_0fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 29, 2021 12:49:42 PM CEST Phillip Potter wrote:
> On Sun, 29 Aug 2021 at 09:52, Fabio M. De Francesco
> <fmdefrancesco@gmail.com> wrote:
> >
> > >  static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
> > >  {
> > > -     s32 ret = _FAIL;
> > >       u8 buf[16];
> > >
> > > -     if (!c2h_evt) {
> > > -             /* No c2h event in cmd_obj, read c2h event before handling*/
> > > -             if (c2h_evt_read(adapter, buf) == _SUCCESS) {
> > > -                     c2h_evt = (struct c2h_evt_hdr *)buf;
> >
> > Dear Philip,
> >
> > Not related to your patch, but what kind of odd assignment is it? c2h_evt takes
> > the address of a local variable and therefore it crashes the kernel whenever
> > someone decides to dereference it after this function returns and unwinds
> > the stack...
> 
> Dear Fabio,
> 
> Thank you for taking a look firstly, really appreciate it :-) As for the line:
> c2h_evt = (struct c2h_evt_hdr *)buf;
> 
> in the original code before I removed it, bear in mind that this
> pointer assignment is
> happening into the parameter variable c2h_evt, which is a copy of the
> passed in argument,
> as C is pass-by-value. 

You're right! Sorry. For sure I was still sleeping when I wrote that message. 
The assignment is to the argument itself, not to the storage 
location it points to... for a moment I forgot how arguments are passed
(by value) and how pointers work :(

> Therefore, after the c2h_evt_hdl function
> returns, the value passed
> in as the argument for this parameter would still have its original
> pointer value (or NULL).
> 
> It would not therefore be possible to deference the pointer to this
> stack-allocated memory
> from outside the function, even in the original code. I agree though,
> its purpose is dubious.
> Originally, the wrapper function rtw_hal_c2h_handler would have passed
> it through to the
> function assigned to the c2h_handler function pointer, but there was
> no such function in
> this driver, so it was never executed.
> 
> >
> > > +     if (!c2h_evt)
> > > +             c2h_evt_read(adapter, buf);
> >
> > Having said that, I strongly doubt that this path is ever taken. I didn't check the call
> > chain, but it may be that the function in never called or, if it is called, it always
> > has a valid c2h_evt argument.
> >
> > Actually I don't mean to suggest something specific. It simply looks odd, so I'd check
> > and if this happens to be the case, I'd remove the whole c2h_evt_hdl().
> >
> > Regards,
> >
> > Fabio
> 
> As alluded to, removing the whole of c2h_evt_hdl would lead to
> c2h_evt_read no longer
> being executed, 

Yes, correct. I see that the only caller of c2h_evt_hdl() is at line 1971 of  core/rtw_cmd.c:
"c2h_evt_hdl(padapter, (struct c2h_evt_hdr *)pdrvextra_cmd->pbuf, NULL);".
Actually I cannot say whether or not pdrvextra_cmd->pbuf is properly initialized at
that specific point.

Maybe that staying on the safe side and checking for !c2h_evt is the most reasonable
thing to do...

Some time ago, Greg wrote that even reads can have side effects on some (broken?) 
hardware. So, you're on the safe side if you leave that read where it is. Well done. 

> which would mean the reads from the adapter register
> don't happen, and
> nor does the clearing by c2h_evt_clear(adapter); - in particular, the
> comment there mentions
> the FW not updating the next command message if this isn't executed when needed.
> 
> This may be perfectly fine, but I thought this approach is safer due
> to the above.

Yes, I must agree with you :)

Thanks for making me notice that detail about arguments. Maybe that that odd 
assignment made me forget for a moment how passing arguments works in C.

Thanks,

Fabio

> Regards,
> Phil
> 



