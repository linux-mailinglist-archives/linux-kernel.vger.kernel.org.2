Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434BE413A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhIUTBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhIUTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:01:06 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:59:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h20so23900362ilj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPanjl/X9LOUVmXrjkeXI0Q7gVy8gp22iJNWmdA5zZg=;
        b=oJAh/Se0IUU493aQZeFEycxN0jgmMrqqfg8bRl2QN9NCCvx/b1R7KbCPnWQ8GcWvSk
         T+8zaXjaQaJ7arkXQqtnT1Xmk0wUH9bovJfATBBVQl1dYBpLPImXLnh1xneyZXVjiW+h
         UrBBJuk0zYG/2/Zx+nJGSq1+0RPqvuacEezNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPanjl/X9LOUVmXrjkeXI0Q7gVy8gp22iJNWmdA5zZg=;
        b=j0IO7sUscADfX//Pg8GIswWPJcmHspUCCBPdBt+9VHYsSF/GE1v78HVsy4UcMWfbYB
         T599CxyMD8FC0kaADas4twUxqSA3plRtwLpnByjW0AfXUjBqDizjwJn07DoydTXEEk4G
         Scn9lzs51YZMn8EfmkmRfST9AkcDfIIcthSJVr60t5Xwwt9X+VuN+ej/hGIzlgzpS5Oy
         It7C/Q9O6IC1wGBRJOyiCmCn7Z7FSOWJLdaQ/SEROG48GV8CdY1pS72JY6agbToOV26o
         1N/h447GhdFnZ2E0zKl1/dgexjgLM8KH8S90fMTtoHPL0H0xcZL54o7IALV7S2I28DPQ
         9Z3Q==
X-Gm-Message-State: AOAM530Nb5TmH2yLIZEmPjO/rQB9+3VTuD9tMeLBeEKmIqrEL3v859Rv
        OwCXuUELnUA0ehkwH3ge5B4PKlgsukL1OQ==
X-Google-Smtp-Source: ABdhPJxUUL56sx6JHPniCNvKnftCK//TyP6htoFS6KudiiljBau1M2o2ghZH9ruzX0jubWUjgQ1kfQ==
X-Received: by 2002:a05:6e02:b29:: with SMTP id e9mr16232927ilu.136.1632250777140;
        Tue, 21 Sep 2021 11:59:37 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id s5sm10602621ilq.59.2021.09.21.11.59.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:59:36 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id a20so23910588ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:59:36 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr21949905ilm.120.1632250775619;
 Tue, 21 Sep 2021 11:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210921110556.v6.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
 <20210921110556.v6.2.I1d6ea362dc76efa77cca2b46253d31b7651eaf17@changeid>
In-Reply-To: <20210921110556.v6.2.I1d6ea362dc76efa77cca2b46253d31b7651eaf17@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Sep 2021 11:59:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFK44E_gz8KvPRape-KHE7FGH1L=kYW9Qtx8V8P35Jcg@mail.gmail.com>
Message-ID: <CAD=FV=XFK44E_gz8KvPRape-KHE7FGH1L=kYW9Qtx8V8P35Jcg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 21, 2021 at 11:06 AM Philip Chen <philipchen@chromium.org> wrote:
>
> Implement the first version of AUX support, which will be useful as
> we expand the driver to support varied use cases.
>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Philip Chen <philipchen@chromium.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Snoozing for 2 days and will plan to apply to drm-misc-next unless
there are objections.

-Doug
