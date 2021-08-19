Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D203F2281
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhHSVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 17:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235679AbhHSVx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:53:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83803610CF;
        Thu, 19 Aug 2021 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629409971;
        bh=hz4ToEn11O2DiQ3bxZuN8OGUGc7W0kXGCy2CxI1VoXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kng3t7djpyX+7l91WqS70uHZCu/kiK7US//O1ZdEu2yJXPi5OjnT3+XbL9fWqW2r3
         oOOC5ZcT9UfiilbP2KUrF4yNg7i9OHkYJAj1PZQsJrfiybepbQty3tIGbK0ZGpJ6Bz
         tFM+ElKP3lxRGvUcLGKvDMvY5QNiPbUv5faLcqjK4b1URCH207khCLwlVG1FWcVNxm
         08Bo8t9l4DH9VHK0FxqtJWae5Q/6+K+rDJRbVyLWP1HBc8QrZnnhuQdQuw6ujpcNy9
         R+unuj2iZ1hXq9uGmVXKn1QRpm2MpA1pjXSMFfSQpvLLxghk6Pef9X3pR9v8i3OvHh
         S5plU2uqokfeQ==
Received: by mail-ed1-f43.google.com with SMTP id v2so10927039edq.10;
        Thu, 19 Aug 2021 14:52:51 -0700 (PDT)
X-Gm-Message-State: AOAM530l54/Xx5Y3g6dEbojjVctSquG9FIwWKtpj45yR83FdF4voo60k
        m7docZoi/MwfR+YGAXAveAf/BD0K74+aIX2y0g==
X-Google-Smtp-Source: ABdhPJw0hq/j5YRbpD02wnMJhEDVCeMQ0sCrUH9AvIo9gZG8TCf7667Nb/WyMEJegfKzTCD/BF4SZP3zTCNMf4ZT1/A=
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr18790051edu.62.1629409970123;
 Thu, 19 Aug 2021 14:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com> <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Aug 2021 16:52:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK1dhwSKbmCbuaWtBWQH0e-+rdJaWkzfx5b_5vX0toAjg@mail.gmail.com>
Message-ID: <CAL_JsqK1dhwSKbmCbuaWtBWQH0e-+rdJaWkzfx5b_5vX0toAjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: sound: rt1015p: correct indentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 5:12 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Use common enum instead of oneOf and correct indentation warning:
>   realtek,rt1015p.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/sound/realtek,rt1015p.yaml          | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
