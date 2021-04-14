Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99435EE75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbhDNH3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348679AbhDNH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:29:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA5C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:29:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l14so19329196ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgKOIRuIsQ8kXdRwlwTu4ZZZzpH+5A4kyMAN1OTQ7hU=;
        b=aNINOsqBxC30qOUx5fl3WkPA5Mk9aMiC33A0aee3DD/EKIpXcqYPHs1UKb4VPk6jNr
         FKD55JILqObGYbRQIqW268PwVx0Ynzi/ficbdm4U+Z6+Zsvwl6rtpJGshQlubNEsqu0w
         UqryakdXf/ATlSn3A5/0qDKPZBH3ak3Ibc8uxlLQo7mbpQViaJj5GFYYtNmULdjy3yoQ
         3vut1tg+ZpzRt+HbrRGIESXFvB+3EUQ+8DU1MZE6sF1ReMYBiPNHm1rS8F6c4hYmUFWy
         SekA+BHgu5vimnblEKRcYRYOfe50jg90GKM5eaM0MDiu2WYV9ZfShS8lon8kPLwItAPa
         qNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgKOIRuIsQ8kXdRwlwTu4ZZZzpH+5A4kyMAN1OTQ7hU=;
        b=UfdExajJtp0LSGWwhEGmmkecuO8Fpyl2QyR/8y3oIGzbfDd6BF/f8P1LY+6GK9H2PT
         i6qaJwUQIHBkwBUstijljHA8Xfu0owq5tBPHCDkWltfi7BHmNP11I8DbKID9vTnzR8oF
         grdSJHwiDT6nP7hc+3o51tNThmBu4/6K9a5XGElGhzGWaivYuzkn4rfgGX/P63LJPXKm
         5ux+cs5keEdGinOCzgiEqKbN33GLAURWIeVhpe2ZkdekSP15M1R2ue9EcyPMdWF/FzXH
         BaMR8LqpsREQKwAHvG/wlfWa/7u6wqAHoAet6idW9FAnMVciJ6ub4M9f3LNdYuNFFS0R
         uv4w==
X-Gm-Message-State: AOAM5332WJkYiVw6PQc0XLvfmKYSgH3g99M/C6rhV3aEWN0TkjHgtWmN
        InNvt05i1F6GZyzVm9IJM0SOwsuothEkIGPUAzbWjQ==
X-Google-Smtp-Source: ABdhPJwGUEe1Q2DKoTdI1PeRAGjLOJHFbrqRHykxPfSLYQ0BB18t1lAwqeZ29W3m27G4qK8f5DlU6ZV2wgRLZ48W4jU=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr7593893ljn.326.1618385358966;
 Wed, 14 Apr 2021 00:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210411133030.1663936-1-pgwipeout@gmail.com>
In-Reply-To: <20210411133030.1663936-1-pgwipeout@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Apr 2021 09:29:08 +0200
Message-ID: <CACRpkdYU0qsNf=AonKR6MZg_oPNXkFnX7f2n9K4oZRBFDdtRow@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] gpio-rockchip driver
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Tao Huang <huangtao@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 3:30 PM Peter Geis <pgwipeout@gmail.com> wrote:

> Separate gpio driver from pinctrl driver, and support v2 controller.
>
> Tested on rk3566-quartz64 prototype board.
>
> Patch History:
> V2 - Rebase to latest linux-next.
>
> Tested-by: Peter Geis <pgwipeout@gmail.com>

This does not apply to the pin control tree, the problem with basing stuff
on -next is that it sometimes does not apply to any development tree
and now that happened (because of conflicts in the GPIO tree).

You can either resend this based on the pinctrl "devel" branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
... or you can wait until kernel v5.13-rc1 is out and then we can merge
it, but it might even require rebasing after that.

Yours,
Linus Walleij
