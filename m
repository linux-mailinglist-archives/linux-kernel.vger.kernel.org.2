Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B510334C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhCJXSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhCJXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:18:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:18:26 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n16so36528623lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETYOYkWWuwEOmh8g1BpUkeMpw9R/2k0WlMIbJjFgbe0=;
        b=mywdMmMNJWXNOvpzRYKiSkJnDeJYqEEFyJbe/D/1vTty0KMngDXw1kVVCfQiNgixNp
         XjR6pFSE91kpGFqSKsZ04/LU40yddLUSHofebFzU0prJ4DMhiSHnUo+tqLTLqbSaWGwa
         XGcnB3+gHEtr8Z/o/Dygi76jE3pgQdew6mAhbclLOcxWeBa7qw+3Os8OeaHDhAYJALFd
         aNERZfBzwon883KcCGibf2Xa1cRLUKXI/SVbL3O/aANTfhh7ZlIHP1VMSnFGOTeaU/kk
         MjLDyqPf9nkDvQdELIJGpZpGTB5lQk4kWH0b1uG98uvoply2zwp59obknZGLFl9wPP2P
         shvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETYOYkWWuwEOmh8g1BpUkeMpw9R/2k0WlMIbJjFgbe0=;
        b=IeYCBSg14XL9xBsOeHrNKokMI9kqeiX1bXoxrAd1mZe+sllG+KECVvvwlVqIuH13U8
         xMljqKY2Wg/iAL0soyYVw24nDcoq0Vo6bWJKRPqZ59hayZjGFyYRQEEjqroUJ/2Gn+IJ
         V6ytyvokvmKIpkfbhxo/lEeFiks8NoT5kO+xNuKjsdV7+7uisTF2Qhbp04IydvOOb9Su
         icMA6f4HS+g98ClGbt1p1hUqJ7LArvE9liSLNX6y0BpENL5wGLeJ3/JlW9d2s50IWbAf
         G/gaVNg/3oAzvQneK85Z5tUi54CCukK7C1ayPf4eKsi3et1KkshlMOaRO87UupoLiCl8
         ZFCA==
X-Gm-Message-State: AOAM5300UYEmOInappKMtUMW9VIHfcO3KU8qcQxB8G7X8BF1y5hp9UdU
        ZO+/jRREGCDa/zcMrvWEJa48uHsWQ/ORD0FvpAFAVQ==
X-Google-Smtp-Source: ABdhPJwmNWGQITUCTc5qmeWRhSOQqyfgdyu7l7/Uv7dVvTj6QBJ8VXjebkqy9nB3G5/ztId3MDTZN+9ZZg9bIijjy98=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr498944lfo.529.1615418304736;
 Wed, 10 Mar 2021 15:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20210305153815.126937-1-vincent.knecht@mailoo.org> <20210305153815.126937-2-vincent.knecht@mailoo.org>
In-Reply-To: <20210305153815.126937-2-vincent.knecht@mailoo.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 00:18:13 +0100
Message-ID: <CACRpkdbtwjVjgv-sXG9_-j7+wSiqP_K_=4dS80JhN-F5SDV_Qw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Input: add MStar MSG2638 touchscreen driver
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 4:38 PM Vincent Knecht <vincent.knecht@mailoo.org> wrote:

> Add support for the msg2638 touchscreen IC from MStar.
> Firmware handling, wakeup gestures and other specialties are not supported.
> This driver reuses zinitix.c structure, while the checksum and irq handler
> functions are based on out-of-tree driver for Alcatel Idol 3 (4.7").
>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
> Changed in v6:

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
