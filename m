Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1233FB62C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhH3Mg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234741AbhH3Mg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9875B61059;
        Mon, 30 Aug 2021 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630326964;
        bh=VSnG7ci/z6It+oL6KcTBEhuTf8u1sv3TMd5qXRIvpQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z9VrAPSYu3o1kLTK5GooxotaEz5m+jtqVGPk8x4/xsNs4xSvwITYKkramNk5d/Ds0
         Teze/fJvUS5JD3p4PamiFqb8HZjoQyXqOhTqZWPGvRcsAursOrRZnb9c31yWhB6kP1
         z7J2AvmUKIV07RunGf8O9elvEyIotC5c1kW9YeGN8AstPmq2X97tMbSCFduB4B7put
         Gjvg/TCjEPgvqzH+1XqWBuZcnDX3l3ZBslHmIwBQ4ginqBAmsCLQGEUmFYThNrvgKJ
         M0cHM01VOqLFW+6ei0XINX0sckimNyiqcvkXgF7RoCI43TdCyB0U20iL6wW7xeU/LQ
         mw9nffcTzgXBA==
Received: by mail-ed1-f50.google.com with SMTP id g22so21351310edy.12;
        Mon, 30 Aug 2021 05:36:04 -0700 (PDT)
X-Gm-Message-State: AOAM530DSbMjmc5MjOkDXS1OYoeo7WZcVt3YpP5IaDshUFjKfHpWyoHF
        VAYwbc2U+1DDN535iAhbOgPBmeHMYn7lQq5aFA==
X-Google-Smtp-Source: ABdhPJzKe9hTkHckfNaR1ucxYim8h6wVK9o1P5JmQEu+WRbO6Yl0Gq0AZ2KqnNnrX8JgVC8B7aRTlLvuFbVruyQ61UA=
X-Received: by 2002:a05:6402:70c:: with SMTP id w12mr24307350edx.289.1630326963208;
 Mon, 30 Aug 2021 05:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210819084144.18483-1-trevor.wu@mediatek.com> <20210819084144.18483-8-trevor.wu@mediatek.com>
In-Reply-To: <20210819084144.18483-8-trevor.wu@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Aug 2021 07:35:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+bLVLqqVKfYuXDVYexMojMgZ5p34Pcx7_7LwU40b-2dA@mail.gmail.com>
Message-ID: <CAL_Jsq+bLVLqqVKfYuXDVYexMojMgZ5p34Pcx7_7LwU40b-2dA@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] dt-bindings: mediatek: mt8195: add audio afe document
To:     Trevor Wu <trevor.wu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, bicycle.tsai@mediatek.com,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Li-Yu Yu <aaronyu@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 3:43 AM Trevor Wu <trevor.wu@mediatek.com> wrote:
>
> This patch adds mt8195 audio afe document.
>
> In order to support dynamic clock reparenting for ADDA and ETDM, PLL
> and MUX clocks are requested even though they are not consumed by afe
> directly.
>
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
> This patch depends on the following series that have not been accepted.
>
> [1] Mediatek MT8195 clock support
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=501923
> (dt-bindings/clock/mt8195-clk.h is included)

This dependency is still not applied, so the example fails. One of the
following needs to happen: the dependency needs to be applied, this
patch reverted, or drop the use of the defines in the example.

Rob
