Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14493EB95F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbhHMPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhHMPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:45:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:45:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r16-20020a0568304190b02904f26cead745so12504511otu.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=IHuDdb+WXOFRmC/LOUYJlgHAErWRMwyktxLBxGw0HxU=;
        b=ULJhbpXYjp+Nb8nY1QTOgIpZmKriaLS+clQDyIrL8scdUS5+wl8flBUQ4HzjFvIX/g
         PTptRsZbYKnkrHyCt2PRmyg3y2GLz8cMmnK7Lk1N2WsGD795suYVsbcmsSHs4Yn5kkRk
         Qss57AaOCHYzvnPVU1iL65kI5NPBEssmAUg0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=IHuDdb+WXOFRmC/LOUYJlgHAErWRMwyktxLBxGw0HxU=;
        b=p35IZp0hum3+00tjUsD03GdZuXjJ2bUinWby2UL2z/+c3x1yxRSDU5M0pUlzgbk9Yh
         jmjpBtruHjnAiqSWLPx74erVCBtUJXGPYSB7KBsr4bBE5lpkMuPo1xrq2RJfu71TaCcW
         Hzd/fkKZCbGkCMc49eMoomG7VaSQwF8YLZpwM9cIrvbhnKbyyglINvlAZ4mYGknN64Fj
         VFteaLGVk8AD0z3lat2uVe/sSBTksV898RmhSdkcf/Chu0GAReSXLyPXvfoYiriVUfhu
         NljdgNJ8yzzeS3eF90JSJfW518jbun2gripgJECyhPEkrKSr+bXlOmpuKNUherpl4rgs
         H8SQ==
X-Gm-Message-State: AOAM532M83uqv9rE9UtFtluhL60O7GjGz4/H7sz0TCTmDOv/Xb5reP7s
        l72y+xTw1hAKD8a1RJuvbT8RaaKfxiTbLZRDP4tvOw==
X-Google-Smtp-Source: ABdhPJxJH8BwLTYD+I8QdwbyJlfIh+pbTo/uAp5m5ivMZnAvzUrlZ7qudZrfjyIc8BvwEVNQ0YP54Lm9a9ekOKdE+x8=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr2650353oti.25.1628869530754;
 Fri, 13 Aug 2021 08:45:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Aug 2021 08:45:30 -0700
MIME-Version: 1.0
In-Reply-To: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
References: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 13 Aug 2021 08:45:30 -0700
Message-ID: <CAE-0n50VyHtGf4TmZBdsQ+nFo_SPk2dBofLgYCQsgZtZyTs-iQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Remove unused variable in rt5682_i2c_remove()
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-08-13 07:34:05)
> In commit 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if
> wrong device ID") I deleted code but forgot to delete a variable
> that's now unused. Delete it.
>
> Fixes: 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if wrong device ID")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
