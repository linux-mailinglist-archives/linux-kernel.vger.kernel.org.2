Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED93B7AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 02:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhF3A16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 20:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhF3A15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 20:27:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD8C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 17:25:29 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f13so677815ljp.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 17:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kC6zfCVfLq+QYp2vov8a7+e9ah6fYKboXI/THVBS/Oc=;
        b=VOTczlBMJnSaTRF0e2WcjphHojjeC+1+pn0oJ2ZPhNHZ7LhRnQxdHr3Or44wB8+50S
         kflMQpJsGHPvIqzNCKN3CEGzlhSPAPy7UTsrDMss854YzCirBNbQsz9czR/DWz248SCk
         jQkw1aDE6iQryBEAzhM5VQo+zESH5AZDYYPgILNetRJgXnRKon45h+6pXyc0KI3xoz+a
         wZOpDOFkqEVNHtKMpTkkDId5QRl19N6YMPd0/6bpy4kHDFUqz6WTsr3DFltN6tvFsjZO
         5r7y5StljTifcKE5hsFbiKeL+VOjN+i5sKjXnbwBly4n3ejKMkyP9BHg+Uh8UJa0+j7C
         TgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kC6zfCVfLq+QYp2vov8a7+e9ah6fYKboXI/THVBS/Oc=;
        b=kSxv6Yin0pWEyo7cS7+ouk3joEjw64G/pLlSjAcDSQY8LcU1vIGJalazyt6vhN1GaZ
         Fl1bxc3fkiENAF0h/npjBm9W6tPrbHjmwJgmueZby46a3UT50yuVnrIf+mYcNTvJW4N0
         KBV6O2pAPqxTX+XvQu5lqQEhXcOlBhVT6Eg5jt0dop82od7hvbUOAsJxc9QF/Ncoqmuq
         bpg+SCfBiiv7oQKucT3bz0sOPs4aJxyqC5fVixn8wOsMLLn68Hl7JnWjE8In4VZBuf6E
         fG53E/mzXUhkGd2sHQ/SZk1WQ1sHYU+YwUkNXpWFlWA0MjUtSthlswOF0/EGXpgbXnWD
         u7tA==
X-Gm-Message-State: AOAM530asdbZHvEz4Gy4bTAzpIymXz9Pykb909DwpluSJX/szC7f+Wlv
        PReNe9tVNRxLTkc0KBgW+ubd/vi0Pf2zy+NpCB+bKKdHQek=
X-Google-Smtp-Source: ABdhPJyc4v+cIpXf4SPZRnQ20g4EGCBsMRjQOawe5CdkI5vll+I0FHnC1mewkgAOwXH4f4Xhf9jmEKHsAJWmBqL2GA4=
X-Received: by 2002:a2e:9483:: with SMTP id c3mr5862322ljh.273.1625012727354;
 Tue, 29 Jun 2021 17:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <6a88e55fe58fc280f4ff1ca83c154e4895b6dcbf.1624972789.git.geert+renesas@glider.be>
In-Reply-To: <6a88e55fe58fc280f4ff1ca83c154e4895b6dcbf.1624972789.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jun 2021 02:25:16 +0200
Message-ID: <CACRpkdZ9+KZx_giKLFXj=KX-pL8kxvQ4DVP31fD=AjFBTn2Gmw@mail.gmail.com>
Subject: Re: [PATCH] PCI: PCI_IXP4XX should depend on ARCH_IXP4XX
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 3:20 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The Intel IXP4xx PCI controller is only present on Intel IXP4xx
> XScale-based network processor SoCs.  Hence add a dependency on
> ARCH_IXP4XX, to prevent asking the user about this driver when
> configuring a kernel without support for the XScale processor family.
>
> Fixes: f7821b4934584824 ("PCI: ixp4xx: Add a new driver for IXP4xx")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
