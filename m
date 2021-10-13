Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA8E42C8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhJMShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbhJMShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:37:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F88C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:35:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n8so15786201lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rDZnrWeGoRepjCpc3OfdE7YBAKz9l8dGQzHDHMy8dnQ=;
        b=oSzrrLlxsTaGxHPrpBBYUO/5vjshvULo7erMOdXFwdQT+zjQQthv7fbm5CKDFlstZz
         d1u7g7byscGhtUM0UI2KJ7BQgB35rSea/uDhwxbQowcyDN+yTwYCUFaji+pbVBgpfNMW
         yN1Qb74Tgew1fpYUM4NfBccjKTeioOd48UuKrkkeCrm58GJYb5f4Xb6eeGRddnOxtrlm
         QHOdoKajbgqCa1a68KCnvqgCl1OEVjurDd9aafe6MCe5nmSB7HHKNNN43e8PfU16g43C
         6Lh6BkN0wxX9xLKpF2RDTyyNyFMc9GHigBdRyc4IjxQbht0Vi9CSP1XQE7CPU0JfILfa
         Bsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rDZnrWeGoRepjCpc3OfdE7YBAKz9l8dGQzHDHMy8dnQ=;
        b=bISpqXqUo8OXEO7JxuEsCQ0WfRS+CI5LBoDbURRmQrpxrAltT8fE7VVqTqtOLWP7fR
         QoGEw1P9J9YqLyFwwUcHkoVBrTdzoHg74uFiG4AJX1vkWjjZ5ICaA1WevHtpA9S2vd3r
         UPLPcWxyTx/+jz1X/D6cOqiE4lS7WjdQsYoemUHRxWEfga6oDXUdZhP3n89EtUDKLAEx
         9ptgoYo8H/QyIKgua5iym5Tevm7OdX22aACIIpDQshgzUHBTm84B8bTtlQM/ffIJ/JQs
         tkQO13iNKXyPr+nBMDoLNq5g3N3Pr93lQlOGTelipd1Fk6gEzxorsd+2/IEKqDHRiAdO
         /wJg==
X-Gm-Message-State: AOAM533uuuBNEy4AhtcC6UXK3PQXE2o3Ep+CQtKYj0nyboub5WCA1dkm
        Pb0j5n+Dwid0P0Fo+ib7xK8vZnFvrZxeEiJQEw5hqg==
X-Google-Smtp-Source: ABdhPJzAgS8wHJY6I62EzOdlpG6Sg72jMybOxEQEvOVXJ89i5iNti04/Bk0r5R9a/na9HoO2A9r4MW+N1hLwSjz2nN8=
X-Received: by 2002:a05:6512:1103:: with SMTP id l3mr611705lfg.550.1634150135927;
 Wed, 13 Oct 2021 11:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210927123830.1278953-1-arnd@kernel.org>
In-Reply-To: <20210927123830.1278953-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Oct 2021 11:35:24 -0700
Message-ID: <CAKwvOd=rFUfuTgK14y__3OQdgwzBCLp+ZVUUqsXfOmSCe1M8Mg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] usb: gadget: avoid unusual inline assembly
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 5:38 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang does not understand the "mrc%?" syntax:
>
> drivers/usb/gadget/udc/pxa25x_udc.c:2330:11: error: invalid % escape in i=
nline assembly string
>
> I don't understand it either, but removing the %? here gets it to build.
> This is probably wrong and someone else should do a proper patch.
>
> Any suggestions?

https://gcc.gnu.org/onlinedocs/gccint/Output-Template.html says:
>> =E2=80=98%=E2=80=99 followed by a punctuation character specifies a subs=
titution that does not use an operand. Only one case is standard: =E2=80=98=
%%=E2=80=99 outputs a =E2=80=98%=E2=80=99 into the assembler code.

I don't think the intention was to have `mrc?` in the emitted
assembler (is that even valid?), so it's not clear to me what this
point of `%?` was. Patch LGTM.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/udc/pxa25x_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc=
/pxa25x_udc.c
> index a09ec1d826b2..52cdfd8212d6 100644
> --- a/drivers/usb/gadget/udc/pxa25x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa25x_udc.c
> @@ -2325,7 +2325,7 @@ static int pxa25x_udc_probe(struct platform_device =
*pdev)
>         pr_info("%s: version %s\n", driver_name, DRIVER_VERSION);
>
>         /* insist on Intel/ARM/XScale */
> -       asm("mrc%? p15, 0, %0, c0, c0" : "=3Dr" (chiprev));
> +       asm("mrc p15, 0, %0, c0, c0" : "=3Dr" (chiprev));
>         if ((chiprev & CP15R0_VENDOR_MASK) !=3D CP15R0_XSCALE_VALUE) {
>                 pr_err("%s: not XScale!\n", driver_name);
>                 return -ENODEV;
> --
> 2.29.2
>


--=20
Thanks,
~Nick Desaulniers
