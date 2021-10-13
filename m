Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7D42BE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhJMLEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhJMLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:04:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF520C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 04:02:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so9954500lfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73KxlkdlyI8mXLBvQp61F7Ysreyok1FWDPua3YonDqI=;
        b=dzUOvMFCFHvCPLA4d4o9RjHZKAsUW8CJ8oRvQYf4LqDiIG7OE6g1KuPgql1kadB3aC
         XzGQ7f+HgP4YIjgcC++iLXXfad+FBeSMLBstC6LODUf/X8gOn/lKxj5odAm1aUlXVwsn
         ISQaOFgM6/zv79n2vyS2H4dFk0UrDDDhStQkeMKKM3GRg5N7QEYtl8UYDerp8QxdegiB
         ATkstm1/7JjmiFB2ZbcpE2NFFe/5mAjWG8z+VH4130qfhXz3HljINzyBbeseSe3eECK9
         7e/7Ix2eDLLhCfJy7sub3EBFnXZkBY/5uQ442QjVMeD6cic7lyr+lh/HGHKbjFGWajkk
         q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73KxlkdlyI8mXLBvQp61F7Ysreyok1FWDPua3YonDqI=;
        b=ndVDR3gAdAytlQgqX41G/YLfHrdzDEJTfacMwUoBXj5b3foh+eTlNfto62bkwJNDuo
         TICB09se7xcL9Jt4bA2J1Zw0YDzh2bf9z+snQfQoR9+UX6uKb00/U1F5qCHzDDD32ujB
         j06hal8+EAUbzBHdmGmU+h1Jc7ViTxbX6BcrgRMyzD+sMDBFfybfJ5pjXLpaSiN+wCl9
         SKMHZ6THFPWGJ1dCywPNHT5pjkSBo4NByEdFi8zY8e9xcQZtsvoDXsUlzdNDyvBRJ9Xy
         DL47X3eheRlXkKBl8nS1+exNcLRd7FK/qxMJ6B693JNPQYnKrIa6M1DLyfSFg02Z72qC
         zcbQ==
X-Gm-Message-State: AOAM531z5QnWCnfRTXHRtIqU8JTU+sWkizSqfrZldbp3kro8zteA+Pvu
        6mif8EUNXOxeu2eRn9elIgrJ9wwRcfEEOvibD10pOA==
X-Google-Smtp-Source: ABdhPJz2gpDUS4W8/df8P/ssMlsByhqzpK4UIzTghVzZx58NQPyhf6+NIw+RgxaAWRM1G+lZLH7/RTstEmgTzE39ngk=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr5578922ljb.145.1634122933990;
 Wed, 13 Oct 2021 04:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211012123557.3547280-1-alvin@pqrs.dk> <20211012123557.3547280-5-alvin@pqrs.dk>
In-Reply-To: <20211012123557.3547280-5-alvin@pqrs.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 13:02:02 +0200
Message-ID: <CACRpkdby5Z9yzUFo4_cXtXb-bz6gF60Rt52naqu5yWBM0bC7bw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] net: dsa: tag_rtl8_4: add realtek 8 byte
 protocol 4 tag
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 2:37 PM Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> This commit implements a basic version of the 8 byte tag protocol used
> in the Realtek RTL8365MB-VC unmanaged switch, which carries with it a
> protocol version of 0x04.
>
> The implementation itself only handles the parsing of the EtherType
> value and Realtek protocol version, together with the source or
> destination port fields. The rest is left unimplemented for now.
>
> The tag format is described in a confidential document provided to my
> company by Realtek Semiconductor Corp. Permission has been granted by
> the vendor to publish this driver based on that material, together with
> an extract from the document describing the tag format and its fields.
> It is hoped that this will help future implementors who do not have
> access to the material but who wish to extend the functionality of
> drivers for chips which use this protocol.
>
> In addition, two possible values of the REASON field are specified,
> based on experiments on my end. Realtek does not specify what value this
> field can take.
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

The code definately looks good:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Some nitpicky personal preferences below:

> +#define RTL8_4_TAG_LEN                 8
> +/* 0x04 =3D RTL8365MB DSA protocol
> + */
> +#define RTL8_4_PROTOCOL_RTL8365MB      0x04

This is #defined

> +       /* Zero FID_EN, FID, PRI_EN, PRI, KEEP; set LEARN_DIS */
> +       tag[2] =3D htons(1 << 5);

I would create defines for the flags like this:
#define RTL8365MB_LEARN_DIS BIT(5)

> +       /* Parse Protocol */
> +       proto =3D ntohs(tag[1]) >> 8;

In the 4byte header code we have something like this:
#define RTL8_4_PROTOCOL_SHIFT 8

> +       /* Parse TX (switch->CPU) */
> +       port =3D ntohs(tag[3]) & 0xf; /* Port number is the LSB 4 bits */

This I think is fair enough. No need to define that mask.

Yours,
Linus Walleij
