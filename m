Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3F357E01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhDHIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhDHIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:23:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16865C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:22:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g10so631355plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZq0jejn6N+JX8GL+6Kd8YjO9l0DTf441L7DW7TCgZA=;
        b=zNdp0UN5zNh0Hn5Z1TCZ3xDcFAQ1A/npFiMYR5jxw8W9T70kCTfHahKhRJNaJxEJuY
         gm3/GSjfxf4P8/R7Q4czouby1tKYVRbqQul+1WmrYzcctkyWhY/yfz2YhWmMiqFbzE66
         ixXoeBEY52sm6xSmwSpa1ULA8Wd1LLT9VrotUFu9dOUwjiDIoXHe5MI7f30fUPDnL2yS
         je+hFLdA8T/TQBQb6qsZ68IKwKkzNqvvARWWtgq0Zf0mO9l5eLn/CV7QcwSqCJNFZsp8
         QkFnz9hWN58yypkk9hbrTw1P4PA05Ndb2lyi2HD4wTW4IyFAVQg+9KdcSix6f/aQjk1m
         BOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZq0jejn6N+JX8GL+6Kd8YjO9l0DTf441L7DW7TCgZA=;
        b=fUppG0FMCmJhk/K1D4HSm+zXRaTvacEQ028/gtFoQb3dlG8paVkopxDI2VC8idpIpv
         ttVAfBrWSFUylLjKh4BLT4N/8ehAUpQ+5HR+HvlJWVgFo2SHvxsxc7/urCOykv4Rjddi
         ObjaQiLB/HETDuprNmRy5KKBJvtyBNtu8b/kyWMWrmKYtxBmW4HtJcruJghVHpu9YtEQ
         GrR3ud8CcpTvgkDZMxpZBZZbcHYAYpvMzkUEfnJ8o41IpBbWwWJnxLOOMG1sIV0OK8/G
         1zfmdXA20G222rxAsFdzSlJ7iQ7kBFGfbzJ5S5iyDeGrb3GOnNK3WyN+HFvjXebRvsZR
         F3LQ==
X-Gm-Message-State: AOAM530Q/8VRvG8vC52wF4kztLy+Cxzy7EUOwIAz+mE8nGkWkFDoRPd7
        WIIcRBQAtU/pTq9sqyLfQUzwtUM4WIGA31tLb65kyg==
X-Google-Smtp-Source: ABdhPJwGCM6bLS59WwupekGslOIZhBXBOCosyKkekU0nP0w9L5cuaeswRG9jxwFqCPpkR2ye5T4uJnMqVad4uqt0AJY=
X-Received: by 2002:a17:90a:516:: with SMTP id h22mr6869903pjh.222.1617870171527;
 Thu, 08 Apr 2021 01:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210406090733.169989-1-zhangjianhua18@huawei.com>
 <CAG3jFyvC6ozPxQ=TPdPgLAugKky5AhOZGJSiw0Dc3Kn5Pba0cA@mail.gmail.com>
 <d9bd5abf-0293-6155-dee0-20199fed1fc0@huawei.com> <CAG3jFyu6YY5pr5bdvqAbzZu0GG0z=PWP+JHL59G26cg0P=563w@mail.gmail.com>
 <a40abdd7-af43-28a3-1b79-0de6ca0c0093@huawei.com> <53492034-4cec-12ed-ae27-d693686084ee@huawei.com>
In-Reply-To: <53492034-4cec-12ed-ae27-d693686084ee@huawei.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 8 Apr 2021 10:22:40 +0200
Message-ID: <CAG3jFyue0Jydf+mK2NxzLkaX81VPuuF8daXC0DFcNmjnfzOMDg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/bridge: lt8912b: DRM_LONTIUM_LT8912B select GPIOLIB
To:     "zhangjianhua (E)" <zhangjianhua18@huawei.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        johnny.chenyi@huawei.com, heying24@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Zhang,

On Thu, 8 Apr 2021 at 09:10, zhangjianhua (E) <zhangjianhua18@huawei.com> wrote:
>
> Hello Robert
>
> I am sorry that I make a mistake about the compiling error of lt8912b,
>
> the reason is that lt8912b miss the header file <linux/gpio/consumer.h>.
>
> Although there are many files reference gpiod_set_value_cansleep() and
>
> devm_gpiod_get_optional(), they all include <linux/gpio/consumer.h>
>
> and not occur the compiling error like lt8912b. I have send the second
>
> version patch, please read.

No worries at all, and good job finding the real issue. I'll have a
look at the next version.

Rob.
