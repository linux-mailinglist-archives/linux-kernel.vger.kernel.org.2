Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542BD416781
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbhIWVdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbhIWVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:33:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96C9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:31:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b20so31869628lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSGexge/yTWailPe6Hp1VQxkjzvMXlLhdnN0SKm1jgk=;
        b=sHXkka97oocc/Avp1+G2WMg9/Kqe44NKcVXC8YurMm1Q5arTOo5d7SR2gd6B1r8KGQ
         u/j2JVVDjd7ly5+7pexUjhyoYw3zCMTNN52V8f/V4vvVFsLVZsvA6g/ApYzKnvyLyT3t
         wYJoedt+57XP5OjI9uDm3fzhHhOVPCXmbOZJUkYJ6fXWAOnwi+QCCYi10flo+mOzSS8S
         5DDRevo5UgdPYGZgjQyhPBVeVHY2UqrDzMR6bTYXos0netmhu+Nx4SdZZG501lTgi3QX
         ZBRqucDMnx8uDcnfDk5sLD3v7M+mWcBAuosQEmQmNGGhAzRWVFiFacjPHmn42MSpnvJJ
         zGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSGexge/yTWailPe6Hp1VQxkjzvMXlLhdnN0SKm1jgk=;
        b=DszFqSgSzUbFayfrQNjH56e6WclKM/5JP+UdKjD5Mb/C2uyiMLVZ8Q2aTd615WRoSY
         zcRD2SJwKy/Tt8S/j6I3aWnitaEewobysI0cNWH8JY4TcO/YkTdLOL2Hme0NJ9UsSvFu
         cEMP9QNo+CRQ5bYmQv+s1MtsUqZW48/oNKojXLBGfJljVTIoZlfyqWqnOmhpNGF96zmy
         JGRmIbgy3XTn4EGk7X2yNaeXzhBXig3lucnGVGZPuRdo+fLRVLdzQa6Byo1ici1jDXZN
         p72zVh7MNFD1r7ZrQ2XyOZeMqoLkSPDYC9FoBZZhUdmMnbNE0YF+Pzk5d3ZPmjia18GS
         lv9w==
X-Gm-Message-State: AOAM530L5x80IoMjqoG17GtqYpeKyJhMq1ld2KIYPPJizlF0vHAfH1R6
        JTD4G2sTecvSKrn96ADW/V8WITo3/ns/gxoBpF0mMg==
X-Google-Smtp-Source: ABdhPJy2mfR57uNliZEcdzZTcs5ysF9NDOwlJSo6qcE2nsS01XTmcffsKxwYrHi5ZVuTy9LqrP5bV2aG6k/zenW3gho=
X-Received: by 2002:ac2:4651:: with SMTP id s17mr6179225lfo.584.1632432696061;
 Thu, 23 Sep 2021 14:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210922025640.11600-1-zhiyong.tao@mediatek.com> <CACRpkdYASy3KMm4VXPrMyvVpONK78gwRn6kthK534pjWb5mhvA@mail.gmail.com>
In-Reply-To: <CACRpkdYASy3KMm4VXPrMyvVpONK78gwRn6kthK534pjWb5mhvA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:31:25 +0200
Message-ID: <CACRpkdbM3hoAxMSaoGDzF84rxmawghHFcSdibs9wANxWn0iynQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] Mediatek pinctrl patch on mt8195
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Light Hsieh <light.hsieh@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 22, 2021 at 4:56 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> > This series includes 5 patches:
> > 1.add rsel define.
> > 2.change pull up/down description
> > 3.fix coding style
> > 4.support rsel feature for common ICs
> > 5.add rsel setting on MT8195
>
> It appears we have consensus so I have applied this patch set for v5.16!

Speaking too soon! It appears there was still comments on patch 4.
I blame my gmail.

I backed the patches out for now but this is starting to look really
good, try to make sure the patches also applies on the "devel"
branch in the pinctrl tree so I don't do any mistakes when merging!

Yours,
Linus Walleij
