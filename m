Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30273FAAF3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhH2Kus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhH2Kup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:50:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05001C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:49:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x16so5165547pll.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcwbt0QYBilC1KUjADiZKweYPQYwCgMgAZVZ1Z7Fg5w=;
        b=cWubZFphcxdu24TVVWdwW2ngYth/s1Sj7sIcpFHLlOU7J1VGniqC5o1xSQG3vfeOUg
         wFiP13SbBxiPAhLzx7+GYgszVoqR0Rm0sICWdLdN5UiaYoE8VR6mCWhtepxRGe8uh4et
         plfmf6CK/vQ8uS8AIBAaJyd6ItUX9IFZCQ6N1lvW2XjOPi5d2wD5snrn+1CbcX3/0jse
         QsFq0OmPUJZzRLa9ngNmnIAVCxJ7pR5iBJj/SNfEvy4SHTLJ0thk5GnR3hJBCL5EfveW
         N8elgOjSDty9ZjvO5jKdtHqdOK7eIhtcdrZv5y0Rnl+2MT5f4Mcv1K2aJ6HcSXKTsz7u
         J06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcwbt0QYBilC1KUjADiZKweYPQYwCgMgAZVZ1Z7Fg5w=;
        b=LFIx2XYnarEMkuplsMJPoZzotin5Wt0/wuFNC98CEoC1ioIUzjxVV2KptYILMpRUjt
         GIkVpkaeuACr4mygENUMtNnf+Xa2V8N/qxPbqJe+yCn31awFgw04DqF3FG011Q/+t0dY
         aB9c8BojfsaWo6qfolrgCBFdSAI/LEQA5NPwPwPWV1csXOdiF/rapMz/A+KV/rxHKtMF
         M1Nv0Ae2vqmnPpjhTEJgekU88jOApTBCB5j6Lil9KLEfPFEktIngq8GikVlL6NqzWT7/
         8cd4chRfVZSx/bEHnLOtsp3+zcHSRVOXNiKGcaAK8eknboWZpqb5dBY/mQbFovUY3sb8
         9fAw==
X-Gm-Message-State: AOAM533gbLLd+6SNyT7+4a4jfy/VqJnodd7QTMoyVy9vC/yhB3W4dwLi
        K//IpDZ+wY8UdJEjtIy5Se/PPGVZHWyFmGwtdcgHwQ==
X-Google-Smtp-Source: ABdhPJyg5OvleoQoU758Mdf0exKeOgwhKC9k987aeUPLHLoMATE2umjufiCp75Lvs+wDPYBBMQCH3EtyKxkmtzJvF5s=
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr33134651pjy.225.1630234192921;
 Sun, 29 Aug 2021 03:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210828212453.898-1-phil@philpotter.co.uk> <20210828212453.898-3-phil@philpotter.co.uk>
 <21174665.bKA57LRvRV@localhost.localdomain>
In-Reply-To: <21174665.bKA57LRvRV@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 29 Aug 2021 11:49:42 +0100
Message-ID: <CAA=Fs0meC_nVjb2gESnmz2pPgzNa4=QT_jnteAh4B8Cds6_0fQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: r8188eu: simplify c2h_evt_hdl function
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 at 09:52, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> >  static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
> >  {
> > -     s32 ret = _FAIL;
> >       u8 buf[16];
> >
> > -     if (!c2h_evt) {
> > -             /* No c2h event in cmd_obj, read c2h event before handling*/
> > -             if (c2h_evt_read(adapter, buf) == _SUCCESS) {
> > -                     c2h_evt = (struct c2h_evt_hdr *)buf;
>
> Dear Philip,
>
> Not related to your patch, but what kind of odd assignment is it? c2h_evt takes
> the address of a local variable and therefore it crashes the kernel whenever
> someone decides to dereference it after this function returns and unwinds
> the stack...

Dear Fabio,

Thank you for taking a look firstly, really appreciate it :-) As for the line:
c2h_evt = (struct c2h_evt_hdr *)buf;

in the original code before I removed it, bear in mind that this
pointer assignment is
happening into the parameter variable c2h_evt, which is a copy of the
passed in argument,
as C is pass-by-value. Therefore, after the c2h_evt_hdl function
returns, the value passed
in as the argument for this parameter would still have its original
pointer value (or NULL).

It would not therefore be possible to deference the pointer to this
stack-allocated memory
from outside the function, even in the original code. I agree though,
its purpose is dubious.
Originally, the wrapper function rtw_hal_c2h_handler would have passed
it through to the
function assigned to the c2h_handler function pointer, but there was
no such function in
this driver, so it was never executed.

>
> > +     if (!c2h_evt)
> > +             c2h_evt_read(adapter, buf);
>
> Having said that, I strongly doubt that this path is ever taken. I didn't check the call
> chain, but it may be that the function in never called or, if it is called, it always
> has a valid c2h_evt argument.
>
> Actually I don't mean to suggest something specific. It simply looks odd, so I'd check
> and if this happens to be the case, I'd remove the whole c2h_evt_hdl().
>
> Regards,
>
> Fabio

As alluded to, removing the whole of c2h_evt_hdl would lead to
c2h_evt_read no longer
being executed, which would mean the reads from the adapter register
don't happen, and
nor does the clearing by c2h_evt_clear(adapter); - in particular, the
comment there mentions
the FW not updating the next command message if this isn't executed when needed.

This may be perfectly fine, but I thought this approach is safer due
to the above.

Regards,
Phil
