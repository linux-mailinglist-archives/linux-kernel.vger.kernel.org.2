Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8213FA69B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhH1Py6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhH1Py5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:54:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6BC061756;
        Sat, 28 Aug 2021 08:54:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b7so14579845edu.3;
        Sat, 28 Aug 2021 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/FoITeBxXzYPYRycaXkbD+65bcxuT4OKmmdeFd0Jlo=;
        b=tf1iMB33IgOI69bWgXQProMFN2EETh3i67dsiFkKRxA9NLeh6/9xl9K6M9XrcT0iWy
         ZFmsotmZKl1z/y+aAEirsUT/PDgeEu+8hHkFNzANECFnmGiW+0JmHcbPc11mynjxEMic
         lNJs5eFdIb++dxvldt7ZZffeIIO+sfoUnEiMdH3ya0AdwMdLKbjGoioHQnPksF8rWGy+
         83Sqr5K2gOgs3X4dcCKS3G0SJb9Gqf0l3d2+xcFQbTi1S+hji3XJEbTYGmfhe8Ijqz20
         L5bTfjfw96ZWjA53QnbUO3kfIBZIuW0kIJar0qXdpTEof5ekF1uolgO8nAqtZSW8Mi2r
         LeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/FoITeBxXzYPYRycaXkbD+65bcxuT4OKmmdeFd0Jlo=;
        b=iM+EssKdLi2BjXcPeQS8TogGLtKPFHpIwQoPlghCNljq7iwSMqCZ2KUU7nuCE6gAbn
         8vF/xYFkQc8bWRUGTq9L00FwytCBxQAddENLP59BAvBESDI6az61GbhcVtv2sxawNeKI
         dFcDFypOhUmwo+ykX/1U0KdyHcDPy0oSJXvXUfHTUBXquJaLXO0yjp2XKsKioEQ0dTKV
         ExyhWQ0L19jlBTg8p4twyMe9OVHx02929CL6T08P3Ruflu+tjh76eIGQ8fhjoOTg5efl
         6oNf8HDv9GrrHbNfsKo5qPiKdhSdaIRqvPgSLsyhg2iKs3r3gWbotIdj3bM9p9Ke+9JF
         uAFg==
X-Gm-Message-State: AOAM531FB3fTRNAvd7T3M9eEmHMQlFCh81+RetzqlKVCv6a5VbYV68yZ
        hqNkZap7weZwmdd1gsGJfSeso9QXV9IyI/yqRA4=
X-Google-Smtp-Source: ABdhPJytLQmCtHspjMyHBMTX4NFKx0mMPjNdfQW3zHxrQS2RLqSasQmOR6hdIPX9F0PdpYCg0LBEGk6dpFFYaYQFU7M=
X-Received: by 2002:a50:e699:: with SMTP id z25mr15370730edm.130.1630166044946;
 Sat, 28 Aug 2021 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-2-linux.amoon@gmail.com>
In-Reply-To: <20210817041548.1276-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 28 Aug 2021 17:53:54 +0200
Message-ID: <CAFBinCBnH1UqaiuHgTXZTH+RPOwCWiWLVheU=bydS4mfkxTP3g@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

sorry for the late reply
I have three very small comments below, apart from these, this is looking good!

On Tue, Aug 17, 2021 at 6:17 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing usb phy power node for usb node fix below warning.
> P5V0 regulator supply input voltage range to USB host controller.
> As described in the C1+ schematics, GPIO GPIOAO_5 is used to
> enable input power to USB ports, set it to Active Low.
I would phrase this last sentence as:
"enable USB VBUS on the Micro-USB port using an active high signal"
My idea here is to 1) clarify that it's about enabling USB VBUS only
on the Micro-USB port and 2) use "active high" like the changes inside
the patch itself

> [    1.260772] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
> [    1.260784] dwc2 c90c0000.usb: Looking up vbus-supply property in
>                 mode /soc/usb@c90c0000 failed
>
> Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host
>                 controller on Odroid-C1/C1+ board)
>
please drop this empty line

[...]
> @@ -119,7 +136,6 @@ vcc_3v3: regulator-vcc-3v3 {
>                 regulator-name = "VCC3V3";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
> -
I don't think that we should make any VCC3V3 regulator changes in this patch
so please keep this empty line as-is.


Best regards,
Martin
