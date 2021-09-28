Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266B41B910
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhI1VNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1VNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:13:04 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116BC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:11:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so153513otb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbWbdXoE6xizT93Ir1J+j8iVAb59AF1M9auCdjMcU/k=;
        b=Gvk4k0KCH+SlNhOJ0Stmp1mxeWcf6ruIlB+ap3tB4f01wMLb27p05OE3EuTY7jaeq7
         W6Dn5uSacPdSwrpM7NFs9L/MtpzPkRCdho4h8fGY1t3Hgayqan7w4QBHqWemtNbjSx4U
         uK/0Yr2FIYVjmkyTGuDL8sUJ0HacDzIfozl2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbWbdXoE6xizT93Ir1J+j8iVAb59AF1M9auCdjMcU/k=;
        b=sasq6jcXXccQyrbsDsgnFp78r3scFOGrkjKnOXHKfU+FgPK57GVwi3dVFnAsDLGte9
         Ya7lqUtFYHy3KlxZ+3o8u9etmPZ0+Iuf880ttw+sSlZUOM6tvE3tezMetPdZdvTpzjXS
         tN05h+OD5RJtNUnv8hYe0+QF0LLLHB8pI2xWFiFckYjBliLppQOh5VNG/pAiOtYm4QgH
         lx6iJiwKfNoi9mdO8ltRNHo4VeCWkpj+zgeoBs5MuodOO/2uDYL7IMQ6a1yHnFOIj8+J
         PYKWo3QotsMl4H4N4iVOwIpH3ZDYI2GxT0EXOEzYhAUgLiJkXcQRk/g+J+BaXSD3JPEt
         Bxcw==
X-Gm-Message-State: AOAM53166bBABgbdJC5Kk3vulF4o0EdNiZIARDxPs2WuISWNVGS+w+b+
        kakbNmfSXfGJX1ZoDTSV+T4CLI2QuzuEIA==
X-Google-Smtp-Source: ABdhPJxo0y3KbNvtfavCJHhnJnusE/2GqXiqJqagiRfEqHCbUM+snH3AXOFq757f7pyPsVV+5igK9w==
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr6734371ote.159.1632863483489;
        Tue, 28 Sep 2021 14:11:23 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id d7sm53979otl.19.2021.09.28.14.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 14:11:22 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id n4-20020a4aa7c4000000b002adb4997965so68966oom.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:11:21 -0700 (PDT)
X-Received: by 2002:a4a:c292:: with SMTP id b18mr6742668ooq.64.1632863481392;
 Tue, 28 Sep 2021 14:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210927175944.3381314-1-briannorris@chromium.org>
 <20210927105928.v2.3.I8bb7a91ecc411d56bc155763faa15f289d7fc074@changeid> <CAGXv+5GxCHJM_CewS8dPTLc7NPC6jcKZvrUFat0nemzZpu8PUQ@mail.gmail.com>
In-Reply-To: <CAGXv+5GxCHJM_CewS8dPTLc7NPC6jcKZvrUFat0nemzZpu8PUQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 28 Sep 2021 14:11:10 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO_hHa2fmkNuitxp=r2nBk4-gdZHk9PrHPbmMhLye9w_g@mail.gmail.com>
Message-ID: <CA+ASDXO_hHa2fmkNuitxp=r2nBk4-gdZHk9PrHPbmMhLye9w_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: dsi: Disable PLL clock on bind error
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Thomas Hebb <tommyhebb@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 9:16 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Tue, Sep 28, 2021 at 2:00 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Fix some error handling here noticed in review of other changes.
> >
> > Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>
> Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi
> bridge driver")
>
> Otherwise,
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

I'll add these tags, thanks.

> Additionally, I would move patch 2 and this patch before the first patch,
> as these two fix a commit introduced in v5.0, while the first patch fixes
> something introduced in v5.14. This would make automatic backporting cleaner.

Personally, I prioritize putting user-visible fixes first, and more
cosmetic things (like error handling that we ~never hit) later. Also,
the buggy commit was already backported to all still-supported stable
releases where it was relevant (i.e., 5.4+), so if these get
backported, they all should.

Regards,
Brian

[1] 43c2de1002d2 drm/rockchip: dsi: move all lane config except LCDC
mux to bind()
