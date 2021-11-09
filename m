Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF344A5E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbhKIEsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbhKIEsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:48:06 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF7C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:45:21 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id o4so31610152oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrUXzO/SXSYvsB+cqJXI4sWsKIikjeXfqc6uXfkQ7dU=;
        b=fZx8eeRzFjoenMcmcYQTn6ymcMuoGaZwU682S15i1IwsNsJ4Kc7YMsYbYqlUDBzoQ5
         0xutz+Ylapgh8ApsABzt7BASgYb9+0tqZWeSLQ+QBcOAHyO41nUuhrxzUqJ55yKN3ShG
         PjER1WHqs+kZ2b17N7OkIFVVdE/wIczhKNcEBHi4iC08o0Hb+bbprn5ZTTYey8I3vTIy
         YfqfkZhhtp7fwANa9X2q6iidrjyXiF9kWBiJTjOY1s2iGCtrUC0Kf3F4zCklQfrTlnCV
         xaC+8xmw3CLcy1CH4mLOtU6tMW/fTnnxIxj+iXTH3c+HRWEL0fTGFt5Bt8M/UvZSaKjM
         3ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrUXzO/SXSYvsB+cqJXI4sWsKIikjeXfqc6uXfkQ7dU=;
        b=pC1vyIHZCj5QagNypfmhbel3DdqgS8zj0dlWlR1afQUhBSQua53zFmHqMyCqhCBHwn
         OwD6Prh1l73EoqtS1dWjudzwtMyiTRaVFGg5VWzMGZvXtIvF9N3y1QCFusZmzdpvuenn
         v6hsOhDpcbU5PMAlu5nEsUAF53di0XIYZi2dVV8ipGCCYJw9V0AyRDRMtyNzHtFSQRoJ
         ma9TnKFK+JGXXbu93rhvf+FYRm9+h5V/KzusJKXLBnjtLymqmiHenSHHnP5t5PAElDcx
         7MSl1YRNr0LS6bwVZKR4YcOUj6jLrRwAO2gOfkEACFqkzXetVKcqqPKB53oCcRRjiber
         zpgg==
X-Gm-Message-State: AOAM5311vRaH78A5wOo536O5jIt0owGlY05+0frj5bvAw7zKeRxuOHsu
        yi3RjoGPkR1rFH2pPq/7+tFc0Y/B9Ku7MtGLBsXZcA==
X-Google-Smtp-Source: ABdhPJxB/Y/jjWaY9guY61DEGMDSZKf3Q4w5/NgwO5gdErp/7ZQwieYv6LRgOffm7IVuHcgnSYnEQbM++u3iJSxmJ5s=
X-Received: by 2002:aca:120f:: with SMTP id 15mr3127795ois.132.1636433120520;
 Mon, 08 Nov 2021 20:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20211027181350.91630-1-nikita@trvn.ru>
In-Reply-To: <20211027181350.91630-1-nikita@trvn.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:45:09 +0100
Message-ID: <CACRpkda_EM9mXuJdrZcpFaJCKF1UDgXkfdxkaniyXFHFd_7+Pw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add touch-keys support to the Zinitix touch driver
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        Michael.Srba@seznam.cz, broonie@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Oct 27, 2021 at 8:15 PM Nikita Travkin <nikita@trvn.ru> wrote:

> This series adds support for the touch-keys that can be present on some
> touchscreen configurations, adds the compatible for bt532 and fixes a
> small race condition bug in the driver probe function.
>
> I also pick up the series that converts the dt bindings to yaml
> initially submitted by Linus Walleij in [1].
> I made some minor changes to those patches:
>  - Fixed dt_schema_check error
>  - Adressed the review comments from Dmitry on the original series

Thanks for picking this up!

Have you notices some behaviour like surplus touch events
(like many press/release events fall through to the UI)
when using this driver? I think it might need some z fuzzing
but I am not sure.

Yours,
Linus Walleij
