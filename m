Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3646142B0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhJMAJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhJMAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:09:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB4C061762
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:07:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so2798023edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTWVNyhczFZinoqJ7kSsMVLCZQV46DfROw4WieDRZL0=;
        b=C+jvuEDHNozuwvDiFT13ZmF9FghO3sCvBMryHwNXqttukFXiOG06ppcJDCCdy2wy28
         U4TOfYlWTXHe98gqEq0f6rRVzif90/rYm8im8hRz3gNOQl+bNY2iajHWjfT4hNv1d8bR
         tpUxFTkQRV47ixP9oqsoDTAmDQElWjtG9MZmMDO0i7G1eMN0M6tbWTdjmbaf/onh8giS
         G0+SKvTrCgFy4TqDzhUus3OtVPOAqwyv685wrg4KXAV0wkzncdTdM/t+IXzMoyDg+5gX
         DLtehrTWmwIDI/lDQE9jLq5AcRb/l+NEUbBXgNPTDds5VzfpySah0PPF/NHmyj9yjYby
         j5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTWVNyhczFZinoqJ7kSsMVLCZQV46DfROw4WieDRZL0=;
        b=j63YrfnsVsTI+nwjDGdEV3qnV0Obbmv2lmjExuNFH3vcDyQBGXHFVOOAAIZjDI0wUw
         6ZLe2aFZ/3SWOSzzLN0bLG35j2owasLtoiTwSogR4BL0ZXRQAcwkMIjcfDejVTrBjG3z
         h8A+8ff/8H1alzVIFdLXGdx10J3KjNJnpdW3dBiyZfw9esgqbAwe7Wu7ST2NU7QHjk/k
         nkhE5NknxZmBEfOIXhtR0oBPMlT/Q+rFTh9FuaBlgRcoMj68vSxRnaXTHOjeAl+ffdrU
         kbxqK0CPyMUmdjTAJtUrqyJbpSG2C/EBwsRR14SjuukN64KTpV8A7YJJzTmo9r3zTzE6
         ZSlQ==
X-Gm-Message-State: AOAM532QeqPuwS1v2r2ktyGcvJ8LQIWGu4o5JrsYqJfLhWLNea5llJYg
        VFV4Ln99oSg0sfQe/A613jdZdhLn3MRLhcspntJmRQ==
X-Google-Smtp-Source: ABdhPJyfDYLRR6F/3juZtl20H7qFZacVtgfDH8pJMmKfRymkv5U3UjEddwOHxHDtXbJ0Au3F1L7uA8SrwAQMX+APApE=
X-Received: by 2002:a05:6402:278a:: with SMTP id b10mr4463346ede.134.1634083640074;
 Tue, 12 Oct 2021 17:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210921193028.13099-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210921193028.13099-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACRpkdaJk-G0YE63uvH9C=G3n7k2gZqf9QrwGfAZC2O4hhps=A@mail.gmail.com> <CAMuHMdUvThtOKrhTqW+U1qijW7dRc6GYg4_Owt_GnUxX4DrGog@mail.gmail.com>
In-Reply-To: <CAMuHMdUvThtOKrhTqW+U1qijW7dRc6GYg4_Owt_GnUxX4DrGog@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 02:07:09 +0200
Message-ID: <CACRpkdaTWb4-m=9UzQUwQyUhT3PQ3YWreG+KNnhLdXGGmJLrBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] pinctrl: renesas: pinctrl-rzg2l: Add IRQ
 domain to handle GPIO interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 11:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > Why can't you just use the hierarchical IRQ domain handling inside
> > gpiolib?
>
> Out of interest (not related to this patch), does this support multiple
> parent domains?

Not currently, but I might have seen a patch adding it?
Now I can't find it...

Yours,
Linus Walleij
