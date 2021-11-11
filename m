Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7144D935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhKKPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhKKPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:34:30 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B891C0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:31:41 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id be32so12152455oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8pB+WwRzjj1VLddfWPFnbpX1zEu/AXjp6IsntdVdc4M=;
        b=eVfYB5znA4+u5yoC3kq22eC1l5Wk36GwHpTFQmVXZ+6Wi+IGQQecl5zjDn5PbwLebG
         9NHQW2rnKHVfOfkkaCicef7RsP2uCQ3uaHpeNbs8CuQklO+liFDFxf8YCkkK098I1lms
         6LVa5VMuACMj7YYOCiicFLyVA11JCk92IaoioXkwrVxUkIuiT5fI4BcAWKbiKu9Wf+vs
         OlvtAvy/c7q3SnQYWw1YHaUCqAuQdqCRPiuCs3gCnSbRbM0TMH4LcRsyQLHrTiRR+o6E
         hG2jqomYCTG9lyC3nK0iC2K+lbj+FPd/WIUSUasqzzxuFnnc/bsC+ksk+rQPBWpRUMMY
         RVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8pB+WwRzjj1VLddfWPFnbpX1zEu/AXjp6IsntdVdc4M=;
        b=6h3b09vIwTmHvZkxbEKVYIDK8OlLWrs7F4RRgIn0xM9+Fi1KpqG45U6LH8emLtE9zk
         0tONLcucAyb5y5N9boCe8l29xy67NN2BNWlm6XW4K2n64GSxQrvXEI6ooQJzso9ChPLb
         k2KbSPd/HWjIwDJKCjgemX8O9Av5KXxxjfUfR5yWX8A9dzn2fM5cOdVKRT36XKVh20K/
         zjL1ZJhCa8gBEGUNL+UUbLKTFpJ1GDgRg2dnh4wXvjb48AQau/8BmwDG1z94V6lhpW7y
         fjELtgXhTFwTPVSZBdLI8+VODdIXYXfL28gWURp/3UgryA4U24TP6ayzKeeCTM9gcaw/
         7H0g==
X-Gm-Message-State: AOAM532dpzdEB32BTfRK0k+ftkwfILuegwYmZwALOg8uVA8J/7ycv0e1
        1xWioE4wmWgIpA2y8P7HTf9UqACXJMyWTx+bhHFgkA==
X-Google-Smtp-Source: ABdhPJwfj+szv19ZdA3wyhVqNUMQ0EA+/NDT2FaE6iQd8Igj9fZrBAlPin27pfo4wMPzekrNeaOxHlxFTjTEVk+FqJc=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr6897527oih.162.1636644700468;
 Thu, 11 Nov 2021 07:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20211110231436.8866-1-zajec5@gmail.com>
In-Reply-To: <20211110231436.8866-1-zajec5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Nov 2021 16:31:28 +0100
Message-ID: <CACRpkdbAS0JiqTQUU0R0yRhVCwagubwsNYLxj1DLE1Ldc+H_JQ@mail.gmail.com>
Subject: Re: [PATCH RFC] dt-bindings: pinctrl: support specifying pins
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 12:14 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>=
 wrote:

> While working with pinctrl in Linux I started wondering if we could
> start specifying pins in DT instead of Linux drivers. When working with
> DT we usually avoid hardcoding hardware description in drivers so it
> isn't clear to me why it doesn't apply to pins.

Historically this is what pinctrl-single.c does.
Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

At the time we created pin control there was a bit back-and-forth and
the conclusion was that there is not one-size-fits all for pin defines.

The reason TI (Tony) wanted to push the information into DT
was that what he gets is a number of unprocessed ASIC datasets,
that are then turned into tables with a script. Header files or DTS
source alike, but some kind of tables.

At the time (2011?) it was unclear what kind of data should go into
e.g. header and data files in the kernel (modules) and what should
go into the DT. So the approach to put pin information into the DT
was allowed for pinctrl-single.

The way I have understood it, DT maintainers have since gotten
a bit wary about (ab)using the DT as a container for "anything data"
and prefer that drivers contain details and derive these from
compatible strings.

As of today, IIUC the DT maintainers are against this scheme.

That said, the topic is open in a way. Some people are also annoyed
that some graphics drivers just ask Torvalds to pull 100.000+ lines
of register defnes in some merge windows. The data has to go
somewhere.

Yours,
Linus Walleij
