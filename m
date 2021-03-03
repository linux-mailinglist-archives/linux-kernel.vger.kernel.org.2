Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E532BF92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835678AbhCCSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbhCCPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:31:04 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0EC0613DB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:29:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e2so22011699ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEXfy/ZFeAXHr/JqY8S8lYyn42FgEZgtzbDtixBCS/4=;
        b=gpYPLeVJAzhZemzpocgjBTsOKj+u8uHS6Q69HnZP+UiIIBE3i2O/w/rvaxbBV9SFu0
         iLMQqLXg+Uue8Z675eGuwLTGok7X3GASZilkDtumHbvnMBvxsxtIjrP6fl+zji5DNLIX
         ejnKGKQRAVMzVD3hfzFk6mFHnX4XMaGVc1sYpXc8aHIfq9p7yuH+B4+B0ihZUJgMXCG7
         N8belZih4LlPHpD7YYHsLQkLZa+7SQ2/ccvHz9MHz7y6McppZggVjjt+46b2PmSl2YY5
         APinamARPVPmLpeDf1jqbXj647alkg0QB4aPxTqrgZ1byMgSRDFPbwUnz+WwL5riH7lw
         DF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEXfy/ZFeAXHr/JqY8S8lYyn42FgEZgtzbDtixBCS/4=;
        b=OCaxYhzsIMwe0rdTaswFG5H8lx2w2F0B8KvxN5o/NhGNRF3/1ziDGngSRy74gNx2TF
         6KCHvvwSOQnN64i9fOK7pWB4RiA8v/RSQcB4Qtx33foyFgJJnfRQdrXF1j1TxedJllxI
         v8/r9Qesi5Sz3NGpNDg153Y/npvgIEd6Z9JToXGqA59T00v71fTcYqPDGGsg1Oe1flsz
         tYSDXuryueY4lBY2+m9Pp0wR/CsbBNoh7KTmc1CTO3DSxnufoJYMUeJVW6p2iOpbFzcQ
         eal/LraGpGpcBzsvFPY5LHyg6qpzofwpKGGIXc2tu9aP8dq+0ylp7LRKstcbBRAnw45d
         QQSQ==
X-Gm-Message-State: AOAM531NDEG0xI6fumAq0pcSConANtOnF1/ZTVnekgqvm04yI/UoFXxC
        xyDZrrlf2RiCKAvU/GOIVCLMLyOvK/Xs4HnR7aZR3w==
X-Google-Smtp-Source: ABdhPJzaszYDGte0emaOCkz3N5HUJ0AguIJh/nQWR3ZFvRwREhpeoKd6NwH8VCX7yeKGE4vd9acdZSXlvkaCUDyeE4M=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr15533227ljc.368.1614785372259;
 Wed, 03 Mar 2021 07:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20210303142310.6371-1-noltari@gmail.com>
In-Reply-To: <20210303142310.6371-1-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 16:29:21 +0100
Message-ID: <CACRpkdbi77SBsssMOnx43fP9RgqnzkUUw=TXaE2_LDexpE2WEg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] pinctrl: add BCM63XX pincontrol support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 3:23 PM =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gm=
ail.com> wrote:

> v3: introduce new files for shared code and add more changes suggested by
>  Linus Walleij. Also add a new patch needed for properly parsing gpio-ran=
ges.

This looks very appetizing, I am ready to merge this once we cut some
slack for DT review (a week or two).

I'd like to merge it soon so you can start working on the IRQ add-on.

I'd probably drop the IRQ-related selects from Kconfig
when applying though (no big deal, no need to resend over that).

Yours,
Linus Walleij
