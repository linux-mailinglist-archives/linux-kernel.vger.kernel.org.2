Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66A03D4907
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhGXRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:23:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02FC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 11:04:21 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a19so4018945qtx.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySjT+9vhA6LvbQeBz3snrx5GQAIqPB2FJPEofd/VFlc=;
        b=CpeZupTFKNWztEfPSidkKyHokcBAMt2Wi3fxZGNLVd9kQwfMEr8hmCzrpiZN8OajUR
         1+Xgsg4E676KQ74nsIIUiTPr4+Zw4V/ZN5RKuKdZ6K8oXET13wSGXe+qjA54BIHiMkKm
         sHm8dYljb49cClUOdGMEM0pvJj4lj4UDwxdJinCyQHxn9TCwvT70YBBHtQPFkZbobDu9
         WF6iQDBjKpudNhx11mX6Mo0MhxNMN6RVUnju9CLdigEgMEXAXweTi0zWlz3/Ykl66JXW
         N+vs6XUlGIKVitlY1Q7e8wm2R9Y2VsNVnlQKT0a5UqVO6HFYANzF8JobRi+jguYBiwJO
         y3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySjT+9vhA6LvbQeBz3snrx5GQAIqPB2FJPEofd/VFlc=;
        b=nupNke781RkPugWg6HI+TYZWK0jSg0DSBYT4T5seODdidxEjm/rMyZ6lhEBWTOiXSD
         sAuDH6jw+rSLyhMV92g/XpR2r04jiqUkJxIZWx4l7AgG879SjSyqpuSzYnXJ+zsH2qe7
         WVKmmqu+7S7Lgk67uHwh+mteW8wStxfOXrgR01CmUcUupIRW8PPxCdmzn5y3QyjNyXiW
         iaeyx/XFU8AX725Ol2E0idVXJ9B4JP3xcUJ26JEYf1iLdeN7xl5KT/IhBRczDWP4gHqN
         NdhJP7eCvPavSZatKh4rk2xLAZTMsKXa7SvWWqKwQxI2wiXyIweNeOwMIfSFAEb+19pB
         zxzA==
X-Gm-Message-State: AOAM530Lky9rr4aJAdOeuY+wG59AoOLV+cHBf9G9PznsiuSgIoshOIBb
        iUWHE0oU+pL6oBkFl/yhTgKqEVaaYuwWEvfsoS4=
X-Google-Smtp-Source: ABdhPJxMOQJzEBbdDPWv1NzazwoX7K1S3r0NWDDWZvXR+QrtOrw9xPXY6S+kNGfbhguYEAiamAOcEG/7A5ZLh49DO54=
X-Received: by 2002:ac8:1483:: with SMTP id l3mr8917231qtj.142.1627149861044;
 Sat, 24 Jul 2021 11:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com> <s5h7dhgi1e2.wl-tiwai@suse.de>
In-Reply-To: <s5h7dhgi1e2.wl-tiwai@suse.de>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Sat, 24 Jul 2021 15:04:13 +0000
Message-ID: <CAEsQvcs3P+TqQFzQetPfRycpo66eJFwnzwhk2JyCXFaCLFHmFg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     Takashi Iwai <tiwai@suse.de>
Cc:     chihhao.chen@mediatek.com, alsa-devel@alsa-project.org,
        wsd_upstream@mediatek.com, damien@zamaudio.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 8:05 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> This looks like a regression introduced by the recent commit
> d2e8f641257d ("ALSA: usb-audio: Explicitly set up the clock
> selector"), which is a fix for certain devices.  Too bad that the
> behavior really depends on the device...

Dr. Iwai, perhaps we could restrict the generalized fix for the
Behringer UFX1604 / UFX1204 with some simple logic to devices that
only have *one* clock source.

In that case the clock selector must be set to the only clock source.

This way we keep the generalization without breaking devices with more
than one clock source.

Just an idea.

Thank you,
Geraldo Nascimento
