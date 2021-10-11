Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9F429196
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhJKOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243292AbhJKORZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07AAC61078;
        Mon, 11 Oct 2021 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633961503;
        bh=zD+AKuupSTYCoj9CcPWhQv82n92KFccXo3yZu9KbnTk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NlKtPXc5y6RKZlCZzv1omZ6axzdFRkATGimdWqud/doU9kWYbzWK8c0frJfhyCfLI
         25ejDlAh8OTc9yIpR7+XpyRQ/ozUm23Hghu+kZm18hSSqo8LFwfCdWdj1Q36P7RC1s
         RGilW596VwN3Iu2z9xOnIPfCQexNBFvXud4Wc7LCmK+Okkl28DLAK6t1vFI2NrOtUv
         Nv8c08ulC+pST0QI54DxJwrRA3d7rPFEOrCqCX+AVttHvG1YkuRyqqBiIW5fG03Vt0
         YUEB5DJGFFXTLh+olfNiKhBXi7upaYffBalzaH+yPxgvBhCX3LbLixIKY8a2km/qHx
         PRn4hNJ6S1Hfg==
Received: by mail-ed1-f54.google.com with SMTP id g10so67631296edj.1;
        Mon, 11 Oct 2021 07:11:42 -0700 (PDT)
X-Gm-Message-State: AOAM531ftzA5BIuV5h3aBp5wQsVaUlXLMm7JxJ/jITQNhfz/0vt4XJt8
        Yb3QcpGua/nOd9Rt0BTRQ/Kq9+t3ZDvKEs6WXQ==
X-Google-Smtp-Source: ABdhPJw0f8TOUqPxU2srZU6oT+yPzQ8tPFsfVqJQ97sHOzWxNPvUan4j9Baaqte3d/Xw1feY7RVQSsfUXDUCp9emalk=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr25557872ejx.363.1633961500932;
 Mon, 11 Oct 2021 07:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com>
In-Reply-To: <YV1XpL7ibF1y4LbV@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Oct 2021 09:11:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
Message-ID: <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Lee Jones <lee.jones@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 23 Sep 2021, Chunyan Zhang wrote:
>
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add bindings for Unisoc system global register which provide register map
> > for clocks.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
>
> Unapplied v3 and applied this (v4) instead, thanks.

What about the clock binding this depends on:

Unknown file referenced: [Errno 2] No such file or directory:
'/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file
'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory:
'/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
make[1]: *** [scripts/Makefile.lib:385:
Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
Error 255


Once again, all the components of MFD bindings need to be applied together.

Rob
