Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9D38F6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhEYAZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEYAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:25:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B9C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:24:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so35870865ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67r0IyTNKB1ymOtz0XDUp8t8JuIpjQtfAAPkETfacjY=;
        b=GJrle6GDtL8Vz7erdhdN6uADC6azVv6HIoWn1wjYxJFpu+/+6VHSwgQY+C0XOPTMRA
         iDm4yJPjnwvtnEjayphzTvZCZfxld0LxvIiAtvLryd8mbm+lH9+Uf1XbjiFuAAjsGMkW
         HC3+TTcbsTyvdCaD4UU+0rQV5e/LlaB5zpzyXgTA5cdG45dbW8vBxxsmhPTLFNTXC5Xr
         mi9IGoQvMKmXkErLCYn2SW4ociWmRui0ChMWCZPZZHQiCommEd8wo2TduWSDZPsJqpC1
         +8W4Sm9mGUaXQ1mv+DTuXEsGltnfBR0LSLmtbD/0tdEplHkC6QWBgbWinuUSVx+gol7g
         VPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67r0IyTNKB1ymOtz0XDUp8t8JuIpjQtfAAPkETfacjY=;
        b=hV1n2eiA1JKoOhiSCjAbQyQ5b0TPgYgY0yAHxNt8aWaRRj0KM+4dslQt2iB0jQym9c
         OlJSQJZckR9wzll2QZNlpS6GO8TQhk4oaMjTtZ1dnpy7q8oghWgxowtogQ4k6hoo4LTi
         8TowNrtTS1qzL2OCJKgwqp6RShZyz7UssHR1H+FsQZwDF59skHwJp/5X+qd6F8HOze3a
         X+1oMMowefoszkSorJYhD/IRbomxkmG7TeGi1Ms/Fed5HMlOLBY6D47FYXWeq/K7OYdR
         yj6ouUN+xYfPO/jv2dD7lC70euMSGvfShg8fSVozxHY61HW92CcO6iJ4fF1D07ozdLYe
         0IsQ==
X-Gm-Message-State: AOAM533nAtq0clcygk7OpJPZ1BegcPXt3DyfAzDJkkJbGHh2jYr9AOfg
        vy0vKHWAMCqqWDt9zaWKQQfZ24spjul0UHy4vyux40mBRQU=
X-Google-Smtp-Source: ABdhPJxiz9uAg5mYC26qFwvFgWpntOH8FLCCrNFyNdBKjLbBKN+cJdD5HzDY1N6DT4gjxKfpK9gw1UEMeEk/qWEsn3k=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr19398398lji.326.1621902238056;
 Mon, 24 May 2021 17:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144819.664462530@linuxfoundation.org> <20210512144825.099918971@linuxfoundation.org>
 <20210515081814.GA30461@amd> <55d58470-f606-8c75-1f00-a2eb09314081@linaro.org>
In-Reply-To: <55d58470-f606-8c75-1f00-a2eb09314081@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 May 2021 02:23:47 +0200
Message-ID: <CACRpkdbr+grtuF3A-QsmDYWK+oDTQ9+DPkPULQRfnswPZRgOOA@mail.gmail.com>
Subject: Re: [PATCH 5.10 160/530] arm64: dts: qcom: db845c: fix correct
 powerdown pin for WSA881x
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:46 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> > Do we have corresponding driver in 5.10 and was it fixed to match?
>
> This corresponding gpio driver patch was submitted along with the
> original fix, however it looks like it was not picked up yet.
>
> https://www.spinics.net/lists/linux-gpio/msg59264.html
>
> Bartosz/Linus W, Do you want me to resend this?

OMG how could we have missed this patch with so many ACKs.

Please rebase on v5.13-rc1 and resend with all ACKs so that Bartosz
can apply it.

Yours,
Linus Walleij
