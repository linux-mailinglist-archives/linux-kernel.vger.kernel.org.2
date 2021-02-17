Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAA31D455
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 04:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhBQD4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 22:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhBQD4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:56:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE55C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:55:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p2so846543edm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 19:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g+XdSGRDC+UKZZb+od4CJ/ox1PUUGOWH7HVwdvWgOms=;
        b=Qd9vr/arQTN+PcJt3DWX6TO3dsl6/R80iu/o6waYw4xwTrj6mYvu+HVXKipiU75PY7
         kNAu5uFtgqL5FAO9tZp7C/4Xd+6zSTr4k1ONKPg5SDclVhS01GklWKJuUTaPrIFoqEmY
         lfQwYF73uPhqOt59UyZteqP+avjsKt7a3D2RDqyPpHnsPO9uh8CYMkmdYulIc5I1mbv7
         qm2fdAhVB7tbnnzp2yVzqycJ0dFLIRBhkP+pLLjHFGgqILyfp/50F9sPubyMnCVUAogu
         Otrh17mdzLdzRED7yW3i1qAwgEikA3840gh1bM6ED3vFD14WwQxNIV11YmsDikTQW+fy
         Z3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+XdSGRDC+UKZZb+od4CJ/ox1PUUGOWH7HVwdvWgOms=;
        b=RH6fpppgub23Na46/ATA3gcakvqaV7E43g7Xwx5z4GQHBlHb1FMKehz4vCwr6jKGe0
         lN/6oKNdI8IPduvEYlqi13LRUbKpHDJhTf3aUGgtu4pMqF9ZsttHdQfQ3+Ig3DCnlPm6
         Mz+73roE5/Ylg4PVCFrCgifLF8uMoPpZp+csqKs3Lu8sm9lxdNMdV5sE6/hiyKhyAyd9
         axPn50X2C/NJZIiM4DQxfc2u5VkDUCii9q+F2mhmVx6FgEtj7d1RRNSifc52V5ltcGfa
         hP4ftEL7zNSQCZZf3eYUCubcOOIRMOet9UZsSOoOFnY8CjvFLRTEwGwX3hfuQoiajozB
         Tdpg==
X-Gm-Message-State: AOAM530fnAssX3fjQ1aGS9uidrE1rtwIURu8p8ulVqi5a3MC7/w85uw/
        4OxcsgxPi+Dqn7ybWPsQyPuoZFlM/MfWgWGX2+vaXg==
X-Google-Smtp-Source: ABdhPJxbyEummMiLabbqUc5of7znDOlGaSNSQaPzX6SYYjiEpYGI47uLVWLG+/V/yL78HvLrDpa0nfbhFqs2CjpNSJo=
X-Received: by 2002:aa7:c58b:: with SMTP id g11mr18792732edq.354.1613534130701;
 Tue, 16 Feb 2021 19:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20210205222842.34896-1-uwe@kleine-koenig.org> <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 19:55:20 -0800
Message-ID: <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 7:48 PM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> On Fri, Feb 5, 2021 at 2:29 PM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> >
> > Hello,
> >
> > I didn't get any feedback for the (implicit) v1 of this series that
> > started with Message-Id: 20210127230124.109522-1-uwe@kleine-koenig.org,
> > but I identified a few improvements myself:
> >
> >  - Use "dax-device" consistently as a prefix
> >  - Instead of requiring a .remove callback, make it explicitly
> >    optional. (Drop checking for .remove from former patch 1, introduce
> >    new patch "Properly handle drivers without remove callback")
> >  - The new patch about remove being optional allows to simplify one of
> >    the two dax drivers which is implemented in patch 4
> >  - Patch 5 got a bit smaller because we now have one driver less with a
> >    remove callback.
> >  - Added Andrew to To: as he merged dax drivers in the past.
> >
> > Andrew: Assuming you consider these patches useful, would you please
> > care for merging them?
>
> I've routed device-dax patches through Andrew when they had core-mm
> entanglements, but a pure device-dax series like this I can take
> through my tree.
>
> One small comment on patch5, otherwise looks good.

I take it back, patch5 looks good. I was going to ask about the return
value removal for dax_bus_remove(), but that would need struct
bus_type to change prototypes.

All merged to the nvdimm tree.
