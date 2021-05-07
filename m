Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC45376BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhEGV1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:27:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC93C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:26:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f12so750400ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG0TLyszi1cmh23fmH0mhN2WgCliBgRLG2x6Fui/g3w=;
        b=hodjiOCfhaug0X3p4IQrL+WcbBvdiThSPchin6eJxMJ2dt0+Me5jQvoBuO67weHHYO
         fBwbLAHWSc9YUyFTQBloGw9B711VjCdTmpXZuh+/yia7xVM6xvl3x2mDefdrS3xYtcO1
         oIetrSG0llXe8YfcymcicYd6DR4droaELRHIVQbG6772pm9JUeoevm+ZO0H1yUzrt5HW
         rnOFfBTK72QJF83XqkEEv2/X8bCQzubEAFkLHQwwbVWpETkA3QYN3MmHGCN2KEYdhjBT
         AfAbjC9daNgoeNwLXGtKfJOeza28WvCd2mk4UQ+0d2i6U3BNsJ7zrcX5TmU3Tl+hAWUi
         nyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG0TLyszi1cmh23fmH0mhN2WgCliBgRLG2x6Fui/g3w=;
        b=MANEFA+jMWYJimtfXqYL+WbjvS71Ab9m4oDDDW8rhAVyj49kgp1q6+8JQwsbiMmLeW
         6YkN7ZDZIZi4GLAo9tPIHJ2bb7P/Wi+fV5wPdojHK9p+AcvKSvFMitCOJPTunngSb8C0
         c4HkBRUwx7aXfqwUxSreoM99InJrNWeT6bcOsByFTuL/3E0Kos/OmwJgagL0X0TyypO3
         Hqd4pBVgmtYE5Lc0n9QnVog2r97qPKPNotR/lLHkqn3SCsYvx+DeXkeHZ4Jdy13ic9T+
         Ri9pMtP0rpyVbKv/v6cdA9VPQY/axQzKib1PmXQRXN08pek48HSjZd64haMCsOWMvZW8
         Ag0g==
X-Gm-Message-State: AOAM531jOn/GOAlnh4YpoJg+DMeTcopDpdcQJ4drRwQLUqKBzXeHvzW8
        LrngUVzAm3uA8ZQ5S4Ypsrr2X0xxYw9lNHdzvKUr3A==
X-Google-Smtp-Source: ABdhPJy3z0qWS5Sneh44i6pk2oO3OOciepj+d38iIgI70000KRkNiArXJwFb6hKxgj5G3aVCUF/o8itqFyKwsM+AULo=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr9286103lju.200.1620422781142;
 Fri, 07 May 2021 14:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210505134028.13431-1-jbx6244@gmail.com> <20210505134028.13431-2-jbx6244@gmail.com>
In-Reply-To: <20210505134028.13431-2-jbx6244@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 May 2021 23:26:09 +0200
Message-ID: <CACRpkdZZ-FZn6Q3w6g=FayOzpUW4ZfenQ9Oxe0+Co2RyYpTZLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: gpio: convert rk3328-grf-gpio.txt to YAML
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Tao Huang <huangtao@rock-chips.com>, cl@rock-chips.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 3:40 PM Johan Jonker <jbx6244@gmail.com> wrote:

> Current dts files with RK3328 GRF 'gpio' nodes are manually verified.
> In order to automate this process rk3328-grf-gpio.txt has to be
> converted to YAML.
>
> Rename 'grf-gpio' nodename to 'gpio'.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
