Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71AB3F2C16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhHTMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbhHTMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:31:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE8C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:30:44 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so13125504otf.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ycqCHprUj8AdNS/PGDGviXgkruDDEIUSv93gStfgEOE=;
        b=pIZcY/FccQr9cwF5yoq+w2taoaZ2lhmXx4NMMGCcq6sFkWgWZp7eWLX2wC+LONOGuQ
         W8fNc7sL4QSj/WqMjLp0ITyK77NsZ3E+opQFjScTfFGYRVUtZyzKpxBlpm+1JM+HxBmy
         X1QV0Kd0YsBoXbg9/yT+lusKGHymUnSS0oJKdUTJlaIsHimbsLQlItHVN671Nk9rmTLR
         ZOvkU9/E3wgUECPTVTvhel/Z48PHIKWwet/Shc/17CX7d7NWBjZ2HwDnuJDGccS86hqS
         IznRndebXT289uxKZHq4CCokDQV5gV5ZScstaftDqL+QHZ8elHXeCTdsJzt7ROHVyQZ8
         NX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ycqCHprUj8AdNS/PGDGviXgkruDDEIUSv93gStfgEOE=;
        b=oIC8ozt3Si//Vk56fBd3NfQGK/mlxqB23Ezg12CSJYDCHZfdRWBHHQrZSO3VJI67A5
         KsHy1Lg0Vs1VSMvEl/YSil2D4BWR9sApPN1EXJD6bxzRup++DXwNKdUIhpECiPU6Leyz
         JaTyp2X2Mc9cf/FQYdVj4EIXD6Gy3w8Sdw/CPGWn+BS7e4vlULSzDXTEw1eLoTDP4i71
         zCxh0zW6T9hCSEUk6i4ApnH/QC+cSS+YwSwUf5uBgFRS4/QIbLmoFBGduYlI2QmEuoZu
         v6uFzAz271RFA63ha+1x/uJuhSAgGecjVB30lYI9JpdwRmiJK9xT8vdP2/SKurHs2+uB
         xI8A==
X-Gm-Message-State: AOAM532vZOj4Iiti2Nwa1SY+BnA+EpLYn/NunV02WFVKwxKQnMWnsFfY
        6sr7kH5lZOH6P0ukaseyDFld98+GIb9KHXKWk3mgybapiQg=
X-Google-Smtp-Source: ABdhPJzb/7pM+Ugc4oy8sTtTr15aETaAI8qb/95qPw63/SnN08yk7ye1x9YcHnEnZv8eXwEP5mjSt2E0PhjQGeCxY30=
X-Received: by 2002:a05:6830:156:: with SMTP id j22mr8385176otp.75.1629462643923;
 Fri, 20 Aug 2021 05:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1624850430-28015-1-git-send-email-zhenguo6858@gmail.com> <YPf16Kr/jUhqxGDM@kroah.com>
In-Reply-To: <YPf16Kr/jUhqxGDM@kroah.com>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Fri, 20 Aug 2021 20:29:35 +0800
Message-ID: <CAGGV+3KZnJPAoEHU4F2ErHAzE6J=75M-E4D5bNf2E1monmCBLA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: add some instructions and code for requester
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,Jiri

I had made the patch series,pls check it.
In out YOCTO project,it works well.

Thanks!

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jun 28, 2021 at 11:20:30AM +0800, Zhenguo Zhao wrote:
> > From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> >
> > The gsm driver can configure initiator or requester by parameter
> > initiator,but the config code and using are different ,the doc has
> > initiator instructions only,it should be add instructions for requester=
.
> >
>
> Again, make this a patch series please.
>
> thanks,
>
> greg k-h
