Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154AB44B3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhKIUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbhKIUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:25:26 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C7C0613F5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:22:40 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso430364otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWuZRe3vhx/rsj3gDszi/QmMzXVPXcxE0U8W784K8CQ=;
        b=DeCDZjnQdNNhZ03hlUnVSgyeAzHG1iPg9MysXicWXq+iOJakaMQOGe/MJWUn3OMl6f
         dOxXSV6NxsEWwHeWX1yqjoPzw/+HpIbt4rbqavjV0MG5IkpPv4T3qSD3Jxt9Ci+iCllD
         2yv1RvveYsRMCZPfiSlv/lmiTh3veXnun+9101ww+5olB7WVn45JSQQBJ3QUJfzHqiBp
         5UxwlWZv1Wakz1VUr1/vIqdTR8Vde99nq4F9gzNbkP56FrtjeoMvAMpL4yl7iZCsmD08
         3qxjjjbENxAeNNPkOrrLnSOtO/oYlpGoQ2E7o844Wf2ME3gWML5MKz/WMMKAF4aEOtdr
         B1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWuZRe3vhx/rsj3gDszi/QmMzXVPXcxE0U8W784K8CQ=;
        b=NyrrUTk6rhAKgKpKhWvQTLr4l07Cb0A60dm7M36HmmJITiD7R9C9+R3xoiWK3yyLkW
         YdtoQiTc1AMFaDac+Tzrg7G55zqgMl999i5bfS4jDVbw8Vz0UtaymDMjG0KR1MNwX2tw
         3Wf5Kc+5uMiSRmIT4AoNgZXiShF3/yjj+FzHKMYJ+DIPpV5JWqAv/PbqcI5D/IPO6UU4
         Sll7aU01Eo6T3TH7LN4cDKH/gwtIY/lEGtnYUsjG3Xgnx5KC0pywSQOGOQ0qNMC0ssSW
         9zonXpPu3ARXawXIQxJvlsVxWQoh0sgBTLKj1WBejpFBJYUc88pklrCso8j4ggeLipZ+
         5rhA==
X-Gm-Message-State: AOAM530bRWfG1Nx3Tbl8Z0k5kGhcQ98lRRt+zsiKCLMw5jVDwRBV1U28
        7ysClxpKSR7eYXH7NCaecqTxqQJgGK1OUpUI4zbfeg==
X-Google-Smtp-Source: ABdhPJxpfFTf/2zksxtqSl9+nWqbnRdYGeqbmbAHc7zwysbZWdRoq+wqw9o01iCe/WvDTX2oANbaqbljxIiWaI8p2gw=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr8122963otj.35.1636489359421;
 Tue, 09 Nov 2021 12:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20211027134509.5036-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211027134509.5036-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACRpkdbY7QtjACCu63k+=Mn-XeLN3+fOjmKYR0w2NbhEZYGbeQ@mail.gmail.com> <CAMuHMdWcx3E-pc9MDMjE08kFHQ=LAr2kHP8Xitu0YfkPP3QNAA@mail.gmail.com>
In-Reply-To: <CAMuHMdWcx3E-pc9MDMjE08kFHQ=LAr2kHP8Xitu0YfkPP3QNAA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 21:22:27 +0100
Message-ID: <CACRpkdakC-PsDpg3w8uEo33zDX-aQbESMx1BsknFCaboMct2qQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pinctrl: pinconf-generic: Add support for
 "output-impedance-ohms" to be extracted from DT files
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 8:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > I suppose Geert will queue this patch with the rest of the Renesas stuff?
>
> Yes, that's the plan.
> Unless you have another user in mind that cannot wait until I will
> have sent a PR for v5.17?

Nope, take it easy and queue it with your stuff.

Yours,
Linus Walleij
