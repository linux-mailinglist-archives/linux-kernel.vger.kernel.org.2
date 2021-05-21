Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8598E38D224
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhEUX4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEUX4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:56:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2923C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:54:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so25857535ljn.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tV/CvepLnR5+D9t29ytGFL8Nj7AdpJJt34520cSY3LA=;
        b=M713uKIY66inHyiEO1T+DBuoxnFAlNemj6CtaopVQxn8BuphkSpRK9jZMLATFw/+jg
         BaGUTJrCmSP6/yWnoxXxICQnpjzBfTZSjElWrrbnEr7ReDqHqTSodw8ijwHxo8diahZg
         D1LIllew4h7IEWe2u4MX9gtgErERqcubYcinEmZ9l1pQvwYhh2uT5QrjBltHrfsPPBVD
         Aljket5JV5L+VoKae0CRUf6ysY+vPcXtoeJXXyigwFvZ1mUO2jOaUCkIlmAgcSQhRRQM
         iO7e4K7gdTKUaKUz/JhpI7oqJzQ4aGISExjH13EDf386UExM3RLWpdcV1QF0gioxwRT8
         n7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tV/CvepLnR5+D9t29ytGFL8Nj7AdpJJt34520cSY3LA=;
        b=jEf2B7d9CwWccFNLW7v83RAVfBSj714hTfBz8s4cdXgScEP/QxljRwkj+dJkao3AFb
         dlL675wKmmszX/U/F+QXY/vJI5+vwphFasQTjmJOURFhU9+64wsRu1tLJlWwwJH5FwaO
         c0a7Mg7PXjdYwQsF3tHKZkablP1hpakMkkhHtTleSyYjvaCR6rU7sMOhJ5cnP9QZK2vh
         nPWn9AknOruAbxPCzplTXlJtsOsG7CVrOks/xHcLNM37hygjZ4Uk93K+nikhgjE5/HJU
         cTaY8gayjCFw6bwrii7V8aBAHfyfSHZyjPnQOo31q5GqjzWDMwvlvMIvNxCAsmm5XAHF
         hGgQ==
X-Gm-Message-State: AOAM530UuZ1w0M4n5p426GnvFddP30tw8yQyUWQDuCg0+nYdSA2aBO8R
        B3EcgxrqMZwBFlmlqR/aqN+2+bWwKQygP0pJgstqoA==
X-Google-Smtp-Source: ABdhPJzJ0T69H5XFqUQwsNg04Epi6XpxdeY+ogh1rdWQ9QB++gsjxv/67mcs+CsBli1tiQ6/dSKRkAWMwWN6iLTO8Y0=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr6305514ljm.467.1621641290037;
 Fri, 21 May 2021 16:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210519203547.837237-1-clabbe@baylibre.com>
In-Reply-To: <20210519203547.837237-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 01:54:38 +0200
Message-ID: <CACRpkdb3TratOcZbi4Y7t_0i0fZ84Ek8vgT5xXxObUuZRYvrCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: convert faraday,tve200
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:35 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Converts display/faraday,tve200.txt to yaml.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied to the DRM misc tree.

Yours,
Linus Walleij
