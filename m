Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED12346869
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhCWTDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhCWTDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:03:30 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:03:29 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h1so19124101ilr.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YWYa+TcfGVaCwF0IqKQL2bqvSxPHonlkY8ibD7lEQyg=;
        b=duHVlhzccYoLjMr9b99zB0s377S814D7H1nZ1dbRhtnRuM+NAopcpLYfh6BDcGZHlJ
         fgwxiymAieVu5gN5Xthx70hY/rjBD5SsXMb9pLk82jp+bcPk0XAWjNY7Gk9kga9rXePH
         MZGNw9Cx2+oBU/foElcdbKPe+iIZssr/tLLZK70zNDZ4HVZViNe+DHkrBVNVE1vmWPUb
         /dmScktILUVe4tDDXBo4v78CeRMx/w8YkyBuwlXcpEYxMTinkmJbjYVG2gqfT9SWFHBR
         uNWVUAIG4R7wbmP49jCRNhpUGduYI7cg71tK1qGi6g3xa+7zafvS+zsi0oxbhFfDzFie
         lAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YWYa+TcfGVaCwF0IqKQL2bqvSxPHonlkY8ibD7lEQyg=;
        b=U5bCBTJZL+xpT/NnWqHYonFe6LzaODwnFxbVbDg3GJCzj0uXl9alkNJ1SzY/XBulvJ
         TGb1oRkWi8M0XAJt9YbbZYtMP4fYPR71ySOlmoRT1FwDZHFJ6+AB5YO1KpOPGcehukeM
         tmjIDHkTlxbYhfLHUuOdWvPg9i1hzlSPntCWaoIjQPwUhenQhDZXMGcnMzfAB0hK54ks
         EewjLS1ihRpECewZjhQYrci8FLhh6pdM1EGBVic8DXUxq33VBSLrDkHWnodVoYjQPeH9
         fXxB3Wf+OpDk//25WwnVP4zV/x3rINH/KZ24DnhCee9RxE+bNq2/4uGAAuPrqt/atfw8
         qhvQ==
X-Gm-Message-State: AOAM530CPmp3Vms1GAXcyc0fyQJSZT2EnRg5Ug4o8X1si4INNREJDJoN
        uX3SdYMleLZFRO0+6ImnRpQUzePsDLC+kZJ0UaU=
X-Google-Smtp-Source: ABdhPJy+eqhOJWib5PnATu7JhGRPXkoyrDHjgz3a04JaXyZAipLcS5x46GFZ5K3QeBj+ILjyxwN+ezZMBqO6AfqzdGw=
X-Received: by 2002:a92:c5d4:: with SMTP id s20mr5673781ilt.225.1616526209395;
 Tue, 23 Mar 2021 12:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210323143144.12730-1-michael@walle.cc> <20210323143144.12730-2-michael@walle.cc>
 <20210323173715.gyozhzbjyfv5osuc@ti.com> <C88FBBF6-4F5C-43A1-951E-332AEE9E3B3A@walle.cc>
In-Reply-To: <C88FBBF6-4F5C-43A1-951E-332AEE9E3B3A@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 23 Mar 2021 20:03:18 +0100
Message-ID: <CAEyMn7bt6iYVBUOoJGs1a2VA-AWf7AyCJ0MJXN9NzQsOuVaQqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
To:     Michael Walle <michael@walle.cc>
Cc:     Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Di., 23. M=C3=A4rz 2021 um 19:45 Uhr schrieb Michael Walle <michael@wall=
e.cc>:
>
> Am 23. M=C3=A4rz 2021 18:37:17 MEZ schrieb Pratyush Yadav <p.yadav@ti.com=
>:
> >On 23/03/21 03:31PM, Michael Walle wrote:
> >> Due to possible mode switching to 8D-8D-8D, it might not be possible
> >to
> >> read the SFDP after the initial probe. To be able to dump the SFDP
> >via
> >> sysfs afterwards, make a complete copy of it.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >
> >Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

>
> thanks for reviewing!
>
> -michael
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
