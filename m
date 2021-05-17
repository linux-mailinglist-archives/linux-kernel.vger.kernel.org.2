Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADB386D13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 00:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbhEQWn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhEQWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 18:43:58 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431ECC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:42:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso6994506otn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=n3Djli0CBbr/m3SaXSvVNvzipKsQbtn+bmmLzOnVVqI=;
        b=nCoLyuMlxHCUgeTLjyz9XLZgPJV8gVt7fHvVleOKVgXyMbYoTOTnjn4s2niBe2ZQmP
         Y1QLjAH7k6zw/Fj/f8O8N7U9ittx6ZQUrVx6sj04EOjq6C+tjhUTZU6ugXRuzUR1bRUG
         YaqYd770CHzQfDlKuHqA8JhTB1zLEDRVfC860=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=n3Djli0CBbr/m3SaXSvVNvzipKsQbtn+bmmLzOnVVqI=;
        b=fV318OTS3xiPnESdqowCD0kIIuREU33qj/AteNbuqgaB+AkS4tZoyvtDoy73HJKM0I
         MwkYN+9OGymER4ZMJmGIBuEB92d4FE88aexJPJac/svQ0GFwyTYjj0X6vLfBSR09fzGP
         D7GaWaoZ7e69p4NVeelgjeTWiONHHBV+raX/TA0wDu1LBh718fXcJLkzY/cgFt6NcjT/
         fDkWQGdIYRRE88TvEJj4QyVMN71kpVzBjxIzEReuJWPVpFhSa1vPLMnnjzGVa8zLvJb+
         ptnGoWgYAQgCv5F2II8O1fymmXv2+h8rIuUrFaVt4bVr3wiLkBQGQ2bH5l8SM0fDDkOz
         YOcQ==
X-Gm-Message-State: AOAM531q2qRPFstFreVyHBTmRZiPU9wB9/dKD1OOq+0iAXt71b3rX9+k
        0MWSg1tRhO5IPu7YJWUWz+0DhzigzYF804Xgbt0Btw==
X-Google-Smtp-Source: ABdhPJyrlcKA5TRpRHBaLxQm81FvqdUsYD3Zuf8Wq5ItOf2C8GCdiAJD8DSnsXJA9rpT0DGnCkm7oobN8EvyA4mOsRo=
X-Received: by 2002:a05:6830:4a1:: with SMTP id l1mr1582306otd.25.1621291360739;
 Mon, 17 May 2021 15:42:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 May 2021 15:42:40 -0700
MIME-Version: 1.0
In-Reply-To: <20210514122051.266169-2-ikjn@chromium.org>
References: <20210514122051.266169-1-ikjn@chromium.org> <20210514122051.266169-2-ikjn@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 17 May 2021 15:42:40 -0700
Message-ID: <CAE-0n52_fypoKrobC+fSrMqf9aovHFgu71qRqKK7J_Q4g-tPTw@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 1/2] mfd: google,cros-ec: add DT bindings for a
 baseboard's switch device
To:     Ikjoon Jang <ikjn@chromium.org>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ikjoon Jang (2021-05-14 05:20:49)
> This is for ChromeOS tablets which have a 'cros_cbas' switch device
> in the "Whiskers" base board. This device can be instantiated only by
> device tree on ARM platforms. ChromeOS EC doesn't provide a way to
> probe the device.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
