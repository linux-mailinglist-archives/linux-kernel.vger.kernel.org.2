Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2342D845
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJNLgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNLgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:36:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899B5C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:34:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q5so5240426pgr.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5zIQtEINl68ppbiKPjAl+bjOFNEBzrwY8VighY2IFQ=;
        b=qVosOjh7AdklRWWS09mi5uq4xPurEmGD+e4QRnJLQV1MBGBdo9gpvfLtsYJ2wHUVup
         doPjWydZlXzwHf6n2oS/DS9bBIQ07lGfx6xk3PDYdyluyaNwgwJjc3HuJ3R6X2c/AaxE
         8kdWzAdSDUGE9TSzLMC4pZRF4wlE4IRqKqczP/q+EDarBhsmLBvn8ZzWpPnevyWzYTaZ
         E+3R9/Dy6LwXSy7+ksZq4OO5wOfq2Hi22gomyAL89t/axxy6aF+VxZA+1LrMyJDk9AsJ
         eoGy0FWPSI8sSsAWYQxlCM8GEil6jdjCEUUp1Sb9h9Htx7JXmEDAYBJOl1uCwggZcxPZ
         ToWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5zIQtEINl68ppbiKPjAl+bjOFNEBzrwY8VighY2IFQ=;
        b=7Bg0jsL5egD5Vyyr8+conk0E455CC9dEhO0eXPwziQsgdR+IyE9w+bUz1d94SBdA2Z
         66TU1xc+rPmIGKf6yalXyWbHzZfHFZy0cMSgO3yUJEYai5JOpxwqCAGb1/v4ZARPzM9+
         rf3IvQSi4V4GsmTMNsrdVt3tEaBTFiIz5/K4Bf8rr9vOr+exiZctiIWzptp/DnYWm6pV
         aNPjAAdm+5JBkpUku+JBxkinSp+MduTlGr/CjHDT18B3YSXO9nnFNDbiTgMruxmrYHKU
         I5YGhjJibxmEbmh2xMwEeYDyDe6dcMgSX7o7TgAqC2ARA0OqH0HsGNhCupAbbuXy0UWT
         9WUw==
X-Gm-Message-State: AOAM531NKx5B7FuAppfmleBZZPJ7j9Olu/0lWCx20vGImEKUl3XaKOxV
        NS+VypXCGT0+KbTodIvDsN5mzvdDlF4NbGiL31vLKg==
X-Google-Smtp-Source: ABdhPJzMPsCfuckKb2wPvpjVBzH0exDzWnWutlx4LciiCMEZlCymR5wF69/3Kle5WNeCXzDA+u6mOHkWVOLkUEAxqO8=
X-Received: by 2002:a05:6a00:d63:b0:44d:186d:c4c0 with SMTP id
 n35-20020a056a000d6300b0044d186dc4c0mr4824579pfv.47.1634211272785; Thu, 14
 Oct 2021 04:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211014093112.3852491-1-fshao@chromium.org> <20211014093112.3852491-2-fshao@chromium.org>
 <CA+Px+wUKXJ7a9th1HyxvCgDTQXL9kHtZH+O9z9oRqCfcF8H-sg@mail.gmail.com> <CAC=S1ngFY_LMQrzGpKXUt9HOJnoBvBoL7MV9sKSUJd0xOHZtZw@mail.gmail.com>
In-Reply-To: <CAC=S1ngFY_LMQrzGpKXUt9HOJnoBvBoL7MV9sKSUJd0xOHZtZw@mail.gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 14 Oct 2021 19:34:21 +0800
Message-ID: <CA+Px+wVVWaFMK+TxZtrQQdBKrGFsv=3MfNH31oMpOtckbbTAGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Fix local clock ID usage
To:     Fei Shao <fshao@chromium.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 7:33 PM Fei Shao <fshao@chromium.org> wrote:
>
> On Thu, Oct 14, 2021 at 6:47 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > On Thu, Oct 14, 2021 at 05:31:11PM +0800, Fei Shao wrote:
> > > +const char *clk_name = "gce";
> > > +const char *clk_names[] = { "gce0", "gce1" };
> > Does letting them static make more sense?
> Yes, I'll send a v2 later. Thanks!
Probably better to keep their scope in probe function but extend the
lifecycle by using static.
