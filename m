Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F150838D22E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEVAC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEVACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:02:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E9C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 17:01:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r5so32070664lfr.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JY/OUqL4bBCTzo6Le0caUcIipVW/mIwPnm3m32VS034=;
        b=Fmr2Bhm7uDB7qyKlxXJlogDxLShM3HFnQ4Q6tgtBPiWtUHXOGmHsSbW43lUDImcpKj
         5DEYIkT1dgdjXtwhJ0a+//4JuHI8/zNpOCVovGzMbN7qR+G2HhIqJmaT42pqdvvl5+M8
         /OIqwiBSH705vbcjKAUV5F0bCz6RFblt+V4Fqd028lC0XCtYguihh9tmi5LMQtAtsb5C
         6w8OJ63p/wSclT0CB64H1tiMr/cNdBHOCi4ksE0AnOZlLud6pAloBN6tlrz3sdIjZevX
         x+FlLfivFwLNIqHNW4fkg8sqny6RQpKT/VmnDMhxOFs1+5RyaHWqWd+GIJJWJADYpX5n
         WeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JY/OUqL4bBCTzo6Le0caUcIipVW/mIwPnm3m32VS034=;
        b=EwzUdAh+oiyj5wo/QMbZXfUjKLKlbTAlhs1vCO1paKF0/YCxR2jMi+yHi+GrilBpbD
         w3KI8g58vVQijEHHmh1LzY5Z5Mv/1ApPrsZDESXv+f/bjE78WDPBN/uzOKvUDjrX+m3s
         djaWiL4kGm3ygyLig4wAoqkAWEgGCFIQwaggjPX+3HfQN1aA2gdhJjnYmWuLsCtBNhXq
         7271m0NCNIwysetHDMegFR+nU626ILRL6ffVXRHgh3XniHVHlks3OvD9+R8fwM369+kl
         PgVrISYhtrxODyvbPva79yqFsl8xInvNgah1vTk6RkyLqVPpMA4BRsX9Y6fgwZGCR1TZ
         J3Fg==
X-Gm-Message-State: AOAM532/GZJgi0SzCcsPRfZKO6f+O8R99v+HHzQnkZrAyY7heFjxxBh9
        x3kENKX+vdpjlKOQScfq0oN+nM/X/ZFL47/R4ExDCg==
X-Google-Smtp-Source: ABdhPJym+3TcDUuV6t+uigQUEPEeeUhtaeE4bcPuSKCytE5CkAKLsE5XM+M6M9V5kCWrMKcKnbkt7fSKjiwvj/uOxzo=
X-Received: by 2002:a05:6512:1185:: with SMTP id g5mr3791888lfr.586.1621641686778;
 Fri, 21 May 2021 17:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210518141108.1324127-1-yangyingliang@huawei.com>
In-Reply-To: <20210518141108.1324127-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 02:01:15 +0200
Message-ID: <CACRpkdZZL71K0rST6ySZoGpY+eeu2gaOj7Z18LQDtHugdMFzJw@mail.gmail.com>
Subject: Re: [PATCH -next] dmaengine: stedma40: add missing iounmap() on error
 in d40_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 4:09 PM Yang Yingliang <yangyingliang@huawei.com> wrote:

> Add the missing iounmap() before return from d40_probe()
> in the error handling case.
>
> Fixes: 8d318a50b3d7 ("DMAENGINE: Support for ST-Ericssons DMA40 block v3")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
