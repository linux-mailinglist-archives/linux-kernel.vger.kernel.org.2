Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935253972C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhFALsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhFALsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:48:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38016C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 04:47:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s25so18749121ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItCVrZoVYv1v/xorZesjCk9X9iKX2f1cF8KOjlONSD8=;
        b=dHa0W5r/jaxOkqLf8O4d5U3XeqmOyFo1o+aqIJiY0wAu40HLt7tkxoxI+zOcdmDliA
         /JkYXVhVXUR1hmY7dqM5DeN00yMMBlKNR+7KW2ZxB9kHoIGfuhtwYzVkm6a7aZ4gc7mT
         0YZ9GHPty3nMIuOgIChlhaXCEX182EeCC1R3zGBckqTjM6KpfDpfPDid0QFvoaq6RbZj
         0d4UodeiOLi7iLIxrBpTvBrfuhUUnA/Kmc8E7Ad+GRSWTNzI9tLcHbxxWWQQUbO6rPY5
         VPzod4tqQZksgFGDr5xuqCraD+nTWQi+0t9NTGohzgS4CDy5jnOjHuTfFGGAp3Vs0bdu
         l2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItCVrZoVYv1v/xorZesjCk9X9iKX2f1cF8KOjlONSD8=;
        b=SdQNwJU3PsfQ7maMM6Oft8xM0bbGPlO8LQKn+ZF34iD9GbNSsrOaP0OdxjtwzorNIl
         6Z8Mxa98iYPluxRxarcVIOGKZPAH8WoOBGRaqO+lPqxRkK4wM8Y4ZIHRRr17fi0yy2Hk
         ZGfvl2VKrUg+WDKUuN3HQTKVSGfuhoGp2MD4j1pwqsYL/IWYk56tVm7vqMx4AkVFntY/
         4HWnKd5HzDZ6+7zHRWFcxM+2/Hs6MiL8TSPVT2V1PcMaZZb6z20XyBqXzepsEMJcn4JS
         7owXrWIBCtnEFcKVe6xeayn+JACEE8vkTilkzTUfh2UliElNqsmS1g+fbGdbmVq5E4qC
         TZYw==
X-Gm-Message-State: AOAM531p2NsFcHJnOt5rtR8NC+wzOeLQ36LK1+4BkJo97pqk6dnWwK26
        EIhAPpjxMDpORdi+3k5zkvru9bpyuapSFfRYtHleMQ==
X-Google-Smtp-Source: ABdhPJzphdDpBI1vj78e5QFB4+8vwKRJMltmceYRijPXZT1d0zYnBwy8BBP/GtL4PeK1itYSd4lMv/4xJ1YfDgZ7PwI=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr20764012ljt.200.1622548028522;
 Tue, 01 Jun 2021 04:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210531120753.719381-1-iwamatsu@nigauri.org>
In-Reply-To: <20210531120753.719381-1-iwamatsu@nigauri.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Jun 2021 13:46:57 +0200
Message-ID: <CACRpkdaqhMk-0mjUhENWODSjdc1uTSnVJ3E923kRe9t-nq33+g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: zynq: convert bindings to YAML
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soren Brinkmann <soren.brinkmann@xilinx.com>,
        Harini Katakam <harinik@xilinx.com>,
        Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 2:08 PM Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:

> Convert gpio for Xilinx Zynq SoC bindings documentation to YAML.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
