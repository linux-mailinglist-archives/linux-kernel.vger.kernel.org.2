Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20D3414516
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhIVJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbhIVJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:28:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02507C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:27:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bk29so7363522qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5r+ZHmLBKiHQX70H5Ts56LudGzMirgnfs/7sEqKhoI=;
        b=bVtsQFphxv+PMBaFYpCnAOxW+4TF/zNObKBiv3jRnZJdKhXF+sN8iULpqlK7nv2udy
         EFb/O1TB3/yIDF4rt46bIctXU6lPtU6iMvapZQmNuvknsnEDRnHgSWodFUUGViCMXghP
         1OzvUxhpmggDrW2jiODD41+Dzdk54eUo2x+FRmoYy2myVV5x4bPNVjs5RJ2RqJieRDfk
         3a9GgMgnnNVwWw+TWLF3ueERRzIHuEXN/MqGTYOJaQhhwNlOs95vBIKE5CYhR9rxL91c
         O2KJJbKrbsU8N8ypJhrTM0lI6dxSxjzYVumuURPCeYmmV7vUHm94aFDIYwsGQ5gKVBSQ
         HagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5r+ZHmLBKiHQX70H5Ts56LudGzMirgnfs/7sEqKhoI=;
        b=gb8pJPQVOLAWWqCQzf4VxTUXAkCrWwiZq1GxwCsiou0IieE5KNNKQFkk3eJBcIpBE+
         gRPIm20cXa+SrwLsB78/yvvN887LvkD+aSgSwyGD37I0wMV0zW44U7okhhkO5pg7wJ9a
         flZRa/A9mPL8OiAQtynLlqH0C9n6IoC3ayA7WGhtsSjIOWq9MqMQ90TgFHKNTNhjjC9/
         1Kb6429DjlXA7yY4ZrGV+ggWGSns9N+4bNSvlR/UXkY1qUVjoOf0DsfgqtFndtDNRjKz
         vBahSHGzYG75wllYqQlAuNUf/IEEfktJ8KF1Q0HFsZbc346OE5tmfIWf/00dQjPPDgK6
         qBoQ==
X-Gm-Message-State: AOAM533/4Bwsik//PQuN0StEa8L4M95Z2kqpHgePfA/M9bZDdx5b9cxQ
        XTHTN8q3Z9+ipuNXjCqjthzL/BpoZhsAsYlMbpnm+Q==
X-Google-Smtp-Source: ABdhPJwH8elDXf5KgspL13jX2tuE0QijykSs4P2ooWi/01P1LoJpz19UTo89aNkMG8go0fKysFrVB+WfuWILVnzwYu4=
X-Received: by 2002:a25:cbc3:: with SMTP id b186mr42620852ybg.199.1632302826203;
 Wed, 22 Sep 2021 02:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210917105412.595539-1-thierry.reding@gmail.com>
In-Reply-To: <20210917105412.595539-1-thierry.reding@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 11:26:55 +0200
Message-ID: <CAMpxmJVhmeiE7vR4T+U7zDeqounqRNdTh9sZ6SEdqtyVM3E+og@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: tegra186: Force one interrupt per bank
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:54 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Newer chips support up to 8 interrupts per bank, which can be useful to
> balance the load and decrease latency. However, it also required a very
> complicated interrupt routing to be set up. To keep things simple for
> now, ensure that a single interrupt per bank is enforced, even if all
> possible interrupts are described in device tree.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Applied, thanks!

Bart
