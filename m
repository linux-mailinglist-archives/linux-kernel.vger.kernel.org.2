Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC62230EF57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhBDJMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhBDJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:10:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A6C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 01:09:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v5so1245640lft.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jKRtqN4LyI5vSCsg0G87EdlBEQs3S6TQSvakMi0odts=;
        b=q7AcSIFv9JBL/B3IcYoITI6si2ga2zH9eZuiw0hiHHncAeQQ/IXSbqKAK4aaVVOJB2
         4J2s+1KaXB7bXY+o1Paku/1W+bgdqdrp0hw4z0aArSqVlZoqoAJcCP+os1LMdBR8yT/J
         ARI6Tq4nr2AXZhtL8e6ZCJTxXir31obUzbnjar3Z1VFfhfetjC2zzlj8zy4zYawnCgAe
         aZheci6q3EwvVifT0E2WZekY62gzW8u0+LNSDWi0OO3bL/xIiegCgmHFOhXYp/Y0Ba+H
         A8OUZ2MNY5ft+W9R9K5jhvNZh9z6dKCEYFApTA6YRyZPGJgFXUSO6IdUajMhh9Nd8MnM
         LWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jKRtqN4LyI5vSCsg0G87EdlBEQs3S6TQSvakMi0odts=;
        b=E1Iope5K5lzNWTPDav+R07awU19fsdwFSt+Bh98TLV/t3wFWldGF7Y3asa93YLRslQ
         mybrSuj+xgsu6vvXEO1n44kPTX0XHGWxSStqdRBEqisIbVjY4sjrB6pKNZXAzDstYSKf
         wx4Og+DMtzIrhXZxxqUXx62ce0ZXJVNgg51Qwk73jjdL+l+C6Tgl+ZKv4/b6ee+Py17L
         KCMlaul41LHq0+/aTgcbaB8N1ETLd3lU2sncAjzOJSg/ExvKAZNXNY7TKIusUb82v5C0
         QiZjTnbq2/h3R0sDsGycmJo3gM+VEdurOKRw4Am4hMp88CjnPK0CgGOBqNUkPC9dap61
         2ZTg==
X-Gm-Message-State: AOAM530NuD7EG3yhN09LXOUQr7nWm19RsP5yNfkmI33WmpwmGugEe5GE
        I9yZUbLnFneDUEVGxKlIxlxOTvJYEyqKrhIRN7w=
X-Google-Smtp-Source: ABdhPJwLUMPd4IwIK/s2+6SL+zJ7h/+2JHdTEWHqKE2Reh7Efw451sy4s7dzX8I5FRjPKMbyVg7VWjAXBBaNo2sFczk=
X-Received: by 2002:a05:6512:2004:: with SMTP id a4mr4080024lfb.212.1612429795359;
 Thu, 04 Feb 2021 01:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com> <CAJZ5v0iS92CN5MKHu8tOpQR6mOWu=4=PLqN84qXG+v+64Ro99Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iS92CN5MKHu8tOpQR6mOWu=4=PLqN84qXG+v+64Ro99Q@mail.gmail.com>
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Date:   Thu, 4 Feb 2021 17:09:17 +0800
Message-ID: <CAG7+-3PuA3CdZAL5_m9aEuEdw7yaguXCFvasLjk==P9URNZ4QA@mail.gmail.com>
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ruifeng.zhang1@unisoc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=99=E9=81=93=EF=BC=9A

>
> On Fri, Jan 29, 2021 at 9:27 AM Ruifeng Zhang
> <ruifeng.zhang0110@gmail.com> wrote:
> >
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >
> > Suspend type contains s2ram and s2idle, but syscore is only
> > available for S2RAM.
> >
> > S2idle requires a similar feature,
>
> No, it doesn't.
Why s2idle don't requires this feature ?
I'm need use it for vendor watchdog driver.

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jan 29, 2021 at 9:27 AM Ruifeng Zhang
> <ruifeng.zhang0110@gmail.com> wrote:
> >
> > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >
> > Suspend type contains s2ram and s2idle, but syscore is only
> > available for S2RAM.
> >
> > S2idle requires a similar feature,
>
> No, it doesn't.
