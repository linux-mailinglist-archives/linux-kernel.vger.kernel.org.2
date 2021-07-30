Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855063DB34D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhG3GMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhG3GMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:12:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74241C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:12:18 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n19so10196898ioz.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVylstF+RdYSXnkjyl5lahf2bSfwHzm4z1yDfPGQdVI=;
        b=VPTuf0nbheGUQyE//X9i8SARdio+nzMaoVocpmeHN1gNvkFT4UKEk2qZoWrBttLuDm
         lsDkqKJ8Qd5Jr9o9IPjoAQONj9Uwt/7PSV8Zrv15BnBYO/3d/N8tZOUU21g+NFAKB+DF
         1B9B6YYzHoTlT70Mv0Jhwl1lPvAA+BZDn+Epo1XFixl7Xjpw5AuNofG0qtBdjcMwzFwH
         sE4CWXRP8yQLZoX4pC3iZE+X+hcPPHGUTJ3jPe92EixRRqoYOyg/QgaSTAgxUhNSn+Bn
         qVHJ4/QTdpANzusiMXhVZsDTGHFUagnkUIz8WvxWGVQ3h3Jcf8oAQERW7TNdGyYP75up
         I8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVylstF+RdYSXnkjyl5lahf2bSfwHzm4z1yDfPGQdVI=;
        b=RlfqN93sHba64srLJTwcgy9kK+t4sEEwdeKo0BSMshvJ/UWWMmV8HURiJ6aoPD4wb5
         j0XL0nyOkCXDDgHMJMqe0pvcdeUnqpHjUeFrlgxUThtvMLQBq8Hd/dmRqk+4u317YfPg
         OSuYbP/PfcWB4e210gmXGtYgjT1izY06iW5EFVr7E2PTGw8iQ4QnxKNMKXi8CmuG9FGj
         64yMZC8eMFzexzQR5vbFDBXa1lUgmyTK2O4HFUOoO0Tgfq2hKJc7rve9RC+0F9QFzy0e
         o7wQmgifPRHZq3SsPww/VDHEd/6gkNBvakj0C/11p3lc6YtRGO5BOaRZdLlwk7CjZFr7
         rm9Q==
X-Gm-Message-State: AOAM530ZQUr+HKpMbO7XcfBazqsUzTivpPl4Na1ulJGB6raO/x7VaME+
        YI5JhQQm9qTC4dk0Bd8ncW3kTNZV5q7bpJs5St8=
X-Google-Smtp-Source: ABdhPJyD9gUyWMmKfzo1VujQCrT2S16XAUxHks29h7s2uvmbY+Vs+7iN8Ir23rGw5Vho/yWxZ3gFmBtPRK9MpqBDTd4=
X-Received: by 2002:a6b:7905:: with SMTP id i5mr1064527iop.175.1627625537968;
 Thu, 29 Jul 2021 23:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210706114120.197-1-alistair@alistair23.me> <CAKmqyKP8HKERLS3ckOA3wwpiv6J4tdFXn8-d6wXxDXDGn5iN=w@mail.gmail.com>
 <20210729112246.GL4670@sirena.org.uk>
In-Reply-To: <20210729112246.GL4670@sirena.org.uk>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 30 Jul 2021 16:11:51 +1000
Message-ID: <CAKmqyKNyvE7wL-sRW7h7LoZJvwpDwMZFvXSLBB9ziz+01fPu1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: sy7636a: Remove the poll_enable_time
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>, lgirdwood@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 9:22 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 29, 2021 at 09:20:14PM +1000, Alistair Francis wrote:
> > On Tue, Jul 6, 2021 at 9:41 PM Alistair Francis <alistair@alistair23.me> wrote:
> > >
> > > From testing on hardware the poll_enable_time isn't required and
> > > sometimes causes the driver probe to fail so let's remove it.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> >
> > Ping
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

Sorry, I was following what happens with some other projects and
pinging after a few weeks.

>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

Ok, in future I'll try to follow what others in the subsystem do.

Alistair
