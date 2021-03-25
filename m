Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0035348C09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCYJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:00:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49320C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:00:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 75so1407200lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hVRMkQ0tHL9uVXvm233X7lLnnZ2hno7sFzdBZfFdOI=;
        b=Kc1IpBZxWVTOYw66WGTB1QyddKnYREmW1xtY3GcCADOywwhEb8Z3AFFd+id2LunKuy
         33cR2Qoh205LF926p5IOG4T7etcLoiDHisk4rtvgDkiC6rkf7rYYQroi9PGiM66UPmRL
         IhkMDH3h+u7Ph+RpUvZciDY5/n4bhiV8AtDigdjW5hdZnENDceYmQZytQJEPjTyWi/UJ
         qNAmMBPTGJt+BVFUvU0fbwPciqtkv2oE/JE5648hLqsKC3RXAdzBot4Gtv5IObVrGHZe
         tsoC6JsHDJL6A3HjA8Hw4DgoJHdvTdMC+ob8r0MzFgQkuZsF3ptYkyTk+IZtZCUh/vRr
         dmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hVRMkQ0tHL9uVXvm233X7lLnnZ2hno7sFzdBZfFdOI=;
        b=g/Vd/F3atnMi+Ei+NZoKXyjkfOCDClpxTZ/OKj4/htHVheFuMiRaLWituzRpbQkJmb
         dXxt/Fhuc/GAB1zasXt/LudPtvSjJtQPn9IaTQWtxbkRJOesULze4l+WzXfCcWFqsxEo
         6dhRKKfj6+hYgnknbs02VJEqgXkDvcWwc7B+WmYF82m4+5kB7EhkBwJ04GhEcsy51UFM
         MWSUGigTNFaZrGiP8zH/wv2Vaz+vKuSRn8tMGMb6vjHjkWW9WB9K3LHsk3gKv2bEM+LT
         GGl37TrHLK9x4Ni4t6mbaEQWtz2DFXft41onynxoWLCxTDsvLDnD/gpfkHRfJnV03w5h
         8zrw==
X-Gm-Message-State: AOAM533VbjKB/q/VLre8KTtcAhXFRhfCJ5Bn+dzQCELBIPUZhkHwS1N+
        cQTG0COfHz/PW1NoMXkM9gnFaIS+HU5gsqK3N3sJ7g==
X-Google-Smtp-Source: ABdhPJwaQP4N7d6gaupRLo89RKDhrzwRsCXYPYHFvTrbyAYIZ4AwHthQskkvtSOpJPpQUNbeNE169N/PfjYTs7sQF/w=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr4510008lfo.529.1616662817810;
 Thu, 25 Mar 2021 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <1615969516-87663-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1615969516-87663-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1615969516-87663-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 10:00:06 +0100
Message-ID: <CACRpkdaWrhEY1izoEm4=Hsysh3RWgNdLVpjDCt=ybd-qZProfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: pinctrl: Add binding for ZynqMP
 pinctrl driver
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:26 AM Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:

> +          io-standard:
> +            description:
> +              Selects the IO standard for MIO pins, this is driver specific.
> +            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            enum: [0, 1]

As concluded from driver review, replace this with
power-source  which is already defined in
Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml

Yours,
Linus Walleij
