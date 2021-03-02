Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2732A937
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580743AbhCBSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384632AbhCBPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:32:30 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BFC061A31
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:28:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 18so23323252lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RVLXV9q75+jht4iE83WdkIxMeuR8jzeBuwVVsN9WTLg=;
        b=gV4ynqlQFejyy+ndUs/LYpx3zBRZkYYb+XQcgjk/Y2UhS8fERlg6PZC6CLPKxWVdJh
         UPpuwSGiXxNNsSj57lw9eHpk00/M9tfI1Hg1/kmS7OkZwCH16dLSQTBjwF9kVmWB4rGf
         VIToCruiTYRvqMwroG7hfCsNWbyHNNICx0RO/cUQCYiba9/ucEhyJCqVR+ieqfUk10pD
         Tb5e+J+FY2x+oxAoSMkjq4lmPeWrE4eEpQTWGeNeXpFyv3wDeBXxYfTAL2oShaJG1gs+
         j7z6zXZhf04vLIkap4O26CMNHIsWyCwd0+f4FJlFOqF7eDzyKn5DBqTv0whla3Zp6Vws
         bYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RVLXV9q75+jht4iE83WdkIxMeuR8jzeBuwVVsN9WTLg=;
        b=hHfyw0mST176f/XeLxZDFCKiESxF8XHZavcnhmc9a8M0I5hCmawh9gImIj+KxIJd6V
         qKYJsu+Cwb4k7wlydz7ok0hPxDADvaOp0EkbKmXczgHSlP4nUIl0FLuVYCuJ2/Ievkme
         E+NrfDyDyS/IgiCGXoYG2GNgnFT43mBkMUKVMNfbELMlp7sSbssrmCWRfQ4e2vyC7hoD
         FmwKJ04RAStxfLm8GgUEjTBPoct8qw3XhYnu7B2JriGh2CusaSx3A1zmIBOu06UQU6rp
         cyv1K0EE8VpYU3JlP5kaCKe1Oo+NBQPD9RKJjltBMYO4CF60qLf4MK7Ev5nIR6AvEwH0
         BS/Q==
X-Gm-Message-State: AOAM531Z7Dl8NcWd9TNfAAnM2OLe1hB8b0/Wa7T2GvKmQhlAuFmQBTuZ
        gZwcZLO1S4H7idi0FQkkTtS2B06GRXzi/iaUucxQhw==
X-Google-Smtp-Source: ABdhPJyq3rpvaXhwX2VHa2lgT2358eC5Ypt/Jh3s8qQ435mBzMUVrLp8/RG4NPHNIYVQcCazuyhFFsD0nTR3rUUV0OU=
X-Received: by 2002:a19:548:: with SMTP id 69mr10323405lff.465.1614698921540;
 Tue, 02 Mar 2021 07:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-10-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-10-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:28:30 +0100
Message-ID: <CACRpkdY5W_me1ym3MftGjMwtbPc2czCASET0-qPz8WgmV7H00g@mail.gmail.com>
Subject: Re: [PATCH 09/12] Documentation: add BCM63268 pincontroller binding documentation
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:42 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> Add binding documentation for the pincontrol core found in the BCM63268
> family SoCs.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

> +  interrupts-extended:
> +    description:
> +      One interrupt per each of the 4 GPIO ports supported by the contro=
ller,
> +      sorted by port number ascending order.
> +    minItems: 4
> +    maxItems: 4

Same comment, this is hierarchical.

Yours,
Linus Walleij
