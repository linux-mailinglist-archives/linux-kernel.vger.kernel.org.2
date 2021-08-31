Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758D43FC8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbhHaNv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239133AbhHaNvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CFE361027;
        Tue, 31 Aug 2021 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630417827;
        bh=9enbDHRItSEBVqHTy4fYhbDScEEUguUhNhfZuTRNQLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EPR06hAJKymadfuLFq6bEcXviID2XR2bAf4H8YvO37aoVEz5i1bQK2XY40l5Nn8+b
         NzZjmBn+7WMQzFw9SCELCWbPFinXfb3nbsOgxv/m3iS0RE2WGP/DiJFpKFGB83NiIt
         wyu0tZK8sZ9nMamUsPZ9QBC7jGics/WENLVQukyPAJu1oWuFvzOOfuYfHW3O4a0yla
         MJN8XGUPSOBqSJ8cYmXLLRIip7REiFg8tpVVO87PETnaOb5KCxRy8culSd1UkGpSwA
         jY6O/b96sHZq7xOQWr7LfduJ5oHI3CtArDlPn1PuhvkIkyKGB6jRU83QRHrQsK32G/
         +XtCAxRkQYsmg==
Received: by mail-ed1-f47.google.com with SMTP id r7so10920433edd.6;
        Tue, 31 Aug 2021 06:50:27 -0700 (PDT)
X-Gm-Message-State: AOAM530Jm2vWNpYveWC2gLQ8SDYTSey0kJP92izNmgcniWh8wxTogwJd
        YtV2nNi025fQkEMpjC1Z9rYVAIxK0gDE3JdL9Q==
X-Google-Smtp-Source: ABdhPJyYQShfn4w//yBf35+yfTgcoefHDREub/IZd9p9I+kmPPLux1ziBhWsKoLgqZF+WYKcr17QvaJhdiBcbfB5HaI=
X-Received: by 2002:aa7:d1d3:: with SMTP id g19mr29465236edp.373.1630417826265;
 Tue, 31 Aug 2021 06:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210831125843.1233488-1-nsaenzju@redhat.com> <20210831125843.1233488-2-nsaenzju@redhat.com>
In-Reply-To: <20210831125843.1233488-2-nsaenzju@redhat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Aug 2021 08:50:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL-CdrAqY_4vnXQfTuSU8GsYzZutyFhZZgm4o3p-qaqFA@mail.gmail.com>
Message-ID: <CAL_JsqL-CdrAqY_4vnXQfTuSU8GsYzZutyFhZZgm4o3p-qaqFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: bcm2711-rpi-4-b: Fix usb's unit address
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 7:59 AM Nicolas Saenz Julienne
<nsaenzju@redhat.com> wrote:
>
> The unit address is supposed to represent '<device>,<function>'. Which
> are both 0 for RPi4b's XHCI controller. On top of that although
> OpenFirmware states bus number goes in the high part of the last reg
> parameter, FDT doesn't seem to care for it[1], so remove it.
>
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830103909.323356-1-nsaenzju@redhat.com/#24414633
> Fixes: 258f92d2f840 ("ARM: dts: bcm2711: Add reset controller to xHCI node")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>
> Chages since v1:
>  - Add patch as per robh suggestion
>
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
