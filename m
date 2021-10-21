Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D272D436B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJUTvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUTvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:51:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C0C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:49:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e19so1623111ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Opei2my2zsRhGEYmSTuquQHbuG/tOHt/W/ohA+sBkZU=;
        b=J56pn8v/zCspqN41ZGEwIT56+31lMkBdJrZdcQLtgO9PhvQz6MeiFi7kH1eEiMGXjo
         4b51gujd75zM4NgVtCt8cJ5xgwsmTIE/6D2iUJM9MNVLTr8A4FyqbCglFi5RlvB8sZ+x
         fGEo7bkxnv35B1qsE7FtZhmIUvXlDBjZmQqr3qrzG9yitRfUjRivRSX90/W5FksMs6FE
         dLjygk54GGFjoHNzPqjObnxCZCGCL1Ftj6shrlmL8I8gZ69aBFmdWuoC/n6QrJZVcOmT
         G36icUoXHyNCMLJN97Vkgz0JoMq5ITrHeTJWng356HwZHZqyw9dyhgtVoHJGSrWg5PTn
         XddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Opei2my2zsRhGEYmSTuquQHbuG/tOHt/W/ohA+sBkZU=;
        b=DasRJVLhTsq/C61vtNV34jL6l68HbmncFHaU72UvNqMmYBTK+ZYfID0HxV1oLWxzRJ
         mFQizXv/QYb0Nsk50E3aZkUymzcIWRA/xh4RtaFgVub9T8G6gct3egDDHGsLRbQBJ8hW
         krYrFsxD6P3CvVmqzNURSqFj4cZZP0IxT96kwuXlKlUY7q2qhwwCFN9XC79ZACLOS8In
         1PVsWJX0FPlpe1Nam40CM2EhaHY8/+bFabniYpnQBizB0knH6MxKbZZXr0s79uOykLZg
         WifD6yF+4/Nmj++VApi4Bs43D8XEugdEK6A103SzezYXlYQH6+XCbrAzp6/Ldvc0ANIx
         LK+w==
X-Gm-Message-State: AOAM530xhu4RMtsxVhenMqLeqJIF8HVLX8Xph3eKYXTRCjz1lmhfO7FK
        RxNWGzxrek0K2mpB4+t71tFJNKFygpg+J9DJTlTbbQ==
X-Google-Smtp-Source: ABdhPJzsohCOTx1G/FZllZ3uAchcRkiXF3/8ioX8Pv2kx2U1CnAV7vzxiVyXFXeanMWMJgtKKvvkklbYWWpHXH5LLpw=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr8206076ljj.4.1634845767028;
 Thu, 21 Oct 2021 12:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211020083902.3669769-1-geert@linux-m68k.org>
In-Reply-To: <20211020083902.3669769-1-geert@linux-m68k.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 21:48:50 +0200
Message-ID: <CAPDyKFouV9C2VrGwB1u5iQ5g5m2i9nmKBZMQg1z5m6t9QY5wAQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-omap: Remove forward declaration of sdhci_omap_context_save()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 at 11:05, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> If CONFIG_PM_SLEEP=3Dn:
>
>     drivers/mmc/host/sdhci-omap.c:1213:13: error: =E2=80=98sdhci_omap_con=
text_save=E2=80=99 declared =E2=80=98static=E2=80=99 but never defined [-We=
rror=3Dunused-function]
>      1213 | static void sdhci_omap_context_save(struct sdhci_omap_host *o=
map_host);
>           |             ^~~~~~~~~~~~~~~~~~~~~~~
>
> The referenced commit added an unrelated forward declaration of
> sdhci_omap_context_save(), which is unneeded in general, and unused when
> CONFIG_PM_SLEEP=3Dn.
>
> Fixes: f433e8aac6b94218 ("mmc: sdhci-omap: Implement PM runtime functions=
")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.=
c
> index 0dec2f849b81e242..a4a1734dcb84e9cf 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1210,8 +1210,6 @@ static const struct soc_device_attribute sdhci_omap=
_soc_devices[] =3D {
>         }
>  };
>
> -static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host);
> -
>  static int sdhci_omap_probe(struct platform_device *pdev)
>  {
>         int ret;
> --
> 2.25.1
>
