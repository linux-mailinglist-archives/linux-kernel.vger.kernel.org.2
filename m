Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3545B32A965
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580850AbhCBSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578837AbhCBP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:27:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC8C0611BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:23:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k9so11951169lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=phGkBVfIBc9N8/MYw3IsLowc0jNOtyQmeOezRPC5r6A=;
        b=IxEHOA/EeqJE9XesCg+nCfa3QJs4ZoTXMJRRwtoaO1dsS8/djz+UWJbAs59nUIy3FV
         K2RJk37iYNtFVVMwae8n2KqT6KXLsaMz+DupUwBbV3X/QoDQ3QmSZlw3bqnfXr7x0M9+
         6Bh00Lr5x3pTcsF0kX9ES2A3AGs/6hVNMJgkt9DHcPtr2p6TBqiDz3+Q14EH3dVEQv15
         PrI8M8O/MX6KRxLXecPHArez80P4gQQyHbwfXn1ItS3rQb840an7hPuiGWs44bUMI0qx
         1KWBY+Jpl9RKhWAFucv/VKzCkBEdA3ykrcitpsdOQaBpyVqG7G7SMRpyjKYYMgDZ0Xxw
         eXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=phGkBVfIBc9N8/MYw3IsLowc0jNOtyQmeOezRPC5r6A=;
        b=oDd4GToGX6adtvkMly/QW8h/0MpyfXnSZaWi0QPafJf6cTimfEJZo/THUgDW/jhcwL
         okK4bmQem6OaYFtutg3kY9bf/XR1ehuwaQATZyMZGivBhJzP44WhqSFQPUBr/cmsUZrC
         KVP0pPyC46fDysGNypT3IFbPHpNjE+uJTnQHMMk0GLZBxr5/8eWTti4HCW9G/NTgZVV0
         hXKaLdKpmxYt0Boe/UPMw7NX18WzMDYXrxlR6VRBnTaNa6pGwj2yC/TSWiHQJEbWU3SQ
         Pvrzm5pQ/z1SI9lg8oLNm8ENBGEU4hL5geXsp6rhQ0LBuHDMjvfMJK/egDdBm3Zbm84b
         mAIQ==
X-Gm-Message-State: AOAM532JDLGVWrhRT+uFbh5gxdPaGCQ+7syU8IOY+KSQXcuUImKl4faz
        I6cvglRZ5RG7hybC4hWzII8DntkRwbbiWzbwBtJEuw==
X-Google-Smtp-Source: ABdhPJyFEssv4TZ20RIixukIPx4G+ICtagjbJAX9g02ycgsPC8yvfaoZNRA54LDHGtijXLpyZkxVrklKXkjozmYype0=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr12960505lfl.529.1614698627904;
 Tue, 02 Mar 2021 07:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-2-noltari@gmail.com>
 <CACRpkdbjhTfQ4EcjndgE_Y7_uCT2ohadTjj-rrQAFNm+c0whRg@mail.gmail.com>
In-Reply-To: <CACRpkdbjhTfQ4EcjndgE_Y7_uCT2ohadTjj-rrQAFNm+c0whRg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:23:36 +0100
Message-ID: <CACRpkdaN3pYMDiPkk109SwOKF56Oxe14_bC5edftGGG0PL7VsA@mail.gmail.com>
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

On Tue, Mar 2, 2021 at 3:57 PM Linus Walleij <linus.walleij@linaro.org> wro=
te:
> On Thu, Feb 25, 2021 at 5:42 PM =C3=81lvaro Fern=C3=A1ndez Rojas
> <noltari@gmail.com> wrote:
>
> > Add binding documentation for the pincontrol core found in BCM6328 SoCs=
.
> >
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> (...)
> > +  interrupts-extended:
> > +    description:
> > +      One interrupt per each of the 4 GPIO ports supported by the cont=
roller,
> > +      sorted by port number ascending order.
> > +    minItems: 4
> > +    maxItems: 4
>
> I don't know if this is advisable, there are different ways
> of specifying interrupts so this may become ambiguous,
> I think Rob will know how/if to do this though.

After reading the code I conclude this gpiochip is hierarchical so this sho=
uld
just be dropped, and we only need interrupt-parent assigned. The
driver will know the hardware offsets between the interrupt parent
and the GPIO block, this is generally the case for
hierarchical interrupt controllers.

Yours,
Linus Walleij
