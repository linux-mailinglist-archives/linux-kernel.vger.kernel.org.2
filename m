Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8952E321349
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBVJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhBVJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:42:38 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F07C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:41:58 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m188so12214145yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnVUVgYdzlTaLNUZVHYsoq81Hf3LdGcZv8wp+xIsMKQ=;
        b=q9HANR+ftiNoosKELJ2rEATlHBG03CRuFOXrzqx9wEUjfjiLeAl4mErAg6hxevZqSB
         1OxRyHDNJ8yjRBD1Rl1XpX5uB6PQq6+bozZgi8PegSWEYuzU0E8CVi1FTas378d7oaRW
         ccQRLdpa83zJYkTKhXVqORSQWGmsxVnTSTVCiPQwjOoskTn2Rkxl2FRoJ/iucIU4JqN8
         TactrLdDk9ew2f7zWA/p0yGvJkvU0EV/pItd0URvTFEUinZJ2mFelm79PWf5ZpwEqfUw
         xOj1lrY12MtvIAk8UcnXALo2J5TqzPkx0ELBE3TKeTv9GecRvKQBeU/jiUzwr6hC4prM
         C1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnVUVgYdzlTaLNUZVHYsoq81Hf3LdGcZv8wp+xIsMKQ=;
        b=Oc/Wt+a3Uqgi59ZW/ifeAOirL4fNjlofY0PQGhiM/K0SImZByXM+riq+lkgJlo57OD
         L7NYlIaKdpSKRbMEE5xBARU3yFqNRz7meIkIyc3dSipzIQDCBElM4kRMDM0U9US+4Kcv
         6GXrbJe/hJnz+PdKbArl3jdfDuFQnOEVKA2brCT5MN6lgbnVhsr7jO34vUzRbo5yX8Qb
         WHMCgbUPdo+7q0kIuiRymgw785/ZGRmEXzbE5EscfDo3odl23k+RFIQBzMedcJwEIb7m
         zJuJYbDlUjlf8fWbAlqam2HsHb8z02ubne1MbnKkq6aMPSYm9scD1yicB8sMTEYCwMe9
         0vHA==
X-Gm-Message-State: AOAM533HRS20FTEHw/iYZNVljG+NDHYXHAQ4OgsTN6Zp2eyeC0Mpr+4I
        rAgu9k1FdyV0T/KPg38OdLcsxSN7QR5Ty8/JHMb16pcHRjs=
X-Google-Smtp-Source: ABdhPJwbbRq9Gy63KRsXCJZ2Ujf2rr34YLhQCl4CYzSt/RlsGoatSRgVM+4Sv8pL5X7Jnkdx7BZbfLabKkf+gNIlPUM=
X-Received: by 2002:a25:9204:: with SMTP id b4mr31636990ybo.420.1613986917930;
 Mon, 22 Feb 2021 01:41:57 -0800 (PST)
MIME-Version: 1.0
References: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
 <CA+=Sn1njFZ-XZRHJdmjzOyvXvcMXg+oBao=wK8w3RXN_Ji=fLA@mail.gmail.com> <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
In-Reply-To: <d9a2cdcf116ed32874ed02bd6fa60ad899ce5f50.camel@cyberfiber.eu>
From:   Andrew Pinski <pinskia@gmail.com>
Date:   Mon, 22 Feb 2021 01:41:46 -0800
Message-ID: <CA+=Sn1kR6jV2j2cOLhC-GBDS_NSxsw0m=K+VghBmqBSB4c2gqw@mail.gmail.com>
Subject: Re: problems with memory allocation and the alignment check
To:     "Michael J. Baars" <mjbaars1977.gcc@cyberfiber.eu>
Cc:     GCC Mailing List <gcc@gcc.gnu.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 1:37 AM Michael J. Baars
<mjbaars1977.gcc@cyberfiber.eu> wrote:
>
> On Mon, 2021-02-22 at 01:29 -0800, Andrew Pinski wrote:
> > On Mon, Feb 22, 2021 at 1:17 AM Michael J. Baars
> > <mjbaars1977.gcc@cyberfiber.eu> wrote:
> > > Hi,
> > >
> > > I just wrote this little program to demonstrate a possible flaw in both malloc and calloc.
> > >
> > > If I allocate a the simplest memory region from main(), one out of three optimization flags fail.
> > > If I allocate the same region from a function, three out of three optimization flags fail.
> > >
> > > Does someone know if this really is a flaw, and if so, is it a gcc or a kernel flaw?
> >
> > There is no flaw.  GCC (kernel, glibc) all assume unaligned accesses
> > on x86 will not cause an exception.
>
> Is this just an assumption or more like a fact? I agree with you that byte aligned is more or less the same as unaligned.

It is an assumption that is even made inside GCC.  You can modify GCC
not to assume that but you need to recompile all libraries and even
check the assembly code that is included with most programs.
Why are you enabling the alignment access check anyways?  What are you
trying to do?
If you are looking into a performance issue with unaligned accesses,
may I suggest you look into perf to see if you can see unaligned
accesses?

Thanks,
Andrew

>
> >
> > Thanks,
> > Andrew
> >
> > > Regards,
> > > Mischa.
>
