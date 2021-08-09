Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEA3E4900
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhHIPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhHIPjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B2116101E;
        Mon,  9 Aug 2021 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628523527;
        bh=FL2Y67qQKqHbmqaV1S2aZjqQmb/E5C5ZK3+E4BtHn/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ThBmEC6NAEFNIVe7zi0ikhLlp1LQUgLjgcr1OHxgamGrdkou1CxI8/WW9Quz41dkj
         9bAqNN/LbbdCxU8sbgiYC/OhTxhbY/ZvDKgsn5r2cgZlMnCshpui5qhmh/D7FR4Bmc
         tN5Bc2X/B50H2gtHnAO/HAgwZz2H6PkjJ2qJNES3jBNB3Fh1emea2LlxtZx07wG+jG
         loBVXuxenCFZimPsmxiFJgLXYIWLD88fa3JX4aF73WNbaBkUyrU4E5x14Jh3o0aOvL
         Q2LMCk2EG8/DpV2F51j9nzmvamtxk6/tMDaeO1/5f9WSEWj4U0LzdAC0t8dNpds7I2
         4jnu+qdwaxtRg==
Received: by mail-ed1-f42.google.com with SMTP id k9so7971412edr.10;
        Mon, 09 Aug 2021 08:38:46 -0700 (PDT)
X-Gm-Message-State: AOAM533fJ6Wq58iLGWhYma0b0x5pfFrJtZa5PE6A1Hh9l9ha36RRPfEk
        pMT/JjCqS/vYvMsXGRq0brT2weopM5yyq9ZHyg==
X-Google-Smtp-Source: ABdhPJwHWW7SqmOjHtOtDmm2lqoa/xhxT33kYVNt+5rEFpgw+r5ogOrkLJOTa6lP4ZuTcsVI90qDJqnl+p/h4q514Ag=
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr14192653edu.62.1628523525547;
 Mon, 09 Aug 2021 08:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <ce9e2f298f0c4fc59f756c39736a297a@realtek.com>
In-Reply-To: <ce9e2f298f0c4fc59f756c39736a297a@realtek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Aug 2021 09:38:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKbHF12TVnktAh6Hq0mLnx9xV__rM_kHcyaJt58sXK0ww@mail.gmail.com>
Message-ID: <CAL_JsqKbHF12TVnktAh6Hq0mLnx9xV__rM_kHcyaJt58sXK0ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: rt1015p: add new compatible id
To:     Jack Yu <jack.yu@realtek.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        =?UTF-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?= 
        <kent_chen@realtek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 4:27 AM Jack Yu <jack.yu@realtek.com> wrote:
>
> Add new compatible ID for rt1015p in dt-bindings document.

Please resend without the winmail.dat attachment. And run 'make
dt_binding_check' as this will fail.

>
> Signed-off-by: Jack Yu <jack.yu@realtek.com>
> ---
>  Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
> index 644b68edf3e1..8fcb5f79a1b5 100644
> --- a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
> @@ -15,7 +15,9 @@ description: |
>
>  properties:
>    compatible:
> -    const: realtek,rt1015p
> +      oneOf:
> +        const: realtek,rt1015p
> +        const: realtek,rt1019p
>
>    sdb-gpios:
>      description:
> --
> 2.31.1
>
