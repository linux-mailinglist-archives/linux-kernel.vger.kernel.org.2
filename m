Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72493A5AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFMX05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFMX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:26:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88500C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 16:24:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v22so17982204lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LX8djcFDE6EP1q+j6q4heiZPR2laaaC2KAlvm+CZBg=;
        b=v1bFFGIm/IK1Xi4cWQgSUjcKoHdhUjhQe9clg9fEl419oO7GqysAUVwoaJSCzreAOl
         TK8XllNUO98Lf701epVkUeEXZMNkWutYxIMjtU58bXrpH/CzObUUxJKL9ERCWAlMIlvv
         gogHqN1sW92dSOMpkj3mxIQq+S9Z8WHA+5idFiDN2a64Vv69NqkPSCj9Oom4UVQhKexC
         CDgtP7plJfM/2r2epPrSBYfiX5v2J7AIPJW8NEztnicV/HvRl7Mkku8pCIw29oZGe5+O
         8mEKc1BQkmQ3P3Qskrl+IishScsxCDLPRdQmObkHh+mQL133mOUsxbAe5qwvViH8Jcqr
         NfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LX8djcFDE6EP1q+j6q4heiZPR2laaaC2KAlvm+CZBg=;
        b=AiWLRC2VAfnShhJQF4mgS2I4PmV+YkVCyDA7dG0svMyEuaxjx6wQCLPySxpVsml4RE
         9AuS6VdrfT/uC6kyWr+l3Ukj0MzvjCbVxwq7NjssPCqOTvZc3UYh8B/jImHy+8bkHXTs
         +saeyENxjFF4dIE/0A24l0NPLPcOF8UCFNhTAd3oIYtY3JPzC/It4Q8En9q1UyCNkW4t
         4+uI9wgaCncg9VoHVv87Qnh0AxgOXUVyF4w0JHcuARUCmeenm3SGlYYmFZJXMTkeJkrt
         wl9GXiCmlR1gPA6rNo/6Z0Cxaxq12tnlQws13mYWilcTN/GGTe6vCmSuEin8yEu62C7g
         fl7A==
X-Gm-Message-State: AOAM533K1MkgfEgDDXxz29EB1+bmm2iEMRf8s18q61AqIyi9FvElPAQ0
        ScbJFvsC9n6ByTHDXq8TGAHS6ZdkFGUBEMsVXtB24A==
X-Google-Smtp-Source: ABdhPJxAmJqouBLRHK9vapOoB8AgqyYhqhda225jRWZDJ5nVLAgKab2TUi3hUlyA+oBy0EhiOJ1ZVkrhCEpwcXvpWOg=
X-Received: by 2002:a05:6512:20c9:: with SMTP id u9mr9891191lfr.291.1623626675791;
 Sun, 13 Jun 2021 16:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210613120608.1527394-1-code@reto-schneider.ch>
 <CAHp75Vc5LRRLc-1A5W4BVQ3QQx-+4Y5CUjG3ksosVdPEecEyqA@mail.gmail.com> <db862b9d-2003-08f4-6856-26fb4870caff@reto-schneider.ch>
In-Reply-To: <db862b9d-2003-08f4-6856-26fb4870caff@reto-schneider.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Jun 2021 01:24:24 +0200
Message-ID: <CACRpkdbSv0h6hB_yR+_ZC3vxSUOkaa94EzCArSaSC=nvc5AT3g@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: mt7621: Assign base field in gpio_chip
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>, Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 5:51 PM Reto Schneider <code@reto-schneider.ch> wrote:

> I did some digging and indeed, it turned out that I used the
> pre-mainline GPIO driver from OpenWRT even on Kernel 4.19 (for which the
> current driver already got mainlined).

Hm isn't OpenWrt switched to the mainline driver?

Another thing we should do is to add libgpiod to the OpenWrt
base distribution so as to encourage people to use the character
device ABI.

Yours,
Linus Walleij
