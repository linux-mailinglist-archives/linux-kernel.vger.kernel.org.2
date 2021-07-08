Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7483BFAC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGHNBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhGHNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:01:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE5C061574;
        Thu,  8 Jul 2021 05:58:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h2so8414380edt.3;
        Thu, 08 Jul 2021 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdvVI0RiOyCLYVSmlJqxFxM19u28EhTeBE89RX/2DLM=;
        b=mFx5RbowAec6X95nlyphkBhbf16eD7Kcn1DeyQmHkkIRv6VZwuXSujODEyNVyspCXp
         Cc0lcXGiF1Tw9Ns9K//rTOounWLVKc49Tbnuf2IU6S5VoPLisNvOzun12nVGgywgwRIo
         XaWGOEdvsZK8GoqurlDzZB4U2fZWa1ko4PJ6spWNHP8kCgthtGuIoOrP0EuMA+g1TWZP
         TaGvMP8Kq/BPXAKD4aDMGYbjpwlSTtDDd0kZhNChq0R1I2RzzxHbb4O/etgnTq5iax/E
         35Ct8Y5PPmj6JgaVOVnFIl2iW7VjaqD17zmKKpJOfXxHPSNMWD82mLetLRhU3/82SE5G
         QJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdvVI0RiOyCLYVSmlJqxFxM19u28EhTeBE89RX/2DLM=;
        b=Kq3+NBO2G72qGlhbdQ4fi0pyT8qk8I6wymnOrJ8rXqP38OoTMIC61ow2INKf1CsL7w
         zHXyVRZ0VmG8KqkCFu8KJzLk/N6WO0lcQqL5pvmpohi1fjGxvv3ZFE8NopTo6c8Q7UTE
         7Qv3vp4ychlPqR3dhAe0SiT+/mpfO5q0vfl9p9Hcgq1J95rsQ4O7GNFLfoGhCE0LVIAp
         HlDimaObWZpJSEf6JFFDTxzlIVKn4wbkmvZB6R4y/STd5/3gM+XvPUIKpg6vTUpTQIJ6
         ba9gTPUoxvf93qYKwt0pik1qIXjXRl6n+cHIRqRUe2Vd3rzXA3HHU4L66GGZ/qqaf8cO
         /1hg==
X-Gm-Message-State: AOAM531P0PDp8NH/+EuI+zSy3U62XG7/gL7jtDfMXNz4TMuIHDzZ0E5H
        Ap+1xTas42rjBV4nwHbonaxsVpdkcX5pN4QCot8=
X-Google-Smtp-Source: ABdhPJzFF9sN3ruvF+DrBuhqHQ/nWFP1BnkX+uZHBBeIbQkk4JsDVH2y6aEtoXFkR+F/g+EdogO9j9Af6n7lw1NM6lM=
X-Received: by 2002:a05:6402:510d:: with SMTP id m13mr37757480edd.179.1625749116555;
 Thu, 08 Jul 2021 05:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210705112358.3554-1-linux.amoon@gmail.com> <20210705112358.3554-3-linux.amoon@gmail.com>
In-Reply-To: <20210705112358.3554-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 8 Jul 2021 14:58:25 +0200
Message-ID: <CAFBinCA5ZAPgmYEpo9WPhcAwnY-BArhWtWZRurtuDqjHPVtZMA@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] ARM: dts: meson8b: mxq: Fix the pwm regulator
 supply properties
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:25 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> After enabling CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
> Changes help link VCCK and VDDEE pwm regulator to 5V regulator supply
> instead of dummy regulator.
> Add missing pwm-supply for regulator-vcck regulator node.
>
> [    7.117140] pwm-regulator regulator-vcck: Looking up pwm-supply from device tree
> [    7.117153] pwm-regulator regulator-vcck: Looking up pwm-supply property in node /regulator-vcck failed
> [    7.117184] VCCK: supplied by regulator-dummy
> [    7.117194] regulator-dummy: could not add device link regulator.8: -ENOENT
> [    7.117266] VCCK: 860 <--> 1140 mV at 986 mV, enabled
> [    7.118498] VDDEE: will resolve supply early: pwm
> [    7.118515] pwm-regulator regulator-vddee: Looking up pwm-supply from device tree
> [    7.118526] pwm-regulator regulator-vddee: Looking up pwm-supply property in node /regulator-vddee failed
> [    7.118553] VDDEE: supplied by regulator-dummy
> [    7.118563] regulator-dummy: could not add device link regulator.9: -ENOENT
>
> Fixes: dee51cd0d2e8 ("ARM: dts: meson8b: mxq: add the VDDEE regulator")
> Fixes: d94f60e3dfa0 ("ARM: dts: meson8b: mxq: improve support for the TRONFY MXQ S805")
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
