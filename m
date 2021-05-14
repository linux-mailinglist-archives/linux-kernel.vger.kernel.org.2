Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5B380272
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 05:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhEND0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhEND0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 23:26:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 20:25:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x5so28702859wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 20:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA/LAFFI+jVcP+Kd0M4qGoF8L0ZjvsmsYJZogOYbiAQ=;
        b=OnjxILPnJeDvRHc9iPEEubFRbiphS8lU5ZgLeRSWr2HzrlP1DuFvVPXhIZfEaZD3gf
         5JA73EIhyl1v6HW8kqMIKaP6pkA7VlsoyV2CZmFIyWQWYiKIxKCFOO3ZKEXwB36LeEaQ
         riU5cxJaoeJ4t7799NBgL/dTh0MWFAVv+t/Q9yiUEtLXTqwwb/Zni9QPUMIqx98cSq9L
         SyVojf4YpB8dBjYSqGZ5HVyYgnjPjkFkAFzNpF3wrPaK85t6QZhJHXDSyfZGrDk1g0za
         9BMqc+dD4M4u4W2xRxiP/eV3iVh2POo1G1J56faFWeqwAYxVAFDx+fWiiy8rZqjnXCS+
         6Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA/LAFFI+jVcP+Kd0M4qGoF8L0ZjvsmsYJZogOYbiAQ=;
        b=mA0xEZzYGRqjuFid3xVvmgO7k/x/Pc0/ugjHD07q/rlw53UTqjoZTpAf337P2AuACw
         FnWnHxqenNrTxMvgBy1OdCwtisc7DykvzJ7BUGQjZhe4v4pMBc4CStZ7Yt7gALvh+kJ4
         0aKetq3sz5lvLXWUL1qUBFLRlnv4TfKmmZ8kD1DBkGThr3AXhhEmFSkLxfmhJp+d9UJU
         kGXMsZpFW2/9tzO0vRg3YHMcp1DBADW1S717ETaq0xa12faGsgZLbjnF6Ze/1OQBbP4x
         FZN9WCtkplbWST4smax1QIaYgOkz1Ur8nXIBg0vk+DUszl6vTKUIqMJk9FozFH1PJ97A
         9PSQ==
X-Gm-Message-State: AOAM531PjmRKTf4xn/nMKionCVvcI9MG+TDL4QHsZ815FVG/KdJWhGCS
        MVJnYzWb6KedbglPTHWu9Pt0rG29dAbVtaQfup/xxg==
X-Google-Smtp-Source: ABdhPJysEt9Tqu0H8JHhPzilEzabOOJJAWxjXOF//mN/UtdUlgdJyJW3QAPMpr1mk0VY8Ri9ETrEsbEKKeJISz8db9w=
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr56971603wrq.307.1620962705236;
 Thu, 13 May 2021 20:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210504054612.3585017-1-hsinyi@chromium.org> <20210504054612.3585017-2-hsinyi@chromium.org>
 <20210506203124.GA753747@robh.at.kernel.org> <a573e490-44bd-d6a1-d0c0-075b6541f720@gmail.com>
In-Reply-To: <a573e490-44bd-d6a1-d0c0-075b6541f720@gmail.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Thu, 13 May 2021 22:24:54 -0500
Message-ID: <CAJe_Zhcz3yPcyxHMtAYTY+wKAzWxt2LJsj-AU7QFneW8MTv1HQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mediatek: Add optional mediatek,
 gce-events property
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 at 10:55, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> Hi Jassi,
>
> On 06/05/2021 22:31, Rob Herring wrote:
> > On Tue, 04 May 2021 13:46:12 +0800, Hsin-Yi Wang wrote:
> >> This property is used by gce clients.
> >>
> >> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >> ---
> >> v2->v3: move definition to Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> >> ---
> >>  .../devicetree/bindings/mailbox/mtk-gce.txt       | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
>
> Will you take this through your branch, or do you prefer me taking it through mine?
>
I see I was not CC'ed on the patch. So I can't.

-j
