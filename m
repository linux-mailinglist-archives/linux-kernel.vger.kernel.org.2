Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FD5342C51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCTLiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhCTLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:38:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220AC0613E8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:38:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r20so15111718ljk.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kpNq+4pzC9q8PqJhkJv2XRb1wrmskPmzcnX1wwKvIT4=;
        b=usugGJstphxXID2U3mOQ0opUCwdg/eCHLAtS59XDR8tr3xP4kZJtMMR0DrqiFbW6mZ
         BbckAuDWNuz4KbRLDestCcqT8Uez7tzJLs3cwOfMLdwRXZsl7SibDBzirk2IQpxekq61
         /1QsQsXGlPQCx2dOSloA4aUDIYozO+iw6KrlI5M8yeiFs7qryv3HcqriKXyrq/4EumRg
         l/+GL0zfhGgQtURUrW75R1gFnJPspwWqYqyt9UVBfhyO4nJMyX/Sv27EqiGlzWull2St
         yuH9eYED9+/Acl2/IA4GACeD2tlkq04pmCkJl+RObkCDqUMklXKnGJGd+VyRHyzvZcko
         jpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kpNq+4pzC9q8PqJhkJv2XRb1wrmskPmzcnX1wwKvIT4=;
        b=fhLPKcJp+KsdhHy5yho7MD9//T5n7tiNkzvFc8FdhhiquIs6uCym7bpfUGgHEU00iA
         9/qUG1y/FtCQ3vVigq5OIIage/dHlFOC9VrJ7gjZV81bXKeINHFvmBIeROeyikL2SQm7
         9bTZuAHrZoruC+jYzffT0OkweHwDqU1o1j8narQkjgbsUcAuLZ/VRtPgbZw1mrsW2LEe
         ZLisnOOcj+hgPMdkana/t1yAlEwjHBDivNcJEYlnpDW3IMWBON3PfC3tIo2BQ2ngYgPJ
         /9dJxjbZyOiuyUApGjmpwx0qIYoFAxKD0vZJqO6MlTheDgCRynzcMcp60JURMkD6uwXd
         DcaQ==
X-Gm-Message-State: AOAM533RTguLbbntJQqYQjz5usUgKB/zHuUyuBfTUCofiXuvo7uyZgit
        MIo4PECBdKKIxW980DeDUX/MUNWhl44ZO26uvL2lFQ==
X-Google-Smtp-Source: ABdhPJyph+35e/m+iaGdkuTx9JEupeD2nzqVohDvenngcwRbROO6Pk1TaZAWccwtj4OtmgFGBBO29aVwIAewWbg4Yhc=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr3571819ljc.368.1616240294278;
 Sat, 20 Mar 2021 04:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210315114214.3096-1-noltari@gmail.com> <CACRpkdYdHgP7QNWco4aN1G-GaRjOd2Y=_fkxv4zOKsQtXtpqfg@mail.gmail.com>
 <34672AEE-B28E-4B07-BFDA-8DF2F20FD410@gmail.com>
In-Reply-To: <34672AEE-B28E-4B07-BFDA-8DF2F20FD410@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Mar 2021 12:38:03 +0100
Message-ID: <CACRpkdbKtjNjC57_m9+3BTex6XmjUrsYN8NkMiCxPt37s3pv-A@mail.gmail.com>
Subject: Re: [PATCH v7 00/22] pinctrl: add BCM63XX pincontrol support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 12:20 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> I appreciate that, but I=E2=80=99m having a hard time in understanding wh=
at
> Rob wants and since there are no examples available on most of the
> stuff he=E2=80=99s requesting this is really frustrating...

I am sorry that the situation can be stressful.

This is not Rob's fault, at least it's also mine.

The real problem we have is lack of hardware people
reviewing hardware descriptions, to put it simple.
As reviewers we get a bit confused, then we try to make
a mind map of the hardware as most driver developers do,
but as we are not chip designers we will make
mistakes and get confused and there will be a bit
of back-and-forth and inconsistencies.

The bindings have very high ambitions (to describe all
hardware) but it's a bit like food: the less you know
about how it's produced, the better the taste.
In fact it is a best effort and involves a bit of guesswork
and group effort and you are part of the group effort
now :)

Yours,
Linus Walleij
