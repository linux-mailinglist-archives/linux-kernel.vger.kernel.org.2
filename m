Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8D3B8512
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhF3Ocp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235004AbhF3Ocm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 009DA61474;
        Wed, 30 Jun 2021 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625063413;
        bh=Dpokg5mx9PCeNh5Maw6E2HZ+R2pO6FZ5ZVOGUwMTUnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I17Y2NzxFnYvX+SCqHEMyKF+UgBrWIV1xSufgom151+id80qYZ+KYzhE7fl0W/P9o
         VWme4IxTO6Kv9CT+AzUmB6nAyoLlpLMovz4/LYxT1YcsDbI07k2IEQEgQDR0NvTdXl
         QvFolbvbdNvaR+1Oj8R+wCtqhJ/xbjjUGpplp2taXJqSNb6lxkNHXqZYK9y7U3VRTP
         TMBnoddWNzxnaJ13IddE6gcUTvfewKGcaohyBQxlwlehNf5SR4IvgF8MWTaRDNnjBV
         ShWtq5QVGx1iV+x9xXQToBJHdoAfCUjzVXJUPn07oe3qv3G2aEEhHBE0IYN+geYv9u
         FrVVOH2Zau6CA==
Received: by mail-ej1-f48.google.com with SMTP id gt10so3182262ejc.5;
        Wed, 30 Jun 2021 07:30:12 -0700 (PDT)
X-Gm-Message-State: AOAM532seDeJj8QVrdbizWvOzzhpPgZblLdZ64A/Tk1AE62husnrO5F6
        aYRYVOUPCTeGhAzG56LQg6Xwth3VRTAPCrDr9A==
X-Google-Smtp-Source: ABdhPJyudkUk6/cfP1T21tKXKcYPMVLiZF2tJOPdLVkJd/moWew1wCGN2luO8WUD5eusbGsFuEw4zAqW4fHhB33nLYo=
X-Received: by 2002:a17:907:980f:: with SMTP id ji15mr180143ejc.194.1625063411467;
 Wed, 30 Jun 2021 07:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210630132804.20436-1-chun-jie.chen@mediatek.com> <20210630132804.20436-2-chun-jie.chen@mediatek.com>
In-Reply-To: <20210630132804.20436-2-chun-jie.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 30 Jun 2021 22:30:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8SgZ5SN9Q0nfL_jQVTbB7ZDqgoGFRkKe8+QJwUi55Hew@mail.gmail.com>
Message-ID: <CAAOTY_8SgZ5SN9Q0nfL_jQVTbB7ZDqgoGFRkKe8+QJwUi55Hew@mail.gmail.com>
Subject: Re: [v11 01/19] dt-bindings: ARM: Mediatek: Add new document bindings
 of MT8192 clock
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chun-Jie:

Chun-Jie Chen <chun-jie.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:30=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8192.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

[snip]

> +
> +  - |
> +    mmsys: clock-controller@14000000 {

mmsys is a system controller rather than clock controller, isn't it?

Regards,
Chun-Kuang.

> +        compatible =3D "mediatek,mt8192-mmsys";
> +        reg =3D <0x14000000 0x1000>;
> +        #clock-cells =3D <1>;
> +    };
> +
