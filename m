Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097F635A4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhDIRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhDIRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:47:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6697C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:47:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m3so7523612edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/DYqeYDZ2tv0pjw6nXCAivxGZElUhydHkSur0hy0Lg=;
        b=fL07bRo1AlQ8538F3YddizvSL3vRN8cISsYffz2e1gqSDx1yzzsRFb9f/s6uye9b7J
         kZ8zK1UPnRR86nK2lEJVUTVrBxgvNbP0hXJlljYXsdobPKNmOkrk1NKCkObxp7uvr4GS
         NcRPN/YenqQPGgm25FJbGyQ6Nq7TAoaCLj2D/jnvpVdIbwzRnMd7CobpdcF+6wIhwCnA
         LFpDOPrdcc8p8ajBEUAU6G40hEBpWU3cEzBPeFC+INBPt+hps6TQOfD0hP35fPgNWZXx
         6ikddwhaV0DyWVQH83zWH19++Qt2/wafurQRsn/7JEonLEZtgde5JPwHgvir8Dg0q0NP
         G6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/DYqeYDZ2tv0pjw6nXCAivxGZElUhydHkSur0hy0Lg=;
        b=FA58LMBqZ8m+AumzrSUqQpkd2OCL66wkUZI2OCmhWVb5Qi7w6/04R8WxuRuePnJSLe
         9WOrYrzLCQ+kVlmtsUOfZj+0xpvWMZJETO6nmQd0SryZRvM92xusLyqaWxcJZhnabFQ/
         W7FLElrMi5fJ9ZuGqi2/nsVkLfki38aE2rKQErYdWLSA2ZePb+xp3frWBKnu4lbD3VfB
         CCCXHkn+VlouYYmOv+Xb77J9e6r5Wf7QDjGHwke3jaQULEwJecf6RqvAlpzoUp2UYO+A
         +jW7squKnrsxVDo2sfIv06r1WQE9ULUcWYSyeEmKa+4JPIwj2aNWt28qjfFdu6Uw0eyV
         7wzg==
X-Gm-Message-State: AOAM533caAiK3m5LWQmpiZks3cPQwGAbc7flnLAdjlDmiRANTkc6rAnW
        3OaufmyvX1JEViXiM4TbCw0mav97yP29r/XWuryzmw==
X-Google-Smtp-Source: ABdhPJw5dTKISltAAxoV0GJqKF6gZNwGP+zQpFKqQsBOiL2hemXFTwP8DvauaaAu4KsetLu5EdkVn0Rk8ibopUKjMJE=
X-Received: by 2002:a50:c3c2:: with SMTP id i2mr18734759edf.23.1617990454256;
 Fri, 09 Apr 2021 10:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu60T=vymv7gA0eaopfNDWXAVT9WRS11Rrk1OfTkrCevw@mail.gmail.com>
 <PSAP153MB042218315B664B15A59A80B094739@PSAP153MB0422.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PSAP153MB042218315B664B15A59A80B094739@PSAP153MB0422.APCP153.PROD.OUTLOOK.COM>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Apr 2021 23:17:22 +0530
Message-ID: <CA+G9fYvcSK-Z7+VrRbHp7ADDDgw2tWWaqTfQMyC2dxuOYGLz6A@mail.gmail.com>
Subject: Re: [EXTERNAL] [next] ERROR: modpost: "dns_query" [fs/cifs/cifs.ko] undefined
To:     Shyam Prasad <Shyam.Prasad@microsoft.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Maciek Borzecki <maciek.borzecki@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Steven French <Steven.French@microsoft.com>, pc <pc@cjr.nz>,
        Pavel Shilovskiy <pshilov@microsoft.com>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 at 21:49, Shyam Prasad <Shyam.Prasad@microsoft.com> wrote:
>
> Hi Naresh,
>
> AFAIK, this has been fixed in an updated patch last evening. Can you please check if you're still seeing it?

Please share the fix commit and subject here.

FYI,
This build error is still on today's Linux next tag 20210409.


- Naresh
