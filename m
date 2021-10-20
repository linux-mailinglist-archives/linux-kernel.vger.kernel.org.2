Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB3B434299
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJTAeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJTAeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:34:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E842AC061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 17:32:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 204so9301702ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6nsyJyFKfWb8ylGf29YNGR4cBIds20QVCnsCLesAU8=;
        b=kZPUFX2zWgXq/8T35MbOX4wBhZvNIdS32XCwQ0zEd3xUSQ4cwI2j+TFrAody1+bPW1
         CEB6S7Zy7jfwDWA7Lz+q++6rQ2+CiHYPq/wH/ZCIvC1qj8Pxf54jZnkCEI8MRu/3D7Xc
         0t1oiexsWI8wXrkoBr19wc6JpPk5ZwM5w1LkBVx/9nlRZ+nJ6zU5b62c21to81PAcwP4
         ZHN0ZAzVfK4VmtdTC2V+Zdimwvx+8iLVrmehBCKf3rmYY8YkFxXdwqq0uu6nq4p67zCG
         T2msed5ifJQgQJBrE9NfUEZvoEpkNV6i6kEl8+YIbyHQ1fSJ3sw6gnMoNRZm7S76y6Uf
         O8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6nsyJyFKfWb8ylGf29YNGR4cBIds20QVCnsCLesAU8=;
        b=Wd909x/YyIY+soj5Aq420EnmH5o1eR06ZHQ6z+9z04wyW1p5WmwhfITjvsQM6mELTw
         EdzwXbY8MB4Ih0uYa/2KWsF9dyD9oH0lzW3c+auo9UJNy2WGQZLtQFUF8+zrIAlLeC9N
         DESKwN4u/g5dhvFnf67POffOFBcWMxpLDoZODwhw1izVPhK5HhfdtdxGZ0f42jC9Kwkw
         0INhmwZALnEkYEFgyASBqFbu34RiEp5Gue2edYNQfCQ6EjWJpIBxGDwtdoaaZc3ABi/u
         z3eXuhelymjHpeZIXabTCcOvJmwiXhg+rOfuVaYugP4GndhbDd+BLy7wYvYIZ9OLjIzk
         hqEw==
X-Gm-Message-State: AOAM531rCwGerVT23HYF5asD5BDZwt+JY9mlnQuSoYPW1R1D5sv8C1iN
        05Hk9emYgQiRQjxfcA9yFTdJM4LeoeC56RmRRFoniw==
X-Google-Smtp-Source: ABdhPJyNNX26X7gI3vVEWzHVmm8QMVN0banwjpbRFYyd6X9OhGhOwQiNrXlozPsJY6VcLhi0JLxtAaASxALLAMmHtfc=
X-Received: by 2002:a2e:7f05:: with SMTP id a5mr9954728ljd.261.1634689949223;
 Tue, 19 Oct 2021 17:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210928192123.1840842-1-robh@kernel.org>
In-Reply-To: <20210928192123.1840842-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Oct 2021 02:32:17 +0200
Message-ID: <CACRpkdbJJ1jLk0npO4Hfb1jLss+N1nKes8b3vL-n7U_mqcFMaQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ixp4xx: Group PCI interrupt properties together
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 9:21 PM Rob Herring <robh@kernel.org> wrote:

> Move the PCI 'interrupt-map-mask' and '#interrupt-cells' properties
> alongside the 'interrupt-map' property in each board dts. This avoids
> having incomplete set of interrupt properties which may fail validation.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied. Sorry for the delay.

Yours,
Linus Walleij
