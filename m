Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7936C5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhD0L7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhD0L7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:59:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:59:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e7so69515203edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8m8em6nxLodDrYPSG/Gs5MYAM2kwAYCaYB3DrEVfIg=;
        b=Zw/itsC0IjGyghTlzOBWrKgLxqfbtcabyqvh7qYnGHVV4ekpTdK2Pl8j/7DYHVRUYW
         Mi5Sf0ZB5RfrXQA53rjcAS5OwpJeTmTeO5tWiaZNnYpE/gzUDjRyqQUAu/5c63p1cHaW
         sTL4HbtRl0esrnOfOpYM1IXoMhgkKOiutuBpidnpePAVTFMSw/n1vQarO+VYK0KB/WFs
         ddiwyklNITaTqHriSVT/NwEgdYWb3atnhaJ/ZqNDVt9PRMXWXAcGo6TfrNy2qgD5AZAF
         Y8WRyvH62gDcXsJ/xwl3Of1TlRXWB+ULI3ShDAUJiTGWOI0mQkdlHitjN4GiZ6Rqogp/
         m8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8m8em6nxLodDrYPSG/Gs5MYAM2kwAYCaYB3DrEVfIg=;
        b=eqlHcL+DGtl5EUKYJwO5tBVYk21T89OaFPiy3n0wu4EwkwsDVVaGYeCMhkxriCOjcv
         PWyuebHSSi4f0Wx7fZOtbBHuAdgP27rKA7Xhbb6tXByRjaRH89fXZ8BtFxsj2T4R95HB
         86LKv2JCTu7u5yI12qKOOt2tvrsE3E9Jo8Q3GJD0i0LDR9Y8l31UNUmtMfQKL8g8LImL
         5Qyu7Flfavvqt28eRUBumlB0OAyvI/myM/PPKxapAioSPN7eyEH6Wrd7fp9zNSrp/nNv
         X1bh06wN1etuHCZIbDLpYTVUodrTVKMe/qUOHPKUmzZNqzdXJ6Ip/wd3Hlm3E3QHS6gL
         IJAA==
X-Gm-Message-State: AOAM533WRq7zCdj47SQQytwchhE27RyNsHjyH4h+HaioFOOGTbioSw4k
        lTw7VnbKFKcAWDCbicyCEhg=
X-Google-Smtp-Source: ABdhPJxRDQkqFqw/QqIZti7I0Xh5mwlm1V5eC53om5tWOsnycvT067WuCzDgBIlz4iHwgO227+23Xw==
X-Received: by 2002:aa7:cc94:: with SMTP id p20mr3901758edt.353.1619524747377;
        Tue, 27 Apr 2021 04:59:07 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id v5sm2246530edx.87.2021.04.27.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:59:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH v3] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Tue, 27 Apr 2021 13:59:05 +0200
Message-ID: <9700190.zQFrKL04sV@linux.local>
In-Reply-To: <20210426220327.GT235567@casper.infradead.org>
References: <20210426184245.12269-1-fmdefrancesco@gmail.com> <107967147.Ip005GxVp3@linux.local> <20210426220327.GT235567@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 27, 2021 12:03:27 AM CEST Matthew Wilcox wrote:
> On Mon, Apr 26, 2021 at 11:15:40PM +0200, Fabio M. De Francesco wrote:
> > On Monday, April 26, 2021 9:21:01 PM CEST Matthew Wilcox wrote:
> > > On Mon, Apr 26, 2021 at 08:42:45PM +0200, Fabio M. De Francesco wrote:
> > > > +static void setup_scsitaskmgmt_handles(struct xarray *xa, struct
> > 
> > uiscmdrsp *cmdrsp,
> > 
> > > >  				       wait_queue_head_t *event,
> > 
> > int *result)
> > 
> > > >  {
> > > > 
> > > > -	/* specify the event that has to be triggered when this */
> > > > -	/* cmd is complete */
> > > > -	cmdrsp->scsitaskmgmt.notify_handle =
> > > > -		simple_idr_get(idrtable, event, lock);
> > > > -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> > > > -		simple_idr_get(idrtable, result, lock);
> > > > +	u32 id;
> > > > +	int ret;
> > > > +
> > > > +	/* specify the event that has to be triggered when this cmd is
> > 
> > complete */
> > 
> > > > +	id = (u32)cmdrsp->scsitaskmgmt.notify_handle;
> > > > +	ret = xa_alloc_irq(xa, &id, event, XA_LIMIT(1, INT_MAX),
> > 
> > GFP_KERNEL);
> > 
> > > OK, think this one through a bit.  When xa_alloc_irq() stores the ID 
that
> > > it assigned into 'id', what happens to it next?
> > 
> > Oh, I overlooked that... The ID in 'id' is lost when the function exits 
and
> > the stack frame is unwound.
> > 
> > Now I have another problem: xa_alloc_irq() writes id u32* but I have an 
u64*
> > in 'id'. What happens if I cast 'id' to an u32* when passing it to
> > xa_alloc_irq()?
> > 
> > u64 *id;
> > int ret;
> > id = &cmdrsp->scsitaskmgmt.notify_handle;
> > ret = xa_alloc_irq(xa, (u32 *)id, event, XA_LIMIT(1, INT_MAX), 
GFP_KERNEL);
> > 
> > Do I destroy the information stored in 'id' with that cast?
> 
> That is a great question!  That would be a really serious bug because
> it behaves differently on big and little endian systems.  That is, on a
> little endian system, a pointer to a u64 can be treated as a pointer to a
> u32 and it will write to the bottom 32 bits of the u64.  On a big endian
> system, treating a pointer to a u64 as if it's a pointer to a u32 means
> you write to the _top_ 32 bits of the u64, and things go wrong from there!
> 
> Similarly, if you have a u16, you can't pass a pointer to it, because
> the called function has no idea that it's only 16 bits, and will do a
> 32-bit store to it, overwriting the 16 bits after it.
> 
> So you need to pass a pointer to a u32 on the stack, and then copy the
> id out of it afterwards.
>
As far as I understand, in setup_scsitaskmgmt_handles(), the task of  
xa_alloc_irq() is: find two empty entries in 'xa', store the indexes into the 
'id'  pointer (before the first call this is set to &cmdrsp-
>scsitaskmgmt.notify_handle, and before the second call it is changed to 
&cmdrsp->scsitaskmgmt.notifyresult_handle), then store the entries at their 
respective indexes.

Indexes that xa_alloc_* set are of type u32*, so why not just change the type 
of notify_handle and notifyresult_handle from u64 to u32?

Furthermore, I cannot understand why those indexes should be passed in and out 
as arguments of the function . It seems that they are not needed anywhere else 
in that file. Are they?

Maybe that I'm still missing something...

Thanks,

Fabio




