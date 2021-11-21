Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E14586E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 00:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhKUXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKUXHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:07:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9BC061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:04:10 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so26078140otj.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKUzxLRhbxmNcnwsOFKDQdF/Nr4S67ZStxmJXr/lOM0=;
        b=zSoZ2TqVC2lf3rXicbt0O+mrUpC+dHa3Y5y9BHWx7Ozsd61qvo7E7h6E+ZWsZVIt3g
         sAB3mKzhD3v/qyxa2UFPNHDn/Z6O7j+rSJqDvUk4na6B9evZ/h2GbCsmyQZXzyavR+vo
         uruDWWRGbRXuYbjdovFC8H9XnZzNLSebSXyw8n4xggjeqN9D+xXMVhj+JTzaT74lnrLF
         ChCP7/RS+7lwbojtgCfFKSAa7XmsDo4yfdkO8a3Eg3hujUDn1NXqkbM4XaipWcY/rjWa
         n/h1DRcLNtxSF4W45IDam/Q+a4I4GakkyAJGQMSDTyJNFuQxA6A5AZJqYGcp8luoVB6x
         v8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKUzxLRhbxmNcnwsOFKDQdF/Nr4S67ZStxmJXr/lOM0=;
        b=V7A5Ym+V1u8bnHsWF/oYLz1pBRZ1LULlvTRXo8U1WZcioMrJM5GbfpoKylFodu1xqq
         CXxxaBs1rimLM6+HsgzbNEVtKYAXoPHQOf49Astfe9dbFWq6m7ZtHQmnWmoBZX+Q1WBX
         6gdONXS5r2yFUYXBe7wnJrQ92VQrCTMR9HhChWEuX+ZFyBDQd0vm4QRQRoEr3SmrvFD8
         p3frA9XiNRIBBa4aSV8eb3larP//Z4mnS9dFu7exm4vQq5nPNpVpZgdGIPnyPcU0hDXl
         ysuC/VS4Mzi/g2aDWdp8luqSdTtjyv9cjZWJaJy8bcvzC3AphK4Kvn6aL/qIyjQUpBEe
         4QYA==
X-Gm-Message-State: AOAM532ACpr3YYg1sAyxwX94Nk0MuQumkGAWKlZbZZMiyNxPiGCRB8iA
        HcFRUR4qmsRK8rhxu1eeG1752PreAt8BErLbqzZsOg==
X-Google-Smtp-Source: ABdhPJyJftrJGkaAE01C15jlXvMwwX+b0zacf33mq/QM8/O1wDwdW/TxpLreaxzKiJSOjfGrlzGJb4lnENCZH8brIsE=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr21329974otg.179.1637535849462;
 Sun, 21 Nov 2021 15:04:09 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxBW0qM06i7TvFG+8HrwbR1eYR+9Ed648aZ95mtXiA7Tg@mail.gmail.com>
In-Reply-To: <CAKXUXMxBW0qM06i7TvFG+8HrwbR1eYR+9Ed648aZ95mtXiA7Tg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Nov 2021 00:03:57 +0100
Message-ID: <CACRpkdYfqrSOJYh9trvcioBAVXZRZsjhNEgxpCNFtpjJCPrMfg@mail.gmail.com>
Subject: Re: Removal of config MACH_FSG and dead reference in LEDS_FSG
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 8:59 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Your commit b71377b3e1e0 ("ARM: ixp4xx: Delete the Freecom FSG-3
> boardfiles") removes the config MACH_FSG. Hence, the config LEDS_FSG
> and its corresponding driver leds-fsg.c is effectively not selectable.
> I do not know much about how with device trees we ensure that specific
> drivers are selected, or how Kconfig build dependencies are combined
> with device trees properly here. So, I do not know what the right
> patch is here.
>
> Was it intended that this code is now made obsolete? Can this driver
> really be deleted?

Oops no.

> Or does it require just some further adjustment to make the leds-fsg
> driver productive again?

Yes. I'll look into it!

Yours,
Linus Walleij
