Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF21141EE77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJANZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230422AbhJANZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:25:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5781261A56;
        Fri,  1 Oct 2021 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633094638;
        bh=IHOjkdVtHr2yn2iCrROhSf2HxbCcAxZK/4COzwhHzIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=unXdz/wJXGk+bSpUBBHwS0H3ZZVcRtvJJ2jX0tLM4QKk+NWahmITvgPDCQrtKBGiM
         rELVURysOfg+aUPHteQUI3OTU9m6lD1W3PjTPYZ2ZswD+XAHbLjBNI/X4d26E0uDiE
         3aIxqr1N4i/OQdH67TgKfvxP7NyiZECIDr1RSY6sG/yFTHcZshi+m2FyuFc4UIPH7R
         fGaLY3Uk0PWmryKRSOBjjaBlqrIGVaJe8EmlD8GkaTHHzkXTbj73sRQjTl8lHT8lV6
         pS1rYB3dna7Q96cMrMOG5v4S9VIMyyUbrU7EFqQex30pzw0E5O0dM5RQVZ0CCib2f0
         zeU7/jw27Q+pA==
Received: by mail-ed1-f43.google.com with SMTP id dn26so34641592edb.13;
        Fri, 01 Oct 2021 06:23:58 -0700 (PDT)
X-Gm-Message-State: AOAM530bAnbOrvzCcX7GbVti4iW3TkZVli195Tyh+gHEtf7EKuJ8yasy
        h605H9+tw5bpEpW6sy3hdq5/+SzPbSyY+z3hkg==
X-Google-Smtp-Source: ABdhPJyaFtOdvdu1jDBsReWOZlu6Nc90LmFcggJNEBhi34cyAEOb2rYsccqHLMB30HObk67AQmWvV7OtO7ZYHT04LD0=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr6063476ejk.147.1633094636833;
 Fri, 01 Oct 2021 06:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000417.15334-1-leoyang.li@nxp.com> <20211001000417.15334-3-leoyang.li@nxp.com>
In-Reply-To: <20211001000417.15334-3-leoyang.li@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 1 Oct 2021 08:23:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJShTL4zf2Bh=fYHfsujKu1rtuduxp7EKYsRqEXdkLCEA@mail.gmail.com>
Message-ID: <CAL_JsqJShTL4zf2Bh=fYHfsujKu1rtuduxp7EKYsRqEXdkLCEA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] dt-bindings: i2c: imx: update schema to align
 with original txt binding
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 7:04 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> When the binding was converted from txt to yaml, it actually added more
> constrains than the original txt binding which was already used in many
> in-tree DTSes.  Some of the newly added constrains are either not valid
> or not neccessary.

IMO, both of these should be fixed in the dts files.

> Not all SoCs use ipg as the clock name for i2c.  There is no point in
> having SoC integration information defined in i2c binding.  Remove the
> clock name requirement in the schema.

Any name you want is not fine. Your choices are remove clock-names,
add all the names used, or change everyone to use 'ipg'.

> The original txt binding didn't require the order of tx and rx for
> dmas/dma-names.  Many in tree DTSes are already using the other order.
> Both orders should just work fine.  Update the schema to allow both.

Doesn't sound like a case where defining the order is challenging.

Rob
