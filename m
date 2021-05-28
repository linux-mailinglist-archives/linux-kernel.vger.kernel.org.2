Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F23943A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhE1N5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhE1N5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:57:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB71CC061574;
        Fri, 28 May 2021 06:56:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so5363415ljr.7;
        Fri, 28 May 2021 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bu3MQ6DgF0fcfplCjXBBOAim/Uo1qYJNmd9RnH8e+ks=;
        b=tVF+0kOaRRXhQna7qmOYKGJIdz3n8LS488iOoSBLmTiEfRpf0rxZ5GDdWAw97Amj5b
         N6XUEXQog0DDfJyMoez4vePANL3E893LsEQIfNfeCneI+hjM0GLI5KoM9FMFwl+INMUq
         MTFMoDr6e1gx6swr8vrpKxdhFH9oGaoPLVcBcyC7x/z7GPtnKfgfRfOv0zzdfNHADg+m
         N4IeDRSwBbtS1/iHe+GOa+/hkpWBrPdWGSrLQSONcRFNs2/TeQBK6KolPn1RWeIq+PX9
         DNu4KSv4smF14u2ueH1JT1pUfTKQRjMtclV9aY1dCqPNXAdhZ3Fqv/Dp5MkJW4/ZlL4n
         vQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bu3MQ6DgF0fcfplCjXBBOAim/Uo1qYJNmd9RnH8e+ks=;
        b=jTc9qa1W7sLJJKcGfMJeOipe/v9zlLi3aTHVgkcEiQsL+1GQh6n4PUL5lUicWiozay
         swwQNfFWzJ9W+x+KDo6FZnKc7Y+F+NedVemqG4GPXJnVrOcMxKWv8WbvvIaUOiRqnM8X
         3AK20CeUUS6aqpXDqBGk2IcE1gC1qsGQwbWyZUFqRuGPCne2dEqAWfz5i+9m/Unwr2FL
         qNWX+DhQzNbNinCnqe2c9RtgTfzxyl51xseUJ3OpxKZbVdVCojuIXs759kPhSqDtRJ5Q
         MgRep0IsHimr/8bcx+FRA5ERv8nRMzFJJuqmBEN4lWNv/KHJ24b+cOy+tj5Ki+HiO1mo
         DRRw==
X-Gm-Message-State: AOAM53192MBFx65Wq6HtLz6TqkpK0NZbxglbtTOJU20zrx7xOPpiUeTH
        pZrEyQpc6bbp1zsLfUxYvh9H3N40rTRVdjAeDSpTDusxWAM=
X-Google-Smtp-Source: ABdhPJzdoAyrq+MXYaDETTn9Y5LvOV5jUsKpvHXTLV4U6vofzDvdswL5xJxnJoQQIYuEWUXo8MoedyvPApORUmIN3Rg=
X-Received: by 2002:a2e:824c:: with SMTP id j12mr6650994ljh.490.1622210163006;
 Fri, 28 May 2021 06:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210528072351.1639575-1-hs@denx.de> <20210528072351.1639575-3-hs@denx.de>
In-Reply-To: <20210528072351.1639575-3-hs@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 28 May 2021 10:55:51 -0300
Message-ID: <CAOMZO5Cq6BT_46tKGWMoLUvaHEzD-mbEF56S0TzWpQXtXRsVmQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mtd: devices: add support for microchip 48l640 EERAM
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, May 28, 2021 at 4:26 AM Heiko Schocher <hs@denx.de> wrote:
>
> The Microchip 48l640 is a 8KByte EERAM connected via SPI.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> I tried to use drivers/mtd/devices/mchp23k256.c but this
> driver does not use any status register and there seems
> slight differences in registers (no write enable register
> for example), so I decided to make a new driver.
>
> This driver sets the continuous mode bit in Status register,
> which states you can write continuous ... but after writting
> 32 bytes the chip goes into an undefined state, so driver now
> writes data in 32 byte chunks.
>
> I also tried to use regmap, but it leads in a lot of more code,
> and as this chip has only spi interface it makes no sense, or?
>
> Tested  this driver on board imx8mp-phyboard-pollux-rdk
> board, which is already in mainline.
>
> Made some tbot tests, which write at random offset random
> length bytes with dd and and random content. Reread the data
> after a reboot and compare with the written data. Works fine.

Works for me too on an imx7d based board, thanks:

Tested-by: Fabio Estevam <festevam@denx.de>
