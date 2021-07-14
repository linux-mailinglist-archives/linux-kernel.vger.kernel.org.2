Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18B3C92C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhGNVK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhGNVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:10:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:07:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dt7so5477848ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKs08PKA3zHnZYiqGFTlV7FYCOVvxTsZbzcVqjAcgso=;
        b=bIQtaIrN/M5zSK25RG9pKNDG5gguoJ9kFWmyyfhmFDbrM5Il0JoSQJo6mZgQXQ7NDS
         7bEdL2/cWvk88mbaPoakH6ghNPsiingIj5ePUEXeFb3ZFGUR+DZu6vUHZhBtnz9qQ4eo
         U8/D0n9TvsHmaXhb+gVynZJaBUbs1KBuy01aAPLjDt/DmvuKngXzwrj8x8JbzR/PKH2E
         4/CY8V6MSQeeF4ouGNTOW0QG8JrEuR655z69wyserrW3acN8CriJuGIClx0RlGERDRro
         TohwQKVQjW4wacwyV99j/0zgkK/J2L2kzjt2ImS5Ri4cGz6diGmtzN60BX5SKoWGO7Dy
         WZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKs08PKA3zHnZYiqGFTlV7FYCOVvxTsZbzcVqjAcgso=;
        b=Ep4Ps+V/Z4Age5KF9FFSLfMCXqxpBWyEzZ0gZExFQgBpuSOhbCuJOLV8jj3p6lTNGs
         y2P28RRsXgBXo8VatpYPtYgYl/ILE/OMr+9DvhEtGnqFv8ex4er+fhQwGM2uHXy+cdHU
         D/VWHgH1rg3jDy7CjVAyI2RnylVl0Js55ihb8DU9F9t7Qf+DnpE/+ekTU6XpsEYcIsn1
         Gg970G+bHIwhqFjRSI2NTzpECBihe8ykKGD5uVeNug9SlQ4pVXmAmGnPQUyCreVmPjxq
         CrNTv/OQbr6W1sb/A2/tWMFc2J3QRSkIjuA4ot5ejgS+hd+W3NSjqZGjAwlhthZglWzv
         ak9g==
X-Gm-Message-State: AOAM530R6klqrcoXwj+M86GaCoiWc+PZxJ/8lMCr8hDqteaK1gE2DFqw
        cECuG3uTWzAHOhhrvoFmic02TAPWGbMA8Y7shY8=
X-Google-Smtp-Source: ABdhPJx0IdYLqpL/ZbZ0z85Rkw9C0uhJ0kkps6LzUM9s1hcfPZrydzc/r/r/1A//ysR3OnjacLyMNks9BArwNjAbCjw=
X-Received: by 2002:a17:906:39c3:: with SMTP id i3mr141055eje.527.1626296852680;
 Wed, 14 Jul 2021 14:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210714134540.1722-1-linux.amoon@gmail.com>
In-Reply-To: <20210714134540.1722-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 14 Jul 2021 23:07:21 +0200
Message-ID: <CAFBinCDN+wTU24tfyqH1nbxm72h7aT960beKkKE54dYGe==DNw@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable CONFIG_MMC_MESON_MX_SDHC
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

thanks for this patch!

On Wed, Jul 14, 2021 at 3:45 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Enable CONFIG_MMC_MESON_MX_SDHC so that SDHC host controller
> on Anlogic SoCs boards enable support for eMMC and MMC drivers.
typo: Anlogic -> Amlogic

> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
with above typo fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +CONFIG_MMC_MESON_MX_SDHC=y
note to myself: =y is fine here because booting from eMMC requires =y
instead of =m


Best regards,
Martin
