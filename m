Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94093FAF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 01:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhH2XAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2XAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 19:00:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:59:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r2so11640789pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6Bitu04SC8w/Oeyk+aMOmbe0Hn4enRhPwVxGk0NMDQ=;
        b=QAV2gTPG3WqToA6QnbQKA+4i1GufBx1aXKpygKCDz0TkeEzkQgTLlu2sODYLWvx2pE
         vDQFpZQEBIixMp6uV87TkJUJcfvBQ8eUo8u7lOJqjzepSZkwakqrAWjdpgG5vNPJKNrz
         fEOLKEDxRYm2gkCF8ObT6EgdVz7rCHyPSeF9nFZ+JIu91XVT9IOiYjXSfOAv/BtDec5a
         MhnXYcL6079mrsJjY4etVJYJDWtqrQ8uofYHuKsktD6WUX0BF8Mvf3UtCFkZDBMEMacW
         wfwq0XjcRlZsA24XdGUzdCaN+HrTogZF53a3j2wbVZkzquDGnRo9Qk7AoeeIU67YNtJ/
         IklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6Bitu04SC8w/Oeyk+aMOmbe0Hn4enRhPwVxGk0NMDQ=;
        b=J8TYnrIvAqWygJdmhL2M3/cL1GGs1bGxqgupxJg0VOsUrCNMe9E0padexibq0W2BAI
         QFPTBj23n+8ONiYmO3lc8/u1jrESF9DqdL06NCLawZnZMJh4hfviYqsgdE4oDZBa0NGp
         1EIY0g0ocMcIWdVuOZkp32RIaGCHaECbOc2Nmx8QHXz6Eo27NMiuYhfFbDIRZCXox8MA
         f3z7NXv+XyZYCCPmL6KCljKaa5nxo82nGF9m4XX63482XN0Ma93NBd+NuamhBKBlPtkV
         7+Ki4orhYTSj0XD7UyBSRp0dLJUJrW/IBaMKUXUlVqNO2IuQoW+MNDCUmYUXUyvHJ7Tw
         E67g==
X-Gm-Message-State: AOAM5301W9cIVKmrxPdjBpnTHQKbtNXoOCHY1qTJcZ+nxa+0EwVbAamd
        XLjOdR1o4LBfo01Avvahk3Nu1+d1s/xP/6OAU4IgyA==
X-Google-Smtp-Source: ABdhPJwtp6YRFVBRJFTzhthGfA7afX2XtHmjB9lS4M2njtIcL2pvEVyhJRarNf8w+B4z82Xz1VbkCF4mZ56gQjV0p5s=
X-Received: by 2002:a05:6a00:1ac7:b0:3e2:2d05:3b31 with SMTP id
 f7-20020a056a001ac700b003e22d053b31mr20507594pfv.2.1630277998914; Sun, 29 Aug
 2021 15:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210828212453.898-1-phil@philpotter.co.uk> <3884124.htuf3bXTbR@localhost.localdomain>
In-Reply-To: <3884124.htuf3bXTbR@localhost.localdomain>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sun, 29 Aug 2021 23:59:48 +0100
Message-ID: <CAA=Fs0kyV4UXFSob5kmCSfYXrB=DN+zy3vh70mnkaLg0bswmrw@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: r8188eu: cleanup c2h_handler code
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

On Sun, 29 Aug 2021 at 13:48, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On Saturday, August 28, 2021 11:24:50 PM CEST Phillip Potter wrote:
> > This small patch set cleans up the c2h_handler code in the HAL layer
> > of the driver. In r8188eu, this field of struct hal_ops, is not even
> > used, so dependent code has always returned _FAIL. For this reason, we
> > should remove this function pointer field, and the wrapper function
> > which checks it. This is done in stages by this set, and helps get
> > the driver closer to the pointer where the HAL layer is
> > deleted/integrated as necessary and no longer a separate entity.
> >
> > Phillip Potter (3):
> >   staging: r8188eu: remove c2h_handler field from struct hal_ops
> >   staging: r8188eu: simplify c2h_evt_hdl function
> >   staging: r8188eu: remove rtw_hal_c2h_handler function
> >
> >  drivers/staging/r8188eu/core/rtw_cmd.c     | 23 +++-------------------
> >  drivers/staging/r8188eu/hal/hal_intf.c     |  9 ---------
> >  drivers/staging/r8188eu/include/hal_intf.h |  4 ----
> >  3 files changed, 3 insertions(+), 33 deletions(-)
> >
> > --
> > 2.31.1
> >
> Dear Philip,
>
> You work looks good (especially after having clarified a couple of minor doubts
> I had expressed in another message). So, the entire series is...
>
> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>
> Regards,
>
> Fabio
>

Dear Fabio,

Thanks very much for the review and Acked-by, much appreciated.

Regards,
Phil
