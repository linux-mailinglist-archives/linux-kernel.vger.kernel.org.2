Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0925E395518
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 07:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEaFiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 01:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhEaFiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 01:38:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1279C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 22:36:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w33so15038389lfu.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6g5b7UW7OqHYksO2g0T13oA4RkoJLmRlGtuKzwG2UXg=;
        b=ePnPLJrjO2xmGKdiOmIwCh9XcNLv+4l19VXX76PcHj6FWxDq3HHBpvH23fB4gKczfN
         iBB4uIHjxS2/dBNGpYnA9cX8eFIfZRvt2BGzYvaUALBiqkElY/lz766irJ0QMQ78v/ud
         ZnqlKXEFZd3YRzl60yPVcpFuxRZvatyAK2nMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6g5b7UW7OqHYksO2g0T13oA4RkoJLmRlGtuKzwG2UXg=;
        b=ahpPV9EGLQoIJAj0KD35YrZGLi/8+kvKd8DiaZqWUHbL0JFSaziw/pllj6ma2W424Q
         JAcuY59E7WjZEU8v3rQjr/Uf3VEHl8bf8yL8B7RIT23QMxs80YK9N/2EtulibRD/sM4u
         ikkdP/dgjGIcoTpSbZjWiEaTm9zBe+dkB9pPnFzpQUoV62f7aNxoMltkJ1VfBKQZjRVp
         wonuE1J2STDxdk4/hgzWzGGgu0oNyy/xjxiC4oCkXL4Gib1B2TzYXVQo2Dp5t1yMwWbM
         pNd1jdXqRGKM6TPxjDnS0xVI83bTSCRujZxvkjAmEyavOQ8nBxF4SmGhpAeSiM2MuNrS
         GyTQ==
X-Gm-Message-State: AOAM530ulkA14cfeLQllZhT4KiXlJ1Ibw4ekJ7JQVDD+stTRR6mwRu8D
        b30K5i2D+QB+exeH1TV95reKiNw2d12Nji88
X-Google-Smtp-Source: ABdhPJyrloRwsZ9FBob5ov5xrZC4ketrNalYfWNfqWhyFvdhjimFEW6U+g5lVade6tXBRe5TBGh9DA==
X-Received: by 2002:ac2:5d4f:: with SMTP id w15mr8299308lfd.348.1622439389835;
        Sun, 30 May 2021 22:36:29 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y15sm1480477lje.74.2021.05.30.22.36.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 22:36:29 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id bn21so6159551ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 22:36:29 -0700 (PDT)
X-Received: by 2002:a2e:b4b0:: with SMTP id q16mr15226955ljm.434.1622439388788;
 Sun, 30 May 2021 22:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210405202857.1265308-1-gwendal@google.com> <CAPUE2uvZzXUoG+Fr7c3q0ysMUz0eb36PrdknG37FkG1v2h7zUg@mail.gmail.com>
In-Reply-To: <CAPUE2uvZzXUoG+Fr7c3q0ysMUz0eb36PrdknG37FkG1v2h7zUg@mail.gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sun, 30 May 2021 22:36:11 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ-bMhrH7pcwNRRTgLFD3opYE2UriU_N=-bu+neq8MHFrQ@mail.gmail.com>
Message-ID: <CAE_wzQ-bMhrH7pcwNRRTgLFD3opYE2UriU_N=-bu+neq8MHFrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] platform/chrome: Update cros_ec sysfs attribute
 after sensors are found
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On Thu, May 27, 2021 at 2:01 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> [+dtor]
> Is this change acceptable? I was worried it could break when
> asynchronous probing is used [https://lwn.net/Articles/629895/], but
> since all probes are deferred in a single thread, it is safe.

I think this is a bit awkward that we need to poke a separate sub-driver.

Have you considered having cros_ec_sensorhub.c create its own
attribute group (it does not have to have a name and it looks like one
can register as many unnamed groups as they want) and have wake angle
show and store methods directly in cros_ec_sensorhub.c?

Thanks,
Dmitry
