Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985F3D8682
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 06:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhG1ET0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 00:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhG1ETY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 00:19:24 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A489C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:19:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d2so474014qto.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98gtSXDc7ZlTP8DOpD7xPPrbBz6KU/i+LtjlbzvHQbE=;
        b=k0X6UEjkKBfbAFH6JYFJNMOfoQuDUk6MYWgifJN2pAnWZnEeGST5bE74ezH/a4Ew8m
         l7+Ha5ZJzvssBw6MkI6+vJItvzys74w8MoJNkyeBcDGKwsmKCY+QW8vmmd26oCSfTTJt
         AaJvOxs7IhcR+nfQJONeDTeW+x1tB+jLz2umb27g8Lv5R7R5wa2TySBJWuj/TmkwXGRP
         VpIhPpKFi4ws1+9QWtJ/4237wxnTJbmRpT4wolmwZclF9yYVJCqyIiY82cByYOx34VNl
         OUYMFTOTln5FSaElAUSKa/6uujrTsBgBpsPW2W6CWfScvptbn1fhKlsAOsHNe0Di95/I
         aVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98gtSXDc7ZlTP8DOpD7xPPrbBz6KU/i+LtjlbzvHQbE=;
        b=DKC7BDI7PME959xntUdwhc/HPxKU6pLhzVytrTKNxIOkY5RcZXk/TLumaeaDg2Jdad
         +9K7nC7Keqg43ZhzVHivpzIPC5mv4FYQ7OjIJwZYBEI+qLjjMSlL4SDPcWh2bVH6pZgq
         ZkKduqr5Q9ZAWJ7ssvcHeqdw+gkWezl7OyWd38M/cn3j+aG/Np/7wZKz/8PnJXGw7Atq
         uhH32usdEbBdiCZ0LLjzqwCLmVYq89HVzvwG58jTIkMW039GVdEj5LGU+KZh2n905naF
         Qcv4kxPaO2UuxA8qxwzGdZujYOtx/OS4ZceQXeqhGaeIrUWna1SBHQ9z5L9YJSAJZZal
         JWTA==
X-Gm-Message-State: AOAM5305OiEzrLc0EWtFfXwe9xodiyAkZPmc8+Xr1RM9wml1Xbpdk6Nk
        lMfF03LTUROzrsQsqvzd9LqU4Dp4efxVpJwhHiQ=
X-Google-Smtp-Source: ABdhPJzpRxaeYMeDLeO8zgqFYNb5J+g+FY8Gr9FLuWekwpckk/L7lwKzlbgsAza9R5n6NqJdrQnj4LbbOWpJUBlWZXs=
X-Received: by 2002:ac8:7c54:: with SMTP id o20mr13378070qtv.142.1627445961649;
 Tue, 27 Jul 2021 21:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
 <20210727102744.30364-1-chihhao.chen@mediatek.com> <CAEsQvcuOQ_Tg0bRbsegECdBUsGxa61ei9-Z2bRbGvQ9FmEUPbA@mail.gmail.com>
In-Reply-To: <CAEsQvcuOQ_Tg0bRbsegECdBUsGxa61ei9-Z2bRbGvQ9FmEUPbA@mail.gmail.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Wed, 28 Jul 2021 01:19:13 +0000
Message-ID: <CAEsQvcvMVCptNss0iSB1uk1vu7PNdyO5c3jzHbi3HvRELi5Jdw@mail.gmail.com>
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

> Chihhao, please try the below patch and perform another echo test.
>
> Let us know if the echo test works or if it still fails and please
> remember to share with us the relevant dmesg logs.
>

Chihhao Chen,

when I said echo test I meant just test the device and observe if
there are noises related to incorrect clock setting.


I then realized a bit too late that probably in your programming
culture "echo test" refers to the whole technique you used to hook the
kernel and debug the issue to produce the fix.

If you call that technique "echo test" I'm sorry, I didn't know it was
called that way.


I just meant to briefly test to hear if there is noise even when the
clock parameters are correctly hardcoded.

My intent with that patch is to try to prove there's a firmware bug in
action just like Takashi Iwai suggested.


My apologies,
Geraldo Nascimento
