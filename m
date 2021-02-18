Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDDC31E7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhBRJVJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Feb 2021 04:21:09 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33791 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhBRIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:09:29 -0500
Received: by mail-lj1-f177.google.com with SMTP id c17so2731874ljn.0;
        Thu, 18 Feb 2021 00:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2JZs1ZJKk51l3YchsPITzi18reItTFJEkOmfTPO4cok=;
        b=Y/dlosL+jBD3uldB0QV31nDjcm9IOvwM3ZrKalsJTunZ2dTdiUjfNfozbxGbBkhpa1
         0o4zLla2Txm/SV+jG7AIPJs/3aFsvMkVARMVTp7FfK7JvTv9WyD9uphvwFiqw7oJ9tZr
         lQDZlzTsEx/6CEymucGrRLMD9vSwVNjw1ul5Ec3KHxc1CLcETXJz6tekjfd1T/Pnmn9a
         6DP98SSb2iMhz5OXKuZ87H8BdVWb3o3/gq8UQtiUotdYf0hfUqlkvOEbrhaGOoZbbBzd
         bZ+IAiDiCeR3Bcr9VxGS+IK94ILkPp826oufdtQIgFxOYbTAmTBdf0Duo1Hv4Fdy1KS3
         TCtQ==
X-Gm-Message-State: AOAM533xmqxA9Z5raJF9qpb3xdomLfIarOabbAwRXLl1BQtG9vVNYRjh
        nkHUlKaMiGKwoB7xZdwOUc2mwAVGQcH2SQ==
X-Google-Smtp-Source: ABdhPJwlB0LbQ2F3xjvUlPsViXClSk1breqtX+mJiVUUt5gk+Ls5ZsF2vwk9rlTNLsia+qoXG62h5w==
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr1961692ljo.494.1613635701372;
        Thu, 18 Feb 2021 00:08:21 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r25sm523182lfn.213.2021.02.18.00.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 00:08:20 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id j6so2681292ljo.5;
        Thu, 18 Feb 2021 00:08:20 -0800 (PST)
X-Received: by 2002:a2e:ba18:: with SMTP id p24mr1864954lja.488.1613635700512;
 Thu, 18 Feb 2021 00:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20210212135725.283877-1-t.schramm@manjaro.org>
 <20210218075835.o43tyarpimrcwbvk@gilmour> <C1E55B65-370F-4875-B7D6-7CD7A82A91DD@aosc.io>
In-Reply-To: <C1E55B65-370F-4875-B7D6-7CD7A82A91DD@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 18 Feb 2021 16:08:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v651jyoD9g25gv4+LoRDopNz2L7YYwp6O=GDNq4E0=HO7Q@mail.gmail.com>
Message-ID: <CAGb2v651jyoD9g25gv4+LoRDopNz2L7YYwp6O=GDNq4E0=HO7Q@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio
 pll output
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 4:06 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> 于 2021年2月18日 GMT+08:00 下午3:58:35, Maxime Ripard <maxime@cerno.tech> 写到:
> >Hi,
> >
> >On Fri, Feb 12, 2021 at 02:57:25PM +0100, Tobias Schramm wrote:
> >> Previously the variable rate audio pll output was fixed to a divider
> >of
> >> four. This is unfortunately incompatible with generating commonly
> >used
> >> I2S core clock rates like 24.576MHz from the 24MHz parent clock.
> >> This commit adds support for arbitrary audio pll output dividers to
> >fix
> >> that.
> >>
> >> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> >
> >It's not really clear to me how that would help.
>
> We have introducee SDM-based accurate audio PLL on several
> other SoCs. Some people is quite sensitive about audio-related things.

Right. What you really want is the SDM-based fractional clock support.
Just look at the other drivers.

> >
> >The closest frequency we can provide for 24.576MHz would be 24580645
> >Hz,
> >with N = 127, M = 31 and P = 4, so it would work with what we have
> >already?

Correct. And that is still slightly off. It's even worse for the 44.1khz
family.


ChenYu

> >Maxime
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
