Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F41930781A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhA1Obm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhA1Obc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:31:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:30:51 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so8048444ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pA0soYrYS1TQkScfo2XAckkNCMRnRnhqZW0XyLUH1Bw=;
        b=OGfEBuAL7zaR0yEQiFhG5C4OBcSm5DZXUjiE1Z/VdodAxQtlWWulYnsNb19ALHSdb2
         o9sdeGU31ITxdAMLzT5NIaKYIWBtWgpNsHFaSc5csKqaUROC6yMDvQpwCUcpT4HiXWuS
         MAadG3y/O1I7Wd+cV9suvOzkt3wWW36LjDyMSuy+Y88QegJ+U8paB3vzB3Zm9m7rw4Vj
         xgDXEhhWoppUKnuTOZaLfcBbWladzjOxpIWdQuUbf/fdYqvyrrLzHUC9urZgLiRhnbvq
         6UQYhKm2h8VED6V3YdAAO5tfVk2roaRaxvAB1zbiY4fmmYaSh/AmZbZCenQfSOmmKw0Z
         tObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pA0soYrYS1TQkScfo2XAckkNCMRnRnhqZW0XyLUH1Bw=;
        b=llS3pM+Q/77oMg9kml3YYNezkL3Hl6ULnbts3bHdObBIgIOzj1cyuXUNxEn4scHCt9
         ieFL6VHZC19BpXpjgRrEBtNo3J1bXsDeqWQLVCz+pxGPwxmjy/6UAOxQUcVIxVXWxGVD
         X4nNoJHKASKTIwhAt6vSFjL2kCueO0kHXv9kIhrULCMRogcPsATvwYMAHjzUJWIeZRdn
         9Ta1t8trj4/xI51E1dBj1Kb0pLmU1RlYxf3d7WEDMFHRN8jNw9a7acEK51qAbdOoXe0J
         BeYoAclsbe8fMbGqBxwYwjfE8z63rLPpaeHJQIsBQN8y1PzDmlymOef1kuMIN0IsJShB
         t6+A==
X-Gm-Message-State: AOAM5323MoghahLICNksiehK10i6oezVz4PfwS7plnvxthT+tG+eUkWx
        ZOOOAj7ljh5TcNFN7sxaKnKBIRuIJB14CaGpQ5c=
X-Google-Smtp-Source: ABdhPJy5xNhVej00+j1zUrQ9aan55waK3RTWYA0a4fltbgbcvHyz7cUUpGTql59w1Hp2fCB2J9D3p2lZPfSr87z/7S8=
X-Received: by 2002:a17:906:c1c1:: with SMTP id bw1mr11695569ejb.86.1611844250535;
 Thu, 28 Jan 2021 06:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20210128120151.554411-1-axel.lin@ingics.com>
In-Reply-To: <20210128120151.554411-1-axel.lin@ingics.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 28 Jan 2021 15:30:39 +0100
Message-ID: <CABkfQAEK3+54-=YWW34HBf0QUpv_DuREZfvXpPGtyXB+v72y2A@mail.gmail.com>
Subject: Re: [PATCH] regulator: pf8x00: Fix typo for PF8200 chip name
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 28 janv. 2021 =C3=A0 13:02, Axel Lin <axel.lin@ingics.com> a =C3=A9=
crit :
>
> Trivial typo fix.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/pf8x00-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8=
x00-regulator.c
> index 827da25466cc..9b28bd63208d 100644
> --- a/drivers/regulator/pf8x00-regulator.c
> +++ b/drivers/regulator/pf8x00-regulator.c
> @@ -529,7 +529,7 @@ static int pf8x00_identify(struct pf8x00_chip *chip)
>                 name =3D "PF8121A";
>                 break;
>         case PF8200:
> -               name =3D "PF8100";
> +               name =3D "PF8200";
>                 break;
>         default:
>                 dev_err(chip->dev, "Unknown pf8x00 device id 0x%x\n", dev=
_id);
> --
> 2.25.1
>

Reviewed-by: Adrien Grassein <adrien.grassein@gmail.com>
