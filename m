Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3B3556B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbhDFOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhDFOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:34:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 07:34:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so14826703otr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUYbOgHuSAYpzoZRGuGwSjbBeBpiwQiB3xQEQ3O76qc=;
        b=a6C3pD6FZR61u+r6hPwcKK5oPhn2ctxJjsOImJToXfLJYrlNSUeZlN8JXgdtQBIVae
         b9yU843pSLe08l56Q2/hEbSH5fsx8eEr5yWr1T4+EzogfNEIZsPyQ67wOIZkugIg0xlQ
         TQ7VNHagnrdq+1WZq2jRezfmr2+eQIdlYIG0l1tvV4dwwIddjU/Pt2Js8t9ufQcfxCqs
         JvGd4jmKggm7npHfYtd0utBl1JwrfefCX79/TTOcmlDBcAsWQxHHw6I4VdJXpratuhk6
         zYSk/LJHPnzrH20acNB8EAYmRlUGgBzARdDYtfZRncK4jMwIptaogcenWCCjnVgLpQ4K
         xswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUYbOgHuSAYpzoZRGuGwSjbBeBpiwQiB3xQEQ3O76qc=;
        b=WGhPMv4WBzX/17ZfMaworONeWxjNqIkEEIYUS6wBjGbMNLA8SxNFVwRMXTYICNyrtU
         NIdoOg5Nz13XrirN3hReiIGu9sb0uD0vLW2R3IOxN4O3tzIIjH0D8y5F5EDAxDTH1Cdb
         /sVKrvK0z++hIQzUgJ1bnAX7pEys+g3cjzob2iTHL7kbHuVHhNyuS+ywIY+52iQWCIGu
         Q3QV8bt0ul1jbPTg5QSOLbk+aC8yB4IDvDgUTsDidb5Zlg0uE1At7XiLiwv6ZZp1iMOF
         3886nQ7JEwIBcPHexhMgy3DrghEIB9Lg3MU9FVKU+Lb1gYImqBvZ6QwRKThl2J0nfcM3
         Qs9g==
X-Gm-Message-State: AOAM530o+euubz0nrAE9tITTgGQ2AWVl44Y+b3wJCRsB+l6xmtRVwT+T
        sUjAQXPSeSePRXdBNqwmOgrElhWdsfhtZSirXdARlkj3PRFzZw==
X-Google-Smtp-Source: ABdhPJw+RpxaUJRD4x+ANKSTuUZqr3U2pPGGzKUXF6U947nHKwYLnjdlgPwqe848FvMQt2dG3B9apfw1P1ldGolMpPs=
X-Received: by 2002:a9d:7f8a:: with SMTP id t10mr26190979otp.239.1617719658109;
 Tue, 06 Apr 2021 07:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210406130556.1417-1-fmdefrancesco@gmail.com> <YGxsExq2fcQvrN99@kroah.com>
In-Reply-To: <YGxsExq2fcQvrN99@kroah.com>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Tue, 6 Apr 2021 16:34:02 +0200
Message-ID: <CAPj211u9MHgtjeZGUPsLxU3HkbJ8cr2EUL0v9HA7LE9-b1uUoA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove
 camelcase in Hal8723BReg.h
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 4:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 06, 2021 at 03:05:56PM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> > are not used anywhere else, therefore this patch does not break the driver.
> >
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
>
> If this is "v2", you need to put below the --- line what changed from
> v1.

It is a v2 only because you made me notice that I forgot to cc
linux-staging and linux-kernel.
So I sent it again, but probably I shouldn't have changed the version
number because nothing else had changed.

> Please fix up and send a v3.
>

No problem at all. I can explain in the patch v3 what I wrote above.
May you please confirm that a patch v3 is the correct solution even
when nothing changes in the code?

Thanks for your help,

Fabio

> thanks,
>
> greg k-h
