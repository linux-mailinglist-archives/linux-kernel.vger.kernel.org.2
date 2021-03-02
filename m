Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8C32A83F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580052AbhCBRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448627AbhCBPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:07:48 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83EC061A30
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:57:53 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y12so11368289ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Im5YPNvUkVcY2oDOFR/SwHL8vc7nQDBtJ/LXMfThDB8=;
        b=zJRw+Yu3R85QSUpo38xDhIvT/Dlbhod/Qk8sxP5xeIFKLrbDE6H+QFkSfE3VIMjfRi
         uUX+UgpxLbkrVNwQav+u2HlrDLdSwkSO0sM7pW+Ns2I8iuW+PK7m9rG3RMN1g8znvgo1
         tX/gr5XA3vHh6KHbkjzdbiPCtOzksTCLXokDqeXps0UpNCDLBBaYZ9AIGFyKEpbLhzdz
         9bOyxGMw+zYHQIW5XE/+h09N7bDyV721lSGKksvaFGKHmv8JtQNPhh1TiJs519AyeRGz
         q0oVha9befOwiwClfUCaLUiW9f4LSe7LFipmeIA6Bg2k6Fhy0tRkbQ51fm7uRQa4mSjo
         mfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Im5YPNvUkVcY2oDOFR/SwHL8vc7nQDBtJ/LXMfThDB8=;
        b=IEiUMwlZKx1bDUoIgjdiSN3WmqUFw6BK6TJULveLSo+GDm5sqgF04Nl8eeTIPpki1o
         xpTIg1oGb1a2cI7A+hlnLPBmQN6PVTfOAE1EBeBKdg2INKj9nAOnZiy0MylOFpzNCzlQ
         zC75EA31PwbojWD7ns2b4MZNCtVG36ihO3SkQV/ESAg88YAPwi6lfpNOOGK663SDupok
         rm2t2LFWMpCdjqXEDYH6dVqChWTuCfJIjeNxQTs9Jkq1xphdAm/Vgz4hs4EEYISi7OYK
         sjKtrwGncW7lQtznAx8F7UWI2o2HdQfGjmok9aun9vKCuVbtFJUZ23vOIVGQiBZ6idl8
         ovKg==
X-Gm-Message-State: AOAM530f187v81LKrCnbaHPamr2DPOkHR4bW+P/0mvg5/K7G8Xt9Ns9y
        hjpqOqJZySrK4Mrt7kRp2FQc18sJeJpuX3qjyAekFg==
X-Google-Smtp-Source: ABdhPJzwO7KakZJQ6OZLNilczG55ectEq/5Dfn1nJ9yzcfKIZ65wvA2Ybol6f5OZXAB+ObTRsQHYhjyHFwPVhl1ADkM=
X-Received: by 2002:a2e:9041:: with SMTP id n1mr12349532ljg.273.1614697072434;
 Tue, 02 Mar 2021 06:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-2-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-2-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 15:57:41 +0100
Message-ID: <CACRpkdbjhTfQ4EcjndgE_Y7_uCT2ohadTjj-rrQAFNm+c0whRg@mail.gmail.com>
Subject: Re: [PATCH 01/12] Documentation: add BCM6328 pincontroller binding documentation
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

> Add binding documentation for the pincontrol core found in BCM6328 SoCs.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
(...)
> +  interrupts-extended:
> +    description:
> +      One interrupt per each of the 4 GPIO ports supported by the contro=
ller,
> +      sorted by port number ascending order.
> +    minItems: 4
> +    maxItems: 4

I don't know if this is advisable, there are different ways
of specifying interrupts so this may become ambiguous,
I think Rob will know how/if to do this though.

Yours,
Linus Walleij
