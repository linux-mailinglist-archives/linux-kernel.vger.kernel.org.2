Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD93CC602
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhGQUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbhGQUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 16:02:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F14C061762;
        Sat, 17 Jul 2021 12:59:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h2so17563530edt.3;
        Sat, 17 Jul 2021 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=762AIHyaLIJRd5Chx9MkMYblmaxMzIP64XnDWe7yge4=;
        b=u2tl/92J8+a0AKu87KFYHYdNR5lpZ8vZAHWOlKtueq89OKWj+bbJcIGQ7iJx/9o1sH
         KBioWFQnyXd3r8KLDBldMzMmvNCokvnJ95EQaO/TATi81MWP3KBRIeF80W7M3ohJl4Uj
         UomWQV7Ra3hWKJvOka3YWsXUolw6nNMZ17NERsm9cxCA8U7Qv65hjsA0X7LmBX7P3UdN
         Uy9m6I34b1LKbR8blkN1Zt8PyV3jRDB8Dudm7oZVs6f3KN/ZLLTlz0E/yIoe6Y/F0lbS
         e0TE9C48ydpIKPVyoyseLHfWkHeE6Ynpd6bqBFx1aEWtHv1eNxhifyc/Yv2P5XRZZHEE
         oQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=762AIHyaLIJRd5Chx9MkMYblmaxMzIP64XnDWe7yge4=;
        b=JAsW2O6z0ozl55JR6Epn5EYWYHYSvcX47Q5Ca4x2OKuBwknkdRXnx1gUCZhqL2Fk54
         STw3HRM9AhoJUiuycyBWjeAMGXOdfT6GxAMHa02HPfBW3cXjgUKcL8drpQPekWDWCM5M
         b06wPSFxKJ2dozXT8WawdtV2Lu4+2HSU8vsr0O1Ot8aHHCkDdrqSD7k3D2BAMOI0dNej
         STRqjYUK2nbu4CAG/qo7KIJ1PNZHjUbcEuBHT7C8D3zmEDhtHRKUFlXgXkdXSf4BwPbH
         e8VEBjh/9ek2YYf/dznrzMzacEnQkHHKG76T5TlilF85KbELbNgqyLKe2Rx+7HNoUaXm
         UYUw==
X-Gm-Message-State: AOAM530LYWkGPs16dT46RRPu07TI/XgKOxh+R7C3oA5DBdZpUMEFfHFE
        vcuVoOCRrH4dz14iVmaj0I5ljVwic1Ht/gdM03M=
X-Google-Smtp-Source: ABdhPJwHt7US2HSby+xCEyO/61wsFoFE3bqY4zs8JfLejU0Lk/xtsoJy92vCwGGJyDmPJm+AzWDwDPgFi7thK92igoA=
X-Received: by 2002:aa7:c550:: with SMTP id s16mr23614280edr.130.1626551988810;
 Sat, 17 Jul 2021 12:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210716103651.1455-1-linux.amoon@gmail.com> <20210716103651.1455-3-linux.amoon@gmail.com>
In-Reply-To: <20210716103651.1455-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 17 Jul 2021 21:59:37 +0200
Message-ID: <CAFBinCAPNomGxO6Z57qPrmwv_iP4yGo4gpOR8o=mi3n+hq3dJA@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] arm64: dts: amlogic: odroidc2: Fix the chip enable
 signal for usb power
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Fri, Jul 16, 2021 at 12:38 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Fix the chip enable signal changing from Active High to Active Low
> to enable input power to USB power. Also updated signal name as per
> the shematics.
typo: shematics -> schematics

>
> Fixes: 5a0803bd5ae2 ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
I don't have an Odroid-C2 so I will not be able to review this as well
as the Odroid-C1 patch.
My suggestion is that we discuss the Odroid-C1 patch first as that's
some hardware that we both have.
Once I understand how the Odroid-C1 patch works I can at least give my
Acked-by on the Odroid-C2 change.


Best regards,
Martin
