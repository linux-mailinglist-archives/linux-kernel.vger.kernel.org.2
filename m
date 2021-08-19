Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032CB3F2170
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhHSUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhHSUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:16:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91EFC061756;
        Thu, 19 Aug 2021 13:15:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d4so15428298lfk.9;
        Thu, 19 Aug 2021 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrWz4NAakvkbXED+TiflwM6YH+DFROJfdHAiNsIJBK0=;
        b=nBFk1XsgHsVry9Qc6yaHDy+PvJLnZ6Zu5cdlqGO+4+12ZvLSfr5ETy6twZb2l0SSs/
         nSUlQAlL4AkAgQVU6+mS+9OBCWI+SGCtn2c8UEmABWG+9gGP2IO4spo7JHqaC5qIUO3v
         Pjn0PDCnFZmTsHnYMR0XxTrxhLBClpjoXOZU05PhKd9KR53SnVhe5OVUIXJaTg4lheDv
         ORogd8/sAqoeago8IklvD8qO9yXq54U1af5ujQWAcL1AMz/vIl7xwQ8pjsQwSg4XQ1ok
         umOgxsjmhaNMPdmMMbVpHpGAv5WGLLMdihIXfWl5YlnFjZqeBZk2ZMQ4CUms0WE8TS5t
         EvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrWz4NAakvkbXED+TiflwM6YH+DFROJfdHAiNsIJBK0=;
        b=NdilHCr0WnEoePAuOn9TAiHLrrhiIn5+i6iMjtAGkZMC7MOP1ijRIApEsu5gs0kU0d
         l91IhpxpvEKuDRhvZoWspBtrMH4wDb0L/peie07QJA4D3ZbdZDkU3/kWY1E1m7cyOaZs
         0EF5aLl6uf7Nn4NkGZyk2DMY4CDz3KVbUFtDfrkzE9Z73dqSiH0yWNrj6V5AKdjnGLsP
         4Hrp+6KeIW8IjOWT3PIMHhIiHPMfVX2b7s51Cik1yN425XzPNOtdAfGynSzHDsROZjVs
         0vSnv8qVGZIALdFu9yYD4QMLWl4wsF8Bu2KGJytoRg0qdZyA3rdNN+cPycB6ZCNPdSRS
         zj1A==
X-Gm-Message-State: AOAM532YExvfJuZHx/LvusYL5EHH1OU/4dWV1cMjNccLQcU3/J/5MfZ1
        qFHhWKHcInHUdLXV4RxPYiGenYrnUx78E1d+jrw=
X-Google-Smtp-Source: ABdhPJwEED8rs03dN1hA20txFirdZi1ehzNxv5jEG4C5upbTpW5JD3zizQuaG+1RowsjPUj0ecXOUW+DtWK9JxSCHLc=
X-Received: by 2002:ac2:4143:: with SMTP id c3mr9598186lfi.295.1629404149335;
 Thu, 19 Aug 2021 13:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154818.18334-1-lutovinova@ispras.ru>
In-Reply-To: <20210819154818.18334-1-lutovinova@ispras.ru>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Aug 2021 17:15:38 -0300
Message-ID: <CAOMZO5DiaNnxc6X77jyPp9PxAUmc2-HdgE0nh4uBda_eLaBimQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: imx8mp: request irq after initializing dwc3
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadezda,

On Thu, Aug 19, 2021 at 12:48 PM Nadezda Lutovinova
<lutovinova@ispras.ru> wrote:
>
> If IRQ occurs between calling  devm_request_threaded_irq() and
> initializing dwc3_imx->dwc3, then null pointer dereference occurs
> since dwc3_imx->dwc3 is used in dwc3_imx8mp_interrupt().
>
> The patch puts registration of the interrupt handler after
> initializing of neccesery data.

"necessary"

> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
