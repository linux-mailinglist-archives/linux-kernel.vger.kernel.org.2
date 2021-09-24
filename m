Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC488417677
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbhIXOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhIXOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:02:56 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA45C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:01:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b8so10396545ilh.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVyMgN7pQUPLmuiS6wVokQrbBuf5eK/9Yt78Ghm8Gzg=;
        b=hVJj0WfPaj+exvOHTuuzhozjU7BPsM1YyX0/2InSzmM+n76c7pUWGTZH1LW4MF18k0
         cxWrM7NmY76svxD84CDDO6Vdb5yTGs+rl3QdlFv5TTWW0wWSuTIYJ0AfZAl+63uUXDQ8
         PQtAkyPahXH7SA2LnJUlD/t779V42wD7UpSqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVyMgN7pQUPLmuiS6wVokQrbBuf5eK/9Yt78Ghm8Gzg=;
        b=TKmZidfgV6l0Z/lY3SsOtbtHlmBEW8p3Rx++0JvhxvAu7JdzJXZRJGERX+cyfEsxPG
         NRU1Nm+exs70cOteuvTl2pn1MWYY1oZQG+3/0WS9nz5hsiS5SOOQWiRDlimLmxiN8Byw
         /YwqG8mgp0ldVIQo9kUjjVs/zmf1dps360Dfg/AOEpA4Zmfyn7gkg0akLWEBkgYmoA2q
         unFhWr7XRIFPI4zXtGqDT5mAXSLrLdZGOpe7Ghq0C3VCGgHRsGJ9uGlujVZ4sM1nWS3n
         3AFLa1GCeqn+xkaRGrrV/AV0dVn+ohD9bgdF4h4eSJJzjM6CV9II8Fij5AMP8BZQm7L4
         iBQA==
X-Gm-Message-State: AOAM532hsRxqPxe8oQrVLiFpWJsz8uL3chWHveOOLSoH9ujVvKZ3apRb
        I/o4Zk+K3TtWWp7Woya/gqzaOAiNQs3SGw==
X-Google-Smtp-Source: ABdhPJyWMUQuelRobrX9rN3GhpQ7gVR4+MuRP+Vr2GFFBW6xqJ5Nu9o5Ak2yMxHrZyv7a289vs1opg==
X-Received: by 2002:a92:c744:: with SMTP id y4mr7993139ilp.288.1632492081859;
        Fri, 24 Sep 2021 07:01:21 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id a5sm4599007ilf.27.2021.09.24.07.01.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 07:01:21 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id n71so12844395iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:01:21 -0700 (PDT)
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr8704318iog.177.1632492080740;
 Fri, 24 Sep 2021 07:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <PU1P153MB0187B57518188FCDB102025CA0A49@PU1P153MB0187.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0187B57518188FCDB102025CA0A49@PU1P153MB0187.APCP153.PROD.OUTLOOK.COM>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Sep 2021 07:01:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8GJbpfs6-h3UOCWL4Kiz8j6zmp6xLpWsf2ZjdzMXR+A@mail.gmail.com>
Message-ID: <CAD=FV=X8GJbpfs6-h3UOCWL4Kiz8j6zmp6xLpWsf2ZjdzMXR+A@mail.gmail.com>
Subject: Re: Linux Next cannot build on Ubuntu 1604 and 1804
To:     Srikanth Myakam <smyakam@microsoft.com>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atin Mukherjee <Atin.MUKHERJEE@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 24, 2021 at 4:09 AM Srikanth Myakam <smyakam@microsoft.com> wrote:
>
> We have a pipeline to build Linux-next daily on Ubuntu 1604 and the compilation is failing at building "drivers/gpu/drm/drm_edid.c" starting from Sept 15th.
>
> The error text:
> drivers/gpu/drm/drm_edid.c:120:16: error: initializer element is not constant
>   EDID_QUIRK("ACR", 44358, EDID_QUIRK_PREFER_LARGE_60),
>                 ^
> drivers/gpu/drm/drm_edid.c:120:16: note: (near initialization for 'edid_quirk_list[0].panel_id')
> drivers/gpu/drm/drm_edid.c:122:16: error: initializer element is not constant
>   EDID_QUIRK("API", 0x7602, EDID_QUIRK_PREFER_LARGE_60),
>                 ^
> drivers/gpu/drm/drm_edid.c:122:16: note: (near initialization for 'edid_quirk_list[1].panel_id')
> drivers/gpu/drm/drm_edid.c:125:16: error: initializer element is not constant
>   EDID_QUIRK("AEO", 0, EDID_QUIRK_FORCE_6BPC),
>                 ^
> drivers/gpu/drm/drm_edid.c:125:16: note: (near initialization for 'edid_quirk_list[2].panel_id')
> drivers/gpu/drm/drm_edid.c:128:16: error: initializer element is not constant
>   EDID_QUIRK("BOE", 0x78b, EDID_QUIRK_FORCE_6BPC),
> ....
> The issue is observed on below environments:
> 1. Ubuntu1604, glibc version 2.23-0ubuntu11.3
> 2. Ubuntu1804, glibc version 2.27-3ubuntu1.2
>
> Seems like it was introduced by patch https://patchwork.freedesktop.org/patch/453876/

Yup. Let's move the discussion to the response to the cover letter of my patch.

https://lore.kernel.org/all/CAD=FV=XEb-jx81inK8hGvdJeRqTLmmBKz7U-m+9=CHbNRSa16g@mail.gmail.com/

-Doug
