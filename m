Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4254032A963
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580817AbhCBSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbhCBP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:12 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB0CC0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:22:13 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q23so24404582lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f7QSrAX2oqY7QLjr4MxaIMFXX49EKilktcV2ECsEf50=;
        b=cAq5Pz+8cNmAYm8ExEJ9vm+wSdHVgbjmay62d3tVTEqElC5eYgW2ldc3Gnk1x+fI/G
         6GE+3goeGPkCEoXaLkGgz0MeJAfwzvSlC3K1+ne8sGjj/tS+KOZkuW1dksS6Q+0Vdld0
         T2hMc7/1ANQIcr+avbf47sElOB5vcaHlu6XZFKvg6dSCMXsdbop34ABaKfUkdrs20tz+
         IFR4GDsXNd9vq+8kUhiSrYOTYPSUp1bRo7JNEkd9Es+gqF2ZBgYlOqeffj4Kbu6/S9M4
         pvwKsywYu7a/Xpr867+K70RoANlkA6ZHm/iA5DLFYfFRLECHLk02AtoJvo2MWbiLf2Iy
         3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f7QSrAX2oqY7QLjr4MxaIMFXX49EKilktcV2ECsEf50=;
        b=lBsMMp0JGoLkWd5fDzpZG6M90VxEmooaERtIykYMsoo5RE469EpZPUWsw8mcN9zRJs
         zvuceTCdiIjnTRrWffeAQmzv8xrGD2dz6IwmZvpPIeVUbQTbQFjTH7jdvbLb05PhEMuS
         dHNmypnFRKR28un0gzrWC+ObXi8hk+3nNJAnjFuhFW25PJ+2ziKSWOTGToSIQwct1kgU
         UgwEk7Om2KOu71nJnSIChiuPLDhXYsmWFPVXLbEhaLaxlMLzcLx/FuRu5thLOp5GFNZ4
         uWEvb+fTBtw0jQHxk8cjjoSzFEF8j61VGLDQX3+Gp/2CKqcpk1bij+P+yB6uCh0uZh3k
         QUVQ==
X-Gm-Message-State: AOAM530gNFsAuuDPdurL+qz3lAMrL9459h3SkxbqEvEIoAdKxIzav1wj
        yNo/DcoTmSYz/ZLBsQwnfB2whuh6n6y38/X3OkgrHQ==
X-Google-Smtp-Source: ABdhPJx8R82A8WHsc3N/khCrQlVXn1aC5i8ZAMzKuDJ7RHWDwOiw3j2ZB3RZnLmIOBWiwevgGmCVy4o5lfwMV2nrjxc=
X-Received: by 2002:a2e:9041:: with SMTP id n1mr12412389ljg.273.1614698532143;
 Tue, 02 Mar 2021 07:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-4-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-4-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:22:00 +0100
Message-ID: <CACRpkdaL1-Mw85hrJNbKk0rY2txeQ3bYVS9TYpwQ=+R3Wvxpug@mail.gmail.com>
Subject: Re: [PATCH 03/12] Documentation: add BCM6358 pincontroller binding documentation
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

> Add binding documentation for the pincontrol core found in BCM6358 SoCs.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

(...)
> +  interrupts-extended:
> +    description:
> +      One interrupt per each of the 4 GPIO ports supported by the contro=
ller,

4? Below says 6.

> +      sorted by port number ascending order.
> +    minItems: 6
> +    maxItems: 6

As noted in the review I think this interrupt controller is hierarchical
and this is not needed. All that is needed is for the chip to know
its interrupt-parent.

Yours,
Linus Walleij
