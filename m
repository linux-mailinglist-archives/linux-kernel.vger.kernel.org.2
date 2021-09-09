Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2186340470C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhIIIcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhIIIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:32:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E1C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 01:31:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so1309295wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rhQ+Sg+eJCdyIigz4yW70ETZ6kRtSTGVLdwqIyYFW5M=;
        b=hrzZdJdfcDUhak7xd/oVUPxlQrDu+2MbSGzh9LEyPJRdjxrexFYiWuptUMIspJaV8Y
         AmAMHNtGrQOh28/8HrCcYjJpTP2AWHoWRL4H6GsfI7JWOhlbQaBZ8HilKadd2NDmTwFC
         xHIdeeTZp5e04upiZmDzgD48OtzqpFu8sQWD+79Fn1oLqoAW7RzgZOQh2rET/Oe/29/7
         dyZKNOhX3pwdABwpeRMmV9jLppM/Dg0DvQFcCgwR8omz9bXh1DI/KaS5tLRpYW+/dLsE
         XnnVPDtlVE8yaN/RD74j8c+kRXrG1K2qdPXxWBEW5i6rIqucAnawYXZAsEQL+vgIr7sz
         mBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhQ+Sg+eJCdyIigz4yW70ETZ6kRtSTGVLdwqIyYFW5M=;
        b=uM4KzX7P9WvwVRRB9+FjkV0vqqZe+EM6CoMpj0OCSaGV9n3yxvQJZ3BN43rrDG+JTv
         IQ35XTAI+g4OdrC1nreW+NLj8rKoLbTtYn/gYTcnyqUeO+B8NJYP4Mf6WgbE0rZnSz5/
         eY0QKQ2wyMMOkLUKB8fMsEMBc0qJf24nrS8PW37n4fegqPXKRZpWOZYuX7lqnZdo6ES7
         MLXohHvzqDpN7KFZNoMjFf2Iy+8xjZBMqJLP1jxrpFm9FKpdlelDJyi9WhNgNiNybhuL
         +vYbP7Z5Qz3NljXaiMyXURUWULFKm8cjxGyUVnRYsLtb4Css7N99GqpS4dlFGpqUrsJo
         Rrtw==
X-Gm-Message-State: AOAM530DcY3Wk3gxveV0z6/Ee4k5kAqL/SO8j+Yy9nvaWkDZS7JQkZI6
        IAi+spqTfvBwGpkuOVbPucE=
X-Google-Smtp-Source: ABdhPJwsOiZN1+b3duXLtNpkmW1MNq6jZpjeK66MXOevW1b1ctufRQ6Nh889CPdOnzVWipNy1zJ7Ww==
X-Received: by 2002:adf:e645:: with SMTP id b5mr2124669wrn.34.1631176293502;
        Thu, 09 Sep 2021 01:31:33 -0700 (PDT)
Received: from localhost.localdomain ([37.161.158.236])
        by smtp.gmail.com with ESMTPSA id p4sm893675wmc.11.2021.09.09.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:31:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 3/3] staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()
Date:   Thu, 09 Sep 2021 10:31:30 +0200
Message-ID: <5319192.FrU0QrjFp7@localhost.localdomain>
In-Reply-To: <0614a5a9a1d54700be6d824bdd7c7469@AcuMS.aculab.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com> <10808398.E1SmXddD8m@localhost.localdomain> <0614a5a9a1d54700be6d824bdd7c7469@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 9, 2021 10:21:04 AM CEST David Laight wrote:
> From: Fabio M. De Francesco
> > To: Larry Finger <Larry.Finger@lwfinger.net>; Phillip Potter 
<phil@philpotter.co.uk>; Greg Kroah-
> > > ...
> > > > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/
> > staging/r8188eu/hal/usb_ops_linux.c
> > > > index f9c4fd5a2c53..e31d1b1fdb12 100644
> > > > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > > > @@ -8,76 +8,51 @@
> > > >  #include "../include/recv_osdep.h"
> > > >  #include "../include/rtl8188e_hal.h"
> > > >
> > > > -static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, 
void
> > *pdata, u16 len, u8
> > > > requesttype)
> > > > +static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, 
u8
> > size)
> > > >  {
> > > > -	struct adapter	*adapt = pintfhdl->padapter;
> > > > -	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> > > > +	u16 value = (u16)(addr & 0x0000ffff);
> > > > +	struct adapter *adapt = intfhdl->padapter;
> > > > +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> > > >  	struct usb_device *udev = dvobjpriv->pusbdev;
> > > > -	unsigned int pipe;
> > > > -	int status = 0;
> > > > -	u8 *pIo_buf;
> > > > +	int status;
> > > > +	u8 *io_buf;
> > >
> > > Some of these changes are whitespace or renames.
> > > They ought to be in a different patch.
> > 
> > Dear David,
> > 
> > No, they are not.
> > 
> > I guess you were misled by the structure of the patches. There is nothing 
I
> > can do about it. Please notice that usb_read() is created in 2/3, and I'm
> > free to use the name of the variables I like in new functions. 
Furthermore,
> > usb_read() is untouched in 3/3. I can see why you thought they are 
renames :)
> 
> Hmmm... it might be worth playing with the patches and the
> order of functions so that the diffs are meaningful.

Yes, I agree. Readability of the diffs should be taken into account because 
it make the work of reviewers a bit easier.

I'm trying and see if some clean-up of usbctrl_vendorreq() (from which I 
copied most of the code and pasted in my new functions) can improve patches 
readability if it is carried out preventively (I mean before creating 
usb_read() in 2/3 and usb_write() in 3/3).

I hope that that preventive clean-ups would help when in 3/3 I will delete 
usbctrl_vendorreq() and the new code overlaps the lines that were used by 
that function.

Let's see... Perhaps it may solve out problem :)

Thanks,

Fabio

> 
> Some experimentation can be needed.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 
1PT, UK
> Registration No: 1397386 (Wales)
> 




