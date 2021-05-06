Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D6375134
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhEFJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEFJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:03:29 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78528C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:02:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x8so4243609qkl.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJVlTf1wAisYyAXO10oVlqyTHmds0dhQ9zCL08SVD/I=;
        b=fpsYiRtdsHOed+tw3DjbJZ3rDItxm1WR7+Rw4iofg/3k0y0vVYtGZdR917UPfaHA+1
         pl9a7tx4awzcnMkc1QEbYqz3pP/0RMqxjVL5hWoOPoESHFadug0wyWr9XAFJ8XbX2Mqo
         leVIRixovBpqNJuUuClujUt6GqvqhhDpFTDJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJVlTf1wAisYyAXO10oVlqyTHmds0dhQ9zCL08SVD/I=;
        b=XQ+G5egCiiYIAJpxbPdow3I3Xe2TD/UuWqfzi8pOCRJSq0pF0/dbQcwfr/yZknu3D6
         tXFQvEDJ0GKkBZ+PqxvMwp5AChlS17+GFTtjhhcMfTqpM89Iu4JTWa5VmLJe1mlwCd2Z
         fdfGq6rizaGq+bsoIiaDiJqqkd9508u8a6PViimg7rj7bIf+a6YJqdihoA3/1te9R/Ad
         9U2CM2207XEDc/yJ2N0DKLntHIf+6x9VQgDmlk/QaMdA1PjHonWa0ZC2EQLlC5ECw1p6
         W7q9Ia2x7PRovOVOl7vJSkysVE0FkYOox2bAy6biymrVUkVNGAjodzlNmyARiL/5HZle
         KXOg==
X-Gm-Message-State: AOAM531Hw3iW4OMaoW6J/eQ8ML4hblPfpKLSfvKu+49zLALzvAwUWDtk
        vmWmPcDm5FSS/E0BO5WtezCZrzsHBsy2Y5KapbDqig==
X-Google-Smtp-Source: ABdhPJwVv/vYuR/GTBskRfJ9KucJECpruxbjXPpqe1EgAza9apUM/4Oi56+4wHkvWc0Ty9mkInenV46V3OeB8BUpb0A=
X-Received: by 2002:a05:620a:918:: with SMTP id v24mr2910497qkv.54.1620291748709;
 Thu, 06 May 2021 02:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <YGtZeofmBv7hXK+a@Red> <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
 <YGxOf8pKN8Ip/kCl@Red> <CACRpkdYRUXJY_tXamS0vc+RNPDxR2oxdRLbBUk0fmQLp+eYAOA@mail.gmail.com>
 <YJLxTgVflotKs5Oe@Red> <CACRpkdaGAiK57LE8vkEBjCGwb+HRWBzWS_C86xdNa8N51G+1PA@mail.gmail.com>
In-Reply-To: <CACRpkdaGAiK57LE8vkEBjCGwb+HRWBzWS_C86xdNa8N51G+1PA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 6 May 2021 18:02:18 +0900
Message-ID: <CAFr9PX=qskO+vxUiNaq5e0E7BFGGuK4xzh2sM2dEO2tEtucMtA@mail.gmail.com>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Coretin

On Thu, 6 May 2021 at 08:56, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 5, 2021 at 9:26 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
>
> > It seems that USB is still a bit buggy, device are detected only if plugged before boot.
>
> Yeah :/ I don't know that driver very well, only that others use it too
> so there might be some people who can help. I haven't mainlined
> that patch because there is something that seems wrong about it
> but I'm not a USB guy.

Assuming I didn't read the wrong dts this machine is using the Faraday FOTG210.
FWIW the MStar/Sigmastar ARMv7 (and earlier I think) chips use
basically the same IP for USB host (FUSBH200).
There used to be a distinct driver for the host-only version but it
got removed at some point so I added support for it to the otg driver
in my tree and it sort of works.

It seems very picky about devices being hot plugged and doesn't seem
able to enumerate low speed/full speed devices at all.
Maybe we are seeing the same issues? I have a USB bus analyzer and I
intend to debug this at some point.
Adding support for USB on the MStar stuff is pretty far off but maybe
if I find something Coretin can test to see if it helps out there too.

Thanks,

Daniel
