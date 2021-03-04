Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE132D49B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbhCDNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbhCDNvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:51:35 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE4C061761
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 05:50:55 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id g68so4537562vkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WfBNuUrd/opuKzkgtwMeHEBHTqndp4QteWKqmlqjrkk=;
        b=EV27IFZ+KtpLSZGMRFgQ2JSb1S+71I7aezbRUK4i7JX7v1rbFFIQgMMOECEg7IfmR0
         tYC91rQ8L8/j0Yi6kQnpdJPFcEPrgrxMX4oUpgxzqPbbDskKkGVfAWiaN37YULwZZeoP
         wGQD5UlgQ9UVfP3EwqZmkxddmqr4bh4/67/pGcb54zeJgmMFDoAjkxYsAf2hWlCvFB9H
         em07LWlHSICrZLayhSEhVU9+BhBujQavIswpkSB4DHMY0aVg3121uTr4z1cNIYe0gIQD
         TugaTLqaw2uog3ICI37ePDFDGGIufKtYzKdPYIJEnqUy+GKyE9S2TZ6Wj/PTq4RbbveV
         lCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WfBNuUrd/opuKzkgtwMeHEBHTqndp4QteWKqmlqjrkk=;
        b=eI6T+YwiqDYqdA58o8A6BFaV7Cr/Cvx9aNkyNRCFs90B7p18cxmnzQ4+LyWnoYwnXD
         kXTaxHm872DHpPRY88mKBGw5KhDD0w2vX18fHztY9kwdukzfHenrljPf7KfMr7WRi0mA
         qcwbHpef48yDIYdCCjHFjHjnhOIx6zS12moAW6/I7b5/Ng3ySYETeTqXrrz+yaczFD4f
         ZTjnbq8QphTLKpB8y9aVxpd04zuA4DYTdedsaBbYJNAit+PzesW9P97/El/AjaS4Owf2
         3/JkEdA9c4+n5EdnbeX3vTcFW24XCjJchzlEXGbteLmAvgAXlmsT6XAGQRE9felUUdhM
         Xa5w==
X-Gm-Message-State: AOAM5312A11etb/UJ+T50FXkTu2o/srmyOUJXHO3YEgicz9xE/w/H8Qh
        qoODUX3rXPa5Zq4dBakqQve8hAspX2F22t+DcayC3w==
X-Google-Smtp-Source: ABdhPJyOw8Ivbs5I2MbmiW7PCGlUo1so5zhUDrOfGB44xQi6GqIBDItt+f25Di8kQdBmoZJFN0vhArCpH9GkQGXWNz4=
X-Received: by 2002:a1f:a68d:: with SMTP id p135mr2712297vke.6.1614865854678;
 Thu, 04 Mar 2021 05:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20210303174248.542175-1-Frank.Li@nxp.com>
In-Reply-To: <20210303174248.542175-1-Frank.Li@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 14:50:18 +0100
Message-ID: <CAPDyKFoHRfvKHS6NWrkkLD4Ek6DyXPyPd2ey5zhsWMCY=cCOZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: cqhci: fix random crash when remove mmc module
To:     Frank Li <lznuaa@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 at 18:42, Frank Li <lznuaa@gmail.com> wrote:
>
> [ 6684.493350] Unable to handle kernel paging request at virtual address =
ffff800011c5b0f0
> [ 6684.498531] mmc0: card 0001 removed
> [ 6684.501556] Mem abort info:
> [ 6684.509681]   ESR =3D 0x96000047
> [ 6684.512786]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [ 6684.518394]   SET =3D 0, FnV =3D 0
> [ 6684.521707]   EA =3D 0, S1PTW =3D 0
> [ 6684.524998] Data abort info:
> [ 6684.528236]   ISV =3D 0, ISS =3D 0x00000047
> [ 6684.532986]   CM =3D 0, WnR =3D 1
> [ 6684.536129] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000081b2=
2000
> [ 6684.543923] [ffff800011c5b0f0] pgd=3D00000000bffff003, p4d=3D00000000b=
ffff003, pud=3D00000000bfffe003, pmd=3D00000000900e1003, pte=3D000000000000=
0000
> [ 6684.557915] Internal error: Oops: 96000047 [#1] PREEMPT SMP
> [ 6684.564240] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm sdhci cq=
hci mmc_block mmc_core fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc ca=
amalg_desc crypto_engine rng_core authenc libdes crct10dif_ce flexcan can_d=
ev caam error [last unloaded: mmc_core]
> [ 6684.587281] CPU: 0 PID: 79138 Comm: kworker/0:3H Not tainted 5.10.9-01=
410-g3ba33182767b-dirty #10
> [ 6684.596160] Hardware name: Freescale i.MX8DXL EVK (DT)
> [ 6684.601320] Workqueue: kblockd blk_mq_run_work_fn
>
> [ 6684.606094] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=3D--)
> [ 6684.612286] pc : cqhci_request+0x148/0x4e8 [cqhci]
> ^GMessage from syslogd@  at Thu Jan  1 01:51:24 1970 ...[ 6684.617085] lr=
 : cqhci_request+0x314/0x4e8 [cqhci]
