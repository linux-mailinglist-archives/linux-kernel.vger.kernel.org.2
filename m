Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA835EE33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349587AbhDNHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349581AbhDNHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:13:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:13:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u20so22149723lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qj0MrsT9MP5e9TP+dMw9mmYBXbSrTZPaBuJ5U6SATfM=;
        b=VmhuoHIcOki+zO4haBZBKfw7hojfMB7Nw0INkxjwf/vBzvZ7iYvt6XBll6SNoIle4r
         pB5Gvpj5/rJUHz0zQEV+nlXGMLOAEWJNTOTkWxk60N3fFyJb0tjIbRwiU0RKUGs2fYsQ
         bYYdCOzzmtp2F9hkIu1ANqoKCMSY+0gzbWuKMwwgooJOJQsuTqE9HhJJJ3MQggWOslYd
         9uuB22CtOAjy+7GArD2AA79musxSr5z09NoNhvwBqrVaMmq3KnyhdHhFq6wOlL7tMwL5
         LxivJMkFjmCuQXFQlLVCEUmPDsgf7rrWqJDiZd3cem9W6lzUqytJzaDTBm96gz1fx8Gw
         dDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qj0MrsT9MP5e9TP+dMw9mmYBXbSrTZPaBuJ5U6SATfM=;
        b=loVb8xK72h4UPyNTJQERqvNqRrXVJxcIcC5KQwDWBu1XUr3AxxLDjmHC/cLeNFiCfu
         yyejQzwIXzjYO82jd33VbwqAreBRgnlBEl2n6wMa0UUKLSjYEycs2MQ0N6klQ+U6Q/q6
         rzy/UqYIWW6D588QqcPfVefCiaAZPSczu4Cb0hOcK2Ry/6GZ1kGfxFn12x1WmFFxbxTo
         93AOpY3O34K40hVJPTC1cdxgdK/khWfTh9r8uiGMVBmRpyOoYUPsUrpRTwgVpETtpEc6
         rrprXoj3vD3RGwTy0VDCzoPAWpS89TAs+1g5PtnQWheY+uV2BL3wXnqZcY7MlUOG1T8+
         EF8w==
X-Gm-Message-State: AOAM530N3MN0uiPx/OThe0dtTvTEzU81Eyd3NZ/PQz2lC25IvD99CGYw
        J/Ig9OuSFsnEj3RBaSoHtOl4qZ9hLaASliqeHMOVRA==
X-Google-Smtp-Source: ABdhPJzdQYN+OFaEjUwuex2WL91l2G0cQ7jC6a5Gr4VgWvGVniRwFeGdvxQ+vEG70ZSzlMCTweKJjZIDCuUm6uChqLI=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr23239380ljc.200.1618384388240;
 Wed, 14 Apr 2021 00:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210412223617.8634-1-jbx6244@gmail.com>
In-Reply-To: <20210412223617.8634-1-jbx6244@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Apr 2021 09:12:57 +0200
Message-ID: <CACRpkdZ-oq4zKt_qOYTNCL7XqvJygRG0gfb9jRGVi2XRiE_3RQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: gpio: add YAML description for rockchip,gpio-bank
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:36 AM Johan Jonker <jbx6244@gmail.com> wrote:

> Current dts files with "rockchip,gpio-bank" subnodes
> are manually verified. In order to automate this process
> the text that describes the compatible in rockchip,pinctrl.txt
> is removed and converted to YAML in rockchip,gpio-bank.yaml.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V2:
>   changed example gpio nodename

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
