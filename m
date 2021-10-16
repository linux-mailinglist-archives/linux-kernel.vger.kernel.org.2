Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621FA43051B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244602AbhJPWAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhJPWAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 18:00:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EC0C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:57:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so58021884lfe.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8oCc0IEea9FCh4BQiGK/7pFTaDRWDhTVEP/QxC1rXA=;
        b=Z/HCYkVoBAG65Us8a35vC10l5Wf3GD6TnZk+hCauCiWX7KSbCwpWxDprsvyyDoVypm
         7pw9J8UtPbybqCPkZjvHDbUAnj/2GhJHd21Aky2mvd8Vs6i5Jlpt7b6XgktCYyboWnu4
         6ylbVzO5JO11aHmjrs3Guy9bwghGE+w0p7dzwTPbM8AVfi80wTx44s4y58jpIwptePCb
         mPYN/8AgkYPIBYOOlMq+Nfmg3FAjbxPBx0vSnR541+zhAo4kJfEZjs+qayTpTEHPaNDB
         OCbe0ao8r/cu5guTZWvAguRKCpxI4OYduVJwdEkuApsylicN3uJQVBVQ1VJSxhq+K/TG
         47hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8oCc0IEea9FCh4BQiGK/7pFTaDRWDhTVEP/QxC1rXA=;
        b=xpmaSFj1C2Mv//tLcFVWl44DOM27XzJxAoBFPLNqMyENbDvlz2BKG27575lW/Qdeq0
         ju2OXDTjBsnZzQbQVpTIu1ybDedsTgbf1TixGNqdLMiR9xCwEjfGfk2w1Ifdtautxd2a
         jA76gbzeNqFXlYWLedDWoC7gaIAAb1I/Y8If+nv8hq9VAVzFSJGTGJUReFuHf47eKIvO
         7UTkcM8F2OjX3EwrlqkiakW2nfBDBu4lTZKieMOT+xycvr8p6PeGF7o828yIShGNZMPx
         vIO+N7QJXowpgvJ++I0R/UCAqH0ecolQdimqeK+Obi3+o984xyCE5Bj5glHFa1W1P+U1
         pxUg==
X-Gm-Message-State: AOAM5334IxydAnnhOICH7YggfanDjXNiQaqGJk7QlglKoClUoGQ7AyqD
        0VNeeOVgKp5oQGd4SFuBClvJ6X5SyMEJ/IYEkh0DKh+y9DQ=
X-Google-Smtp-Source: ABdhPJw3tkY4ofQ0BEM0O3PhgMuQUq+ZSasUs25BatGDnf3HchYalXBN/1NxFHIYf3L6CSeI4FYavJ9uDzzI3/Sb7rU=
X-Received: by 2002:a05:6512:3d27:: with SMTP id d39mr6386174lfv.229.1634421472660;
 Sat, 16 Oct 2021 14:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <5d683882-257d-87b2-20aa-0871e2902090@amd.com> <20211009033240.21543-1-nakato@nakato.io>
In-Reply-To: <20211009033240.21543-1-nakato@nakato.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 Oct 2021 23:57:41 +0200
Message-ID: <CACRpkdYgqmNZEGWmjzeFtfiH-hJb6eJRuz7hnxw1GeRUuyTnRA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: amd: disable and mask interrupts on probe
To:     Sachi King <nakato@nakato.io>
Cc:     bnatikar@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 5:33 AM Sachi King <nakato@nakato.io> wrote:

> Some systems such as the Microsoft Surface Laptop 4 leave interrupts
> enabled and configured for use in sleep states on boot, which cause
> unexpected behaviour such as spurious wakes and failed resumes in
> s2idle states.
>
> As interrupts should not be enabled until they are claimed and
> explicitly enabled, disabling any interrupts mistakenly left enabled by
> firmware should be safe.
>
> Signed-off-by: Sachi King <nakato@nakato.io>

This v2 version applied for fixes.

Yours,
Linus Walleij
