Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A51439662
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhJYMfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232582AbhJYMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:35:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E3C60EE9;
        Mon, 25 Oct 2021 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635165169;
        bh=y8fSi9WWcDf/0n2m0MD8XxvOkeJmvTCho6D17Jzq5Us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rHfDQ/sDjbm5maDqOzOjDrpcG7mb/Myt3F+8iAdW+5WaVDloV96ItadcrNrJR+JT6
         GrVykDOSlUHx5BihLvSmYqVVii+iWCK02FxpFrCreJdTlHMBMbGvI88aEwQpEz7qn1
         6AFLvF0ux+D61GjjS5r5H+enY+c4kOL+eTvtdSuPaGsNMaCbiYN9s+HDq0qHzXX3SR
         kUJGS/b880WfdG2vMSqV0NuQnWS0smBmNm0YpdJLdYGk814jMMRfmwNTRJXgt4iK6i
         sXIWpwxeeadrKYq0GGPo0Jf9viBnxqs/LAnYkhgGYBm7/m6QpSaNDnGxQPWQawWWPl
         6pDAuJ9lPXPuw==
Received: by mail-ed1-f50.google.com with SMTP id u13so18620065edy.10;
        Mon, 25 Oct 2021 05:32:49 -0700 (PDT)
X-Gm-Message-State: AOAM5339UpbTafcGtj6S6wahQp0C2/cM4ZZ/o8FmXXl2QgkliXxPCatI
        RxF40Om7JkXLNqkFAl5kX5d2wRne0iRt4g4X/Q==
X-Google-Smtp-Source: ABdhPJwveJ+pTjLt/bG9qGnHw+r7bSq1U6lLMb2VPr9M5pGOWoPouj+3iyw6PfQeJKbbIqCpJoY+FS9c1qOKIH7XJL8=
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr22565165ejc.84.1635165161284;
 Mon, 25 Oct 2021 05:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <ec54d0aa65a3b98ae425721663f196b499a59513.1634630485.git.mchehab+huawei@kernel.org>
 <CACRpkdZMSsCmJhsNsP_aTvT7xanOQQkDRk6gK9PAEAnTgTU3qw@mail.gmail.com>
In-Reply-To: <CACRpkdZMSsCmJhsNsP_aTvT7xanOQQkDRk6gK9PAEAnTgTU3qw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 25 Oct 2021 07:32:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvkL=F9PDKjzH5pd7Lc75OpcJPoSQXNPMMaMyB25A-MA@mail.gmail.com>
Message-ID: <CAL_JsqKvkL=F9PDKjzH5pd7Lc75OpcJPoSQXNPMMaMyB25A-MA@mail.gmail.com>
Subject: Re: [PATCH v3 04/23] MAINTAINERS: update arm,vic.yaml reference
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 5:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Oct 19, 2021 at 10:04 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
>
> > Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> > renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> > to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.
> >
> > Update its cross-reference accordingly.
> >
> > Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> I suppose Marc Z could merge this into the irqchips tree?

I already applied all these MAINTAINERS fixes.

Rob
