Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E7E42CF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJMXb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:31:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:29:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y30so343935edi.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IAmbFUBq6FyXbY9U+IsHNSuXUYGM3mx9/sHVjLgyKcU=;
        b=zYRpezfU+PYPeu6wduyuvc4OlGCV6lxnIDcqTQPtDlzARTTExz9W/9wQOjhvajRozw
         YCelcFc5K7RIPIjiaEj9iJtmPAynrqA2bZ7pu8Tb40t6JMaEmROr0IMJXunPG6MOalJg
         +wskUteZV8Edqjm0jFYVdJ4q0VkXh+pUtxndkuHk3HODUSLD6RUV+1OeRenNMQXLVgS5
         g0CMYsFotY0/nAXGzaA4Q1na7bdZ98rocUR6uCqcAUwdHG9Dm51DH/7Uag1BCT5QyN0V
         HyYNLZ/fbHCKc1qBRO6bPNzMXnNCoHQfMdkZMQ4cYqjL6gENyRFrTucW7OFENFFG3OBO
         yEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IAmbFUBq6FyXbY9U+IsHNSuXUYGM3mx9/sHVjLgyKcU=;
        b=rCZLOEODXKi5PLT7ujL+buQW6PRcF50nIr3U7PvOoFNvEE5YUgDdJErn+1roJkV+hX
         kLCcRjdp3B/dAU2WI0QQGJNcQ090Uo6b8fyQE1b/YA3jqQiOOh54h0cDDaDtmSKR+FdF
         hWSz/FE4tclJfr7mWIZw8aAlmHRvgEpQmSIiUoZ1wks/fwh0VGYfJsDyy1UlwpxKqbc/
         28wCZD8kNvMaOU39tm6OpM75T6sXO8ZKJx+Gt113yrOjFEbA7h2X6ReA+fd3gg49joMo
         7MwiQZszMWI70BlKRc02DGHvoC/6JNAEQZrCSba/2Fu8lGkaMVR1R6TqpULmpVIu7mkp
         KC+Q==
X-Gm-Message-State: AOAM530TQZmo0KyC5FNrJRWLmhveWE+zA0QhzxFrxTRot7GnQNtMYGuW
        lWyM+NsMaLyHA9efMBu1an1P+dLrDh95DU/UfeZ9vg==
X-Google-Smtp-Source: ABdhPJxlpklSd6riqPlyeZXwCoTeJi8fF1euVjJ6/7IvJVL47paIaIiF4t28vWljLHujLnz/Ss06YgE1joWtaPDhTgI=
X-Received: by 2002:a05:6402:5209:: with SMTP id s9mr3511121edd.250.1634167759316;
 Wed, 13 Oct 2021 16:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210929181645.21855-1-clabbe.montjoie@gmail.com>
 <CACRpkdZgXW4HOTsiw30-oncfiU54Jr_nDvZL-ZznRp8Tym=TmQ@mail.gmail.com> <YWWAMk2PbYOxUdWU@Red>
In-Reply-To: <YWWAMk2PbYOxUdWU@Red>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 01:29:08 +0200
Message-ID: <CACRpkdadQsHtZPFVfYeeHQCBzeBzRoK33W=ss+G4Xh=ttAHT+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: handle CONFIG_CPU_ENDIAN_BE32 in arch/arm/kernel/head.S
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 2:31 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> Le Wed, Sep 29, 2021 at 09:08:38PM +0200, Linus Walleij a =C3=A9crit :
> > On Wed, Sep 29, 2021 at 8:19 PM Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> >
> > > My intel-ixp42x-welltech-epbx100 no longer boot since 4.14.
> > > This is due to commit 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kern=
el
> > > mapping regression")
> > > which forgot to handle CONFIG_CPU_ENDIAN_BE32 as possible BE config.
> > >
> > > Suggested-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> > > Fixes: 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regr=
ession")
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> >
> > Good catch!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Please put this into Russell's patch tracker.
>
> hello
>
> How to achieve that ?
> Do you mean https://www.arm.linux.org.uk/developer/patches/add.php ?

Yes you need an account and the  submit the patches using mail
or the web interface.

If it seems troublesome for you, tell me and I can sign it off and put it i=
nto
the system.

Yours,
Linus Walleij
