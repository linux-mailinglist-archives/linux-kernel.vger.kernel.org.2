Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD174334D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhJSLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhJSLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:39:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B7C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:37:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t9so6806500lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwfDNTxztsaFFsnMzgXIH5wS3ZyzclKxra1KT8MNpgQ=;
        b=Djlw03UNXO1XUB5rvTWozOrTXI61Rd2t0/E0T3eVHz5A8+A+LdKVUkFga+7BShD5RF
         hE6Ghz7dGz6XUAqj0UTOE8KKqUR+60Jg0PmdsA/NAi87fldmewCRm34XhEmbIPqR7GWb
         w1Z42F1t/SSUAtkq2JVqkjsYGJ5kgQiMHCaElfzQalkMXq+8DU3ZUV5Bnx9rnD1TXkZo
         BpPV96vUysgEL7Y+FOYQITxwwVufBP027CnMgVWHyfblYcycIE4St/wm8T35mzgeYMbg
         YgS9xRDofO0VlOqFvX6Ph7whGNH3mwGsU8l8aNrjcpG8X9fs+yC4Bg/hNA3R5dvFUmRA
         P1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwfDNTxztsaFFsnMzgXIH5wS3ZyzclKxra1KT8MNpgQ=;
        b=BxLarfR+uzJVrHpdML9vG67qRJI0QBOMDBjhBiHfH46alNojHHsgVsdxXVYAPxXCiZ
         p1CFe9gCDNjrSVipGmMM9gTZe3XS4BF29oNaw6cEApcpuaae1owkjPGgWiaWCpgwgMpD
         5TEa8MGR0/hkuSCrGfuaM3YUavjPgMZkO3Ao4dskOC1lAKoVFe635/Zu4HMm0b1sQgVW
         jZpFGmRToLlKvkY/JEMTc6OXVz5eus9oSiECXSyN6DcfaS2fdz2FKzg5MuZDMtfFulQZ
         0QilL3CGO5qhohOrNqfrAAh2t0gJszf/TDCtWo0wZEPxz3Oy2Ns/RPlpNzwn70c2BsqV
         mZLA==
X-Gm-Message-State: AOAM533ZxJtcnIOxPh3soiQRH/7caOx6Wh5AyPdaKVJ1ny6g72zWkYnD
        B4y2KvTOpbTLbo75B2Q+hL0Q2iroNjMzByYGESJrdf/QNfw=
X-Google-Smtp-Source: ABdhPJwKUD35kQ6H8T4ZUXwLM6yT/9Zi5J5IpF/jT0jYnziIq0TIFEZANVCooZqV1pAEC4qgZoWDu9C2MOPsIbuEtUA=
X-Received: by 2002:a05:6512:32c5:: with SMTP id f5mr5717565lfg.373.1634643443626;
 Tue, 19 Oct 2021 04:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 13:36:47 +0200
Message-ID: <CAPDyKFpX8Xh6aZ6aO=CcHYw45aq89oSywZx9tVaq+GOW1HP=aA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] mmc: sdhci-pci: Remove dead code and deduplicate
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 at 15:26, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It appears that one of the supported platform magically worked with
> the custom IRQ handler (any hints how?) while having two PCB designs
> with an opposite CD sense level. Quirking it out reveals the code
> duplication and dead code.
>
> Patch 1 is code deduplication to save few LOCs.
> Patch 2-5 are dead code removals.
>
> In v3:
> - dropped the fix as it has been applied (Ulf)
> - added tag (Adrian)
> - elaborated commit IDs with their short descriptions in patch 3 (Adrian)
> - corrected dependency in patch 5 (Adrian)
>
> In v2:
> - redone fix to use ->get_cd() instead of quirks (Adrian)
> - due to above transformed previous clean up to the current patch 2
> - added a new patch, i.e. patch 3
> - added commit IDs to patch 4 (Adrian)
> - mentioned dependencies on previous patches in patch 5 and 6 (Adrian)
>
> Andy Shevchenko (5):
>   mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
>   mmc: sdhci: Remove unused prototype declaration in the header
>   mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
>   mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
>   mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)
>
>  drivers/mmc/host/Makefile          |   1 -
>  drivers/mmc/host/sdhci-acpi.c      |  14 +--
>  drivers/mmc/host/sdhci-pci-core.c  | 152 +----------------------------
>  drivers/mmc/host/sdhci-pci-data.c  |   6 --
>  drivers/mmc/host/sdhci-pci.h       |   5 -
>  drivers/mmc/host/sdhci.c           |  19 ++++
>  drivers/mmc/host/sdhci.h           |   2 +-
>  include/linux/mmc/sdhci-pci-data.h |  18 ----
>  8 files changed, 26 insertions(+), 191 deletions(-)
>  delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
>  delete mode 100644 include/linux/mmc/sdhci-pci-data.h
>

Applied for next, thanks!

Kind regards
Uffe
