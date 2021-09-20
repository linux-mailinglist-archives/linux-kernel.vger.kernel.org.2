Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A84115EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhITNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhITNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:39:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18337C061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:37:39 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s20so13491932ioa.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5BHUeQDqZDo4PwVzyGcKr+XMnBx8AVg4XoTAeI0iqM=;
        b=OegjK066w6oG7gRN0w2LsPZ/Fv/QnITUWWZ78nIfMwlypU716TJKqUT0TONaDnqeM4
         Qn5TjM3MfoX9BTkw8UjiJKnLbAvRjxWx6Bd/g0h5V3sDx6F9VIDo8eTYODwO8CShIXAz
         Za86JxoW3m0estyg2kL/936/mTvJEVyJ5e+Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5BHUeQDqZDo4PwVzyGcKr+XMnBx8AVg4XoTAeI0iqM=;
        b=v7/mneg/VlbimCgRAeEOJyPijEU4adRugK28c4fKt2DHCCkFqo3uzR+7RxYip3govJ
         Vn0KfNZ1/J/Hrt2LHBQqm6R4R7VJjBVxyD4E6/5hyswqCNP1uakuxGWRQj9kxk0bLRlc
         Z1eYzvrdEZNb3HUgjsjZuxplGDBBnFalJEMJY4JorjAx2fc52HEZ07w9PwdIOzH29cVV
         OeG76tg+9hlhYBcBIDQPle9rwb+kbL+KdaGu9xJ5PKGBurCv/G0uWzc4gO1EObtHtc9q
         aIbuLRIwfO6SC+/ejPiZ8+9QmdmOVhIbTegLhevzx+aFXMpZTjYMVsPHm7z3OtTf6tMn
         kflQ==
X-Gm-Message-State: AOAM531Rd3jeiJQj/Y5HuSqWRPKkfydinmGXfRWs5uiTgl2OEdjNKA+h
        Pe/pk9gTA/pcRx4yLo1b65aI3NETD3Rg6Q==
X-Google-Smtp-Source: ABdhPJwxfk4SMD10W2Kg44IjODHiM068s652/0d9kRah39Gi5dLJ9xwz/ZUXv0jOMIz9nmLmbWyQGw==
X-Received: by 2002:a6b:e70f:: with SMTP id b15mr18671480ioh.140.1632145058085;
        Mon, 20 Sep 2021 06:37:38 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id j5sm9090797ilk.58.2021.09.20.06.37.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 06:37:37 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id h9so18675707ile.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:37:36 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr14574906ili.142.1632145056490;
 Mon, 20 Sep 2021 06:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210920100226.1448267-1-arnd@kernel.org>
In-Reply-To: <20210920100226.1448267-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Sep 2021 06:37:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UYOSNG1we=MaNwqZCLjV9re7hHSvtYR3qmzAaLCvDJ=g@mail.gmail.com>
Message-ID: <CAD=FV=UYOSNG1we=MaNwqZCLjV9re7hHSvtYR3qmzAaLCvDJ=g@mail.gmail.com>
Subject: Re: [PATCH] PM: AVS: qcom-cpr: select CONFIG_NVMEM
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 20, 2021 at 3:02 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> nvmem_cell_read_variable_le_u32 is only defined when CONFIG_NVMEM
> is set, otherwise we end up with this build failure:
>
> drivers/soc/qcom/cpr.c: In function 'cpr_populate_ring_osc_idx':
> drivers/soc/qcom/cpr.c:814:23: error: implicit declaration of function 'nvmem_cell_read_variable_le_u32' [-Werror=implicit-function-declaration]
>   814 |                 ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->ring_osc, &data);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Select the framwork from Kconfig.
>
> Fixes: 6feba6a62c57 ("PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

A fix should have already landed for this error. See the patch:

https://lore.kernel.org/r/20210830083449.1.I38e95343209fe1f808c3b4860795a00a2b539701@changeid

...and Greg has applied it. I got a message 6 days ago saying it was in:

    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

That being said, if people think that we should _also_ select NVMEM
for this driver then I have no objections. The use of nvmem in this
driver predates my patch.

-Doug
