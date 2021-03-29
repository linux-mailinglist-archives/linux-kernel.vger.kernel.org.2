Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8A34D803
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhC2TV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhC2TUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:20:45 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:20:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f19so2113589vsl.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvLD+PBfEDR5RGMD5FUigiiQrG3A/zwzq8Ry41sJqeo=;
        b=I+0T1dIvk8JG1w0iMxG5sY7HAIZ1KywN2bGq84hDhC/hvOHQxPcmDcwWd4r7mZaUiv
         auHW90otn/DhujB8rBznYKDkeiix4aDWe3XnX+Z+zU1rwDxMHPs1RC/q3ecyI1kjauJx
         zJdIxs4MRafp/skdtrk+fVNGPFJ7osW6QAeuYg3hs0vH3kc/zCEuZjZiwgvfwsSahM1J
         05x3E+JsWnNhz2swzeAOy9snwzH/Lo3W+wHvb5yDD1hp4U88ZYEkxeqb16ibdYRxFUa/
         9/tFIgwMSKqPevZra8MKr3sQEois0LnyYN5MWI3Pd7k4we3JWAeSyR6aQvdhP4nfq9Tt
         ABkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvLD+PBfEDR5RGMD5FUigiiQrG3A/zwzq8Ry41sJqeo=;
        b=BXetyMm22wH0VO/LWRqBSLqYi1Ik3mJ7UZVWK2Jg+AS59EZHFkT3pANK8jKMZgghGX
         KZEIFRMSY1Pe9m13R52L+gouVx10Ad/pzOiCugnSrwdASpZjEuH+8AA5xEoZ3kHSyrkT
         g2iFMTdpLbPie3fchixpK593hWdce3oU30kGweiZIamGXXhvOp1jgxnfLYZsp8SdniC2
         liRC3QXkpHov8cyxADuOvQchJg/jcmqmwPzWl+ohUUcLzTrcS4ghCxF9k4NeUPvxqRlM
         96/gaj1lwgDu98kzx+aIBuf31UsdG2ZHVbjLN7h4dka0vZjrbHn+AvQBaw5nRxiyRh1z
         Vv0Q==
X-Gm-Message-State: AOAM533bGyCnayMarvvxrdH3jhTq+ytDPNzsxbIwbPimFCRCpk074cjr
        rUvRaMQ825p1lyR3us7HmaZeApzsIl/YqiT8RgQVqvz7E7M=
X-Google-Smtp-Source: ABdhPJy5DDb8trwWTPgJsdi/YP1pvSvV+RO5LH1PyfxkJ2v/fTWZp31tazdsLcOQ9rDtKOkVqiyMd9aHVSzqNG1w2Sg=
X-Received: by 2002:a67:1ac7:: with SMTP id a190mr10259146vsa.18.1617045644023;
 Mon, 29 Mar 2021 12:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com>
In-Reply-To: <YGFeQUuAaKgeaqCA@kroah.com>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Mon, 29 Mar 2021 21:20:32 +0200
Message-ID: <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
To:     Greg KH <greg@kroah.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,



On Mon, 29 Mar 2021 at 06:57, Greg KH <greg@kroah.com> wrote:
>
> On Sun, Mar 28, 2021 at 10:20:50PM +0200, Fawad Lateef wrote:
> > Hi
> >
> > I am using an Olimex A20 SOM with NAND and due to some binary blob for
> > NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
> > here: https://github.com/linux-sunxi/linux-sunxi)
>
> Please work with the vendor that is forcing you to use this obsolete and
> insecure kernel version.  You are paying for that support, and they are
> the only ones that can support you.
>

The problem is vendor Olimex now have eMMC based SOM which is
supported by mainline kernel _but_ they still selling NAND SOM and
only supporting 3.4 kernel (as this is the only latest version from
sunxi with NAND support, after that sunxi is now moved away from NAND
too).


> > I am currently using buildroot-2016 and gcc-5.5 for building the
> > kernel and every other package needed.
> >
> > Now the requirement is to move to the latest version of gcc-9.x, so
> > that we can have glibc++ provided by the gcc-9.1 toolchain.
> >
> > Main problem for moving to later versions of buildroot is the kernel
> > 3.4 which we couldn't to work with gcc-6 a few years ago _but_ now the
> > gcc-9.1 requirement is mandatory so now have to look into compiling
> > linux-3.4 with gcc-9.1 or above.
> >
> > Now I need some help.
> >
> > -- Is it realistic to expect 3.4 kernel compiling and boot
> > successfully with gcc-9.1?
>
> No.  It took a lot of work and effort just to get the 4.4.y kernel to
> work with that gcc version.
>

Ok, thanks for the information. Any pointers on what to look at if I
had to go this route for 3.4 kernel?

> Again, please work with the company that you are already paying for
> support from, they can do this for you.
>

From Olimex they say it's an open hardware platform, so I really can't
expect them to do anything for it.
(https://www.olimex.com/Products/SOM/A20/A20-SOM/   NAND version)

Thanks and regards,

Fawad Lateef


> good luck!
>
> greg k-h
