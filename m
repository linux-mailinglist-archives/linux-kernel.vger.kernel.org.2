Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A04425A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhKBCY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhKBCYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:24:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F5A0613A1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819697;
        bh=Sh+E3vhcUYFTuSr5p8OLYai9a31WkvMD0XH84I6uVVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jGvLS2mvwvbQjzIZdPfSQrOYwqj1joqIK71bIW9nPy+rNYFWVRAYzXRXGzXJQQLld
         HbhLIGOoecO+5AO2EiTGb9K83lonHTXmC9j9/qJ/4TnJTycWcWRoqVvt+tK1QNuboF
         bHxd/6eUveB7jjY4Kt9EZj1Gy7tHLyDQHKzKgoSB9QJayujftcJsE4CCpoDdirODGK
         NYo4JO1KAOPD/K3CJxy4U+/ABjwsjPuSkZUZCXjitWXwDFlZqsn4WGk4qNO8Q/MFoF
         zzK4O3H+cbpNCSrHhFP9HwY7y0NuFdMs9i3rPr73d48KmTQdc/2UBFy5DJL2EkHzW7
         Spkq22ZryELLA==
Received: by mail-vk1-f178.google.com with SMTP id t127so8882486vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 19:21:37 -0700 (PDT)
X-Gm-Message-State: AOAM533UBZsUVVYauxJVhnly0ql/SqRx61KmJ6xRxCNRcrRlNo4g7HJ8
        pHR4BeevCCUVCoWn+MliqPnl2F6x+SQHWDQPESc=
X-Google-Smtp-Source: ABdhPJxL9iIZ+HGyalsZ8HcJwGeVT3uEvIXAyPennCwENsyNtPuJA9yWQJYWPYLFiyb/lwBb0ciA7KgQ5z3VEUDOr4E=
X-Received: by 2002:a1f:1844:: with SMTP id 65mr33732861vky.3.1635819696531;
 Mon, 01 Nov 2021 19:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-2-guoren@kernel.org>
In-Reply-To: <20211024013303.3499461-2-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 2 Nov 2021 10:21:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSDTXu7HsABTHfTbCd2TNpHBpzSMqYGh9Av8kzJ+6AOPw@mail.gmail.com>
Message-ID: <CAJF2gTSDTXu7HsABTHfTbCd2TNpHBpzSMqYGh9Av8kzJ+6AOPw@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] dt-bindings: vendor-prefixes: add T-Head Semiconductor
To:     Guo Ren <guoren@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

ping? If there is no problem, could you help pick up this patch into your tree?

On Sun, Oct 24, 2021 at 9:33 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add vendor prefix for T-Head Semiconductor [1] [2]
>
> [1] https://github.com/T-head-Semi
> [2] https://www.t-head.cn/
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index a867f7102c35..f532a8830693 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1169,6 +1169,8 @@ patternProperties:
>      description: Terasic Inc.
>    "^tfc,.*":
>      description: Three Five Corp
> +  "^thead,.*":
> +    description: T-Head Semiconductor Co., Ltd.
>    "^thine,.*":
>      description: THine Electronics, Inc.
>    "^thingyjp,.*":
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
