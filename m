Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862143BE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 02:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhJ0AFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 20:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbhJ0AFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 20:05:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97BC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 17:02:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d63so1492337iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4twnWZaz/uCnsUp6yfoaHYStTI/UK/5pB+90myxvwMY=;
        b=McGYTg8EWlwdYu4NP87nhhrmGSR61hXJ5OYQ8OkGOrk7OMTerkySezVKbw6NB6lXX9
         V9mGDV/jQFXRdWhP5n5ukJxhXardWMokHErGiZTwKRsYbk6hqy4y2thQbIqYxm9qkXns
         9EAMr3DAHJ6gPE2b+FtDf9v4hcAWJLQ4I0yJrEs2WI24f6yNF3z47oXlLwA4QIAy6i5A
         tbX6YFJ4uIPec3Qz275WTkL0LqoyUtQ3Fr4YXN8Ry7nSRLwoqaA1pZkEnivZNxjkAqit
         yig8OsE9uFG5h6KAbgpIUslEugJWp70UJIep+y3iqMt0briWYHsVMCu5Mk2pJodydhpX
         Vz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4twnWZaz/uCnsUp6yfoaHYStTI/UK/5pB+90myxvwMY=;
        b=yRAfCQcrp4jJgvf6EZ20XEmfzKOAjysF7qkiAp2u175ykMxuQzj8GfskDhT0Ww0MMT
         ASi6bnjtLfy83Dqbk9uAGgGylh+s+5oEQ0aLLOG3774Df+lFdHX5/uHa7jTjD0+1jthh
         YsGn47Dcm3LUA7SbtCwx846LQB7ygACyOVP5XMH2x2mxfE9CrRwQ0QWD6CsJY4P4LCYh
         y8gK3Xnj2MlSGnHnzEMZWWhe6/2leQJ5QIlnY9FMt+fBLv6Bi7WnE6kn0Dw9F59/ZlBi
         PyIKbqxEn7EXdWKdSaWuSsYgbf6CPF5s/+ZJPJ0Xcr03t9+WUXV+i93MbE0/RXnIfxh8
         9kKw==
X-Gm-Message-State: AOAM533+M3nleKc9A8JK6oSSvKgp/3WSng92jTCap+6sJwjiY+2QeIwQ
        57uV8eMlLz+PgNSTWf8Jv4QEoBjUNcFAEt9PbTXM/g==
X-Google-Smtp-Source: ABdhPJxP6jHFGZWuyB1s4DXm7xha6KVLCdtpM5c9ip48DGNXWfx/P0lsyJ2IyXXN/PUzPJwYsp0zTllz2xTKRMpx/So=
X-Received: by 2002:a05:6602:148b:: with SMTP id a11mr17937967iow.85.1635292958699;
 Tue, 26 Oct 2021 17:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOhMmr7bWv_UgdkFZz89O4=WRfUFhXHH5hHEOBBfBaAR8f4Ygw@mail.gmail.com>
 <YXcGPLau1zvfTIot@unknown>
In-Reply-To: <YXcGPLau1zvfTIot@unknown>
From:   Slade Watkins <slade@sladewatkins.com>
Date:   Tue, 26 Oct 2021 20:02:27 -0400
Message-ID: <CA+pv=HPK+7JVM2d=C2B6iBY+joW7T9RWrPGDd-VXm09yaWsQYg@mail.gmail.com>
Subject: Re: Unsubscription Incident
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Lijun Pan <lijunp213@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Oct 25, 2021 at 4:10 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Fri, Oct 22, 2021 at 10:53:28AM -0500, Lijun Pan wrote:
> > Hi,
> >
> > From Oct 11, I did not receive any emails from both linux-kernel and
> > netdev mailing list. Did anyone encounter the same issue? I subscribed
> > again and I can receive incoming emails now. However, I figured out
> > that anyone can unsubscribe your email without authentication. Maybe
> > it is just a one-time issue that someone accidentally unsubscribed my
> > email. But I would recommend that our admin can add one more
> > authentication step before unsubscription to make the process more
> > secure.
> >
>
> Same here.
>
> Fortunately I just switched to lei:
> https://josefbacik.github.io/kernel/2021/10/18/lei-and-b4.html
> so I can unsubscribe all kernel mailing lists now.

Not a bad workaround! I may consider trying this out. Thanks for
sending this along.

I'd still love to figure out why the whole "randomly unsubscribing
people who want to be subscribed" thing is happening in the first
place, though.

>
> Thanks.

Cheers,
             -slade
