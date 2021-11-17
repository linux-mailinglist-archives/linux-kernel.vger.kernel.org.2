Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B585C453FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 05:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhKQEuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 23:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhKQEuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:50:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45434C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 20:47:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so3623100lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 20:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8U2582OS1JaBUff58dtaXUBiFj+EMR4BTAPwq+0xIaw=;
        b=Ja0Ly8463jJKuAdQpWA9GcfTz/Daj29Uu2xpAl1NWvznw8nGJu/8idwsv+h7nsS0d7
         sbeZ7SxYetg0OxoD1VJAouul5fHz8PZ8Y+WymnSq10XoGlkkBjnWXb0NY8jeSOtSQW3r
         NulV4ePey2/k2Hd5WlTG3cQOSTOZj8Wh2UDkavPJsLslIU20/gedLTDWYxsZAaKt34N6
         WS5sQkUMcWWXNMLjhv3n0pg66FCkN7QCUZjzDUF7xQ33AMyqSkOQ+Co1ellV6tw7Z+OU
         pPFessNFKq7IMJtSvyHelqGXb085MkRXli8fd/Z0FLR54PilmMiSct7p4NMczpCyoZjr
         /vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8U2582OS1JaBUff58dtaXUBiFj+EMR4BTAPwq+0xIaw=;
        b=mZWs3pmrrZk58zeS0q5BwD1a19idvbD2NrSX6t8ps9SmI2HR/7IkgFwBtpCvAdN9Jo
         LaF/vw07Lcf/j9AjvrGBlVsU/34plbEcTx7/pY0PUlMO6AfSUGOv9JBOYN9gFJvS4fAe
         sgS2GaOgBxRvnN0mxuvxJcZNJaw4tbCNHOR2m5/5fWV8se62mCxvWQT6oaYb/NiFMKzH
         B+gs25d2IMoJeFtjio6tzZgKwt0vJG+xylyUgXdNNJ3eIphRzCM08WgN5HHKP70WOTXZ
         EEEfHe2jk3TNkA2Xav0neUtxbdu2IEu+Gou0e/Csxvy0/9/yLmPVmn0S7Jn1Hr+whU+O
         Y3yQ==
X-Gm-Message-State: AOAM532Bk6yAkRgEGP0eUQk+qH/jJNJXTheSBnMPgRamdWMTURUPJV06
        3ntkkEfViRrqPWWFS2do9s+KJwn2CJ8tqJfTEBRexQ==
X-Google-Smtp-Source: ABdhPJyldWMENzlShuXN8AJQein9+ZsGwLrHFzyV/qsCAWzPwXoeo0B6vnn8tzVqsZ6DlJyqFYmqFXnBQniUo774f18=
X-Received: by 2002:a19:c105:: with SMTP id r5mr12116791lff.661.1637124474573;
 Tue, 16 Nov 2021 20:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20211117020724.2647769-1-pcc@google.com>
In-Reply-To: <20211117020724.2647769-1-pcc@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 16 Nov 2021 20:47:43 -0800
Message-ID: <CALAqxLWn67emfDPcMGrjVag0zCCrNF2=rEiHKQgr2eJ8AotCPg@mail.gmail.com>
Subject: Re: [PATCH] lontium-lt9611: check a different register bit for HDMI sensing
To:     Peter Collingbourne <pcc@google.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 6:07 PM Peter Collingbourne <pcc@google.com> wrote:
>
> It has been observed that with certain monitors such as the HP Z27n,
> the register 0x825e reads a value of 0x79 when the HDMI cable is
> connected and 0x78 when it is disconnected, i.e. bit 0 appears
> to correspond to the HDMI connection status and bit 2 is never
> set. Therefore, change the driver to check bit 0 instead of bit 2.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I7e76411127e1ce4988a3f6d0c8ba5f1c3d880c23
> ---
> N.B. I don't currently have easy access to a monitor that works
> with the existing driver, so it would be great if people with
> monitors that currently work could test this patch to make sure
> that it doesn't introduce any regressions. Otherwise I will change
> it to check both bits.

So very interesting! I gave this a spin with my monitors and it works fine.

Vinod: Can you check the datasheet to see if the wrong bit is being used here?

thanks
-john
