Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059114206AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhJDHfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJDHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:35:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D548C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 00:33:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x7so59776466edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cV11GKQpiiSfjsUTcqQtG5ZPcTMMGpjKKrTGh/xwTKw=;
        b=ZB3e9lLY3b1ckvvg+8RSjH7XT6XaptWwSV9uvOV4cu3oHGaMZHQaBkqBXlvZPH/CGG
         rMqCb5otZH36vpr54gCd/iOT0hh03eFZCR6ktllIiupJLvSZrdJU08/zVgNIdFHJBEIX
         GaGmMV0DkYBddY+BS1HaFTiJUgLmTiEsF+SuayUg+wSqYI61UDzSwGVRMZ49tTAOG+xb
         asmUw9I7vr9kkgnWdLCMyjXw9rAQ5ThM1rrwzU8vdZhDUvxioCXeiLZ3xVb0/HxCFVUS
         ziLaDJLIYD9RawoebNYwJ+UVIl5yiYDIQJmVR2eFdC8fbfibP1buIYNK5cNDw72L1Go2
         rnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cV11GKQpiiSfjsUTcqQtG5ZPcTMMGpjKKrTGh/xwTKw=;
        b=RcbMvQi/O+qMBy/j3aviQfcmly0zsVaqY9jRJ2XvS8PvnGoINLHnsF9xw8mLRVZkY/
         I0uX78QD2GlPprbzU/+sI50q/M4DX7vGEIF5k2tmVLpZM5981T9OhNfJnIN5sUF+sZ3G
         CX8dzfTHyqbmne5tlz9Vy9vR+CUkaQdFuSKMQYsNzg3kF4iEJpnZMTGSimkR6lzcT8uU
         fW7PGGd6qiyHBv5LZDsg+MFvJODJVB0m+aqFsSBaOmwp0Q4JaT7NWHKA0qrFhHUZ2Oec
         RvNz9asb6OQc+JuLHUsU7vyvr2Otyx8Uj0qCYpUy+pEkXPwn2qXIYNG0pmHjJrZpUryg
         mSMA==
X-Gm-Message-State: AOAM53312Xhl2NPfdWOUqnUZ49ItYE1ktuV6B+qcZX9Te6LM6ZYMDZWe
        hWmThACngczq6TuNPIuGAQ3IXIIkn9SFTnNr9s7aRzDVWxU=
X-Google-Smtp-Source: ABdhPJw8opFzwpe7dpLm4gPVrIl1QFUXEW3nNS2ue5ebQ1RgE+zU+brMkpBuU9QnczSm3nal7U1Hr3HLrkp+qcBxVtE=
X-Received: by 2002:a17:906:5a47:: with SMTP id my7mr15059199ejc.128.1633332798510;
 Mon, 04 Oct 2021 00:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com> <2bee95f7-d54d-5d65-3c9b-91d8db228b09@enneenne.com>
In-Reply-To: <2bee95f7-d54d-5d65-3c9b-91d8db228b09@enneenne.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Oct 2021 10:32:42 +0300
Message-ID: <CAHp75VcP3DCQAbLNXvNzmdB3+sBNNu=_BfkbY5v1c1okX=wOdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pps: generators: pps_gen_parport: Switch to use module_parport_driver()
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 9:52 AM Rodolfo Giometti <giometti@enneenne.com> wrote:
>
> On 01/10/21 17:03, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.

...

> > -#define DRVDESC "parallel port PPS signal generator"
> > -
>
> I suppose this is not so important to be able to switch to use
> module_parport_driver(), isn't it?
>
> However, aprat this silly note, the patch is OK for me. :)

Thanks! Can you give a formal tag?

-- 
With Best Regards,
Andy Shevchenko
