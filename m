Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5806397105
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhFAKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhFAKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:12:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BBC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 03:11:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so20880258lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXZO1IaKj8e+HsJJD6dime89CXjE2mtKCwPbk2wFi1Y=;
        b=PAmnyLWW3xVrnfCXBt8ZAGO4Q6ntqnhqG5dYV7hJSuJcjfz46+Et8k+ZJPCM1BbZ68
         TG30+Lum7qdt+KFfaIPLppcZ+cC7Hjl/4YvZUOC3YvkrnsemTsWbKM3utq4ecrfqzGnp
         wG6rWxR1hkbQxRl4pyjns2ASVGp7qMPah2XtXfT2HgS24+nZPRxxUdxxfozIckySzQQu
         81jHqhEgQE+g2+cEl8S2lVtlysJkwMtH5p3P9U6t9vA+SxFRg/HGzbmH4lsg2Gb1HNDe
         kUapQFMJTmTP3FxH1qolW4NglYaEkjjk/P4s2j4kORb+HN77y/+xh42P06B7dxPuQ5LN
         tmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXZO1IaKj8e+HsJJD6dime89CXjE2mtKCwPbk2wFi1Y=;
        b=IiGNxSyZBahclaaacWWpcV75eouXXQlqVI9qA+KOckgTkU9G6UtNFyEUovPECeYEYG
         E1oOh9m/W/GOJP1ODJ4bbLrcOvoqQOZG7Mhow+LTsbClxZNdA60jfFBRUyKhmLpBOkBQ
         zguL6X9ufCamSGhIat+ZUl+fCZ3rVJBdnsi9v08EdfB1zEhqStMjxpUhl/7r2uM29S1B
         Bf2PaA1iYgOL5Opr25Y86gsIBe+Yun41cRql9mH//RKLsVx5f+7d218iYPuwVjcJ2KEZ
         ZiwppC3Y/u9dglQhq/A4WsBCFboab0H4XK9xEzRjN7ztw0bhF9kH/RvlzqxPHXkmPw61
         0WOw==
X-Gm-Message-State: AOAM530XywBxMvhR/KGtsF1IAzI7qAhFz1MKYw1VeFy4zj2vvUeeIN32
        DZKGhbG2nMFjy7QUjqclyXZ8iepBQaVqmUvcBEyPmA==
X-Google-Smtp-Source: ABdhPJwadJG1Z+DxbBmxKxvEQqSH6jDHpGXRXGCT9utnR1hgTl/yCZLnOQU86Xt7cd6GKg6JmptLeQ8X5upF3QJ6nq4=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr17616726lfs.157.1622542258735;
 Tue, 01 Jun 2021 03:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210325122832.119147-1-sandberg@mailfence.com>
 <20210530161333.3996-1-maukka@ext.kapsi.fi> <20210530161333.3996-2-maukka@ext.kapsi.fi>
In-Reply-To: <20210530161333.3996-2-maukka@ext.kapsi.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Jun 2021 12:10:47 +0200
Message-ID: <CACRpkdbD-AZrZrHZ0mQm09TV6mMWunmBF1sMLgaDFUHxTV+R5Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpio-mux-input: add documentation
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     Mauri Sandberg <sandberg@mailfence.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 6:16 PM Mauri Sandberg <maukka@ext.kapsi.fi> wrote:

> Add documentation for a general GPIO multiplexer.
>
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> Tested-by: Drew Fustini <drew@beagleboard.org>
> Reviewed-by: Drew Fustini <drew@beagleboard.org>

Overall very interesting!

> +  pin-gpios:
> +    description: |
> +      The GPIO pin used as the output from the multiplexer

This is not a good name. "pin" what pin? Choose a descriptive
name, like:

parent-gpios
multiplexed-gpios
cascaded-gpios
fanout-gpios

(My order of preference.)

Otherwise these bindings look good.

Yours,
Linus Walleij
