Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E07374C25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEEX5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 19:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEEX5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 19:57:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 16:56:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so4686837lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fw7QXJGTsrjr3zuPRgQiAU7U58qxLFo5Weq3W8UeAIk=;
        b=NVEql6v3DLZu4uHy44aAXvAF4LKSO9D6LCN+nDL+InoVa0ZnV1vRTtG+SsFmuV0QqB
         4BSDGNktTU+3A3h8U6l/Vp7DAhP1th8AWeV6M1rvJRRbdQ+iiDEPEDQThqlWMNyE0Ag1
         jaLWjeLQqwnymNeggNv/fXGKlMZ5bFZ6THEfZAhkoRoF97dBi184VEHi72L/6AM/oxJO
         XOmOUpauKpB1/Vjl4V54rBcWkLEQtJVDc4VwFV420p8p5yNSHUdKLeoCm9PzFcRFloPv
         GOVl7YBs1aXCD3cBdbLYqFNWI3wcI1DHaREI5QOFRSlG95oCsY9gDoOcGn1nZqjnRfUd
         UY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fw7QXJGTsrjr3zuPRgQiAU7U58qxLFo5Weq3W8UeAIk=;
        b=YHZNJlbO7Mh566ZIwlXJQl370YRcO3b2fAlB6KZy/XG1AWth+7y4kfasenN+g/t+6b
         8GPjQ+bcWEf2UvNrx57tlbBwjwFFPp5yuYxJhavdj5K9jvxdWU9avUb9CoJURRbCaUvp
         MWglYHkI0SB3SsxZDIUN+ybxLiFUczW4wVHDzJQ1CKPiMqF6DyiLN2bqfqez8KZOlv5r
         LTmXsR6bUHPumeYez213tETn+aCMXMDv1hAWq0L6jvrl0IdYhKijz7r4RUSUk9wmk1in
         g/bEQ8T5LlX/e5+6ob0imIwFEoDoBZBE+Dqa6flzwAlckCFHpcYOz64MHOlLoivvDuR0
         Nkbg==
X-Gm-Message-State: AOAM530QfZoMW/wqP3Cxvd4quwPRn+wwqpWt7OgvUlUxcGCndyqYElZC
        ArswfcnQbI2NjU3zlCxN8sM4vABFNxixc1oajmbiPg==
X-Google-Smtp-Source: ABdhPJy++qgGBoHXV7D8jU9no39eQo/Mg+p/IwsWGvgwYxsds9fL8Il97amaN3rdoofggSAL07oM53Jq81g9mJv+OBo=
X-Received: by 2002:a2e:814d:: with SMTP id t13mr922707ljg.467.1620258999642;
 Wed, 05 May 2021 16:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <YGtZeofmBv7hXK+a@Red> <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
 <YGxOf8pKN8Ip/kCl@Red> <CACRpkdYRUXJY_tXamS0vc+RNPDxR2oxdRLbBUk0fmQLp+eYAOA@mail.gmail.com>
 <YJLxTgVflotKs5Oe@Red>
In-Reply-To: <YJLxTgVflotKs5Oe@Red>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 01:56:28 +0200
Message-ID: <CACRpkdaGAiK57LE8vkEBjCGwb+HRWBzWS_C86xdNa8N51G+1PA@mail.gmail.com>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

I will check the patches you posted too, sorry for being a bit busy
with some merge window and stuff.

On Wed, May 5, 2021 at 9:26 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> It seems that USB is still a bit buggy, device are detected only if plugged before boot.

Yeah :/ I don't know that driver very well, only that others use it too
so there might be some people who can help. I haven't mainlined
that patch because there is something that seems wrong about it
but I'm not a USB guy.

> I hit a problem on the NS2502, sata drives does not work well:
(...)
> It seems a problem soon after driver probe (qc timeout and HPA error).
> Any idea ?
>
> The SATA works well on my other board (SSI1328)
> having one or two disk does not change the behavour.

Could be the SATA muxing, this thing in your device tree:

sata: sata@46000000 {
    cortina,gemini-ata-muxmode = <0>;
    cortina,gemini-enable-sata-bridge;
    status = "okay";
};

cortina,gemini-ata-muxmode should be 3 for two harddisks
I think.

If that is correct then check if DMA is broken like on SQ201,
see drivers/ata/pata_ftide010.c and here:

/* This device has broken DMA, only PIO works */
if (of_machine_is_compatible("itian,sq201")) {
    pi->mwdma_mask = 0;
    pi->udma_mask = 0;
}

This had to be explicitly disabled for SQ201 to work and
I guess it must be broken electronics design (too long
leads, interference...) so try to put the compatible for your
board in there and see if the drive starts working. You should
be able to check the source code of the vendor tree to
see if they also turned off DMA, if they did then that is
a certain sign it has the same bug so you should make a
patch for it. Maybe it should rather be some "disable-dma"
flag in the DT node, the above is a bit ugly but works.

Yours,
Linus Walleij
