Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA6F3FB0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhH3FfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhH3FfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:35:08 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218DFC061575;
        Sun, 29 Aug 2021 22:34:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b200so18303473iof.13;
        Sun, 29 Aug 2021 22:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iatc6vajkY0MDwzapGj1skQWsvXeM4hcy36GIWGpEW4=;
        b=LVxShmhA8oScomf8RXUdPHgEs1CGooPT3O642dmOoyDC81k8HM76pDNJcuz7NGT53A
         2+H1qbu6agP0IjAjo4C9Iv6WFR2Ajw1yo5KwKBYQIer0OiVvFSvgGkdm/H7JPBQXnOHC
         GhrwsS6a6vd3/I2ADgN7NWlKls5FQlXzQkeKFb55TzRKsfrwlEJ0VP0QxOQCoMIeTuJZ
         xdFpOZ/Zl/XHxgm2rdjR6KJHEmlyCbUYC7vZDMn4V16MEoEY8LiYHxC1dXjaRwcft7Ir
         WqtIepeuZMCdgXCh+mYoNtt9uJ30okb770fO9vvF6kj4XU/wxYarH5IvJ0IY2r4Mk5Pq
         x71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iatc6vajkY0MDwzapGj1skQWsvXeM4hcy36GIWGpEW4=;
        b=G5KUl7hs0CzO36tPxG2DKAcPOCnEzksKG88wAXhsXyhwfxtiPs7teVX3+JRQAX5RAo
         RzZ0xCMsqtbK6YTUJlc126k924w1JQplrQFi8JrZn6AFsvA5pIDeAxYR2d6v1xLoFPXo
         dUZK+d67ZzxkfDRglz1Dp6aONzb1U/9RHttjxgeWmhxHix72BcoxYLRbp7HkiygVFDRf
         hcVaWY816Iym5XDIIg6qrozgum3lHVdWpXDBxTsm8wsHxB4UF5Txy/nWN0I7Mtkjd0E8
         nq+J2xCZ0WrhJZ9nL6DdLq9AxxjwRacwC3wH0ZraYxpZs9xyqHCW05ojQG6mnBAu4++g
         4nQA==
X-Gm-Message-State: AOAM5327j6SLOxWiT6f+4GtKDwzv65pAsGC0v6G5IglH8j+37CAPhZTS
        wKYHyJu0m5aiwtEx9sGQRrsPgB4Vmxvhw10/xcc=
X-Google-Smtp-Source: ABdhPJySdhgVn3pG/z4LQSgTkNKL789y+ndUcjN0DNkBlsvtkaFO+0/2QmBSSGQHgFOyjeI4JI8d79g04HUloAEYRdo=
X-Received: by 2002:a6b:fb03:: with SMTP id h3mr16892442iog.198.1630301653881;
 Sun, 29 Aug 2021 22:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210825094120.5005-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20210825094120.5005-1-jason-jh.lin@mediatek.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 30 Aug 2021 00:34:03 -0500
Message-ID: <CABb+yY0rTZrM1J7mFbSf0Z5tdwjYsQ8Tff-DnVfxX8P4HRu01w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add gce support for mt8195
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 4:41 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> Change in v6:
> - remove the unused define in GCE header file.
>
Please rebase the patches over other previous mtk patchset for mt8192.
https://git.linaro.org/landing-teams/working/fujitsu/integration.git/log/?h=mailbox-for-next

Thanks.
