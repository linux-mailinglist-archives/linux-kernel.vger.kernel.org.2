Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABADE38D20F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEUXld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:41:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D4C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:40:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b26so16001298lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlVQ19ISRCpscjuNlAD4cWT0Svz2bcNKZPYIjMUXu1M=;
        b=aX1k9mRZcKVRXtR1fUzhOuJtGunx82/uhrILnRXElnoUtFojyFtfh6lKbXkKyAOQkm
         eCG9HEmcv5RFT0cmTvqKgGTwpgaUxW8HHxAMZjRYL+pj7yc6F5PiAXL2GlLYOCABMuwe
         8TpqU+dd6C0Wooth5OjLW6PoS8E8PcPFnL9YYBUd7Eakg67tvTvpilydshRA4EW5HjdF
         iVwisrwXYLSmKUqdALwYa1yTqN33NvgizZvl5E7zDLH9ndaFyLe18Zuu0Tazau6rV4bD
         V3CzJELMn7uqbz36Yvj/8OI4csslshgPR+sJ3wyeH+ZtKgMJnYCGyWknt7x0P6udQ/WF
         eO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlVQ19ISRCpscjuNlAD4cWT0Svz2bcNKZPYIjMUXu1M=;
        b=AyQufFXU59yQDXnURhml+YmENBj/5RcG4u5E/LNxyA9xD06sD3adp0rOgHMTelMhOm
         yVTUvDbk4Y5TNXM6LH7BqCCFkurMs3tKfXJJC72ov+ZSEvwFmskuOg4E/EyPy1dM0ZRD
         q2Mgs+0A5yTVxMNgzS/wAhdJ70lRQ2qcgI39zCrwHzghP7x+Sa/Rtye0u/8bIN8ofx62
         KKDEC7GndxMhMjvP1TZrnv/8MYOjLYHnPhZq7VTqgDW3peKGgtpo4N7Ws8AugGK5HOeh
         WrgMUydV7LhwMYn926SLv6f8pZDFt3qRHvgl+a5WeS5Np7aFnn/uBpX+kFSIm+19cpFE
         7leg==
X-Gm-Message-State: AOAM530KbxSaIuq8UTM0Z4JnOv6QwPa372gRYAoO3nG9SvdRcGSrb2kZ
        iBMyEGWLiDLqdXCwiwXzfZpumMJrExarH2vb7J/ttw==
X-Google-Smtp-Source: ABdhPJxvqTjEXujANJ0Q5EyvfpuNItFf1XQR9pdTLGePX4mVVjEnb0im2IRaX+dCIMf2w+qj2uRWQqY0J6afZcgtelg=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr3624563lfn.465.1621640405652;
 Fri, 21 May 2021 16:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210521193540.16164-1-clabbe@baylibre.com> <20210521193540.16164-2-clabbe@baylibre.com>
In-Reply-To: <20210521193540.16164-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 01:39:54 +0200
Message-ID: <CACRpkdaF6bOR7dkL2dhDy12XaKOWH6S8x-YyCOREopZ-KxeU_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: gemini-dlink-dir-685: rename gpio-i2c to i2c
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:35 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> gemini-dlink-dir-685.dt.yaml: gpio-i2c: $nodename:0: 'gpio-i2c' does not match '^i2c(@.*)?'
> From schema: /usr/src/linux-next/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied!

Yours,
Linus Walleij
