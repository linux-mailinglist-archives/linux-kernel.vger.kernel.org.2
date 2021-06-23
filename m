Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73203B20A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:53:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:50:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t9so2541935pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ir9jY3nBe5iS3sggziqw4z6Vtt5ZPYlyAkE3Eq8Re1w=;
        b=Teg+shfiHdgmBiXQ/OBYwrl4Fmbf5gjlvU8VtroATqbWuwqWiGSyqG8afpfUeM+40E
         Gz2q5WHQAgY+tVj6xLTPC60S1LvckR/JcRY5Kmp9KzHKoiuQ2s5l6jCI/BOxQiXvqn8V
         tWS+S7+VujtLyuhP5Pg344KpfdowpUB9Rw6ecJNSYwtdQ4S/88QMZduV817RoNX9Rj22
         P/FFM8VghAqHklAxTnUpqD8+mBIiFEjFVvvjjZTqbUNBCeN4Samd7LGc5chMaIydGo0K
         sNf9fFXjRG4lm/iTXw9H9yxmr4jS0/iVwX2kHDtPjME9w6OL3I7vEFv8VfP0O+kAXBld
         OdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ir9jY3nBe5iS3sggziqw4z6Vtt5ZPYlyAkE3Eq8Re1w=;
        b=RIeynonBUolkxWyIDjqWrtfz7ryrFC/emriv5v5aU0GrTAOzJ6fdcJfPz+C+iMlSf6
         YBOoqMrr6Q+AW0zbygDr621b7XasarcCs5hsVB8qANbt7wymBzkcFprbSH2HxXzyiHpu
         waL+g+N4wvWfMjGoABNYZ6rKhf1AFRKPQj1VLqvkEkJdX1AcGSoY72j7nyrHTPLWkgKE
         ilsQphY69U10RJMFY5K+Hm6kbLhtkGR0ogTCDSD/qPWsDy+6pzprz+Xkk91hHaoePsZG
         mDav4PlknMs5E2qcGCKghPXS6ftGkRzgSrKVo6KEvRj3nBRsl6h8wnSPkWU7sXNDgfcO
         /lhg==
X-Gm-Message-State: AOAM532q+ozTmzA+bldqbUx/4Nsi6FPTtckikrkw5njZGapYus7G3s3c
        czMnXcUPGO7CfwXr8f9QJ+cLiQ==
X-Google-Smtp-Source: ABdhPJxCZMfCsSZ78Yj+voU+e+Y4Ki+GbrOGOAxXaLbA72duG/o6cTs5ZO7Bof7AHV928WS8Ll9sKQ==
X-Received: by 2002:a05:6a00:d4d:b029:307:78ef:d767 with SMTP id n13-20020a056a000d4db029030778efd767mr1115704pfv.12.1624474245873;
        Wed, 23 Jun 2021 11:50:45 -0700 (PDT)
Received: from x1 ([174.127.163.79])
        by smtp.gmail.com with ESMTPSA id s4sm309782pjn.31.2021.06.23.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:50:45 -0700 (PDT)
Date:   Wed, 23 Jun 2021 11:50:43 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Adding jh7100 SoC to defconfig
Message-ID: <20210623185043.GA493015@x1>
References: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22f6d7e-97ab-85db-5448-c2bcef0ea0e7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 09:45:52PM +0900, Akira Tsukamoto wrote:
> 
> Would like to have comments for adding jh7100 SoC to defconfig.

Thanks for preparing this defconfig.

Let's refer to the SoC as StarFive JH7100 SoC [1] which is used in the
BeagleV Starlight JH7100 board [2].

> To make the upstream friendly, try to add as minimum as possible in
> arch/riscv/configs/defconfig required for beaglev-beta against the

Please use "BeagleV Starlight JH7100" instead of beaglev-beta.

> upstream defconfig. I might have added too much configs.
> 
> Then the distro vendors could use:
> make defconfig beablev-fedora.config
> or
> make defconfig beablev-debian.config
> 
> while distro vendors keeping beablev-fedora.config and
> beablev-debian.config in their own repositories to make one binary kernel
> which boots for all riscv boards.

Note about naming, BeagleV refers to any RISC-V board produced by
BeagleBoard.org and likely in the future will include other SoC
families.

> 
> Probably, it is not good practice to add a different defconfig file under
> arch/riscv/configs/ when each new riscv board comes out.

We currently have:

  defconfig
  nommu_k210_defconfig
  nommu_k210_sdcard_defconfig
  nommu_virt_defconfig
  rv32_defconfig

It seems like 'defconfig' supports the SiFive Unleashed board which
makes sense as it was the only board for a longtime:

  $ git grep -i sifive
  defconfig:CONFIG_SOC_SIFIVE=y
  defconfig:CONFIG_SPI_SIFIVE=y
  defconfig:CONFIG_GPIO_SIFIVE=y

I suppose the kconfig options needed for BeagleV Starlight JH7100 could
be added to 'defconfig' as long as there were no incompatibilities.  I
assume the k210 versions were added because that is a rather odd SoC
that has a non-supported MMU and thus runs in m-mode.

Thanks,
Drew

[1] https://github.com/starfive-tech/beaglev_doc/
[2] https://github.com/beagleboard/beaglev-starlight
