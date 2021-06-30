Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5A23B7AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 02:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhF3A3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 20:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhF3A3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 20:29:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 17:26:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p24so742750ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLDNIKDc2LkQOFgO3bOE8z8TwqChJogo1fz5CBrfcS0=;
        b=g9RHzpi1y4jDnNgoGwUs3HT6MJW0NhiWVTs5EYavv4bX9sYC6zr4khjtieCT4PEPF5
         OBGgHAhAvdsahOgdWDHSd9VAMa6Gp+XgAk/u8riSKhJ9CFGskHjj1NVaJe8L2AWkdzID
         qbmANphsTzr31kIl2xPou4UsXPSESR/7K30s3DUwXJsgVRjNm+KOBn0KqVT0N5YINdRo
         m8zUnGHU0XYQbTHUtgEHXR1cITkerTdqyBgi2nx49HY36HmamBBTqJUE5AjaV9luO1oa
         5X/B/BUyhoLHQT45giImBNO8s66xZmSJ5L58/4Qu09oczRlZAHAOJd+Ki21RMCnLpJaW
         fLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLDNIKDc2LkQOFgO3bOE8z8TwqChJogo1fz5CBrfcS0=;
        b=AyKl2XIVHVGILyrS0NqabzhlTPsAWNEPfQlNRRhgBBtwNgr1bgteCJgECKZYN8iiZi
         ywHBtX0uhQYhAVgCT3FEkUnjHdVMRq4ATIXHLrSgivZ5xQD8GsKNUCmg8iKOvevXF6fG
         vc+u5xdeOXijXSUH1LRPG+Fz1aw+cK+FJiYiVmPjF0SmnIXU8wTrhAWpwd1D9c3BsFC/
         pErSzKMZgISk1bVfs0b2n8DTImpBzQHGaQOb5L2gZQxF+E9yR15l4lZK9XUIilUjQNd8
         M5TDQ+pPsgr8gpFEOLqE74CTqO37P4PupiVMYpv624AeDBN1ovTusnzNcAS+CIGGTu1C
         jVTQ==
X-Gm-Message-State: AOAM5307KRiDtY7JE7mSrw+IQNWp/TAuFQIYGKqoKfSXOwLfP1j+7Lwx
        OTmFs/P0goCb90gEmX4GMbabmgT/1PUHGNTD1q3BcA==
X-Google-Smtp-Source: ABdhPJzGQKuF7peEnTXePqRWxJP4VXoO0pHL3pozKWL5VfwLHPVLt9QrzXgCtIQbmOSqQT8zDeGOOadUHB7iblV3584=
X-Received: by 2002:a2e:9d15:: with SMTP id t21mr5969690lji.200.1625012805780;
 Tue, 29 Jun 2021 17:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <1b2fd6f2b2e87a7d483450c20f31366b7f17c997.1624972206.git.geert+renesas@glider.be>
In-Reply-To: <1b2fd6f2b2e87a7d483450c20f31366b7f17c997.1624972206.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jun 2021 02:26:34 +0200
Message-ID: <CACRpkdavxy4wmsj8XtXmbMDkmScquABynphnmD_GAARfudd1AQ@mail.gmail.com>
Subject: Re: [PATCH] arm: Typo s/PCI_IXP4XX_LEGACY/IXP4XX_PCI_LEGACY/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Geert!

On Tue, Jun 29, 2021 at 3:12 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Kconfig symbol PCI_IXP4XX_LEGACY does not exist, but IXP4XX_PCI_LEGACY
> does.
>
> Fixes: d5d9f7ac58ea1041 ("ARM/ixp4xx: Make NEED_MACH_IO_H optional")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Are you sending this to ARM SoC or should I?

Yours,
Linus Walleij
