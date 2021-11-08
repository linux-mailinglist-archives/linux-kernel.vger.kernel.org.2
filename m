Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEA449DAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhKHVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbhKHVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:13:15 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550BC061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 13:10:30 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w15so18431200ill.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vw347pPZakjnhQXz4AE2AtikP+kiHbH2rXzNzfiKQ7A=;
        b=eCItfBmVWYdWOs2akM5kq641YDR9/1Vjyetzol7GT5AOf7/JTmE/RFV9WsJfzAe/aK
         Y7Q0JHUafp3hMBzt47lUD/UN2j9pchGz+xPsIa91o/kQt6JtzCQSWJdFC+kfyN2Mx3Kg
         x6BOUKXOURAUvqcmB+HAnxj1u4x0pA3k9bA6/QiKEJlUBENwpuhUz8S+h3AmYCevYTDy
         oGebrInjdUC92zyTSYTs/pe6ojS4uvwIW1J7CDan6S0/qB2hbkbVxunxBxez/5PeKHLh
         ERIh0y5Zs1jtZZJD4z1TCo9VXGKpAZdLClXEgsTj/mA17O2CtSptlE57xufHrlf1QR0Y
         PETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vw347pPZakjnhQXz4AE2AtikP+kiHbH2rXzNzfiKQ7A=;
        b=otVBLBE+ts7qmlN5wD+pSfS5DoYq1Rux6XwO/McpVgtpG3jqH/xgcQ5uAbRwsplT8S
         yEFcq/4xuuVd//N6ZutwP425qVQxe+gdw6zMQEsC/CP8Ot3i+wRXnpw4dNYSlB5vxTZA
         Dhy19k2jrdgr33Vbw877Vz6c9NwIv/g/DI21ppVpRCIKw4JzLy63HIbstuMDgH3/2LqJ
         3jnHtnnvuG/Ji+xn75yQ8F6gHd65kEYH/ZwMQGXhzJLOk6rI9gMc/OJtnBLHafK9ON0Q
         UvqJM7k/GOVh/PylpbUxF3MyP6MtLWJCtqyq1bMBoJXrQ2x33/PXA4Hiuick069kPkGr
         KB4A==
X-Gm-Message-State: AOAM530cU77uAukJ3Amr2BV3ERDkjeWR9YJG0s0by1+JaL/lm/jZ39rY
        7sN4Srt85hG8X2Th4s4aH1YD10nGOC6jMSVc87aaKA==
X-Google-Smtp-Source: ABdhPJzXz7qfwBqjD6zXy+T6KTQGePvSQoIAMa9Gd7l4M1WPLjiorJVm1ve22BwZwWF+eab+K8LrSncOebkpbRe8emM=
X-Received: by 2002:a05:6e02:1a85:: with SMTP id k5mr1549393ilv.27.1636405830231;
 Mon, 08 Nov 2021 13:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20211104124927.364683-1-robert.marko@sartura.hr> <20211108202058.th7vjq4sjca3encz@skbuf>
In-Reply-To: <20211108202058.th7vjq4sjca3encz@skbuf>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 8 Nov 2021 22:10:19 +0100
Message-ID: <CA+HBbNE_jh_h9bx9GLfMRFz_Kq=Vx1pu0dE1aK0guMoEkX1S5A@mail.gmail.com>
Subject: Re: [net-next] net: dsa: qca8k: only change the MIB_EN bit in
 MODULE_EN register
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, vivien.didelot@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gabor Juhos <j4g8y7@gmail.com>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 9:21 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Timed out waiting for ACK/NACK from John.
>
> On Thu, Nov 04, 2021 at 01:49:27PM +0100, Robert Marko wrote:
> > From: Gabor Juhos <j4g8y7@gmail.com>
> >
> > The MIB module needs to be enabled in the MODULE_EN register in
> > order to make it to counting. This is done in the qca8k_mib_init()
> > function. However instead of only changing the MIB module enable
> > bit, the function writes the whole register. As a side effect other
> > internal modules gets disabled.
>
> Please be more specific.
> The MODULE_EN register contains these other bits:
> BIT(0): MIB_EN
> BIT(1): ACL_EN (ACL module enable)
> BIT(2): L3_EN (Layer 3 offload enable)
> BIT(10): SPECIAL_DIP_EN (Enable special DIP (224.0.0.x or ff02::1) broadcast
> 0 = Use multicast DP
> 1 = Use broadcast DP)
>
> >
> > Fix up the code to only change the MIB module specific bit.
>
> Clearing which one of the above bits bothers you? The driver for the
> qca8k switch supports neither layer 3 offloading nor ACLs, and I don't
> really know what this special DIP packet/header is).
>
> Generally the assumption for OF-based drivers is that one should not
> rely on any configuration done by prior boot stages, so please explain
> what should have worked but doesn't.

Hi,
I think that the commit message wasn't clear enough and that's my fault for not
fixing it up before sending.
MODULE_EN register has 3 more bits that aren't documented in the QCA8337
datasheet but only in the IPQ4019 one but they are there.
Those are:
BIT(31) S17C_INT (This one is IPQ4019 specific)
BIT(9) LOOKUP_ERR_RST_EN
BIT(10) QM_ERR_RST_EN
Lookup and QM bits as well as the DIP default to 1 while the INT bit is 0.

Clearing the QM and Lookup bits is what is bothering me, why should we clear HW
default bits without mentioning that they are being cleared and for what reason?

We aren't depending on the bootloader or whatever configuring the switch, we are
even invoking the HW reset before doing anything to make sure that the
whole networking
subsystem in IPQ4019 is back to HW defaults to get rid of various
bootloader hackery.

Gabor found this while working on IPQ4019 support and to him and to me it looks
like a bug.

I hope this clears up things a bit.
Regards,
Robert
>
> >
> > Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")
> > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/net/dsa/qca8k.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
> > index a984f06f6f04..a229776924f8 100644
> > --- a/drivers/net/dsa/qca8k.c
> > +++ b/drivers/net/dsa/qca8k.c
> > @@ -583,7 +583,7 @@ qca8k_mib_init(struct qca8k_priv *priv)
> >       if (ret)
> >               goto exit;
> >
> > -     ret = qca8k_write(priv, QCA8K_REG_MODULE_EN, QCA8K_MODULE_EN_MIB);
> > +     ret = qca8k_reg_set(priv, QCA8K_REG_MODULE_EN, QCA8K_MODULE_EN_MIB);
> >
> >  exit:
> >       mutex_unlock(&priv->reg_mutex);
> > --
> > 2.33.1
> >



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