> [ 6684.626734] sp : ffff80001243b9f0
> [ 6684.630049] x29: ffff80001243b9f0 x28: ffff00002c3dd000
> [ 6684.635367] x27: 0000000000000001 x26: 0000000000000001
> [ 6684.640690] x25: ffff00002c451000 x24: 000000000000000f
> [ 6684.646007] x23: ffff000017e71c80 x22: ffff00002c451000
> [ 6684.651326] x21: ffff00002c0f3550 x20: ffff00002c0f3550
> [ 6684.656651] x19: ffff000017d46880 x18: ffff00002cea1500
> [ 6684.661977] x17: 0000000000000000 x16: 0000000000000000
> [ 6684.667294] x15: 000001ee628e3ed1 x14: 0000000000000278
> [ 6684.672610] x13: 0000000000000001 x12: 0000000000000001
> [ 6684.677927] x11: 0000000000000000 x10: 0000000000000000
> [ 6684.683243] x9 : 000000000000002b x8 : 0000000000001000
> [ 6684.688560] x7 : 0000000000000010 x6 : ffff00002c0f3678
> [ 6684.693886] x5 : 000000000000000f x4 : ffff800011c5b000
> [ 6684.699211] x3 : 000000000002d988 x2 : 0000000000000008
> [ 6684.704537] x1 : 00000000000000f0 x0 : 0002d9880008102f
> [ 6684.709854] Call trace:
> [ 6684.712313]  cqhci_request+0x148/0x4e8 [cqhci]
> [ 6684.716803]  mmc_cqe_start_req+0x58/0x68 [mmc_core]
> [ 6684.721698]  mmc_blk_mq_issue_rq+0x460/0x810 [mmc_block]
> [ 6684.727018]  mmc_mq_queue_rq+0x118/0x2b0 [mmc_block]
>
> cqhci_request was called after cqhci_disable.
>
> cqhci_disable                                 cqhci_request
> {                                             {
>         dmam_free_coherent();  (1) free
>                                                   if(!cq_host->enable)
>                                                        return
>                                          (2) pass check here
>         cq_host->enable =3D false;
>
>                                                   task_desc=3D get_desc(c=
q_host,tag);
>                                                              ^^^^ crash h=
ere
>                                          (3) access memory which is alrea=
dy free
>
> }                                             }
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for fixes, thanks! I added a fixes tag and a stable tag.

Kind regards
Uffe


> ---
>
> Change from v1 to v2
>  - use Adrian Hunter suggested method to fix this problem
>
>  drivers/mmc/core/bus.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index c2e70b757dd1..4383c262b3f5 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -399,11 +399,6 @@ void mmc_remove_card(struct mmc_card *card)
>         mmc_remove_card_debugfs(card);
>  #endif
>
> -       if (host->cqe_enabled) {
> -               host->cqe_ops->cqe_disable(host);
> -               host->cqe_enabled =3D false;
> -       }
> -
>         if (mmc_card_present(card)) {
>                 if (mmc_host_is_spi(card->host)) {
>                         pr_info("%s: SPI card removed\n",
> @@ -416,6 +411,10 @@ void mmc_remove_card(struct mmc_card *card)
>                 of_node_put(card->dev.of_node);
>         }
>
> +       if (host->cqe_enabled) {
> +               host->cqe_ops->cqe_disable(host);
> +               host->cqe_enabled =3D false;
> +       }
> +
>         put_device(&card->dev);
>  }
> -
> --
> 2.25.1
>
