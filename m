Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A755844A5D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbhKIEm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbhKIEm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:42:27 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD3C061767
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:39:41 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id be32so9191662oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Pz92NevhlQIIHyCP8oFIg+pYIGx0bc+HYq2+R7qC0s=;
        b=VXV3qFd6feUoGA0Dj9phwKZpS6bnzrgOGgkh4jB6zxhBHGrJWiE6ZPWQgiOL0hf+4y
         qPFNTS07kLxXPEKjgkJZzla9vgUarIHavmn1Ebk5vhwk+FFIBNaaOlm6pzP9GD2NL2Ao
         C0CyaC3M/FdxyahUSp/7HVE4/xD8h5YPBFjhow+/rSFRhtkFwEb84oV98XeX7HDzDfJU
         dxozTPS9XosCvtTuDh4cAldDz0QIS5FIGEnB1k0U2Hj1fzrgwxhka4ppO18Pujf+CBPR
         yZzAQaLyzeGmKVuwpo731edvn++wOhyMWouW06nGXaBFbnfau+FdLMn5PFgKordxB1wv
         0eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Pz92NevhlQIIHyCP8oFIg+pYIGx0bc+HYq2+R7qC0s=;
        b=ADKFokYlXxb0aQx5xoQA399WcVfdUWvzN+KQhzfBf3Or8PDegsj7R+9Qp9zq6cGP0e
         Oeh7k9bc1/mosZz0IJmAjQxZd8uskScq16Gr/K5KM2nXKohmO1vtxZNIWdkbV6Rpd1+e
         VSxYYMxKZO9SCcLRLUQiCt5IMf9DZKMl2bqqK+8okjn1eegNTVsnEefgg0GoakQy2HX5
         FXGcIy0+LRBijuAgwJMQws3rT0AY8XAbyDrYqQBR3qooUAXFPDbv9u/tFNsv3rXfAGz+
         N3kFQ86gpILexfo69K6aD/zMfvcZYWTqpRNOqEFRaQaHmn1ZiUT0+OaDagkYH4/xc4XA
         laCQ==
X-Gm-Message-State: AOAM531hRQpe+4J5/CbJJ1a/t/IkDYZwBTeyVzCYqa82/1pk1Z05tEHb
        Mpp5Hq0oKnHms+Ur/g72hmGKMqOxPOp43j2lFVu2nQ==
X-Google-Smtp-Source: ABdhPJx4wXgHEOdy5PVg8KK2lc3tL/e4WuUSdMvP/hxe2OguXf8K6B7xBS6H6P73oUEw7ixFmlMFF5XtvO0seM32+74=
X-Received: by 2002:aca:120f:: with SMTP id 15mr3108464ois.132.1636432780940;
 Mon, 08 Nov 2021 20:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20211027181350.91630-1-nikita@trvn.ru> <20211027181350.91630-3-nikita@trvn.ru>
In-Reply-To: <20211027181350.91630-3-nikita@trvn.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:39:29 +0100
Message-ID: <CACRpkdb1LJkKd8L6XtbDbvenV7=nSLPBqKYkfiVH4UNO64c=Hw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: input/ts/zinitix: Convert to YAML, fix
 and extend
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        Michael.Srba@seznam.cz, broonie@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 8:15 PM Nikita Travkin <nikita@trvn.ru> wrote:

> This patch was previously submited here:
> https://lore.kernel.org/linux-input/20210625113435.2539282-1-linus.walleij@linaro.org/
>
> Changes since the original patch:
>  - Use enum for compatible list instead of oneOf + const

Thanks for picking this up. I was meaning to get back to fixing up the
Zinitix driver but haven't had time.

Yours,
Linus Walleij
