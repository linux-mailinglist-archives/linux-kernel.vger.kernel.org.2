Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26DD3E1BB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbhHESvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbhHESvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:51:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFBC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:51:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so339237qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZEunsTnaA1XzE54VnUD0YcTvntYvxdVoZOW+fPpXuY=;
        b=jwbsiwneBJFd2Ig6fWCLzTscXOQBAlvphpkOrnXo5ln4b/cl4H84JzNrDvAcVuVS04
         +Uix/Q7yD7sCFQhfpMWtshsEx2thnVuroO11Ye12H7cLNnOIvo/FiPnsWG+SFQk1lwcV
         3sEv24pAJMkGwqt9wGxdiFoeyMzMpupOtbBb0Qwy6pBrMiRdEymB2b2knQOYqGjPFgNr
         E8DdbgAlkZrQqmqjZM0uoeQipY4C5YPDXm6UBtDqPrSHvBMJ83dSMElz7Fa3vWk6st0c
         JwAJt9hDzH1Nn7gPakCOcQ/bsvw0Ub6O85EkbtxZ6rBTYCkWjaX1/1KiXp56WxWZO1bM
         bq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZEunsTnaA1XzE54VnUD0YcTvntYvxdVoZOW+fPpXuY=;
        b=bzxNmmXb+lJ3dcl5m1do1tz8H/JqC2TEp+WS66i1oVDJCZtBnecpVG6XEgX+ENMI5u
         pUixgyXBr9jKUV0Sc2ifKqhLZR5nlHnjbTMvUT8oJM8znbxCs9QXv8hI9EpldcBCX4nI
         q0++kvZ0h0Uqd5AYgcXUn/KP6pqfbQUi5JMlQnCXLi58jLkd+/KHVbxkFp7H+08a12P8
         FQzWVz3zVu4LWrdFrIPCBNseQYbCdWPW/TeFb2OJ/soG+lBbzsXwBvznL4K/+tHdsAmx
         B8rfYMs0Hs39H4/Zmnt/JOs8RPomdHBaRXCUlkFeXlkiuCC1mO0E7OF8Fox5bF0faFz7
         IKDw==
X-Gm-Message-State: AOAM533fb5mH5ub6Myc94tlsdT4ePSZH44tL3S76ArhSwtZehKzza2bh
        Kpw0/OqXKKgucEBOXNMl3oLwA58p3UG6BJ2FxfU=
X-Google-Smtp-Source: ABdhPJw01R3FsLE2EQNT7CIn9yocm0qu86fk/7OLpG7DKbhG2q6MJn/s0acJtp4DeG5ZfTa6LLUEBQbe0kohY2aFTRY=
X-Received: by 2002:ac8:5b83:: with SMTP id a3mr5789733qta.210.1628189467046;
 Thu, 05 Aug 2021 11:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
 <20210805075401.21170-1-chihhao.chen@mediatek.com>
In-Reply-To: <20210805075401.21170-1-chihhao.chen@mediatek.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Thu, 5 Aug 2021 15:50:58 +0000
Message-ID: <CAEsQvcsvbJdgvAOxkv_kbLohGi676Zrgz4XSFW2o3CWU3Q68Dg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     chihhao chen <chihhao.chen@mediatek.com>
Cc:     alsa-devel@alsa-project.org, damien@zamaudio.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        tiwai@suse.com, Takashi Iwai <tiwai@suse.de>,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 7:54 AM <chihhao.chen@mediatek.com> wrote:
>
> From: chihhao chen <chihhao.chen@mediatek.com>
>
> Hi Geraldo Nascimento,

Hi Chihhao Chen!

>
> For echo test, it means we use this earphone to receive and play sounds at the same time.
> We found in this case serious noise problem happens.
>

That's what I understood initially, and only a little later I became
afraid echo test was the name of the debugging technique you used :)

Thanks for the clarification.

> Log as follows with your patch
> <6>[  175.960387][T401365] __uac_clock_find_source: Clock Selector 0xc has pin 2 selected
> <6>[  175.966980][T401365] __uac_clock_find_source: Clock Selector 0xb has pin 2 selected
> <6>[  176.026251][T400354] __uac_clock_find_source: Clock Selector 0xc has pin 1 selected
> <6>[  176.032406][T400354] __uac_clock_find_source: Clock Selector 0xb has pin 1 selected
>
> There is no noise and I think this should be a firmware bug.

From the log I'm afraid my worst assumptions were right.

Regardless of which Clock Selector we want to set, the firmware will
always set them both.

We should contact Samsung now that we have at least a sketch of a bug report...

Thanks,
Geraldo Nascimento

>
> Thanks
> Chihhao
>
